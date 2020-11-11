class PostSerializer < ActiveModel::Serializer
    attributes :id, :message, :user, :billing, :address, :contact, :images
  
    def user
      @object.user
    end

    def images
      @object.images
    end
    
  end