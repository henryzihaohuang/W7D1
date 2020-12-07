class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    validates :password_digest, presence: {message: "Password cannot be blank"} 

    validates :session_token, presence: true, uniqueness: true

    validates :password, length: {minimum: 6}, allow_nil: true

    after_initialize :ensure_session_token

    has_many :cats,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cat

attr_reader :password

def ensure_session_token
    self.session_token ||= self.class.generate_session_token
end

def reset_session_token!
    self.update!(session_token: self.class.generate_session_token)
    self.session_token
end

def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
end

def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
end

def self.find_credentials(username, password)
    user = User.find_by(username: username )
    return nil unless user && user.is_password?(password)
end

private
def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
end

end