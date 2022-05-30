# Gas Station Simulator script

a small [gas station simulator](https://www.roblox.com/games/9359839118/Gas-Station-Simulator) script since im tired of re-writing the same mess every 25 seconds

## loadfile approach

```lua
writefile('Gas Station Simulator.lua',game:HttpGetAsync'https://raw.githubusercontent.com/YieldingExploiter/gas-station-sim-script/main/output.lua');
loadfile('Gas Station Simulator.lua')();
delfile('Gas Station Simulator.lua');
```

## loadstring approach

```lua
loadstring(game:HttpGetAsync'https://raw.githubusercontent.com/YieldingExploiter/gas-station-sim-script/main/output.lua','Gas Station Simulator.lua')();
```
