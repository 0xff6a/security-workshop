class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :organisation_name
  belongs_to :organisation
  has_many :payments

  after_create do
    if self.organisation.nil?
      org = Organisation.create(name: self.organisation_name)
      self.organisation_id = org.id
      self.save
    end
  end

  def manager?
    !!manager
  end

  def manages?(org)
    manager? && self.organisation == org
  end
  
end
