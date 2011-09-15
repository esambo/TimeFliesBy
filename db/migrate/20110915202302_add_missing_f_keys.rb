class AddMissingFKeys < ActiveRecord::Migration
  def self.up
    add_index     :tag_tasks, :tag_id
    add_index     :tag_tasks, :task_id
    add_index     :tag_tasks, :user_id
    add_index     :tasks,     :user_id
    add_index     :tags,      :user_id
  end

  def self.down
    remove_index  :tag_tasks, :tag_id
    remove_index  :tag_tasks, :task_id
    remove_index  :tag_tasks, :user_id
    remove_index  :tasks,     :user_id
    remove_index  :tags,      :user_id
  end
end
