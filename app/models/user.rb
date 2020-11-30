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

    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.utc
        save!
    end
       
       def password_token_valid?
        (self.reset_password_sent_at + 4.hours) > Time.now.utc
       end
       
       def reset_password!(password)
        self.reset_password_token = nil
        self.password = password
        save!
       end
       
       private
       
       def generate_token
            SecureRandom.hex(10)
       end
    
end
