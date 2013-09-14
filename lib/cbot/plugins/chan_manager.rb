class CBot
	module Plugins
		class ChanManager
			include CBot::Plugin
			
			listen_to :invite, method: :invited
			def invited(m)
				if m.params[0] == @cbot.name then
					@bot.join m.channel
				end
			end
			
			listen_to :kick, method: :kicked
			def kicked(m)
				if m.params[1] == @cbot.name then
					@bot.join m.channel
				end
			end
			
			match /part(?: \#(.+))?/, method: :part
			def part(m, ch = nil)
				ch = @bot.channel_list.find_ensured(ch) if ch.is_a? String
				ch = m.channel unless ch.is_a? Cinch::Channel
				@cbot.perms.with(m.user, ch, :part) { @bot.part(ch) }
			end
		end
	end
end