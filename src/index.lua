local UI = require('ui/index')
local StockTab = UI:CreateTab('Stock', 'Things related to restocking', true);
local InitialStock, Stock, Products, Stockables = require('Stocking/InitialStock'), require('Stocking/Stock'),
                                                  require('Stocking/Products'), {};
for Product in pairs(Products) do table.insert(Stockables, Product) end
StockTab:CreateButton('Initial Stock', InitialStock)
StockTab:CreateDropDown('Stock Product', Stockables,
                        function(Product) for _, Location in pairs(Products[Product]) do Stock(Product, Location) end end)
local EvLoopTimer = 7;
if fireproximityprompt then
  local AutoTab = UI:CreateTab('Automation', 'Lets you automate basic tasks', true);
  local AutoClean = false;
  local AutoRefuel = false;
  local AutoScan = false;
  task.spawn(function()
    while true do
      local DidAction = false;
      if AutoScan and not DidAction then
        for _, ScanPP in pairs(game:GetService 'Workspace'.Checkouts:GetDescendants()) do
          if ScanPP.Name == 'Scan' and ScanPP:IsA 'ProximityPrompt' and ScanPP.Enabled then
            task.wait(1.5)
            if ScanPP.Enabled then
              fireproximityprompt(ScanPP)
              DidAction = true;
              break
            end
          end
        end
      end
      if AutoRefuel and not DidAction then
        for _, Car in pairs(game:GetService 'Workspace':GetChildren()) do
          if string.sub(Car.Name, 1, 3) == 'Car' then
            local Refuel = Car:FindFirstChild 'Lid' and
                               (Car.Lid:FindFirstChild 'Refuel' or Car.Lid:FindFirstChild 'FinishFuel')
            if Refuel and Refuel:IsA 'ProximityPrompt' and Refuel.Enabled then
              task.wait(1.25)
              if Refuel.Enabled then
                fireproximityprompt(Refuel)
                if Refuel.Name ~= 'FinishFuel' then
                  DidAction = true;
                  task.wait(2)
                end
                break
              end
            end
          end
        end
      end
      if AutoClean and not DidAction then
        for _, CleanPP in pairs(game:GetService 'Workspace':GetDescendants()) do
          if CleanPP.Name == 'Clean' and CleanPP:IsA 'ProximityPrompt' and CleanPP.Enabled then
            task.wait(0.5)
            if CleanPP.Enabled then
              fireproximityprompt(CleanPP)
              DidAction = true;
              break
            end
          end
        end
      end
      if DidAction then
        task.wait(EvLoopTimer)
      else
        task.wait(1 / 15)
      end
    end
  end)
  AutoTab:CreateToggle('Auto-Scan', function(arg) AutoScan = arg; end)
  AutoTab:CreateToggle('Auto-Refuel', function(arg) AutoRefuel = arg; end)
  AutoTab:CreateToggle('Auto-Clean', function(arg) AutoClean = arg; end)
  AutoTab:CreateSlider('Task Loop Delay', 5, 10, function(arg) EvLoopTimer = arg end)
end

local CreditTab = UI:CreateTab('Credits', 'Made by Yielding#3961', true);
CreditTab:CreateButton('Made by Yielding#3961', function() end)

if fireproximityprompt then
  CreditTab:CreateButton('Uses a timed task loop,', function() end)
  CreditTab:CreateButton(' so don\'t expect it to do', function() end)
  CreditTab:CreateButton(' things instantly', function() end)
end
