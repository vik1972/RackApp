require_relative 'middleware/time_format'

class App

  def call(env)
    request = Rack::Request.new(env)
    
    if request.get?
      route_request(request)
    end
  end

  private

  def route_request(request)
    case request.path
    when '/time'
      time_format_response(request)
    else
      response(404, '404 Not Found')
    end
  end

  def time_format_response(request)
    time_format = TimeFormatter.new(request.params['format'])
    time_format.call

    if time_format.valid?
      response(200, time_format.converted_time_format)
    else
      response(400, time_format.bad_result)
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish   
  end
end