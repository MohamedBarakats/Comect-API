# frozen_string_literal: true

class Image < ApplicationRecord
  has_one_attached :file

  validates :tag, presence: true
  validates :description, presence: true

  validates :file, attached: true, size: { less_than: 3.megabytes, message: 'Size is very large' },
                   content_type: %i[png jpg jpeg]
end
