# frozen_string_literal: true

class CreateNoteJob < ApplicationJob
  queue_as :create_note

  def perform(attrs)
    Note.insert_all(attrs, returning: %w[id name description])
  end
end
