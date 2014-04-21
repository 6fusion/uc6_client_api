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
