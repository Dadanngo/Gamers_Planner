class User < ApplicationRecord
  authenticates_with_sorcery!
  include Hashid::Rails
  has_many :events
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  has_many :authentications, dependent: :destroy
end
