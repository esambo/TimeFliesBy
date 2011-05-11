class CreateTagTasks < ActiveRecord::Migration
  def self.up
    create_table :tag_tasks do |t|
      t.references :user
      t.references :tag
      t.references :task

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_tasks
  end
end
