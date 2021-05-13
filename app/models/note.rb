# frozen_string_literal: true

class Note < ApplicationRecord
  validates :name, :description, presence: true
end
