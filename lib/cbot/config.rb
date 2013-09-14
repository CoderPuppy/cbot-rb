require 'set'

require_relative 'config/bot.rb'
require_relative 'config/nickserv.rb'

class CBot
	class Config
		def load(c); self; end
		
	protected
		
		def load_prop(c, prop, type)
			v = c[prop]
			return v if v.is_a?(type)
			
			prop = prop.to_s
			
			v = c[prop]
			return v if v.is_a?(type)
			
			prop = prop.to_sym
			
			v = c[prop]
			return v if v.is_a?(type)
			
			return nil
		end
	end
end