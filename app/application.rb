class Application

  @@items = [Item.new("Milk", 3.50), Item.new("Banana", 2.00), Item.new("Ice Cream", 3.75)]


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find do |item_obj| item_obj.name == item_name
      end

      if item != nil
        resp.write item.price 
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
        resp.status = 404
        resp.write "Route not found"
      end
      resp.finish
    end
  end
