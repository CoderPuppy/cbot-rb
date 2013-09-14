class CBot
	class Config
		class Bot < Config
			@loaders = []
			class << self; attr_reader :loaders; end
			
			def initialize(bot)
				@bot = bot
				
				@channels = []
				
				self.name = 'cbot'
				self.prefix = '\''
				self.server = 'localhost'
				self.port = 6667
			end
			
			def name; @bot.config.nick; end
			def name=(n)
				n = n.to_s if n.is_a? Symbol
				if n.is_a? String then
					@bot.cbot.config.nick = n
					@bot.cbot.config.user = n
					@bot.cbot.config.realname = n
				end
			end
			
			def server; @bot.cbot.config.server; end
			def server=(s)
				@bot.cbot.config.server = s if s.is_a? String
			end
			
			def port; @bot.cbot.config.port; end
			def port=(port)
				@bot.cbot.config.port = port.to_i if port.is_a? Integer
			end
			
			def channels; @channels; end
			def channels=(c)
				@channels = c if c.is_a? Array
			end
			
			def prefix; @prefix; end
			def prefix=(p)
				p = p.to_s if p.is_a? Symbol
				@prefix = p if p.is_a? String
			end
			
			def load(c)
				self.name = load_prop(c, :name, String) || load_prop(c, :name, Symbol)
				self.prefix = load_prop(c, :prefix, String) || load_prop(c, :prefix, Symbol)
				self.server = load_prop(c, :server, String)
				self.port = load_prop(c, :port, Integer)
				self.channels = load_prop(c, :channels, Array)
				
				self.class.loaders.each { |p| instance_exec(c, &p) }
				
				return self
			end
		end
	end
end