module UC6
  class NIC
    include Hashable
    attr_accessor :id, :name, :uuid, :kind, :ip_address, :mac_address
    attr_accessor :readings

    NIC_TYPES = {
      'LAN' => 0,
      'WAN' => 1
    }

    def initialize(hash)
      from_hash(hash)
      @readings = []
    end

    def kind=(val)
      @kind = val.is_a?(Integer) ? val : NIC_TYPES[val] 
    end

    def add_reading(at, transmit, receive)
      @readings << Readings::NIC.new(at, transmit, receive)
    end
  end
end
