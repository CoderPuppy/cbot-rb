class CBot
	module Plugins
		
	end
	
	module Plugin
		def self.included(cla)
			cla.instance_eval do
				extend ClassMethods
				include Cinch::Plugin
				include Initer
				include CBot::Listener
				
				set prefix: ''
			end
		end
		
		module Initer
			def initialize(bot, cbot)
				super(bot)
				@cbot = cbot
			end
		end
		
		module ClassMethods
			def prefixed_match(name, m, opts = nil, &b)
				m = Regexp.new(m) if m.is_a? String
				opts = {} unless opts.is_a? Hash
				opts.merge! method: name
				match Regexp.new("(\\S+?)#{m.source}", m.options), opts
				define_method(name) do |m, prefix, *matches|
					instance_exec(m, *matches, &b) if prefix == @cbot.conf.prefix
				end
			end
		end
	end
	
	require_relative 'plugins/nickserv.rb'
	require_relative 'plugins/flags.rb'
	require_relative 'plugins/lifecycle.rb'
	require_relative 'plugins/chan_manager.rb'
end