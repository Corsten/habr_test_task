require 'test_helper'

class Api::NotesControllerTest < ActionController::TestCase
  setup do
    @note = create(:note)
    @notes = create_list(:note, 2)
  end

  test 'should get index' do
    get :index

    assert_response :success
  end

  test 'should get show' do
    get :show, params: { id: @note.id }

    assert_response :success
  end

  test 'should get by_queue_hash' do
    get :by_queue_hash, params: { hash: @note.queue_hash }

    assert_response :success
  end

  test 'should post create collection' do
    attrs = attributes_for_list(:note, 3)
    post :create_collection, params: { notes: attrs }

    assert_response :success
  end

  test 'should post create' do
    attrs = attributes_for(:note)
    assert_difference('Note.count') do
      post :create, params: { note: attrs }
    end

    assert_response :success
  end

  test 'should patch update' do
    attrs = { id: @note.id, note: { name: generate(:string) } }
    patch :update, params: attrs

    assert_response :success

    @note.reload
    assert_equal attrs[:note][:name], @note.name
  end

  test 'should patch update collection' do
    attrs = { notes: [] }

    @notes.each do |note|
      attr = note.attributes
      attr['name'] = 'marat'
      attrs[:notes] << attr
    end

    patch :update_collection, params: attrs

    assert_response :success
  end

  test 'should destroy one record' do
    delete :destroy, params: { id: @note.id }

    assert_response :success
  end

  test 'should destroy collection' do
    delete :destroy_collection, params: { ids: @notes.pluck(:id) }

    assert_response :success
  end
end
