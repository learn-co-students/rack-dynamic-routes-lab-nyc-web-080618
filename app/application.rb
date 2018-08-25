class Application

  @@items = [
    Item.new("Apple", 1.30),
    Item.new("Pancakes", 5.75)
  ]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find do |item|
        item.name == item_name
      end
      if item != nil
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end # end if item != nil
    else
      resp.write "Route not found"
      resp.status = 404
    end # end if req.path
    resp.finish
  end # call

end # class Application
