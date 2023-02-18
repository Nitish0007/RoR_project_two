class User < ApplicationRecord
    has_one_attached :image
    attr_accessor :password

    validates :first_name, :last_name, :email, presence: true
    validates :email, format: { with: %r{(.+)@(.+)\z}, message: "Invalid Email"  },uniqueness: true, length: { minimum: 4, maximum: 50 }
    validates :password, confirmation: true, length: {minimum: 6}, on: :create

    before_save :encrypt_password

    def self.authenticate(email, password)
        return false if email.blank? || password.blank?
        user = find_by_email(email)
        return user if user && user.match_password(password)
    end

    def match_password(password)
        if self.encrypted_password == hashing_algo(password)
            return true
        end
    end


protected  
    def encrypt_password
        return if password.blank?
        self.encrypted_password = hashing_algo(password)
    end

    def hashing_algo(str)
        Digest::SHA1.hexdigest(str)
    end

    
end
