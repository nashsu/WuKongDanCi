json.array!(@recite_tasks) do |recite_task|
  json.extract! recite_task, :id, :task_type, :word_ids, :user_id, :start_time, :next_time
  json.url recite_task_url(recite_task, format: :json)
end
