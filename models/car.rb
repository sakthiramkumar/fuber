require_relative 'base'
require_relative 'location'

class Car < Base

    TIME_FARE = 1
    DISTANCE_FARE = 2

    attr_accessor :id, :name, :location, :available, :distance

    def initialize(name, x, y)
        @name = name
        @location = Location.new(x,y)
        @available = true
        super()
    end

    def as_hash
        {:id => @id, :name => @name, :location => @location.as_hash, :available => @available}
    end

    def stop(location)
        @location = location
        @available = true
    end

    def start
        @available = false
    end

    def self.book_nearest(location)
        allowed_cabs = Car.data.select{|item| item.available}
        book(allowed_cabs, location)
    end

    def calculate_fare(time, distance)
        (time * TIME_FARE) + (distance * DISTANCE_FARE)
    end


private

    def self.book(allowed_cabs, location)
        calculate_distances(allowed_cabs, location)
        nearest_cab = allowed_cabs.min_by{|car| car.distance}
        nearest_cab 
    end
    
    def self.calculate_distances(allowed_cabs, location)
        allowed_cabs.each do |item|
            item.distance = item.location.distance_square(location)
        end
    end
    
end