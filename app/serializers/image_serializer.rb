# frozen_string_literal: true

class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :description, :tag, :image_url, :resized_image_url

  def image_url
    rails_blob_path(object.file, only_path: true) if object.file.attached?
  end

  def resized_image_url
    return unless object.file.attached?

    Rails.application.routes.url_helpers.rails_representation_url(
      object.file.variant(resize_to_limit: [200, 200]).processed, only_path: true
    )
  end
end
