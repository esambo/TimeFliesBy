require 'legacy_migrations'

# Reason: The "timestamp" columns are not at the end of the table anymore!
# Fix:    Move columns down
# How:    1. Create new table with the (same) columns in the correct order
#         2. Copy the original data to this new table
#            2.a. Use Rails Plugin: legacy_migrations
#            2.b. Create ActiveRecord Models for these two tables
#            2.c. Copy data from old to new table between columns of the same name
#         3. Drop original table
#         4. Rename new table to what the original used to be
#         5. Re-create index

class MoveColumnsInUsers < ActiveRecord::Migration
  class UserDevise082 < ActiveRecord::Base
    set_table_name 'users'
  end

  class UserDevise107 < ActiveRecord::Base
    set_table_name 'users_devise107'
  end

  def self.up
    # Create new table with "timestamp" columns at the end
    create_table :users_devise107 do |t|
      t.database_authenticatable
      # t.token_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      t.timestamps
    end

    # Use: http://github.com/btelles/legacy_migrations
    transfer_from UserDevise082, :to => UserDevise107, :validate => false do
      match_same_name_attributes
    end

    drop_table :users
    rename_table :users_devise107, :users

    add_index :users, :email,                :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
