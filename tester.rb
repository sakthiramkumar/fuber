Dir.glob('./{models}/*.rb').each { |file| require file }

c1 = Car.new('A', 1, 1)
c2 = Car.new('B', 2, 3)
c3 = HipsterCar.new('C', 4, 5)