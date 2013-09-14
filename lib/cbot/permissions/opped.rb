class CBot
	class Permissions
		class Opped < Permissions
			def has?(user, channel, perm)
				channel.opped?(user) || nil
			end
		end
	end
end