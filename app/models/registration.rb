class Registration < ApplicationRecord
  attr_accessor :current_step


  STATUS = ["pending", "confirmed"]
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :status, :ticket_id
  validates_presence_of :name, :email, :cellphone, :if => :should_validate_basic_data?
  validates_presence_of :name, :email, :cellphone, :bio, :if => :should_validate_all_data?
  validate :check_event_status, :on => :create

  belongs_to :event
  belongs_to :ticket
  belongs_to :user, :optional => true

  before_validation :generate_uuid, :on => :create

  def should_validate_basic_data?
    current_step == 2  
  end

  def should_validate_all_data?
    current_step == 3 || status == "confirmed"  
  end

  def to_param
    self.uuid
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def check_event_status
    if self.event.status == "draft"
      errors.add(:base, "活動尚未開放報名")
    end
  end

end
