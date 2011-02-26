class AddDeviseUnlockTokenIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    remove_index :users, :unlock_token
  end
end
