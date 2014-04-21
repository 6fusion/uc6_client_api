#   Copyright 2012 6fusion, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
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
