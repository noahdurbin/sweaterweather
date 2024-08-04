class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialize_json
    binding.pry
    {
      errors: [
        {
          status: @error_object.status_code,
          title: @error_object.message
        }
      ]
    }
  end
end
