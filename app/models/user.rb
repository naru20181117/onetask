# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_destroy :validate_delete_all_admin_user
  has_secure_password
  validates :name, presence: true
  validates :email, {
    presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: {
      case_sensitive: false,
      }
    }

  has_many :tasks, dependent: :destroy

  private

  def validate_delete_all_admin_user
    if User.where(admin: true).count == 1 && admin?
      errors.add :base, '少なくとも1つ、権限者アカウントが必要です'
      throw :abort
    end
  end
end
