module UC6
  module Readings
    class NIC
      include Hashable
      attr_accessor :reading_at, :transmit_kilobits, :receive_kilobits

      def initialize(at, tx, rx)
        @reading_at = at
        @transmit_kilobits = tx
        @receive_kilobits = rx
      end
    end
  end
end
