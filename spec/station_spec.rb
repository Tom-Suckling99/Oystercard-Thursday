require 'station'

describe Station do

    let(:station) { Station.new(1, "Bolton") }

    it "Should have a zone" do
        expect(station.zone).to eq (1)
    end

    it "Should have a name" do
        expect(station.name).to eq ("Bolton")
    end
end