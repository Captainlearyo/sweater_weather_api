class MunchiesSerializer
  include JSONAPI::Serializer
  set_type :munchie
  attributes :destination_city, :forecast, :restaurant
end