class CBot
	class Config
		class NickServ < Config
			def initialize(bot)
				@bot = bot
				self.nickserv_msg = proc { |user, pass| "identify #{user} #{pass}" }
				self.nickserv_prompt = /This nickname is registered\./
				self.nickserv_done = /You are now identified for .*\./
				self.nickserv_user = :NickServ
				self.pass = ''
			end
			
			attr_reader :nickserv_user
			def nickserv_user=(u)
				u = u.to_s if u.is_a? Symbol
				@nickserv_user = u if u.is_a? String
			end
			
			attr_reader :nickserv_prompt
			def nickserv_prompt=(p)
				p = Regexp.new(Regexp.escape(p)) if p.is_a? String
				@nickserv_prompt = p if p.is_a? Regexp
			end
			
			attr_reader :nickserv_done
			def nickserv_done=(p)
				p = Regexp.new(Regexp.escape(p)) if p.is_a? String
				@nickserv_done = p if p.is_a? Regexp
			end
			
			attr_reader :nickserv_msg
			def nickserv_msg=(m)
				@nickserv_msg = m if m.is_a? Proc
			end
			
			def user; @user || @bot.name; end
			def user=(u)
				u = u.to_s if u.is_a? Symbol
				@user = u if u.is_a? String
			end
			
			attr_reader :pass
			def pass=(p)
				p = p.to_s if p.is_a? Symbol
				@pass = p if p.is_a? String
			end
			
			def load(c)
				self.nickserv_user = load_prop(c, :nickserv_user, String) || load_prop(c, :nickserv_user, Symbol)
				self.nickserv_prompt = load_prop(c, :nickserv_prompt, Regexp) || load_prop(c, :nickserv_prompt, String)
				self.user = load_prop(c, :user, String) || load_prop(c, :user, Symbol)
				self.pass = load_prop(c, :pass, String) || load_prop(c, :pass, Symbol)
			end
		end
	end
end