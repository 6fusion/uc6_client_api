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
    class Disk
      include Hashable
      attr_accessor :reading_at, :usage_btyes, :read_kilobytes, :write_kilobytes

      def initialize(at, usage, read, write)
        @reading_at = at
        @usage_bytes = usage 
        @read_kilobytes = read 
        @write_kilobytes = write
      end
    end
  end
end
