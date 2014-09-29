class Employee < ActiveRecord::Base
  
  attr_accessor :passwd
  mount_uploader :image, ImageUploader
  
  before_save :encrypt_password
  
  validates :passwd, :confirmation => true, :presence => true, :length => { :in => 6..20 },
                     :format => { :with => /\A(?=.*[a-zA-Z])(?=.*[0-9])/, 
                                  :message => "must contain at least one letter and one number" }, :on => :create
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :image, :presence => true
  
  def self.authenticate(uname, pass)
    user = Employee.find_by_name(uname)
    if user && user.password == BCrypt::Engine.hash_secret(pass, user.salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if passwd.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(passwd, salt)
    end
  end
  
end
