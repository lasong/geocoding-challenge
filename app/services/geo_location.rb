class GeoLocation
  def initialize(params)
    @params = params
  end

  def coordinates
    location = Geocoder.search("#{@params[:street]}, #{@params[:zip]} #{@params[:city]}")

    {
      latitude: location.first&.latitude,
      longitude: location.first&.longitude
    }
  end
end
