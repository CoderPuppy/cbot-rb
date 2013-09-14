CBot::Config::Bot.class_eval do
	attr_reader :nickserv
	def nickserv=(n)
		return unless n.is_a?(Hash)
		
		@nickserv = CBot::Config::NickServ.new(@bot) unless @nickserv.is_a?(CBot::Config::NickServ)
		@nickserv.load(n)
	end
	
	@loaders << proc { |c| self.nickserv = load_prop(c, :nickserv, Hash) }
end

class CBot
	module Plugins
		class NickServ
			include CBot::Plugin
			
			listen_to(:notice, method: :nickserv)
			def nickserv(e)
				conf = @cbot.conf.nickserv
				if conf && e.user && e.user.nick == conf.nickserv_user then
					case e.message
					when conf.nickserv_prompt
						User(conf.nickserv_user).send(conf.nickserv_msg[conf.user, conf.pass])
					when conf.nickserv_done
						@cbot.bus.emit(:join_channels)
					end
				end
			end
		end
	end
end