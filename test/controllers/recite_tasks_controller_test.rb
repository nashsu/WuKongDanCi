require 'test_helper'

class ReciteTasksControllerTest < ActionController::TestCase
  setup do
    @recite_task = recite_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recite_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recite_task" do
    assert_difference('ReciteTask.count') do
      post :create, recite_task: { next_time: @recite_task.next_time, start_time: @recite_task.start_time, task_type: @recite_task.task_type, user_id: @recite_task.user_id, word_ids: @recite_task.word_ids }
    end

    assert_redirected_to recite_task_path(assigns(:recite_task))
  end

  test "should show recite_task" do
    get :show, id: @recite_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recite_task
    assert_response :success
  end

  test "should update recite_task" do
    patch :update, id: @recite_task, recite_task: { next_time: @recite_task.next_time, start_time: @recite_task.start_time, task_type: @recite_task.task_type, user_id: @recite_task.user_id, word_ids: @recite_task.word_ids }
    assert_redirected_to recite_task_path(assigns(:recite_task))
  end

  test "should destroy recite_task" do
    assert_difference('ReciteTask.count', -1) do
      delete :destroy, id: @recite_task
    end

    assert_redirected_to recite_tasks_path
  end
end
