-- Licensed under the AGPL-3.0-OR-LATER
local ProductCFPairs = require('Stocking/Products');
local Stock = require('Stocking/Stock');
return function()
  for Product, poslist in pairs(ProductCFPairs) do for _, Location in pairs(poslist) do Stock(Product, Location); end end
end
