class TimeFormatter

  TIME_FORMATS = { year: '%Y', month: '%m', day: '%d',
                   hour: '%H', minute: '%M', second: '%S' }.freeze

  def initialize(params)
    @params = params
    @good_params = []
    @bad_params = []
  end

  def call
    all_params   = @params.split(',')
    all_params.each do |key|
      if TIME_FORMATS.key?(key.to_sym)
        @good_params << TIME_FORMATS[key.to_sym]
      else
        @bad_params << key
      end
    end
  end

  def bad_result
    "Unknown time format #{@bad_params}"
  end

  def valid?
    @bad_params.empty?
  end

  def converted_time_format
    format = @good_params.join("-")
    Time.now.strftime(format)
  end
end