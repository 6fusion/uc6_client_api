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
  class Infrastructure
    include Hashable
    REST_NOUN = "infrastructures"
    REST_SUB_NOUN = nil
    attr_accessor :id, :uuid, :name, :type, :kind, :status, :current_price, :engine_room, :location, :infrastructure_node_abstract
    attr_accessor :networks, :capabilities
    attr_accessor :tags

    def initialize(client, hash={})
      @client = client
      from_hash(hash)
    end

    def find_by_name(name)
      infralist = get()
      infralist.each do |x|
        return x if x.name == name
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
          infra = Infrastructure.new(@client, current)
          results << infra
        end
        return results
      end
      Infrastructure.new(@client, response)
    end

    def delete(id)
      http_response = @client.make_request("delete", REST_NOUN, REST_SUB_NOUN, id)
    end

    def create()
      args_hash = {"name" => name, "agent_version" => @client.agent}
      args_hash.merge!({"tags" => tags}) unless tags.nil?
 
      http_response = @client.make_request("post", REST_NOUN, REST_SUB_NOUN, nil, args_hash)
      response = http_response[:result]
      Infrastructure.new(@client, response)
    end

    def update()
      args_hash = {"name" => name, "agent_version" => @client.agent}
      args_hash.merge!({"tags" => tags}) unless tags.nil?
 
      http_response = @client.make_request("put", REST_NOUN, REST_SUB_NOUN, id, args_hash)
      response = http_response[:result]
      Infrastructure.new(@client, response)
    end
  end
end
