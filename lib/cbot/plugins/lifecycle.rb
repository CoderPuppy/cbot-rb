require 'rubygems'
require 'god'
require 'drb'

class CBot
	module Plugins
		class Lifecycle
			include CBot::Plugin
			
			prefixed_match :reload, 'reload' do |e|
				@cbot.perms.with(e.user, e.channel, :reload) do
					@bot.quit
				end
			end
		end
	end
end