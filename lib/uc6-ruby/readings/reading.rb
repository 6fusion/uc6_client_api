module UC6
  module Readings
    class Reading
      include Hashable
      REST_NOUN = 'machines'
      REST_SUB_NOUN = 'readings'
      
      attr_accessor :machine_id, :reading_start_date, :reading_end_date, :cpu_mhz, :memory_megabytes, :disk_io_kilobytes
      attr_accessor :lan_io_kilobits, :wan_io_kilobits, :storage_gigabytes, :consumption_wac
    
      def initialize(client, hash={})
        @client = client
        from_hash(hash)
      end
  
      def get(machine_id, start_date=nil, end_date=nil)
        args_hash = {}
        args_hash.merge!({:since => start_date}) unless start_date.nil?
        args_hash.merge!({:until => end_date}) unless end_date.nil?
  
        http_response = @client.make_request('get', REST_NOUN, REST_SUB_NOUN, machine_id, args_hash)
        response = http_response[:result]
        results = []
        response.each do |current|
          results << Reading.new(@client, current)
        end
        return results
      end
    end
  end
end

