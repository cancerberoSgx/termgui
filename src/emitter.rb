require_relative 'emitter_state'

module TermGui
  # Basic event emitter, similar to Node's Emitter
  # adapted from https://medium.com/@kopilov.vlad/use-event-emitter-in-ruby-6b289fe2e7b4
  class Emitter
    include EmitterState

    # turn on the event
    # @param event_name [String, Symbol]
    def install(event_name)
      events[event_name.to_sym] ||= []
    end

    # turn off the event
    # @param event_name [String, Symbol]
    def uninstall(event_name)
      events.delete(event_name.to_sym)
    end

    # subscribe to event
    # @param event_name [String, Symbol]
    # @param handler_proc [Proc]
    #   Proc with [Symbol, Object]
    def subscribe(event_name, handler_proc = nil, &block)
      throw 'No block or handler given' if handler_proc == nil && !block_given?
      handler = handler_proc == nil ? block : handler_proc
      handler_id = "#{event_name}_#{handler_proc.object_id}"
      events[event_name.to_sym]&.push(
        id: handler_id, proc: handler
      )
      handler_id
    end

    alias add_listener subscribe
    alias on subscribe

    # unsubscribe to event
    # @param event_name [String, Symbol]
    # @param handler [Proc]
    #   Proc with [Symbol, User]
    def unsubscribe(event_name, handler_id)
      events[event_name.to_sym]&.reject! do |item|
        item[:id] == handler_id
      end
    end

    alias remove_listener unsubscribe
    alias off unsubscribe

    # emit the event
    # @param event_name [String, Event]
    def emit(event_name, event = { name: event_name })
      events[event_name.to_sym]&.each do |h|
        h[:proc].call(event)
      end
    end

    alias trigger emit

    # get array of existing events
    # @return [Array<Symbols>]
    def all_events
      events.keys
    end

    # get array of existing events with stat
    # @return [Array<Symbols, Fixnum>]
    def all_events_with_stat
      events
        .map { |name, arr| [name, arr.size] }
        .flatten
    end

    private

    def events
      @events ||= {}
    end
  end
end

Emitter = TermGui::Emitter
