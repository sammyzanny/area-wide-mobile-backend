class User < ApplicationRecord
    has_secure_password
    validates :email, :phone, uniqueness: { case_sensitive: false }
    has_many :posts

    def filled
        self.posts.select{|post| post.filled}
    end

    def unfilled
        self.posts.select{|post| !post.filled}
    end
    
end
