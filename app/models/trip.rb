class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :rating, presence: true, format: { with: /^[1-5]$/, multiline: true} #multiline to allow the start karat and end dollar sign in regex

  #task is independent of context -- biz logic only
  def earnings
    drivers_trips = self.all(id: params[:id].to_i)
    fee = drivers_trips.length * 1.65 #a fee is subtracted for each trip, multiplied by total trips
    gross_earnings = drivers_trips.cost.reduce(:+) - fee
    net_earnings = gross_earnings * 0.80

    return net_earnings
  end
end
