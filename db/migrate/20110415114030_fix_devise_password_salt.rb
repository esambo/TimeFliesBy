class FixDevisePasswordSalt < ActiveRecord::Migration
  def self.up
      # Devise doesn't use default and NULL settings on this column anymore
      change_column         :users, :password_salt, :string, :null => true
      change_column_default :users, :password_salt, nil
    end

    def self.down
      change_column         :users, :password_salt, :string, :null => false
      change_column_default :users, :password_salt, ""
  end
end
