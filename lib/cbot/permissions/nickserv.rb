class CBot
	class Permissions
		class NickServ < Permissions
			attr_reader :perms
			
			def initialize(bot)
				super(bot)
				
				@perms = {}
			end
			
			def has?(user, channel, perm)
				manager = @perms[user.authname]
				manager.nil? ? nil : manager.has?(user, channel, perm)
			end
		end
	end
end