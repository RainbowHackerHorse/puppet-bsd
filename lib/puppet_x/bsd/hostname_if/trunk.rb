# Module: PuppetX::Hostname_if::Trunk
#
# Responsible for processing the trunk(4) interfaces for hostname_if(5)
#
require 'puppet_x/bsd/util'

module PuppetX
  module BSD
    class Hostname_if
      class Trunk

        attr_reader :content

        def initialize(config)
          @config = config
          ::PuppetX::BSD::Util.normalize_config(@config)

          required_config_items = [
            :interface,
            :proto,
          ]

          optional_config_items = [
            :address,
          ]

          ::PuppetX::BSD::Util.validate_config(
            @config,
            required_config_items,
            optional_config_items
          )
        end

        def content
          data = []
          data << trunk_string()
          data.join(' ')
        end

        def trunk_string
          trunkstring = []
          trunkstring << 'trunkproto' << @config[:proto]

          if @config[:interface].is_a? Array
            @config[:interface].each {|i|
              trunkstring << 'trunkport' << i
            }
          elsif @config[:interface].is_a? String
              trunkstring << 'trunkport' << @config[:interface]
          end

          trunkstring.join(' ')
        end
      end
    end
  end
end

