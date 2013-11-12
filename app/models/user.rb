require 'bcrypt'

class User < ActiveRecord::Base

  # Member fields
  attr_accessor :location, :location_description
  EMAIL_PATTERN = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  # Validation requirements
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTERN
  validates :passhash, :confirmation => true, :presence => true
  validates_length_of :passhash, :in => 8..20, :on => :create
  
  # Relationships
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy
  has_many :user_locations, dependent: :destroy
  has_many :user_feedbacks, :class_name => 'UserFeedback', :foreign_key => 'user_from_id', :dependent => :destroy
  has_many :user_feedbacks, :class_name => 'UserFeedback', :foreign_key => 'user_to_id', :dependent => :destroy
  has_many :trade_lines, :class_name => 'TradeLine', :foreign_key => 'user_from_id', :dependent => :destroy
  has_many :trade_lines, :class_name => 'TradeLine', :foreign_key => 'user_to_id', :dependent => :destroy
  has_many :trade_notes, dependent: :destroy

  # Triggers to be run in certain situations
  before_save :encrypt_passhash, :send_activation
  
  # Need to send activation email when user changes their address
  def send_activation
    if email_changed?
      activated = false
      UserMailer.welcome_email(self).deliver
    end
  end

  # A filter method which, whenever the password is changed, hashes it
  # before it will be saved. Only the hash is stored.
  def encrypt_passhash
    if passhash_changed?
      self.salt = BCrypt::Engine.generate_salt
      self.passhash = BCrypt::Engine.hash_secret(passhash, salt)
    end
  end

  # Utility method which looks up a user and returns it if
  # the provided password hashes identically to the database
  def self.authenticate(login_username, login_password)
    user = User.find_by_username(login_username)
    if user && user.matches_password(login_password)
      return user
    end

    return false
  end

  # Returns whether a given password hashes to this user's password
  def matches_password(login_password)
    passhash == BCrypt::Engine.hash_secret(login_password, salt)
  end
  
  # Create a new user with the given location as its initial location
  def self.create_with_location(user_params, location_params)
    
    User.transaction do
      @user = User.new(user_params)
      @user.activated ||= false

      if @user.save

        @user_location = UserLocation.new(location_params)
        @user_location.user_id = @user.id

        if @user_location.save
          return @user
        else
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    end

  end

end
