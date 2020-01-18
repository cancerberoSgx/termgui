# adapted from tco
# tco - terminal colouring application and library
# Copyright (c) 2013, 2014 Radek Pazdera

module Tco
  class Config
    attr_accessor :options, :colour_values, :names, :styles

    def initialize(locations = [])
      @options = {
        'palette' => 'extended',
        'output' => 'term',
        'disabled' => false
      }
      @colour_values = {}
      @names = {
        'black' => '@0',
        'red' => '@1',
        'green' => '@2',
        'yellow' => '@3',
        'blue' => '@4',
        'magenta' => '@5',
        'cyan' => '@6',
        'light-grey' => '@7',
        'grey' => '@8',
        'light-red' => '@9',
        'light-green' => '@10',
        'light-yellow' => '@11',
        'light-blue' => '@12',
        'light-magenta' => '@13',
        'light-cyan' => '@14',
        'white' => '@15'
      }

      @styles = {}

      locations.each do |conf_file|
        conf_file = File.expand_path conf_file
        next unless File.exist? conf_file

        load conf_file
      end
    end

    private

    def name_exists?(colour_name)
      @names.key? colour_name
    end

    def parse_bool(value)
      return true if value =~ /true/i || value =~ /yes/i || value.to_i >= 1

      false
    end
  end
end
