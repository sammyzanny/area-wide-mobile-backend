class PostSerializer < ActiveModel::Serializer
    attributes :id, :message,  :user
  
    def user
      @object.user
    end
    
  end