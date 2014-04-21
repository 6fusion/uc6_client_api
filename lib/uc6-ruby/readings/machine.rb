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
