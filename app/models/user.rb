# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  MAX_EMAIL_LENGTH = 255

  has_many :assigned_tasks, foreign_key: :assigned_user_id, class_name: "Task"
  has_secure_password
  has_secure_token :authentication_token
  has_many :created_tasks, foreign_key: :task_owner_id, class_name: "Task"

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: MAX_EMAIL_LENGTH },
    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create

  before_save :to_lowercase

  before_destroy :assign_task_to_creator

  private

    def to_lowercase
      email.downcase!
    end

    def assign_task_to_creator
      task_whose_owner_is_not_current_user = assigned_tasks.select { |task| task.task_owner_id != id }
      task_whose_owner_is_not_current_user.each { |task| task.update(assigned_user_id: task.task_owner_id) }
    end
end
