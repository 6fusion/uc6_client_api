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
require 'date'
require 'net/http'
require 'net/https'
require 'openssl'
require 'multi_json'
require 'json'
require 'base64'

require_relative './uc6_client_api/version' unless defined?(UC6::VERSION)
require_relative './uc6_client_api/client' 
require_relative './uc6_client_api/hashable' 
require_relative './uc6_client_api/infrastructure'
require_relative './uc6_client_api/nic'
require_relative './uc6_client_api/machine'
require_relative './uc6_client_api/disk'
require_relative './uc6_client_api/readings/reading'
require_relative './uc6_client_api/readings/nic'
require_relative './uc6_client_api/readings/disk'
require_relative './uc6_client_api/readings/machine'

