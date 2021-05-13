# frozen_string_literal: true

module NoteService
  module_function

  BATCH_SIZE = 100

  def import_notes(attributes, action)
    records = []
    queue_hash = uniq_queue_hash
    job = action == 'update' ? UpdateNoteJob : CreateNoteJob

    attributes.each do |attrs|
      records << prepare_records(attrs, queue_hash)
      if records.count == BATCH_SIZE
        job.send('perform_later', records)
        records = []
      end
    end

    job.send('perform_later', records)

    queue_hash
  end

  def prepare_records(attrs, queue_hash)
    attrs[:queue_hash] = queue_hash
  end

  def uniq_queue_hash
    SecureRandom.hex 32
  end
end
