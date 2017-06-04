class StorySerializer < ActiveModel::Serializer
  attributes :id, :plot, :writer, :upvotes
  
end