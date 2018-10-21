class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
