class Admin::EventRegistrationsController < AdminController
  before_action :find_event
  before_action :require_editor!
  require 'csv'

  def index
  @q = @event.registrations.ransack(params[:q])
  @registrations = @q.result.includes(:ticket).order("id DESC").page(params[:page]).per(10)

    if params[:status].present? && Registration::STATUS.include?(params[:status])
      @registrations = @registrations.by_status(params[:status])
    end
      
    if params[:ticket_id].present?
      @registrations = @registrations.by_ticket(params[:ticket_id])
    end

    if Array(params[:statuses]).any?
      @registrations = @registrations.by_status(params[:statuses])
    end
    
    if Array(params[:ticket_ids]).any?
      @registrations = @registrations.by_ticket(params[:ticket_ids])
    end

    if params[:start_on].present?
      @registrations = @registrations.where( "created_at >= ?", Date.parse(params[:start_on]).beginning_of_day )
    end
    
    if params[:end_on].present?
      @registrations = @registrations.where( "created_at <= ?", Date.parse(params[:end_on]).end_of_day )
    end

    if params[:registration_id].present?
      @registrations = @registrations.where( :id => params[:registration_id].split(",") )
    end

    respond_to do |format|
      format.html
      format.csv {
        @registrations = @registrations.reorder("id ASC")
        csv_string = CSV.generate do |csv|
          csv << ["報名ID", "票種", "姓名", "狀態", "Email", "報名時間"]
          @registrations.each do |r|
            csv << [r.id, r.ticket.name, r.name, t(r.status, :scope => "registration.status"), r.email, r.created_at]
          end
        end
        send_data csv_string, :filename => "#{@event.friendly_id}-registrations-#{Time.now.to_s(:number)}.csv"
      }
      format.xlsx
    end
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
end
