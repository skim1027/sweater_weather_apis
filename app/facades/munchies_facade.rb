class MunchiesFacade 
  def food_rec(location, type)
    data = MunchiesService.new.food_rec(location, type)
    Munchies.new(data)
  end
end