class Card 

    attr_accessor :balance , :minimum_fare , :entry_station, :exit_station
    attr_reader :journeys
    TOP_UP_LIMIT = 90
    

    def initialize(starting_balance)
        @balance = starting_balance
        @minimum_fare = 1 
        @entry_station = nil
        @exit_station = nil
        @journeys = []
        @current_journey = {}
    end

    def top_up (top_up_amount)
        new_balance = @balance += top_up_amount
        if new_balance <TOP_UP_LIMIT
            return @balance
            
        elsif new_balance >TOP_UP_LIMIT
            return "error-balance cannot exceed £#{TOP_UP_LIMIT}"
            
        end

    end

    def touch_in(station)
        @exit_station = nil
        @entry_station = station
        raise "card balance is below minimum balance of £#{@minimum_fare} to touch in" unless balance >= @minimum_fare
        return  
    
    end    


    def deduct(payment_amount)
        @balance -= payment_amount
    end 
    private :deduct 

    

    def touch_out(station)
        @exit_station = station
        journey_maker()
        @entry_station = nil
        deduct(@minimum_fare)
        return
    end  

    def in_journey?
        if @entry_station != nil
            true 
        else
            false  
        end        
    end 
    
    def journey_maker()
        @current_journey = {
            :entry_station  => @entry_station,
            :exit_station => @exit_station
        }
        @journeys << @current_journey
    end 
end