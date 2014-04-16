module UC6
  module Readings
    class Disk
      include Hashable
      attr_accessor :reading_at, :usage_btyes, :read_kilobytes, :write_kilobytes

      def initialize(at, usage, read, write)
        @reading_at = at
        @usage_bytes = usage 
        @read_kilobytes = read 
        @write_kilobytes = write
      end
    end
  end
end
