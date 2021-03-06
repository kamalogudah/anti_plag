class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :docs , :dependent => :destroy
  has_many :plags ,:dependent => :destroy
  has_many :results ,:dependent => :destroy
end
