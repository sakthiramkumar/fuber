class HipsterCar < Car
    attr_accessor :color

    def initialize(name, x, y)
        @color = 'pink'
        super(name, x, y)
    end

    def calculate_fare(time, distance)
        super(time,distance) + 5
    end

    def as_hash
        super.merge({:color => @color})
    end

    def self.book_nearest(location)
        allowed_cabs = HipsterCar.data.select{|item| item.available}
        book(allowed_cabs, location)
    end
end