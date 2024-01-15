class Munchies
  attr_reader :name, :address, :rating, :reviews
  def initialize(data)
    @id = nil
    @name = data[:businesses][0][:name]
    @address = "#{data[:businesses][0][:location][:address1]}, #{data[:businesses][0][:location][:city]}, #{data[:businesses][0][:location][:state]}, #{data[:businesses][0][:location][:zip_code]}"
    @rating = data[:businesses][0][:rating]
    @reviews = data[:businesses][0][:review_count]
  end

end