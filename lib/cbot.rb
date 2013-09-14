require 'rubygems'
require 'cinch'
require 'psych'

require_relative 'cbot/event_bus.rb'
require_relative 'cbot/config.rb'
require_relative 'cbot/permissions.rb'
require_relative 'cbot/plugins.rb'

class CBot
	include Listener
	
	attr_reader :conf, :cbot, :bus, :perms
	
	alias :config :conf
	
	def initialize
		@cbot = Cinch::Bot.new
		@bus = EventBus.new
		@conf = Config::Bot.new(self)
		
		@perms = Permissions::MultiManager.new(self)
		
		bus.register self
		
		plugin(Plugins::NickServ, self)
		plugin(Plugins::Flags, self)
		plugin(Plugins::Lifecycle, self)
		plugin(Plugins::ChanManager, self)
	end
	
	def start
		@cbot.start
	end
	
	def name; @cbot.name; end
	def name=(name)
		@cbot.name = name
		self
	end
	
	def plugin(p, *args)
		p = p.new(@cbot, *args) if p.is_a?(Class) && p.ancestors.include?(Cinch::Plugin)
		@cbot.plugins << p
		bus.register p
		self
	end
	
	handle :join_channels
	def join_channels
		conf.channels.each do |ch|
			@cbot.join(ch.to_s)
		end
	end
end