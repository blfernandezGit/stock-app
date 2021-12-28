class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :inventories, dependent: :destroy

  after_create :add_user_cash_data

  def admin?
    self.role == 'admin'
  end
  
  private 

  def add_user_cash_data
    @cashes = Cash.create(balance: 0, user_id: self.id)
  end
end