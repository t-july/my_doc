class User < ActiveRecord::Base
  has_many :documents, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def display_name
    name.presence || email
  end
end
