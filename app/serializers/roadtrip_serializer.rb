class RoadtripSerializer
  include JSONAPI::Serializer
  set_type :road_trip
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end