class Location

    attr_accessor :x, :y

    def initialize(x, y)
        @x,@y = x.to_i,y.to_i
    end


    def distance_square(loc)
        (@x - loc.x)**2 + (@y - loc.y)**2
    end

    def as_hash
        {:x => @x, :y => @y}
    end
end