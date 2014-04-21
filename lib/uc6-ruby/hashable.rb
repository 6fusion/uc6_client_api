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
  module Hashable
    def from_hash(hash)
      hash.each do |var, val|
        self.send("#{var}=", val)
      end
    end

    def to_hash
      hash = {}
      self.instance_variables.each do |var|
        value = self.instance_variable_get var
        key = var.to_s.delete('@')

        next if (key == 'client')

        if (value.respond_to?(:each))
          new_array = []
          value.each do |curr|
            new_array << (curr.respond_to?(:to_hash) ? curr.to_hash : curr)
          end
          hash[key] = new_array
        else
          hash[key] = value.respond_to?(:json) ? value.json : value
        end
      end
      hash
    end

    def json
      to_hash.to_json
    end
  end
end
