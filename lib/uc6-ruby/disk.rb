module UC6
  class Disk
    include Hashable
    attr_accessor :id, :name, :uuid, :type, :maximum_size_bytes
    attr_accessor :readings

    def initialize(hash)
      from_hash(hash)
      @readings = []
    end

    def maximum_size_bytes
      return 0 if (@type == "CD")
      return val
    end

    def type=(val)
      @type = val if (val == 'Disk' or val == 'CD')
    end

    def add_reading(at, usage, read, write)
      @readings << Readings::Disk.new(at, usage, read, write)
    end
  end
end
