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
      not_found_response
    end
  end

  def time_format_response(request)
    time_format = TimeFormat.new(request.params['format'])

    if time_format.valid?
      response(status:200, body: time_format.result)
    else
      response(status: 400, body: time_format.result)
    end
  end

  def response(status:, headers: { 'Content-Type' => 'text/plain' }, body:)
    [status, headers, [body]]
  end

  def not_found_response
    response(status: 404, body: '404 Not Found')
  end
end