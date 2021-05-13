# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :name
      t.string :description

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
