class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :registrations
  has_many :memberships
  has_many :groups, :through => :memberships
  has_one :profile
  
  accepts_nested_attributes_for :profile

  ROLES = ["admin", "editor"]

  def display_name
    self.email.split("@").first
  end

  def is_admin?
    self.role == "admin"
  end

  def is_editor?
    ["admin", "editor"].include?(self.role) 
  end
end
