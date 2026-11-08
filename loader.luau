local a="https://raw.githubusercontent.com/Fayeeu/hi/refs/heads/main/sdk.luau"
local b=...


local c={
[10768827250]="twc",
[10313654312]="gts",
[10767828648]="da",
[10765707128]="gc",
[10526463655]="feye888.lua",
[10771403972]="tqd",
[10759594563]="ctsa",
[10773082965]="tlb",
[10773540105]="tsq.luau",
}

local d=c[game.GameId]


local e,f=pcall(function()
return loadstring(game:HttpGet(a))()
end)

if e and type(f)=="table"then

if not getgenv().DiscordID then
local g=f.decode(b)
if g then
getgenv().DiscordID=g
end
end


if getgenv().DiscordID then
f.notify(getgenv().DiscordID)
end
end

if not getgenv().DiscordID then
warn"Missing DiscordID"
task.wait(3)
return
end

if not d then
game.Players.LocalPlayer:Kick"Map not found"
return
end


loadstring(game:HttpGet(
"https://raw.githubusercontent.com/Fayeeu/hi/refs/heads/main/"..d
))()


local g=game:GetService"VirtualUser"
game:GetService"Players".LocalPlayer.Idled:Connect(function()
g:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
g:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
