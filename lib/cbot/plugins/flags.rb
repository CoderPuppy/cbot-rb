class CBot
	module Plugins
		class Flags
			include CBot::Plugin
			
			definer = proc do |name, perm, &b|
				prefixed_match(name, /#{Regexp.escape name}(?: (\S+))?(?: \#(\S+))?/) do |e, *args|
					user = e.user
					ch = e.channel
					args.each do |a|
						case a
						when /^\#.+/
							ch = @bot.channel_list.find_ensured(a)
						when String
							user = @bot.user_list.find_ensured(a)
						end
					end
					@cbot.perms.with(e.user, ch, user == e.user ? "#{perm}::self" : perm, e.channel) { instance_exec(e, user, ch, &b) }
				end
			end
			
			definer.call(:op, :opdeop) { |e, user, ch| ch.op(user) }
			definer.call(:deop, :opdeop) { |e, user, ch| ch.deop(user) }
			definer.call(:voice, :voicedevoice) { |e, user, ch| ch.voice(user) }
			definer.call(:devoice, :voicedevoice) { |e, user, ch| ch.devoice(user) }
		end
	end
end