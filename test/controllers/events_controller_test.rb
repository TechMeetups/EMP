require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { description: @event.description, e_date: @event.e_date, e_time: @event.e_time, s_date: @event.s_date, s_time: @event.s_time, title: @event.title, twitter_hash_tag: @event.twitter_hash_tag, user_id: @event.user_id }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { description: @event.description, e_date: @event.e_date, e_time: @event.e_time, s_date: @event.s_date, s_time: @event.s_time, title: @event.title, twitter_hash_tag: @event.twitter_hash_tag, user_id: @event.user_id }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
