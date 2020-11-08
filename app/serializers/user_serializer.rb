class UserSerializer < ActiveModel::Serializer
  attributes :id, :posts, :address, :message, :billing

  def posts
    @object.posts
  end
  
end
