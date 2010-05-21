class UpgradeGemDeviseFrom082To107InUsers < ActiveRecord::Migration
  def self.up

    # devise-1.0.7

    # authenticatable
    #deprecated. Please use t.database_authenticatable instead

    # database_authenticatable
    #apply_schema :email,              String, :null => null, :default => default
    #apply_schema :encrypted_password, String, :null => null, :default => default, :limit => 128
    #apply_schema :password_salt,      String, :null => null, :default => default

    # token_authenticatable
    #apply_schema :authentication_token, String

    # confirmable
    #apply_schema :confirmation_token,   String
    #apply_schema :confirmed_at,         DateTime
    #apply_schema :confirmation_sent_at, DateTime

    # recoverable
    #apply_schema :reset_password_token, String

    # rememberable
    #apply_schema :remember_token,      String
    #apply_schema :remember_created_at, DateTime

    # trackable
    #apply_schema :sign_in_count,      Integer, :default => 0
    #apply_schema :current_sign_in_at, DateTime
    #apply_schema :last_sign_in_at,    DateTime
    #apply_schema :current_sign_in_ip, String
    #apply_schema :last_sign_in_ip,    String

    # lockable
    #apply_schema :failed_attempts, Integer, :default => 0
    #apply_schema :unlock_token,    String
    #apply_schema :locked_at,       DateTime



    # Upgrade gem devise from 0.8.2 to 1.0.7

    change_column :users, :email,                :string,   :limit => 255, :default => "", :null => false #explicitly override :limit
    change_column :users, :encrypted_password,   :string,   :limit => 128, :default => "", :null => false
    change_column :users, :password_salt,        :string,   :limit => 255, :default => "", :null => false #explicitly override :limit
    change_column :users, :confirmation_token,   :string,   :limit => 255                                 #explicitly override :limit
    change_column :users, :reset_password_token, :string,   :limit => 255                                 #explicitly override :limit
    change_column :users, :remember_token,       :string,   :limit => 255                                 #explicitly override :limit
    change_column :users, :sign_in_count,        :integer,                 :default => 0

    add_column :users, :failed_attempts, :integer, :default => 0
    add_column :users, :unlock_token,    :string
    add_column :users, :locked_at,       :datetime

    # I could move the "timestamps" columns back down by using: http://github.com/btelles/legacy_migrations
    #   create_table :users_devise107 do |t|
    #     t.database_authenticatable
    #       t.token_authenticatable
    #     t.confirmable
    #     t.recoverable
    #     t.rememberable
    #     t.trackable
    #       t.lockable
    #     t.timestamps
    #   end
    #
    #   transfer_from users, :to => users_devise107 do
    #     match_same_name_attributes
    #   end
    #
    #   drop_table :users
    #   rename_table :users_devise107, :users
  end

  def self.down
    change_column :users, :email,                :string,   :limit => 100, :null => false #Can't remove :default
    change_column :users, :encrypted_password,   :string,   :limit => 40,  :null => false #Can't remove :default
    change_column :users, :password_salt,        :string,   :limit => 20,  :null => false #Can't remove :default
    change_column :users, :confirmation_token,   :string,   :limit => 20
    change_column :users, :reset_password_token, :string,   :limit => 20
    change_column :users, :remember_token,       :string,   :limit => 20
    change_column :users, :sign_in_count,        :integer                                 #Can't remove :default

    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
  end
end
