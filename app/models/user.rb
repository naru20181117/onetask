# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password
  validates :name, presence: true
  validates :email, {
    presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: {
      case_sensitive: false,
      }
    }

  has_many :tasks, dependent: :destroy
end
