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
