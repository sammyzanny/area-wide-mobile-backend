class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :posts, :address, :officename, :phone, :email, :filled, :unfilled

  def posts
    @object.posts
  end

  def filled
    @object.filled
  end

  def unfilled
    @object.unfilled
  end
  
end
