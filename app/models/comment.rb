# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  MAX_COMMENT_LENGTH = 33

  validate :content, presence: true, length: { maximum: MAX_COMMENT_LENGTH }
end
