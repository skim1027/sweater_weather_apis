class MunchiesSerializer < CombinedSerializer
  include JSONAPI::Serializer

  attributes :name, :address, :rating, :reviews
end