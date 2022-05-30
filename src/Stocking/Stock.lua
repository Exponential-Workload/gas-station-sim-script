local Send = require 'util/SendEvent'
local Action = 'PlaceProduct'
return function(Product, Location) Send(Action, Product, Location) end
