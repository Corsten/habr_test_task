# frozen_string_literal: true

module Api
  class NotesController < Api::ApplicationController
    def create
      puts 'create action!'
    end

    def update
      puts 'update action!'
    end

    def destroy
      puts 'destroy action!'
    end
  end
end
