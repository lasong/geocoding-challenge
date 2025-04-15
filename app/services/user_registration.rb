class UserRegistration
  def initialize(params)
    @params = params
  end

  def call
    User.new(attributes)
  end

  private

  def attributes
    {
      email: @params[:email],
      password: @params[:password],
      location_attributes: location_attributes
    }
  end

  def location_attributes
    location_params = @params.slice(:street, :city, :zip)
    coordinates = GeoLocation.new(location_params).coordinates
    location_params.merge(latitude: coordinates[:latitude], longitude: coordinates[:longitude])
  end
end
