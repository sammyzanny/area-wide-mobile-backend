class User < ApplicationRecord
    has_secure_password
    validates :username, :email, :phone, uniqueness: { case_sensitive: false }
    has_many :posts
    
end
