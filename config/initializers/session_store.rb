# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_minilog_session',
  :secret      => '9c3eabf4bc2c51544a9edc877a66b5b47c66883354b3868c1c8efce5a9d474783c57b75534581ab3a69bfa70399aca68f7c4264781cc9a818009cc2f8b0630c0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
