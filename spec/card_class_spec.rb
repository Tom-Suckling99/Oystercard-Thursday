require 'card_class'


RSpec.describe Card do
    # before(:each) do
    #     @my_oystercard_a = Card.new(10)
    #     @my_oystercard_b = Card.new(0)
    # end
    let(:my_oystercard) { Card.new(10) }
    let(:entry_station) {double :station}
    let(:exit_station) {double :station}
    let(:journey) {double :journey}
    

       
    it "has a starting balance" do
        expect(my_oystercard.balance). to eq (10)
    end

    it "can be topped up" do
        expect(my_oystercard.top_up(10)). to eq (20)
    end

    it "throw error if limit of £90 is exceeded" do
        expect(my_oystercard.top_up(85)). to eq "error-balance cannot exceed £90"
    end

    it "deduct payment from my balance" do

        expect(my_oystercard.send(:deduct, 5)). to eq (5) # @my_oystercard_a.send(:deduct, 5) to override a private method
    end

    it " will raise an error when balance is below minimum balance" do
        my_oystercard.balance = 0

        expect {my_oystercard.touch_in(entry_station)}.to raise_error "card balance is below minimum balance of £#{my_oystercard.minimum_fare} to touch in"
    end 
    
    it "touch in when a card has balance >= 1" do
        my_oystercard.touch_in(entry_station)
    
        expect(my_oystercard).to be_in_journey
    end



    it "touch in card on the barrier" do
        my_oystercard.touch_in(entry_station)
        expect(my_oystercard).to be_in_journey
    end

    it "touch out card on the barrier" do
        my_oystercard.touch_in(entry_station)
        my_oystercard.touch_out(exit_station)
        expect(my_oystercard).not_to be_in_journey
    end

    it "deduct the minimum fair on touch out" do 
        expect {my_oystercard.touch_out(exit_station)}.to change{my_oystercard.balance}.by(-1)
    end  
    
    it "need to know station signed in from" do
        my_oystercard.touch_in(entry_station)
        
        expect(my_oystercard.entry_station).to eq entry_station
    
    end     

    it "set station on card to nill" do
    
        my_oystercard.touch_in(entry_station)
        my_oystercard.touch_out(exit_station)
        
        expect(my_oystercard.entry_station).to eq nil
    
    end 

    it "need to know station touched out from" do
        my_oystercard.touch_out(exit_station)
        
        expect(my_oystercard.exit_station).to eq exit_station
    end  

    it "Should start a card with no journeys" do
        expect(my_oystercard.journeys).to eq []
    end

    it "Should create a journey into journeys" do
        my_oystercard.touch_in(entry_station)
        my_oystercard.touch_out(exit_station)
        expect(my_oystercard.journeys).to eq ["Journey was from #{entry_station} to #{exit_station}"]
    end

    it "Should create a journey into journeys" do
        my_oystercard.touch_in(entry_station)
        my_oystercard.touch_out(exit_station)
        expect(my_oystercard.journeys).to eq [journey]
    end
   
end