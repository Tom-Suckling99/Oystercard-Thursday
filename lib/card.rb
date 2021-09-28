class Card

    attr_reader :balance
    TOP_UP_LIMIT = 90

    def initialize(starting_balance)
        @balance = starting_balance
    end

    def top_up (top_up_amount)
        new_balance = @balance += top_up_amount
        if new_balance <TOP_UP_LIMIT
            return @balance
            
        elsif new_balance >TOP_UP_LIMIT
            return "error-balance cannot exceed £#{TOP_UP_LIMIT}"
            
        end

    end




end