class CBot
	class Permissions
		class Basic < Permissions
			def initialize(bot, perms = {})
				super(bot)
				
				@perms = perms
			end
			
			def has?(user, channel, perm)
				perm = perm.to_sym if perm.is_a? String
				@perms[perm] || @perms[perm.to_s]
			end
		end
	end
end