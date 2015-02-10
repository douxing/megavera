require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :current_password

  validates :name, presence: true, length: { in: 2..32 }
  validates :password, length: { in: 6..32 }, confirmation: true, unless: Proc.new { |a| a.password.blank? }
  validates_presence_of :password, on: :create
  validate :check_current_password

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user && user.encrypt_password == Digest::SHA1.hexdigest("#{password}#{user.salt}")
      user
    else
      nil
    end
  end

  def password=(value)
    @password = value
    return if value.blank?

    generate_salt
    self.encrypt_password = Digest::SHA1.hexdigest("#{password}#{self.salt}")
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  private
  def check_current_password
    if self.current_password.present? && self.class.authenticate(self.name, self.current_password).nil?
      errors.add(:current_password, :invalid)
    end
  end
end
