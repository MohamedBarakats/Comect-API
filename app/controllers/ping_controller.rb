# frozen_string_literal: true

class PingController < ApplicationController
  def index
    render json: { status: :ok, message: 'comect_service_api is running' }, status: :ok
  end
end
