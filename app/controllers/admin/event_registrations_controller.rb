class Admin::EventRegistrationsController < AdminController
  before_action :find_event

  def index
    @registrations = @event.registrations.includes(:ticket).order("id DESC")
  end

  def destroy
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.destroy

    redirect_to admin_event_registrations_path(@event)
  end

  private

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

  def registration_params
    params.require(:registration).permit(:status, :ticket_id, :name, :email, :cellphone,:website, :bio)
  end
nd