# frozen_string_literal: true

module Api
  class ApplicationController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render_error(:not_found, :not_found, t('api.errors.not_found'))
    end

    def render_error(status, code, error = nil)
      render json: {
        code: code,
        message: error
      }, status: status
    end

    def render_ok
      render json: { code: :ok }
    end
  end
end
