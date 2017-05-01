require 'sinatra'


Dir.glob('./{models}/*.rb').each { |file| require file }

Car.new('Car1', 1500, 1500)
Car.new('Car2', 100, 100)
Car.new('Car3', 500, 500)
Car.new('Car4', -500, -500)
HipsterCar.new('Car3', 100,100)
Customer.new('Sak')
Hipster.new('Hsak')
Hipster.new('HShin')
Customer.new('John')


before do
    content_type 'application/json'
end


post '/cars' do
    car = Car.new(params[:name], params[:x], params[:y])
    car.as_json
end

get '/cars' do
    Car.as_json
end



post '/hcars' do
    car = HipsterCar.new(params[:name], params[:x], params[:y])
    car.as_json
end

get '/hcars' do
    HipsterCar.as_json
end



get '/customers' do 
    Customer.as_json
end

post '/customers' do
    customer = Customer.new(params[:name])
    customer.as_json
end

get '/rides' do
    Ride.as_json
end



get '/hipsters' do 
    Hipster.as_json
end 

post '/hipsters' do
    hipster = Hipster.new(params[:name])
    hipster.as_json
end


post '/customers/:id/book' do
    ride = book_nearest(params[:id], params[:x], params[:y])
    if(ride)
        ride.as_json
    else
        status 400
        cerror('Cars not available')
    end
end

post '/rides/:id/end' do
    ride = end_ride(params[:id], params[:x], params[:y])
    if(ride)
        ride.as_json
    else
        status 400
        cerror('Invalid Ride provided')
    end
end


get '/customer/:id/rides' do
    rides = Ride.get_for_customer(params[:id])
    puts rides
    rides_hash = rides.collect{|ride| ride.as_hash}
    rides_hash.to_json
end


get '/cars_ui' do
    content_type 'text/html'
    send_file 'cars.html'
end


def book_nearest(customer_id, x, y)
    location = Location.new(x,y)
    customer = Customer.get(customer_id)
    car = defined?(customer.hipster) ? HipsterCar.book_nearest(location) : Car.book_nearest(location)
    if(car)
        ride = Ride.new(customer, car, location)
        car.start
        customer.add_ride(ride)
        ride
    else
        false
    end
end


def end_ride(ride_id, x, y)
    location = Location.new(x,y)
        ride = Ride.get(ride_id)
    if(ride)
        ride.finish(location)
        ride
    else
        false
    end
end


def cerror(msg)
    {"error" => msg}.to_json
end

