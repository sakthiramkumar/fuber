require_relative 'base'

class Customer < Base
    attr_accessor :id, :name, :rides, :riding

    def initialize(name)
        @name = name
        @rides = []
        @riding = false
        super()
    end

    def as_hash
        {:name => @name, :id => @id, :riding => @riding}
    end

    def end_ride
        @riding = false
    end


    def add_ride(ride)
        @rides.push(ride)
        @riding = true
    end
    
end