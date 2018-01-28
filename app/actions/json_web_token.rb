class JsonWebToken
  class << self
    def encode(payload = {}, expiration = 1.hours.from_now)
      token = JWT.encode(
        payload.merge(exp: expiration.to_i),
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
      { token: token, expires_at: expiration }
    end

    def decode(token)
      begin
        # add leeway to ensure the token is still accepted = 30 seconds
        decoded_token = JWT.decode(
          token,
          Rails.application.secrets.secret_key_base,
          true,
          {
            :exp_leeway => 30,
            :algorithm => 'HS256'
          }
        )
        return HashWithIndifferentAccess.new decoded_token[0] rescue nil
      rescue JWT::ExpiredSignature
        # Handle expired token, e.g. logout user or deny access
        # Log.info expiration
      rescue => e
        # Log general exception
      end
      nil
    end
  end
end
