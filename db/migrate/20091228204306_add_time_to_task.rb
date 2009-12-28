class AddTimeToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :start, :datetime
    add_column :tasks, :stop,  :datetime
  end

  def self.down
    remove_column :tasks, :start 
    remove_column :tasks, :stop
  end
end
