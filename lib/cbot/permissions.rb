class CBot
	class Permissions
		attr_reader :bot
		
		def initialize(bot)
			@bot = bot
		end
		
		def has?(user, channel, perm); false; end
		
		def with(user, channel, perm, reply = channel, &b)
			if has?(user, channel, perm)
				b.call(user, channel)
			else
				reply.send("#{user.nick}: You do not have permission: #{perm.is_a?(Symbol) || perm.is_a?(String) ? perm : perm.inspect}")
			end
		end
	end
	
	require_relative 'permissions/multi_manager.rb'
	require_relative 'permissions/basic.rb'
	require_relative 'permissions/opped.rb'
	require_relative 'permissions/nickserv.rb'
end