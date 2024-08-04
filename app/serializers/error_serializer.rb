class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def serialize
    {
      errors: [
          {
            status: @error.status.to_s,
            message: @error.message,
          }
      ]
    }
  end
end
