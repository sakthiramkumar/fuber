class Hipster < Customer
    
    attr_accessor :hipster

    def initialize(name)
        @hipster = true
        super(name)
    end

    def as_hash
        super.merge({:hipster => @hipster})
    end

end