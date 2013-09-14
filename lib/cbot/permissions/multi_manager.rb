class CBot
	class Permissions
		class MultiManager < Permissions
			attr_reader :managers
			
			def initialize(bot)
				super(bot)
				@managers = []
			end
			
			def add(m, *args)
				m = m.new(@bot, *args) if m.is_a? Class
				@managers << m
				m
			end
			
			def has?(user, channel, perm)
				managers.each_with_index do |m, i|
					res = m.has?(user, channel, perm)
					case res
					when true
						return true
					when false
						return false
					when Permissions
						managers.insert i + 1, res
					end
				end
				
				nil
			end
		end
	end
end