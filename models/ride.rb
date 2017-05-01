require_relative 'car'
require_relative 'customer'

class Ride <  Base

    attr_accessor :id, :customer, :car, :start_time, :end_time, :charge, :start_location, :end_location, :ended, :fare

    def initialize(customer, car, start_location)
        @customer, @car, @start_location = customer, car, start_location
        @start_time = Time.now
        @ended = false
        super()
    end

    def finish(location)
        @end_time = Time.now
        @end_location = location
        @ended = true
        @fare = @car.calculate_fare(time, distance)
        @car.stop(location)
        @customer.end_ride
    end

    def as_hash
        if(@ended)
            {:id => @id, :customer => @customer.as_hash, :car => @car.as_hash, :start_time => @start_time, :end_time => @end_time, :start_location => @start_location.as_hash, :end_location => @end_location.as_hash, :fare => @fare}
        else
            {:id => @id, :customer => @customer.as_hash, :car => @car.as_hash, :start_time => @start_time, :end_time => nil, :start_location => @start_location.as_hash, :end_location => nil}
        end
    end


    def self.get_for_customer(id)
        Ride.data.select{|ride| ride.customer.id.to_s == id.to_s}
    end

private

    def time 
        (@end_time - @start_time)/60
    end

    def distance
        Math.sqrt(@end_location.distance_square(@start_location))
    end

end