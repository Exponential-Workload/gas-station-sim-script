local DataRemote = game:GetService 'ReplicatedStorage':WaitForChild 'Remote';
return function(...) DataRemote:FireServer(...) end
