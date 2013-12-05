require 'bcrypt'

class User < ActiveRecord::Base

  # Member fields
  attr_accessor :location, :location_description, :old_passhash
  cattr_accessor :enable_mailer do
    true
  end

  EMAIL_PATTERN = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  # Validation requirements
  validates :first, :presence => true
  validates :last, :presence => true
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..12 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_PATTERN
  validates :passhash, :confirmation => true, :presence => true
  validates :passhash_confirmation, :presence => true
  validates_length_of :passhash, :in => 8..20, :on => :create
  validates :terms, :acceptance => true
  validates :user_locations, presence: true

  # Relationshipsvalidates 
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy
  has_many :user_locations, dependent: :destroy
  has_many :user_feedbacks, :class_name => 'UserFeedback', :foreign_key => 'user_to_id', :dependent => :destroy
  has_many :trade_notes, dependent: :destroy

  # Triggers to be run in certain situations
  before_save :encrypt_passhash, :pre_activation
  after_save :send_activation

  def admin?
    id == 16
  end
  
  def self.initialize
    enable_mailer = true
  end

  def pre_activation
    if email_changed? and enable_mailer
      generate_token
    end
  end

  # Need to send activation email when user changes their address
  def send_activation
    if email_changed? and enable_mailer
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


  # User feedbacks methods

  def feedback_count
    return user_feedbacks.count
  end

  def feedback_positive
    return user_feedbacks.where('score = 1').count
  end

  def feedback_negative
    return user_feedbacks.where('score = 0').count
  end

  def feedback_score
    x = user_feedbacks.average(:score)
    if x.nil?
      return 0
    else
      return x.round
    end
  end

  # Utility method which looks up a user and returns it if
  # the provided password hashes identically to the database
  def self.authenticate(login_username, login_password)

    user = User.find_by_username(login_username)
    if user && user.matches_password(login_password)
      return user
    end

    return nil
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
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
      @user_location = @user.user_locations.build(location_params)
      @user.save
      return @user
    end
  end

end
