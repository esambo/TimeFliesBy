class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      
      # devise-0.8.2
      
      t.authenticatable :encryptor => :sha1, :null => false
      # apply_schema :email,              String, :null => null, :limit => 100                                  #t.string   "email",                :limit => 100, :null => false
      # apply_schema :encrypted_password, String, :null => null, :limit => Devise::ENCRYPTORS_LENGTH[encryptor] #t.string   "encrypted_password",   :limit => 40,  :null => false
      # apply_schema :password_salt,      String, :null => null, :limit => 20                                   #t.string   "password_salt",        :limit => 20,  :null => false

      t.confirmable
      # apply_schema :confirmation_token,   String, :limit => 20
      # apply_schema :confirmed_at,         DateTime
      # apply_schema :confirmation_sent_at, DateTime

      t.recoverable
      # apply_schema :reset_password_token, String, :limit => 20

      t.rememberable
      # apply_schema :remember_token,      String, :limit => 20
      # apply_schema :remember_created_at, DateTime

      t.trackable
      # apply_schema :sign_in_count,      Integer
      # apply_schema :current_sign_in_at, DateTime
      # apply_schema :last_sign_in_at,    DateTime
      # apply_schema :current_sign_in_ip, String
      # apply_schema :last_sign_in_ip,    String


      t.timestamps
      # column(:created_at, :datetime, options)  #t.datetime "created_at"
      # column(:updated_at, :datetime, options)  #t.datetime "updated_at"
    end

    add_index :users, :email,                :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
