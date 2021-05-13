# frozen_string_literal: true

class UpdateNoteJob < ApplicationJob
  queue_as :update_note

  def perform(attrs)
    Note.upsert_all(attrs, returning: %w[id name description])
  end
end
