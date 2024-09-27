# require 'googleauth'
# include Sidekiq::Job
# include DatabaseConnection

# client_id = Google::Auth::ClientId.new(ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"])
# token_store = Google::Auth::Stores::FileTokenStore.new(file: 'path_to_tokens.yaml') # or a database store

# authorizer = Google::Auth::UserAuthorizer.new(client_id, scopes, token_store)

# # Obtain user credentials (this is where your refresh token is managed)
# user_id = 'your_user_id'
# credentials = authorizer.get_credentials(user_id)

# if credentials.expired?
#   # Automatically refresh the access token
#   credentials.refresh!
# end
