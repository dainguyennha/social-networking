class User < ApplicationRecord
  attr_accessor :remember_token
  validates :name, :presence => { message: "Tên không được để trống"}
  VALID_PHONE_REGEX = /\b(0)+[2-9]+([0-9]{8})\b/
  validates :phone_number, presence: { message: "Số điện thoại không được để trống"}
  validates :phone_number,allow_blank: true, format: { with: VALID_PHONE_REGEX, \
    message: "Số điện thoại không hợp lệ!"}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: "Email không được để trống!"}
  validates :email, allow_blank: true, length: { maximum: 250 },
    format: { with: VALID_EMAIL_REGEX, message: "Email không hợp lệ!" },
    uniqueness: { case_sensitive: false }
  validates :password, presence: { message: "Mật khẩu không được để trống!"}
  validates :password, 
    length: { minimum: 8, message: "Mật khẩu phải có ít nhất 8 ký tự" }, 
    confirmation: { message: "Mật khẩu xác nhận không khớp!"}
  validates_confirmation_of :password
  validates :password_confirmation,
    presence: { message: "Mật khẩu xác nhận không được để trống!" }

  before_save :downcase_email

  has_secure_password validations: false

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute :remember_digest, nil
  end


  private
    def downcase_email
      self.email = email.downcase
    end

  
end
