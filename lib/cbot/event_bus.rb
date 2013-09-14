require 'rubygems'
require 'events'
require 'set'

class CBot
	class EventBus
		include Events::Emitter
		
		def register(o)
			if o.is_a? Listener then
				o.class.instance_variable_get(:@listener_handlers).each do |event, handlers|
					handlers.each do |h|
						h = o.method(h) if h.is_a?(Symbol) || h.is_a?(String)
						h = h.to_proc unless h.is_a? Proc
						on(event, &h)
					end
				end
			end
		end
	end
	
	module Listener
		module ClassMethods
			def self.extended(cla)
				cla.instance_eval { @listener_handlers = {} }
			end
			
			def inherited(cla)
				cla.instance_variable_set(:@listener_handlers, @listener_handlers.dup)
			end
			
			def handle(e, m = e)
				@listener_handlers[e] ||= Set.new
				@listener_handlers[e] << m
			end
		end
		
		def self.included(cla); cla.send(:extend, ClassMethods); end
	end
end