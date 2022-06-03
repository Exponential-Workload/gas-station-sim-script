-- old gas tation sim script/gist i made in a rush lol
local Items = {};
local c = 0;
local ItemAdded = function(i)
	if i:IsA('ProximityPrompt') then
		if Items[i] then return end
		Items[i] = true;
		local x = 0;
		while not i.Enabled do x=x+1; task.wait(1/30) if x>512 then break end end
		if x > 512 then return print('cancelled on twitter') end
		x=0;
		c=c+1;
		repeat task.wait(1) until c >= 1;
		repeat
			x=x+1
			task.wait(1/3)
			fireproximityprompt(i)
		until not i.Enabled or not i or x > 60
		task.wait(1/3)
		if x > 60 then
			print('cancel')
		end
		c=c-1;
	end
end
local CheckoutAdded = function(c)
	c:WaitForChild('Items').DescendantAdded:Connect(ItemAdded)
end
local Checkouts = game:GetService'Workspace'.Checkouts;
for _,o in pairs(Checkouts:GetChildren()) do CheckoutAdded(o) end;
Checkouts.ChildAdded:Connect(CheckoutAdded);
print('give that wolf a banana')
