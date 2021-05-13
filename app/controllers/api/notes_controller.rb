# frozen_string_literal: true

class Api::NotesController < Api::ApplicationController
  def show
    note = Note.find(params[:id])
    render json: note
  end

  def index
    query = { s: 'id asc' }.merge(params[:q] || {})
    notes = Note.ransack query
    notes.sorts = 'created_at asc'

    render json: notes.result
  end

  def create
    note = Note.new(member_permitted_params)

    if note.save
      render json: note
    else
      render_error :unprocessable_entity, :error, note.errors.full_messages
    end
  end

  def create_collection
    notes = Note.insert_all(collection_permitted_params, returning: %w[id name description])

    render json: notes
  rescue ActiveRecord::RecordInvalid
    render_error :unprocessable_entity, :error
  end

  def update
    note = Note.find(params[:id])

    if note.update(member_permitted_params)
      render_ok
    else
      render json: { code: :error }, status: :unprocessable_entity
    end
  end

  def update_collection
    notes = Note.upsert_all(collection_permitted_params, returning: %w[id name description])

    render json: notes
  rescue ActiveRecord::RecordInvalid
    render json: { code: :error }, status: :unprocessable_entity
  end

  def destroy
    note = Note.find(params[:id])

    if note.destroy
      render_ok
    else
      render json: { code: :error }, status: :unprocessable_entity
    end
  end

  def destroy_collection
    notes = Note.where(id: params[:ids])
    if notes.destroy_all
      render json: { code: :ok }
    else
      render json: { code: :error }, status: :unprocessable_entity
    end
  end

  private

  def collection_permitted_params
    params.require(:notes)
  end

  def member_permitted_params
    params.require(:note).permit(:name, :description)
  end
end
