require 'rails_helper'

RSpec.describe TravelTime do
  describe 'travel time' do
    it 'exist' do
      attr = {
        route: {
          formattedTime: "04:00:00",
          time: 14400
        }

      }

      travel = TravelTime.new(attr)
      expect(travel.travel_time).to eq("04:00:00")
      expect(travel.time_in_hrs).to eq(4)
    end
  end

end