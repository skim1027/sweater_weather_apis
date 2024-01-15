class RoadTripSerializer
  include JSONAPI::Serializer
  set_type :road_trip

  attributes :from, :to, :hours, :weather

end