# frozen_string_literal: true

class Comment < ApplicationRecord
  MAX_COMMENT_LENGTH = 50
  belongs_to :task
  belongs_to :user

  validates :content, presence: true, length: { maximum: MAX_COMMENT_LENGTH }
end
