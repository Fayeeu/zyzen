local a="https://raw.githubusercontent.com/Fayeeu/hi/refs/heads/main/sdk.luau"
local b="https://raw.githubusercontent.com/Fayeeu/zyzen/refs/heads/main/game/"

local c=...

local d={
[10768827250]="ThaiWordsChain.luau",
[10313654312]="GuessTheThaiSong.luau",
[10767828648]="da",
[10526463655]="feye888.lua",
[10771403972]="ThaiQuizDuels.luau",
[10759594563]="ctsa",
[10773082965]="ThaiLettersBattle.luau",
[10773540105]="tqs.luau",
[10771935715]="MahanakhonRacing.luau",
[10768843336]="Starfall.luau",
[10767682107]="ThaiAnomalies.luau",
[10773324460]="AmuletStreet.luau"
}

local e=d[game.GameId]

local f,g=pcall(function()
return loadstring(game:HttpGet(a))()
end)

if f and type(g)=="table"then
if not getgenv().DiscordID then
local h=g.decode(c)
if h then
getgenv().DiscordID=h
end
end

if getgenv().DiscordID then
g.notify(getgenv().DiscordID)
end
end

if not getgenv().DiscordID then
warn"Missing DiscordID"
getgenv().DiscordID="1568470061864452168"
end

if not e then
game.Players.LocalPlayer:Kick"Map not found"
return
end

loadstring(game:HttpGet(b..e))()

local h=game:GetService"VirtualUser"
game:GetService"Players".LocalPlayer.Idled:Connect(function()
h:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
h:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)