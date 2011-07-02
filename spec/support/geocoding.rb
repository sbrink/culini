module GeoKit
  module Geocoders
    class FakeGeocoder < Geocoder
      def self.do_geocode(address, options = {})
        loc = GeoLoc.new
        loc.lat = 1
        loc.lng = 1
        loc.success = true
        loc
      end
    end
  end
end
