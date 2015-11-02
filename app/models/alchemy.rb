module Alchemy
  mattr_accessor :redis

  def self.table_name_prefix
    'alchemy_'
  end

  Alchemy.redis = if ENV["REDISTOGO_URL"]
                      uri = URI.parse(ENV["REDISTOGO_URL"])
                      Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
                    else
                      Redis.new
                    end

end
