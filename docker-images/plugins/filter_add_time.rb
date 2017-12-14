require 'fluent/filter'

class Fluent::AddTimeFilter < Fluent::Filter
  Fluent::Plugin.register_filter('add_time', self)

  config_param :time_key, :string, :default => 'time'

  def initialize
    super
  end

  def configure(conf)
    super
  end

  def filter(tag, time, record)
	if record.nil? 
		return
	end
    record[@time_key] = Time.now.strftime '%Y-%m-%dT%H:%M:%S.%L'
    record['time8601'] = (Time.parse(Time.now.utc.iso8601(6)).to_f*1000000).to_i
    return record
  end
end if defined?(Fluent::Filter)
