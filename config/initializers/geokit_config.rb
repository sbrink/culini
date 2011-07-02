if defined? Geokit

	# These defaults are used in Geokit::Mappable.distance_to and in acts_as_mappable
	Geokit::default_units = :kms
	Geokit::default_formula = :sphere

	# This is the timeout value in seconds to be used for calls to the geocoder web
	# services.  For no timeout at all, comment out the setting.  The timeout unit
	# is in seconds.
	#Geokit::Geocoders::timeout = 3

	# This is your yahoo application key for the Yahoo Geocoder.
	# See http://developer.yahoo.com/faq/index.html#appid
	# and http://developer.yahoo.com/maps/rest/V1/geocode.html
	Geokit::Geocoders::yahoo = 'NOT_HERE'

	# This is your Google Maps geocoder key.
	# See http://www.google.com/apis/maps/signup.html
	# and http://www.google.com/apis/maps/documentation/#Geocoding_Examples
	Geokit::Geocoders::google = 'ABQIAAAAFRc3mPWu3qFLxmUVerXE2xROjqsNw3pKgnjfaEK4aH-NQINYtRT6zJGTPrcPkKtOJpquyzWJrdPs0g'


	# Uncomment to use a username with the Geonames geocoder
	#Geokit::Geocoders::geonames="REPLACE_WITH_YOUR_GEONAMES_USERNAME"

	# This is the order in which the geocoders are called in a failover scenario
	# If you only want to use a single geocoder, put a single symbol in the array.
	# Valid symbols are :google, :yahoo, :us, and :ca.
	# Be aware that there are Terms of Use restrictions on how you can use the
	# various geocoders.  Make sure you read up on relevant Terms of Use for each
	# geocoder you are going to use.
	Geokit::Geocoders::provider_order = [:google]
end
