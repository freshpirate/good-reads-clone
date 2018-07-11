class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :name, :password, :password_confirmation, :confirmation_token, :email_confirmation
  
  has_many :reviews, foreign_key: "user_id", dependent: :destroy
  has_many :user_book_statuses, foreign_key: 'user_id', dependent: :destroy
  has_many :books, through: :user_book_statuses, source: :book

  validate :spam_filter

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetMailer.reset_email(self).deliver_now
  end

  private 

  def spam_filter
    if SpamFilter[email]
      errors.add(:email, "belongs to a spam domain!")
    end
  end
end