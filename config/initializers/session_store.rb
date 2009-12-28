# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timefliesby_session',
  :secret      => 'bf2419071a4747c0d515a71d04848aa449d448cb492ec42d3eb3f77707fff092c6924163ba2f89fc4cc2cb01b3ee98e05479f0bacb70d69cade54017743fb5bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
