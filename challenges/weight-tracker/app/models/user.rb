class User < ActiveRecord::Base
  validates :email, uniqueness: true
  has_many :entries

  def self.authenticate(email, password)
    User.where(email: email, password: password).first
  end
end
