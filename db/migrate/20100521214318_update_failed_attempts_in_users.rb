class UpdateFailedAttemptsInUsers < ActiveRecord::Migration
  def self.up
    users = User.find_all_by_failed_attempts nil
    users.each do |u|
      u.failed_attempts = 0
      u.save!
    end
  end

  def self.down
    users = User.find_all_by_failed_attempts 0
    users.each do |u|
      u.failed_attempts = nil
      u.save!
    end
  end
end
