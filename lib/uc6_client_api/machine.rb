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
  class Machine
    include Hashable
    REST_NOUN = 'machines'
    REST_SUB_NOUN = nil

    attr_accessor :id, :infrastructure_id, :cpu_count, :cpu_speed_mhz, :tags, :maximum_memory_bytes, :name, :virtual_name
    attr_accessor :uuid, :status
    attr_accessor :agent_version
    attr_accessor :power_state
    attr_accessor :disks, :nics
    attr_accessor :client, :readings

    def initialize(client, hash={})
      from_hash(hash)
      @client = client
      @readings = []
      @agent_version = @client.agent
      @disks = []
      @nics = []
      if (not hash['nics'].nil?)
        hash['nics'].each do |x|
          add_nic(UC6::NIC.new(x))
        end
      end
      if (not hash['disks'].nil?)
        hash['disks'].each do |x| 
          add_disk(UC6::Disk.new(x))
        end
      end
    end

    def power_state=(val)
      @power_state = val ? 'poweredOn' : 'poweredOff'
    end

    def add_disk(disk)
      @disks << disk
    end

    def get_disk(disk_name)
      @disks.each do |x|
        return x if x.name == disk_name
      end
      return nil
    end

    def add_nic(nic)
      @nics << nic
    end

    def get_nic(nic_name)
      @nics.each do |x|
        return x if x.name == nic_name
      end
      return nil
    end

    def add_reading(at, cpu, memory)
      @readings << Readings::Machine.new(at, cpu, memory)
    end

    def find_by_name(current_inf, name)
      machlist = get()
      machlist.each do |x|
        return x if (x.name == name && x.infrastructure_id == current_inf.id)
      end
      return nil
    end

    def get(id=nil)
      http_response = @client.make_request("get", REST_NOUN, REST_SUB_NOUN, id)
      response = http_response[:result]
      return response if response.nil?
      if (response.kind_of?(Array))
        results = []
        response.each do |current|
          infra = Machine.new(@client, current)
          results << infra
        end
        return results
      end
      Machine.new(@client, response)
    end

    def delete(id)
      http_response = @client.make_request("delete", REST_NOUN, REST_SUB_NOUN, id)
    end

    def create()
      http_response = @client.make_request("post", REST_NOUN, REST_SUB_NOUN, nil, self.to_hash)
      response = http_response[:result]
      Machine.new(@client, response)
    end

    def update()
      http_response = @client.make_request("put", REST_NOUN, REST_SUB_NOUN, id, self.to_hash)
      # Update method only returns the status code.  So, we call back to the server to get the
      # new instance of the machine.
      Machine.get(self.id)
    end
  end
end

