class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :inventories, dependent: :destroy

  after_create :add_user_cash_data

  validates :full_name, presence: true
  ROLES = %w[trader admin].freeze
  validates :role, inclusion: { in: ROLES }
  STATUS = %w[pending accepted rejected].freeze
  validates :status, inclusion: { in: STATUS }

  def admin?
    self.role == 'admin'
  end

  def rejected?
    self.status == 'rejected'
  end

  def accepted?
    self.status == 'accepted'
  end
  
  private 

  def add_user_cash_data
    @cashes = Cash.create(balance: 0, user_id: self.id)
  end
end