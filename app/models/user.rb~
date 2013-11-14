<<<<<<< HEAD
require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :location, :location_description
  EMAIL_PATTERN = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTERN
  validates :passhash, :confirmation => true, :presence => true
  validates_length_of :passhash, :in => 8..20, :on => :create
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy
  before_save :encrypt_passhash

  def encrypt_passhash
    if passhash.present?
      self.salt = BCrypt::Engine.generate_salt
      self.passhash = BCrypt::Engine.hash_secret(passhash, salt)
    end
  end
  
  def self.authenticate(login_username, login_passhash)
    user = User.find_by_username(login_username)
    if user && user.matches_password(login_passhash)
      return user
    end

    return false
  end

  def matches_password(login_passhash)
    passhash == BCrypt::Engine.hash_secret(login_passhash, salt)
  end

end
=======
require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :location, :location_description
  EMAIL_PATTERN = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTERN
  validates :passhash, :confirmation => true, :presence => true
  validates_length_of :passhash, :in => 8..20, :on => :create
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy
  before_save :encrypt_passhash

  def encrypt_passhash
    if passhash_changed?
      self.salt = BCrypt::Engine.generate_salt
      self.passhash = BCrypt::Engine.hash_secret(passhash, salt)
    end
  end
  
  def self.authenticate(login_username, login_passhash)
    user = User.find_by_username(login_username)
    if user && user.matches_password(login_passhash)
      return user
    end

    return false
  end

  def matches_password(login_passhash)
    passhash == BCrypt::Engine.hash_secret(login_passhash, salt)
  end

end
>>>>>>> 2b62c701546e8d2e1f7b6841363f2f79a7fb087e
