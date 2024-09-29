class GoogleOAuthService
  attr_reader :access_token

  def initialize
    @access_token = get_access_token
  end


end
