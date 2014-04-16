module UC6
  class Disk
    include Hashable
    attr_accessor :id, :name, :uuid, :type, :maximum_size_bytes
    attr_accessor :readings

    def initialize(hash)
      from_hash(hash)
      @readings = []
    end

    def maximum_size_bytes=(val)
      @maximum_size_bytes = 0 if (@type == "Disk")
      @maximum_size_bytes = val
    end

    def add_reading(at, usage, read, write)
      @readings << Readings::Disk.new(at, usage, read, write)
    end
  end
end
