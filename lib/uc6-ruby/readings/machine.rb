module UC6
  module Readings
    class Machine
      include Hashable
      attr_accessor :reading_at, :cpu_usage_percent, :memory_bytes

      def initialize(at, cpu, memory)
        @reading_at = at
        @cpu_usage_percent = cpu 
        @memory_bytes = memory 
      end
    end
  end
end
