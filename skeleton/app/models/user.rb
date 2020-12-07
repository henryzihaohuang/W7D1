class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    validates :password_digest, presence: {message: "Password cannot be blank"} 

    validates :session_token, presence: true, uniqueness: true, 

    validates :password, length: {minimum: 6}, allow_nil: true

    after_initialize :ensure_session_token **


def reset_session_token!
    self.update!(session_token: self.class.generate_session_token)
    self.session_token
end


private
def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
end

end