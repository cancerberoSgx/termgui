require_relative 'emitter_state'
require_relative 'util'

# TODO: this is the same as event.rb Event. Move Event classes to individual - non dependency file
class Event
  # @return {String}
  attr_reader :name
  # @param {String} name
  def initialize(name)
    @name = name
  end
end

module TermGui
  # Basic event emitter, similar to Node's Emitter
  # adapted from https://medium.com/@kopilov.vlad/use-event-emitter-in-ruby-6b289fe2e7b4
  class Emitter
    include EmitterState

    # turn on the event
    # @param {String, Symbol, (String|Symbol)[]} event_names
    # @return {nil}
    def install(event_names)
      to_array(event_names).each do |event_name|
        events[event_name.to_sym] ||= []
      end
    end

    # turn off the event
    # @param {String, Symbol, (String|Symbol)[]} event_names
    # @return {nil}
    def uninstall(event_names)
      to_array(event_names).each do |event_name|
        events.delete(event_name.to_sym)
      end
    end

    # subscribe to event
    # @param {String, Symbol, (String|Symbol)[]} event_names
    # @param handler_proc [Proc]
    # @return {Proc}
    def subscribe(event_names, handler_proc = nil, &block)
      throw 'No block or handler given' if handler_proc == nil && !block_given?
      handler = handler_proc == nil ? block : handler_proc
      to_array(event_names).each do |event_name|
        events[event_name.to_sym]&.push handler
      end
      handler
    end

    alias add_listener subscribe
    alias on subscribe

    # unsubscribe to event
    # @param {String, Symbol, (String|Symbol)[]} event_names
    # @param handler [Proc]
    # @return {nil}
    def unsubscribe(event_names, handler)
      to_array(event_names).each do |event_name|
        events[event_name.to_sym]&.reject! do |item|
          item == handler
        end
      end
    end

    alias remove_listener unsubscribe
    alias off unsubscribe

    # emit the event
    # @param {String, Symbol} event_name
    # @param {Event} event
    # @return {nil}
    def emit(event_name, event = Event.new(event_name))
      events[event_name.to_sym]&.each do |h|
        h.call(event)
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

    def once(event_name, handler_proc = nil, &block)
      throw 'No block or handler given' if handler_proc == nil && !block_given?
      handler = handler_proc == nil ? block : handler_proc
      listener = on(event_name) do |event|
        handler.call(event)
        off(event_name, listener)
      end
    end

    private

    def events
      @events ||= {}
    end
  end
end

Emitter = TermGui::Emitter
