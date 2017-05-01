require 'json'

class Base

    class << self
        attr_accessor :data
    end

    def self.as_json
        json_data = []
        if(data != nil)
            data.each do |item|
                json_data.push(item.as_hash)
            end
        end
        json_data.to_json
    end

    def as_json
        as_hash.to_json
    end

    def self.get(id) 
        self.data.select{|item| item.id.to_s == id.to_s}[0]
    end

protected

    def initialize
        @id = self.get_next_id
        add(self)
    end

    def get_next_id
        last_record  = base_entity_class.data.last
        if(last_record)
            last_record.id + 1
        else
            1
        end
    end


private

    def data
        self.class.data ||= []
    end

    def base_entity_class
        klass = sclass = self.class
        while sclass != Base
            klass = sclass
            klass.data ||= []
            sclass = sclass.superclass
        end
        return klass
    end

    def add(item)
        sclass = self.class
        while sclass != Base
            sclass.data.push(item)
            sclass = sclass.superclass
        end
    end

    def set_data(data)
        self.class.data = data
    end

end