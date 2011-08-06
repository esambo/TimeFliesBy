class UpdateDevise133To142 < ActiveRecord::Migration
  def self.up
    remove_column :users, :remember_token
  end

  def self.down
    add_column    :users, :remember_token, :string
  end
end
