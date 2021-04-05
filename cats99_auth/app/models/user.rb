class User < ApplicationRecord 
    validates :user_name, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    after_initialize :ensure_session_token

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user)

        if user && user.is_password?(password)
            user 
        else 
            nil 
        end 

    end 

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end 
 
    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
        #one is class of string, one is hash class
        #is_password? Bcrypt built in method is used on strings?? (I think)    
    end


    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token   
    end


end 