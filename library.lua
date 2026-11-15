local a={cache={}}




do
local function MaidFactory()
local b={}
b.__index=b

function b.new()
return setmetatable({_tasks={},_dead=false},b)
end

local function destroyTask(c)
local d=typeof(c)
if d=="RBXScriptConnection"then
c:Disconnect()
elseif d=="Instance"then
c:Destroy()
elseif d=="function"then
c()
elseif d=="thread"then
if coroutine.status(c)~="dead"then
pcall(task.cancel,c)
end
elseif d=="Tween"then
c:Cancel()
elseif d=="table"then
if type(c.Destroy)=="function"then
c:Destroy()
elseif type(c.Clean)=="function"then
c:Clean()
elseif type(c.Disconnect)=="function"then
c:Disconnect()
end
end
end

function b.Give(c,d)
if c._dead then
pcall(destroyTask,d)
return d
end
table.insert(c._tasks,d)
return d
end

function b.Connect(c,d,e)
return c:Give(d:Connect(e))
end

function b.Sub(c)
return c:Give(b.new())
end

function b.Clean(c)
local d=c._tasks
c._tasks={}
for e=#d,1,-1 do
local f,g=pcall(destroyTask,d[e])
if not f then
warn("[shadcn] maid task failed to clean: "..tostring(g))
end
end
end

function b.Destroy(c)
c._dead=true
c:Clean()
end

function b.Count(c)
return#c._tasks
end

return b
end

function a.Maid()
local b=a.cache.maid
if not b then
b={class=MaidFactory()}
a.cache.maid=b
end
return b.class
end




do
local function ThemeFactory()
local b=game:GetService"TweenService"

local function hex(c)
return Color3.fromHex(c)
end

local c={}

c.Themes={
Dark={
Background=hex"0d0f12",
Foreground=hex"d3d6de",
Card=hex"15171b",
CardForeground=hex"d3d6de",
Primary=hex"2156d7",
PrimaryForeground=hex"fafafa",
Secondary=hex"24262b",
SecondaryForeground=hex"d3d6de",
Muted=hex"24262b",
MutedForeground=hex"888c94",
Accent=hex"24262b",
AccentForeground=hex"d3d6de",
Destructive=hex"dc2626",
DestructiveForeground=hex"fafafa",
Border=hex"2e3036",
Input=hex"2e3036",
Ring=hex"51628c",
Sidebar=hex"131418",
SidebarForeground=hex"d3d6de",
SidebarAccent=hex"212429",
SidebarBorder=hex"2e3036",
SidebarPrimary=hex"4477f2",
SidebarPrimaryForeground=hex"fafafa",
Shadow=hex"000000",
SwitchThumb=hex"d3d6de",
Popover=hex"1a1b20",
},
Light={
Background=hex"ececee",
Foreground=hex"232324",
Card=hex"f4f4f5",
CardForeground=hex"232324",
Primary=hex"27272a",
PrimaryForeground=hex"fafafa",
Secondary=hex"e4e4e7",
SecondaryForeground=hex"232324",
Muted=hex"e4e4e7",
MutedForeground=hex"6a6a6b",
Accent=hex"dcdce0",
AccentForeground=hex"232324",
Destructive=hex"dc2626",
DestructiveForeground=hex"fafafa",
Border=hex"d4d4d8",
Input=hex"d4d4d8",
Ring=hex"71717a",
Sidebar=hex"e4e4e7",
SidebarForeground=hex"232324",
SidebarAccent=hex"d4d4d8",
SidebarBorder=hex"d4d4d8",
SidebarPrimary=hex"27272a",
SidebarPrimaryForeground=hex"fafafa",
Shadow=hex"000000",
SwitchThumb=hex"ffffff",
Popover=hex"f4f4f5",
},
White={
Background=hex"ffffff",
Foreground=hex"262626",
Card=hex"ffffff",
CardForeground=hex"262626",
Primary=hex"18181b",
PrimaryForeground=hex"fafafa",
Secondary=hex"f4f4f5",
SecondaryForeground=hex"262626",
Muted=hex"f4f4f5",
MutedForeground=hex"737373",
Accent=hex"f4f4f5",
AccentForeground=hex"262626",
Destructive=hex"ef4444",
DestructiveForeground=hex"fafafa",
Border=hex"e4e4e7",
Input=hex"e4e4e7",
Ring=hex"18181b",
Sidebar=hex"fafafa",
SidebarForeground=hex"262626",
SidebarAccent=hex"f4f4f5",
SidebarBorder=hex"e4e4e7",
SidebarPrimary=hex"18181b",
SidebarPrimaryForeground=hex"fafafa",
Shadow=hex"000000",
SwitchThumb=hex"ffffff",
Popover=hex"ffffff",
},
}

c.Accents={
Default={
Light={
Primary=hex"2156d7",
PrimaryForeground=hex"fafafa",
Ring=hex"2156d7",
SidebarPrimary=hex"2156d7",
SidebarPrimaryForeground=hex"fafafa",
},
},
Zinc={
Dark={
Primary=hex"fafafa",
PrimaryForeground=hex"18181b",
Ring=hex"d4d4d8",
SidebarPrimary=hex"fafafa",
SidebarPrimaryForeground=hex"18181b",
},
Light={
Primary=hex"27272a",
PrimaryForeground=hex"fafafa",
Ring=hex"71717a",
SidebarPrimary=hex"27272a",
SidebarPrimaryForeground=hex"fafafa",
},
},
Blue={
Dark={Primary=hex"3b82f6",PrimaryForeground=hex"f8fafc",Ring=hex"1d4ed8"},
Light={Primary=hex"2563eb",PrimaryForeground=hex"f8fafc",Ring=hex"2563eb"},
},
Green={
Dark={Primary=hex"22c55e",PrimaryForeground=hex"052e16",Ring=hex"15803d"},
Light={Primary=hex"16a34a",PrimaryForeground=hex"f0fdf4",Ring=hex"16a34a"},
},
Orange={
Dark={Primary=hex"ea580c",PrimaryForeground=hex"fafaf9",Ring=hex"ea580c"},
Light={Primary=hex"f97316",PrimaryForeground=hex"fafaf9",Ring=hex"f97316"},
},
Rose={
Dark={Primary=hex"e11d48",PrimaryForeground=hex"fff1f2",Ring=hex"e11d48"},
Light={Primary=hex"e11d48",PrimaryForeground=hex"fff1f2",Ring=hex"e11d48"},
},
Violet={
Dark={
Primary=hex"5d0ec0",
PrimaryForeground=hex"f5f3ff",
Ring=hex"71717b",
SidebarPrimary=hex"8e51ff",
SidebarPrimaryForeground=hex"f5f3ff",
},
Light={
Primary=hex"7008e7",
PrimaryForeground=hex"f5f3ff",
Ring=hex"9f9fa9",
SidebarPrimary=hex"7f22fe",
SidebarPrimaryForeground=hex"f5f3ff",
},
},
Yellow={
Dark={Primary=hex"facc15",PrimaryForeground=hex"422006",Ring=hex"854d0e"},
Light={Primary=hex"facc15",PrimaryForeground=hex"422006",Ring=hex"facc15"},
},
Slate={
Dark={Primary=hex"64748b",PrimaryForeground=hex"f8fafc",Ring=hex"475569"},
Light={Primary=hex"475569",PrimaryForeground=hex"f8fafc",Ring=hex"334155"},
},
Gray={
Dark={Primary=hex"6b7280",PrimaryForeground=hex"f9fafb",Ring=hex"4b5563"},
Light={Primary=hex"4b5563",PrimaryForeground=hex"f9fafb",Ring=hex"374151"},
},
Neutral={
Dark={Primary=hex"737373",PrimaryForeground=hex"fafafa",Ring=hex"525252"},
Light={Primary=hex"525252",PrimaryForeground=hex"fafafa",Ring=hex"404040"},
},
Stone={
Dark={Primary=hex"78716c",PrimaryForeground=hex"fafaf9",Ring=hex"57534e"},
Light={Primary=hex"57534e",PrimaryForeground=hex"fafaf9",Ring=hex"44403c"},
},
Red={
Dark={Primary=hex"ef4444",PrimaryForeground=hex"fef2f2",Ring=hex"b91c1c"},
Light={Primary=hex"dc2626",PrimaryForeground=hex"fef2f2",Ring=hex"b91c1c"},
},
Pink={
Dark={Primary=hex"ec4899",PrimaryForeground=hex"fdf2f8",Ring=hex"be185d"},
Light={Primary=hex"db2777",PrimaryForeground=hex"fdf2f8",Ring=hex"be185d"},
},
Fuchsia={
Dark={Primary=hex"d946ef",PrimaryForeground=hex"fdf4ff",Ring=hex"a21caf"},
Light={Primary=hex"c026d3",PrimaryForeground=hex"fdf4ff",Ring=hex"a21caf"},
},
Purple={
Dark={Primary=hex"a855f7",PrimaryForeground=hex"faf5ff",Ring=hex"7e22ce"},
Light={Primary=hex"9333ea",PrimaryForeground=hex"faf5ff",Ring=hex"7e22ce"},
},
Indigo={
Dark={Primary=hex"6366f1",PrimaryForeground=hex"eef2ff",Ring=hex"4338ca"},
Light={Primary=hex"4f46e5",PrimaryForeground=hex"eef2ff",Ring=hex"4338ca"},
},
Sky={
Dark={Primary=hex"0ea5e9",PrimaryForeground=hex"f0f9ff",Ring=hex"0369a1"},
Light={Primary=hex"0284c7",PrimaryForeground=hex"f0f9ff",Ring=hex"0369a1"},
},
Cyan={
Dark={Primary=hex"06b6d4",PrimaryForeground=hex"ecfeff",Ring=hex"0e7490"},
Light={Primary=hex"0891b2",PrimaryForeground=hex"ecfeff",Ring=hex"0e7490"},
},
Teal={
Dark={Primary=hex"14b8a6",PrimaryForeground=hex"f0fdfa",Ring=hex"0f766e"},
Light={Primary=hex"0d9488",PrimaryForeground=hex"f0fdfa",Ring=hex"0f766e"},
},
Emerald={
Dark={Primary=hex"10b981",PrimaryForeground=hex"ecfdf5",Ring=hex"047857"},
Light={Primary=hex"059669",PrimaryForeground=hex"ecfdf5",Ring=hex"047857"},
},
Lime={
Dark={Primary=hex"84cc16",PrimaryForeground=hex"1a2e05",Ring=hex"4d7c0f"},
Light={Primary=hex"65a30d",PrimaryForeground=hex"1a2e05",Ring=hex"3f6212"},
},
Amber={
Dark={Primary=hex"f59e0b",PrimaryForeground=hex"451a03",Ring=hex"b45309"},
Light={Primary=hex"d97706",PrimaryForeground=hex"451a03",Ring=hex"b45309"},
},
}


local d={}
c.Token=setmetatable({},{
__index=function(e,f)
if c.Themes.Dark[f]==nil then
error("unknown theme token: "..tostring(f),2)
end
local g=d[f]
if not g then
g=table.freeze{__token=f}
d[f]=g
end
return g
end,
})

function c.TokenOf(e)
return if type(e)=="table"then e.__token else nil
end

c.Mode="Dark"
c.Accent="Default"
c.Overrides={}
c.RandomKeys={}
c.Palette={}
c.Defaults={Mode="Dark",Accent="Default"}


local function contrastFor(e)
local f=0.2126*e.R+0.7152*e.G+0.0722*e.B
return if f>0.55 then hex"09090b"else hex"fafafa"
end

function c.Build()
local e=c.Themes[c.Mode]or c.Themes.Dark
local f=c.Accent
local g=table.clone(e)

if typeof(f)=="Color3"then
g.Primary=f
g.PrimaryForeground=contrastFor(f)
g.Ring=f
g.SidebarPrimary=f
g.SidebarPrimaryForeground=g.PrimaryForeground
else
local h=c.Accents[f]
local i=h and h[c.Mode]
if h and not i and c.Mode~="Dark"then
i=h.Light
end
if i then
for j,k in pairs(i)do
g[j]=k
end
if not i.SidebarPrimary and i.Primary then
g.SidebarPrimary=i.Primary
g.SidebarPrimaryForeground=g.PrimaryForeground
end
end
end

for h,i in pairs(c.Palette[c.Mode]or{})do
g[h]=i
end
for h,i in pairs(c.Overrides)do
g[h]=i
end
return g
end

c.Radius={Sm=4,Md=6,Lg=7,Xl=10,Xxl=13,Full=999}
c.TextSize={Xs=12,Sub=13,Sm=14,Title=15,Base=16,Lg=18}
c.Fast=TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
c.Current=c.Themes.Dark





local e=120
local f={}
local g={}
local h={}

function c.Tween(i,j,k)
local l=b:Create(i,k or c.Fast,j)
l:Play()
return l
end

function c.Color(i)
return c.Current[i]
end

local function unbindInstance(i)
local j=f[i]
if j then
for k,l in pairs(j)do
local m=g[l]
if m then
m[i]=nil
end
end
f[i]=nil
end
local k=h[i]
if k then
k:Disconnect()
h[i]=nil
end
end

local function registerBinding(i,j,k)
local l=f[i]
if not l then
l={}
f[i]=l
h[i]=i.Destroying:Connect(function()
unbindInstance(i)
end)
end

local m=l[j]
if m and m~=k then
local n=g[m]
local o=n and n[i]
if o then
o[j]=nil
if next(o)==nil then
n[i]=nil
end
end
end

l[j]=k

local n=g[k]
if not n then
n={}
g[k]=n
end
local o=n[i]
if not o then
o={}
n[i]=o
end
o[j]=true
end

function c.Bind(i,j,k)
registerBinding(i,j,k)
i[j]=c.Current[k]
end

function c.Rebind(i,j,k)
registerBinding(i,j,k)
c.Tween(i,{[j]=c.Current[k]})
end

function c.Apply(i,j)
local k=c.Current
c.Current=i


local l={}
for m,n in pairs(g)do
local o=i[m]
if o and o~=k[m]then
for p,q in pairs(n)do
local r=l[p]
if not r then
r={}
l[p]=r
end
for s in pairs(q)do
r[s]=o
end
end
end
end

local m=0
for n in pairs(l)do
m+=1
end
local n=(not j)and m<=e

for o,p in pairs(l)do
if n then
c.Tween(o,p)
else
for q,r in pairs(p)do
o[q]=r
end
end
end
end

function c.Prune()end

function c.Count()
local i=0
for j in pairs(f)do
i+=1
end
return i
end

function c.Reset()
for i in pairs(h)do
unbindInstance(i)
end
table.clear(f)
table.clear(g)
c.Mode="Dark"
c.Accent="Default"
c.Overrides={}
c.Palette={}
c.Defaults={Mode="Dark",Accent="Default"}
c.Current=c.Themes.Dark
end

return c
end

function a.Theme()
local b=a.cache.theme
if not b then
b={class=ThemeFactory()}
a.cache.theme=b
end
return b.class
end
end




do
local function FontsFactory()
local b="rbxassetid://12187365364"
local c="rbxasset://fonts/families/RobotoMono.json"
local d="zyzen/fonts"

local e={
{name="Regular",weight=400,enum=Enum.FontWeight.Regular},
{name="Medium",weight=500,enum=Enum.FontWeight.Medium},
{name="SemiBold",weight=600,enum=Enum.FontWeight.SemiBold},
{name="Bold",weight=700,enum=Enum.FontWeight.Bold},
}

local f={
Regular=Font.new(b,Enum.FontWeight.Regular),
Medium=Font.new(b,Enum.FontWeight.Medium),
SemiBold=Font.new(b,Enum.FontWeight.SemiBold),
Bold=Font.new(b,Enum.FontWeight.Bold),
Heading=Font.new(b,Enum.FontWeight.SemiBold),
HeadingMedium=Font.new(b,Enum.FontWeight.Medium),
Mono=Font.new(c,Enum.FontWeight.Regular),
Family="Inter",
Url="https://gitlab.com/Andrxssy/library/-/raw/main/roblox/fonts/",
}

local g

local function applyInterFonts()
for h,i in ipairs(e)do
f[i.name]=Font.new(b,i.enum)
end
f.Family="Inter"
end

local function tryLoadOutfit()
local h,i,j,k,l=
writefile,readfile,isfile,makefolder,getcustomasset

if not(h and j and k and l)then
return nil
end

pcall(k,"zyzen")
pcall(k,d)

local m={}
for n,o in ipairs(e)do
local p=d.."/Outfit-"..o.name..".ttf"
local q=j(p)and i and#i(p)>1000
if not q then
local r,s=pcall(function()
return game:HttpGet(f.Url.."Outfit-"..o.name..".ttf")
end)
if not r or type(s)~="string"or string.sub(s,1,4)~="\0\1\0\0"then
return nil
end
h(p,s)
end
table.insert(m,{
name=o.name,
weight=o.weight,
style="normal",
assetId=l(p),
})
end

local n=d.."/Outfit.json"
h(n,game:GetService"HttpService":JSONEncode{name="Outfit",faces=m})
return l(n)
end

function f.Load(h)
local i=h or"Inter"
if g==i then
return f.Family
end
g=i

if i~="Outfit"then
applyInterFonts()
return f.Family
end

local j,k=pcall(tryLoadOutfit)
if not j or not k then
applyInterFonts()
return f.Family
end

for l,m in ipairs(e)do
f[m.name]=Font.new(k,m.enum)
end
f.Family="Outfit"
return f.Family
end

function f.Reset()
g=nil
applyInterFonts()
end

return f
end

function a.Fonts()
local b=a.cache.fonts
if not b then
b={class=FontsFactory()}
a.cache.fonts=b
end
return b.class
end
end




do
local function IconsFactory()
local b={}
b.Url="https://gitlab.com/Fayeeu/library/-/raw/main/shadcn-icons.luau"

local c={
add="plus",subtract="minus",close="x",
["close-circle"]="circle-x",
["checkbox-circle"]="circle-check",
["check-double"]="check-check",
["error-warning"]="alert-circle",
alert="triangle-alert",
information="info",
question="circle-help",
loader="loader-circle",
home="home",
dashboard="layout-dashboard",
apps="layout-grid",
["side-bar"]="panel-left",
menu="menu",
more="ellipsis",
["more-2"]="ellipsis-vertical",
["arrow-down-s"]="chevron-down",
["arrow-up-s"]="chevron-up",
["arrow-left-s"]="chevron-left",
["arrow-right-s"]="chevron-right",
["expand-up-down"]="chevrons-up-down",
user="user",
["user-settings"]="user-cog",
team="users",
group="users",
settings="settings",
equalizer="sliders-horizontal",
palette="palette",
brush="brush",
eye="eye",
["eye-off"]="eye-off",
lock="lock",
["lock-unlock"]="lock-open",
shield="shield",
["shield-check"]="shield-check",
sword="sword",
crosshair="crosshair",
focus="focus",
["focus-3"]="crosshair",
mic="mic",
["mic-off"]="mic-off",
["volume-up"]="volume-2",
["volume-mute"]="volume-x",
heart="heart",
["heart-pulse"]="heart-pulse",
["first-aid-kit"]="briefcase-medical",
["map-pin"]="map-pin",
compass="compass",
search="search",
notification="bell",
["notification-off"]="bell-off",
time="clock",
timer="timer",
calendar="calendar",
file="file",
["file-list"]="file-text",
folder="folder",
save="save",
download="download",
upload="upload",
refresh="refresh-cw",
restart="rotate-cw",
["delete-bin"]="trash-2",
edit="pencil",
pencil="pencil",
code="code",
terminal="terminal",
["terminal-box"]="square-terminal",
bug="bug",
flashlight="zap",
flash="zap",
fire="flame",
star="star",
sun="sun",
moon="moon",
contrast="sun-moon",
["logout-box"]="log-out",
["logout-box-r"]="log-out",
["login-box"]="log-in",
["shut-down"]="power",
fullscreen="maximize",
["fullscreen-exit"]="minimize",
link="link",
global="globe",
earth="earth",
gamepad="gamepad-2",
keyboard="keyboard",
mouse="mouse",
cursor="mouse-pointer",
computer="monitor",
smartphone="smartphone",
database="database",
server="server",
cpu="cpu",
["money-dollar-circle"]="circle-dollar-sign",
coin="coins",
["shopping-cart"]="shopping-cart",
gift="gift",
trophy="trophy",
["vip-crown"]="crown",
magic="wand-sparkles",
sparkling="sparkles",
robot="bot",
ghost="ghost",
skull="skull",
walk="footprints",
run="person-standing",
car="car",
plane="plane",
rocket="rocket",
anchor="anchor",
leaf="leaf",
plant="sprout",
drop="droplet",
windy="wind",
["box-3"]="box",
archive="archive",
inbox="inbox",
mail="mail",
["chat-3"]="message-circle",
message="message-square",
["send-plane"]="send",
share="share-2",
filter="filter",
["list-check"]="list-checks",
["list-unordered"]="list",
layout="layout-panel-left",
["drag-move"]="move",
grid="grid-3x3",
image="image",
camera="camera",
video="video",
music="music",
play="play",
pause="pause",
stop="square",
}

local d={
["alert-circle"]="exclamationmarkCircle",
["circle-alert"]="exclamationmarkCircle",
["app-window"]="macwindow",
bell="bell",check="checkmark",
["chevron-down"]="chevronDown",
["chevron-up"]="chevronUp",
["chevron-left"]="chevronLeft",
["chevron-right"]="chevronRight",
["chevrons-up-down"]="chevronUpChevronDown",
["circle-check"]="checkmarkCircle",
["circle-x"]="xmarkCircle",
component="cubeTransparent",
box="cube",crosshair="scope",target="target",
download="squareAndArrowDown",upload="squareAndArrowUp",
eye="eye",["eye-off"]="eyeSlash",heart="heart",
["heart-pulse"]="waveformPathEcg",
home="house",house="house",info="infoCircle",
keyboard="keyboard",["layout-grid"]="squareGrid2x2",
lock="lock",["log-out"]="rectanglePortraitAndArrowRight",
["maximize-2"]="arrowUpLeftAndArrowDownRight",
["minimize-2"]="arrowDownRightAndArrowUpLeft",
mic="mic",minus="minus",plus="plus",
moon="moon",sun="sunMax",["sun-dim"]="sunMin",
["sun-moon"]="circleLefthalfStripedHorizontal",
["mouse-pointer-click"]="cursorarrowClick",
["mouse-pointer"]="cursorarrow",
palette="paintpalette",brush="paintbrush",
["panel-left"]="sidebarLeft",["panel-left-open"]="sidebarLeft",
play="play",plug="powerplug",
radio="dotRadiowavesLeftAndRight",
["refresh-cw"]="arrowClockwise",
["rotate-cw"]="arrowClockwise",
["rotate-ccw"]="arrowCounterclockwise",
undo="arrowCounterclockwise",
ellipsis="ellipsis",["scan-eye"]="viewfinder",
search="magnifyingglass",settings="gearshape",
shuffle="shuffle",["sliders-horizontal"]="sliderHorizontal3",
tag="tag",["text-cursor-input"]="characterCursorIbeam",
["toggle-right"]="switch2",
["triangle-alert"]="exclamationmarkTriangle",
trash="trash",["trash-2"]="trash",
type="textformat",x="xmark",zap="bolt",
send="paperplane",lightbulb="lightbulb",
rocket="paperplane",swords="figureFencing",
sword="figureFencing",
["loader-circle"]="arrowTriangle2Circlepath",
loader="arrowTriangle2Circlepath",
inbox="tray",["list-checks"]="checklist",
link="link",folder="folder",pencil="pencil",
star="star",shield="shield",flame="flame",
globe="globe",user="person",users="person2",
copy="docOnDoc",clipboard="docOnClipboard",
calendar="calendar",clock="clock",map="map",
["map-pin"]="mappin",car="car",
["gamepad-2"]="gamecontroller",
["shopping-cart"]="cart",gift="gift",
crown="crown",sparkles="sparkles",
["wand-sparkles"]="wandAndStars",
wrench="wrenchAdjustable",hammer="hammer",
skull="exclamationmarkOctagon",ghost="eyeSlash",
cpu="cpu",server="serverRack",database="cylinder",
terminal="appleTerminal",
code="chevronLeftForwardslashChevronRight",
bug="ant",image="photo",camera="camera",
video="video",music="musicNote",pause="pause",
square="square",filter="line3HorizontalDecrease",
menu="line3Horizontal",
["ellipsis-vertical"]="ellipsis",
["arrow-left"]="arrowLeft",
["arrow-right"]="arrowRight",
["arrow-up"]="arrowUp",
["arrow-down"]="arrowDown",
["external-link"]="arrowUpRightSquare",
["log-in"]="rectanglePortraitAndArrowForward",
power="power",wifi="wifi",battery="battery100percent",
["volume-2"]="speakerWave2",
["volume-x"]="speakerSlash",
["mic-off"]="micSlash",["bell-off"]="bellSlash",
["lock-open"]="lockOpen",key="key",
coins="dollarsignCircle",trophy="trophy",
["target-arrow"]="scope",
move="arrowUpAndDownAndArrowLeftAndRight",
grip="line3Horizontal",["chart-bar"]="chartBar",
["bar-chart"]="chartBar",
["line-chart"]="chartLineUptrendXyaxis",
["pie-chart"]="chartPie",
}

local e={Lucide=nil,SF=nil}
local f={}
local g={}
local h={}
local i=setmetatable({},{__mode="k"})

local function filesystemAvailable()
return writefile~=nil
and readfile~=nil
and isfile~=nil
and makefolder~=nil
and getcustomasset~=nil
end

local j="zyzen/icons"
local k="zyzen/gifs"

local function getHttpRequest()
return(syn and syn.request)
or(http and http.request)
or http_request
or request
end

local function hashString(l)
local m=5381
for n=1,#l do
m=(m*33+string.byte(l,n))%4294967296
end
return string.format("%x",m)
end

local function urlExtension(l)
local m=string.match(l,"^([^?#]+)")or l
local n="png"
for o in string.gmatch(m,"%.(%w+)")do
n=o
end
if#n<2 or#n>5 then
n="png"
end
return string.lower(n)
end

local function isGifUrl(l)
if type(l)~="string"or not string.find(l,"://",1,true)then
return false
end
local m=string.lower(string.match(l,"^([^?#]+)")or l)
if string.sub(m,-4)==".gif"then
return true
end
local n=string.lower(string.match(l,"%?([^#]+)")or"")
return string.find(n,"format=gif",1,true)~=nil
end

local function validGifMeta(l)
return type(l)=="table"
and type(l.columns)=="number"and l.columns>0
and type(l.totalFrames)=="number"and l.totalFrames>0
and type(l.frameWidth)=="number"and l.frameWidth>0
and type(l.frameHeight)=="number"and l.frameHeight>0
end

local function convertAndCacheGif(l)
if type(l)~="string"or l==""then
return nil,nil
end
local m=g[l]
if m then
return m.asset,m.meta
end

if writefile==nil or getcustomasset==nil then
warn"[Zyzen] writefile/getcustomasset unavailable for GIF support"
return nil,nil
end

local n=game:GetService"HttpService"
local o=makefolder~=nil
if o then
pcall(makefolder,"zyzen")
pcall(makefolder,k)
end

local p=hashString(l)
local q=if o then(k.."/")else"zyzen_gif_"
local r=q..p..".png"
local s=q..p..".json"

if isfile~=nil and readfile~=nil and isfile(r)and isfile(s)then
local t,u=pcall(function()
return n:JSONDecode(readfile(s))
end)
if t and validGifMeta(u)then
u.fps=(type(u.fps)=="number"and u.fps>0)and u.fps or 15
local v,w=pcall(getcustomasset,r)
if v and type(w)=="string"and w~=""then
h[w]=u
g[l]={asset=w,meta=u}
return w,u
end
end
end

local t=getHttpRequest()
if not t then
warn"[Zyzen] HTTP request function unavailable for GIF conversion"
return nil,nil
end

local u,v=pcall(t,{
Url=b.GifEndpoint,
Method="POST",
Headers={
["Content-Type"]="application/json",
},
Body=n:JSONEncode{
gifUrl=l,
},
})

if not u or type(v)~="table"or v.StatusCode~=200 or type(v.Body)~="string"or#v.Body==0 then
warn("[Zyzen] GIF convert error:",u and(v and v.Body or"empty response")or v)
return nil,nil
end

local w={}
if type(v.Headers)=="table"then
for x,y in pairs(v.Headers)do
w[string.lower(tostring(x))]=tonumber(y)
end
end

local x={
columns=w["x-columns"],
totalFrames=w["x-total-frames"],
frameWidth=w["x-frame-width"],
frameHeight=w["x-frame-height"],
fps=w["x-fps"]or 15,
}
if x.fps<=0 then
x.fps=15
end

if not validGifMeta(x)then
warn"[Zyzen] GIF response missing sprite metadata headers"
return nil,nil
end

local y=pcall(writefile,r,v.Body)
if not y then
return nil,nil
end
pcall(writefile,s,n:JSONEncode(x))

local z,A=pcall(getcustomasset,r)
if not z or type(A)~="string"or A==""then
return nil,nil
end

h[A]=x
g[l]={asset=A,meta=x}
return A,x
end

local function cacheUrlIcon(l)
if type(l)~="string"or l==""then
return l
end
if f[l]then
return f[l]
end

local m=l
if filesystemAvailable()then
pcall(makefolder,"zyzen")
pcall(makefolder,j)

local n=j.."/"..hashString(l).."."..urlExtension(l)

local o=true
if not isfile(n)then
local p,q=pcall(function()
return game:HttpGet(l)
end)
if p and type(q)=="string"and#q>0 then
local r=pcall(writefile,n,q)
if not r then
o=false
end
else
o=false
end
end

if o and isfile(n)then
local p,q=pcall(getcustomasset,n)
if p and type(q)=="string"and q~=""then
m=q
end
end
end

f[l]=m
return m
end

b.Set="SF"
b.SFUrl="https://gitlab.com/Fayeeu/library/-/raw/main/shadcn-sf.luau"
b.GifEndpoint="https://mayesgun.vercel.app/con"

local function loadRemoteIconTable(l)
local m,n=pcall(function()
return loadstring(game:HttpGet(l))()
end)
if m and type(n)=="table"then
return n
end
return{}
end

function b.Load(l)
if type(l)=="table"then
e.Lucide=l
return true
end
local m=loadRemoteIconTable(l or b.Url)
e.Lucide=m
return next(m)~=nil
end

local function getIconSet(l)
local m=e[l]
if not m then
if l=="SF"then
m=loadRemoteIconTable(b.SFUrl)
else
m=loadRemoteIconTable(b.Url)
end
e[l]=m
end
return m
end


local function toCamelCase(l)
local m,n="",true
for o in string.gmatch(l,"[^%.%-_%s]+")do
if n then
m=o
n=false
else
m..=string.upper(string.sub(o,1,1))..string.sub(o,2)
end
end
return m
end

local function findSFIcon(l)
local m=getIconSet"SF"
local n=m[l]or m[toCamelCase(l)]
if n then
return n
end
local o=d[string.lower(l)]
if o then
return m[o]
end
return nil
end

local function findLucideIconById(l,m)
local n=string.gsub(m,"^ri%-","")
n=string.gsub(n,"%-line$","")
n=string.gsub(n,"%-fill$","")
local o=c[n]
if not o then
local p=string.gsub(n,"%-%d+$","")
o=c[p]or p
end
return l[o]or l[n]
end

local function getLucideAsset(l)
local m=getIconSet"Lucide"
local n=string.lower(l)
local o=m[n]
if not o then
o=findLucideIconById(m,n)
end
if o then
return"rbxassetid://"..o
end
return nil
end

function b.Get(l)
if l==nil then return nil end
if type(l)=="number"then return"rbxassetid://"..l end
if type(l)~="string"or l==""then return nil end
if string.find(l,"^%d+$")then return"rbxassetid://"..l end
if string.find(l,"://",1,true)then
if isGifUrl(l)then
local m=convertAndCacheGif(l)
if m then
return m
end
end

return cacheUrlIcon(l)
end

local m,n=string.match(l,"^(%a+):(.+)$")
if m then
m=string.lower(m)
if m=="sf"then
return findSFIcon(n)
elseif m=="lucide"then
return getLucideAsset(n)
elseif m=="gif"then
return convertAndCacheGif(n)
end
end

if b.Set=="SF"then
return findSFIcon(l)or getLucideAsset(l)
end
return getLucideAsset(l)or findSFIcon(l)
end

function b.IsGif(l)
if type(l)~="string"then return false end
if h[l]~=nil then return true end
if string.sub(string.lower(l),1,4)=="gif:"then return true end
return isGifUrl(l)
end

function b.GetGif(l)
if type(l)~="string"or l==""then
return nil,nil
end
local m=string.gsub(l,"^[gG][iI][fF]:","")
return convertAndCacheGif(m)
end

function b.GetGifMeta(l)
if type(l)~="string"then return nil end
if h[l]then
return h[l]
end
local m=string.gsub(l,"^[gG][iI][fF]:","")
local n=g[m]
return n and n.meta or nil
end

function b.AttachGif(l,m)
if not l or not l:IsA"ImageLabel"then
return false
end

local n=m or l.Image
local o=h[n]
if not o then
if i[l]~=nil then
i[l]=nil
l.ImageRectSize=Vector2.new(0,0)
l.ImageRectOffset=Vector2.new(0,0)
end
return false
end

local p={}
i[l]=p

local q=o.columns
local r=o.totalFrames
local s=o.frameWidth
local t=o.frameHeight
local u=o.fps or 15

l.ImageRectSize=Vector2.new(s,t)
l.ImageRectOffset=Vector2.new(0,0)

task.defer(function()
local v=0
while i[l]==p and l.Parent and l.Image==n do
local w=v%q
local x=math.floor(v/q)
l.ImageRectOffset=Vector2.new(w*s,x*t)
v=(v+1)%r
task.wait(1/u)
end
if i[l]==p then
i[l]=nil
end
end)

return true
end

function b.Apply(l,m,n)
if not l or not l:IsA"ImageLabel"then
return nil,nil
end
local o,p
if n then
o,p=b.GetGif(m)
else
o=b.Get(m)
p=h[o]
end
l.Image=o or""
b.AttachGif(l,o)
return o,p
end

function b.IsImage(l)
if type(l)=="number"then return true end
if type(l)~="string"then return false end
return string.find(l,"^%d+$")~=nil
or string.find(l,"://",1,true)~=nil
or string.find(l,"rbxasset",1,true)~=nil
end

function b.Reset()
e.Lucide=nil
e.SF=nil
b.Set="SF"
b.GifEndpoint="https://mayesgun.vercel.app/con"
for l in pairs(f)do
f[l]=nil
end
for l in pairs(g)do
g[l]=nil
end
for l in pairs(h)do
h[l]=nil
end
for l in pairs(i)do
i[l]=nil
end
end

return b
end

function a.Icons()
local b=a.cache.icons
if not b then
b={class=IconsFactory()}
a.cache.icons=b
end
return b.class
end
end




do
local function CreatorFactory()
local b=game:GetService"Players"
local c=game:GetService"TextService"
local d=a.Theme()
local e=a.Fonts()
local f=a.Icons()
local g={}

g.Token=d.Token

local h
function g.SelectionRing()
if not h then
local i=Instance.new"Frame"
i.Name="SelectionRing"
i.BackgroundTransparency=1
i.Size=UDim2.new(1,6,1,6)
i.Position=UDim2.fromOffset(-3,-3)

local j=Instance.new"UICorner"
j.CornerRadius=UDim.new(0,8)
j.Parent=i

local k=Instance.new"UIStroke"
k.Thickness=2
k.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
k.Parent=i
d.Bind(k,"Color","Ring")

h=i
end
return h
end

function g.Create(i,j,k)
local l=Instance.new(i)

if l:IsA"GuiButton"then
l.SelectionImageObject=g.SelectionRing()
end

if j then
for m,n in pairs(j)do
if m~="Parent"then
local o=d.TokenOf(n)
if o then
d.Bind(l,m,o)
else
l[m]=n
end
end
end
end

if k then
for m,n in ipairs(k)do
n.Parent=l
end
end

if j and j.Parent then
l.Parent=j.Parent
end

if l:IsA"ImageLabel"then
f.AttachGif(l)
l:GetPropertyChangedSignal"Image":Connect(function()
f.AttachGif(l)
end)
end

return l
end

local i=g.Create

function g.Corner(j)
return i("UICorner",{CornerRadius=UDim.new(0,j)})
end

function g.Stroke(j,k)
return i("UIStroke",{
Color=j,
Thickness=k or 1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
})
end

function g.ApplyGlassStroke(j,k,l,m)
if not j then return nil end
local n=m or{}
j.Transparency=0
local o=j:FindFirstChildOfClass"UIGradient"or i("UIGradient",{
Rotation=n.Rotation or 135,
Parent=j,
})

local function apply(p)
local q=p or d.Current
local r=q.Background or Color3.fromRGB(13,15,18)
local s=0.2126*r.R+0.7152*r.G+0.0722*r.B
local t=s<0.5
local u=if t
then(n.DarkSeq or{0.80,0.90,0.95,0.88})
else(n.LightSeq or{0.72,0.84,0.91,0.82})
o.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,u[1]),
NumberSequenceKeypoint.new(0.35,u[2]),
NumberSequenceKeypoint.new(0.75,u[3]),
NumberSequenceKeypoint.new(1,u[4]),
}
end

apply(d.Current)
if l then
local p=l:Connect(apply)
if k then k:Give(p)end
j.Destroying:Connect(function()
p:Disconnect()
end)
end
return o
end

function g.ApplyGlass(j,k,l,m,n)
if not j then return end
local o=n or{}
local p=i("UIGradient",{
Rotation=135,
Parent=j,
})
if k then
g.ApplyGlassStroke(k,l,m,{
DarkSeq=o.DarkSeq or{0.84,0.92,0.96,0.90},
LightSeq=o.LightSeq or{0.76,0.86,0.92,0.84},
})
end

local function apply(q)
local r=q or d.Current
local s=r.Background or Color3.fromRGB(13,15,18)
local t=0.2126*s.R+0.7152*s.G+0.0722*s.B
local u=t<0.5

local v=o.DarkAlpha or{0.58,0.74,0.64}
local w=o.LightAlpha or{0.45,0.62,0.52}
local x=if u then v else w
p.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,x[1]),
NumberSequenceKeypoint.new(0.5,x[2]),
NumberSequenceKeypoint.new(1,x[3]),
}
end

apply(d.Current)
if m then
local q=m:Connect(apply)
if l then l:Give(q)end
j.Destroying:Connect(function()
q:Disconnect()
end)
end
end

function g.AuroraPalette(j)
local k=j or d.Current
local l=k.Popover or k.Background or Color3.fromRGB(13,15,18)
local m=k.Foreground or Color3.new(1,1,1)
local n=k.Primary or Color3.fromRGB(99,102,241)
local o=k.Ring or k.Accent or n

local p=0.2126*l.R+0.7152*l.G+0.0722*l.B
local q=p<0.5

local r,s,t=n:ToHSV()
local u=math.clamp(s*(if q then 0.92 else 0.78),0.22,0.95)
local v=math.clamp(t,if q then 0.65 else 0.55,1)

local w=Color3.fromHSV((r-0.08)%1,u,v)
local x=n:Lerp(l,if q then 0.08 else 0.04)
local y=Color3.fromHSV((r+0.09)%1,math.clamp(u*0.9,0.2,0.95),v)
local z=y:Lerp(if q then m else o,0.22)

return{
isDark=q,
topColor=if q then m:Lerp(w,0.42)else Color3.new(1,1,1),
topAlpha=if q then 0.89 else 0.92,
primarySeq=ColorSequence.new{
ColorSequenceKeypoint.new(0,w),
ColorSequenceKeypoint.new(0.5,x),
ColorSequenceKeypoint.new(1,y),
},
secondarySeq=ColorSequence.new{
ColorSequenceKeypoint.new(0,y),
ColorSequenceKeypoint.new(0.5,z),
ColorSequenceKeypoint.new(1,w),
},
curtainSeq=ColorSequence.new{
ColorSequenceKeypoint.new(0,x),
ColorSequenceKeypoint.new(0.5,w),
ColorSequenceKeypoint.new(1,z),
},
}
end

g._auroraEnabled=true
g._auroraIntensity=1
g._auroraListeners={}

function g.ScaleAuroraAlpha(j,k)
local l=if k~=nil then k else g._auroraIntensity
return 1-math.clamp((1-j)*l,0,0.92)
end

function g.SetAuroraEnabled(j)
g._auroraEnabled=j~=false
for k in g._auroraListeners do
k(g._auroraEnabled,g._auroraIntensity)
end
end

function g.SetAuroraIntensity(j)
g._auroraIntensity=math.clamp(tonumber(j)or 1,0,2)
for k in g._auroraListeners do
k(g._auroraEnabled,g._auroraIntensity)
end
end

function g.AttachAurora(j,k,l)
if not j then return nil end
local m=l or{}
local n=game:GetService"RunService"

local o=i("Frame",{
Name="AuroraBackground",
BackgroundTransparency=1,
BorderSizePixel=0,
ClipsDescendants=true,
Visible=if m.Enabled~=nil then m.Enabled==true else g._auroraEnabled,
Size=UDim2.fromScale(1,1),
ZIndex=m.ZIndex or 1,
Parent=j,
},{g.Corner(m.Radius or d.Radius.Lg)})

local p=i("Frame",{
Name="TopSheen",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0),
Position=UDim2.fromScale(0.5,-5E-2),
Size=UDim2.fromScale(1.4,0.7),
ZIndex=m.ZIndex or 1,
Parent=o,
})
local q=i("UIGradient",{
Rotation=90,
Parent=p,
})

local r=i("Frame",{
Name="PrimaryRibbon",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.28,0.25),
Size=UDim2.fromScale(1.7,1.7),
ZIndex=m.ZIndex or 1,
Parent=o,
})
local s=i("UIGradient",{
Rotation=-24,
Parent=r,
})

local t=i("Frame",{
Name="SecondaryRibbon",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.72,0.75),
Size=UDim2.fromScale(1.6,1.6),
ZIndex=m.ZIndex or 1,
Parent=o,
})
local u=i("UIGradient",{
Rotation=32,
Parent=t,
})

local function applyPalette(v)
local w=g.AuroraPalette(v)
local x=g.ScaleAuroraAlpha
p.BackgroundColor3=w.topColor
q.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,x(w.topAlpha)),
NumberSequenceKeypoint.new(0.45,x(0.962)),
NumberSequenceKeypoint.new(1,1),
}

r.BackgroundColor3=Color3.new(1,1,1)
s.Color=w.primarySeq
s.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.22,x(0.945)),
NumberSequenceKeypoint.new(0.5,x(if w.isDark then 0.78 else 0.85)),
NumberSequenceKeypoint.new(0.78,x(0.945)),
NumberSequenceKeypoint.new(1,1),
}

t.BackgroundColor3=Color3.new(1,1,1)
u.Color=w.secondarySeq
u.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.24,x(0.955)),
NumberSequenceKeypoint.new(0.5,x(if w.isDark then 0.82 else 0.88)),
NumberSequenceKeypoint.new(0.76,x(0.955)),
NumberSequenceKeypoint.new(1,1),
}
end

applyPalette(d.Current)

local v=m.Phase or 0
local w=n.Heartbeat:Connect(function(w)
if not o.Parent or not o.Visible then return end
v+=math.min(w,0.05)

r.Position=UDim2.fromScale(
0.28+math.sin(v*0.25)*0.16,
0.25+math.cos(v*0.19)*0.12
)
s.Rotation=-24+math.sin(v*0.21)*18

t.Position=UDim2.fromScale(
0.72+math.cos(v*0.22)*0.16,
0.75+math.sin(v*0.17)*0.12
)
u.Rotation=32+math.cos(v*0.18)*20
end)

local x
if m.ThemeChanged then
x=m.ThemeChanged:Connect(applyPalette)
end

local y=g._auroraIntensity
local function onAuroraToggle(z,A)
if o.Parent then
o.Visible=z==true
end
if A~=nil and A~=y then
y=A
applyPalette(d.Current)
end
end
g._auroraListeners[onAuroraToggle]=true

if k then
k:Give(w)
if x then k:Give(x)end
k:Give(function()
g._auroraListeners[onAuroraToggle]=nil
end)
end

o.Destroying:Connect(function()
w:Disconnect()
if x then x:Disconnect()end
g._auroraListeners[onAuroraToggle]=nil
end)

return o
end

function g.Padding(j,k,l,m)
return i("UIPadding",{
PaddingTop=UDim.new(0,j),
PaddingRight=UDim.new(0,k or j),
PaddingBottom=UDim.new(0,l or j),
PaddingLeft=UDim.new(0,m or k or j),
})
end

function g.List(j,k,l)
return i("UIListLayout",{
Padding=UDim.new(0,j),
FillDirection=k or Enum.FillDirection.Vertical,
VerticalAlignment=Enum.VerticalAlignment.Top,
SortOrder=Enum.SortOrder.LayoutOrder,
Wraps=l or false,
})
end

function g.Text(j)
local k={
Name="Text",
BackgroundTransparency=1,
FontFace=e.Regular,
TextSize=d.TextSize.Sm,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
Size=UDim2.new(1,0,0,0),
TextColor3=d.Token.Foreground,
}
for l,m in pairs(j)do
k[l]=m
end
return i("TextLabel",k)
end


local j={}
local k=0
local l=4000

function g.TextWidth(m,n,o)
local p=o.Family.."|"..o.Weight.Name.."|"..n.."|"..m
local q=j[p]
if q then
return q
end

local r,s=pcall(function()
local r=Instance.new"GetTextBoundsParams"
r.Text=m
r.Size=n
r.Font=o
r.Width=10000
r.RichText=string.find(m,"<",1,true)~=nil
return c:GetTextBoundsAsync(r)
end)

if r then
q=s.X
else
q=#m*n*0.5
end

if k>=l then
table.clear(j)
k=0
end
j[p]=q
k+=1
return q
end

local m="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function g.Base64Encode(n)
local o=crypt and crypt.base64encode
if o then
local p,q=pcall(o,n)
if p and type(q)=="string"then
return q
end
end

local p=string.gsub(n,".",function(p)
local q,r=string.byte(p),""
for s=8,1,-1 do
if q%2^s-q%2^(s-1)>0 then
r..="1"
else
r..="0"
end
end
return r
end)

local q=string.gsub(p.."0000","%d%d%d?%d?%d?%d?",function(q)
if#q<6 then return""end
local r=0
for s=1,6 do
if string.sub(q,s,s)=="1"then
r+=2^(6-s)
end
end
return string.sub(m,r+1,r+1)
end)

return q..({"","==","="})[#n%3+1]
end

function g.Base64Decode(n)
local o=crypt and crypt.base64decode
if o then
local p,q=pcall(o,n)
if p and type(q)=="string"then
return q
end
end

local p=string.gsub(n,"[^%w%+/=]","")
local q=string.gsub(p,".",function(q)
if q=="="then return""end
local r,s=(string.find(m,q,1,true)or 1)-1,""
for t=6,1,-1 do
if r%2^t-r%2^(t-1)>0 then
s..="1"
else
s..="0"
end
end
return s
end)

return(string.gsub(q,"%d%d%d?%d?%d?%d?%d?%d?",function(r)
if#r~=8 then return""end
local s=0
for t=1,8 do
if string.sub(r,t,t)=="1"then
s+=2^(8-t)
end
end
return string.char(s)
end))
end

function g.GuiParent()
local n,o=pcall(function()
return gethui()
end)
if n and o then
return o
end

local p,q=pcall(function()
return game:GetService"CoreGui"
end)
if p and q then
return q
end

return b.LocalPlayer:WaitForChild"PlayerGui"
end

return g
end

function a.Creator()
local b=a.cache.creator
if not b then
b={class=CreatorFactory()}
a.cache.creator=b
end
return b.class
end
end




do
local function ConfigFactory()
local b=game:GetService"HttpService"
local c=0.5
local d={}

d.__index=d

local function encodeValue(e)
local f=typeof(e)
if f=="Color3"then
return{__type="Color3",value=e:ToHex()}
elseif f=="EnumItem"then
return{__type="EnumItem",enum=tostring(e.EnumType),value=e.Name}
elseif f=="UDim2"then
return{
__type="UDim2",
value={e.X.Scale,e.X.Offset,e.Y.Scale,e.Y.Offset},
}
elseif f=="Vector2"then
return{__type="Vector2",value={e.X,e.Y}}
elseif f=="table"then
local g={}
for h,i in pairs(e)do
g[h]=encodeValue(i)
end
return g
end
return e
end

local function decodeValue(e)
if type(e)~="table"then
return e
end
local f=e.__type
if f=="Color3"then
return Color3.fromHex(e.value)
elseif f=="EnumItem"then
local g,h=pcall(function()
return(Enum)[e.enum][e.value]
end)
return if g then h else nil
elseif f=="UDim2"then
return UDim2.new(table.unpack(e.value))
elseif f=="Vector2"then
return Vector2.new(table.unpack(e.value))
end

local g={}
for h,i in pairs(e)do
g[h]=decodeValue(i)
end
return g
end

local function splitPath(e)
return string.split(e,".")
end

local function filesystemAvailable()
return writefile~=nil
and readfile~=nil
and isfile~=nil
and makefolder~=nil
and isfolder~=nil
end

function d.new(e,f)
local g=e or{}
local h=setmetatable({
Folder=g.Folder or"zyzen",
File=g.File or"config",
AutoSave=g.AutoSave~=false,
Data={},
_pending=nil,
},d)

f:Give(function()
if h._pending and coroutine.status(h._pending)~="dead"then
task.cancel(h._pending)
end
h._pending=nil
end)

h:Load()
return h
end

function d.Path(e)
return string.format("%s/%s.json",e.Folder,e.File)
end

function d.Load(e)
if not filesystemAvailable()then return false end

local f,g=pcall(function()
if not isfile(e:Path())then return nil end
return b:JSONDecode(readfile(e:Path()))
end)

if f and type(g)=="table"then
e.Data=decodeValue(g)
return true
end
return false
end

function d.Save(e)
if not filesystemAvailable()then return false end

local f=pcall(function()
local f=""
for g,h in ipairs(string.split(e.Folder,"/"))do
f=if f==""then h else f.."/"..h
if not isfolder(f)then
makefolder(f)
end
end
writefile(e:Path(),b:JSONEncode(encodeValue(e.Data)))
end)
return f
end

function d.Get(e,f)
local g=e.Data
for h,i in ipairs(splitPath(f))do
if type(g)~="table"then return nil end
g=g[i]
end
return g
end

function d.Set(e,f,g)
local h=splitPath(f)
local i=e.Data
for j=1,#h-1 do
local k=h[j]
if type(i[k])~="table"then
i[k]={}
end
i=i[k]
end
i[h[#h] ]=g

if e.AutoSave then
e:SaveSoon()
end
end

d.Encode=encodeValue
d.Decode=decodeValue

function d.ProfileFolder(e)
return e.Folder.."/profiles"
end

function d.CleanName(e)
local f=string.gsub(e,"[^%w%s%-_]","")
f=string.gsub(f,"^%s+","")
f=string.gsub(f,"%s+$","")
return string.sub(f,1,40)
end

local function ensureFolderTree(e)
local f=""
for g,h in ipairs(string.split(e,"/"))do
if f==""then
f=h
else
f=f.."/"..h
end
if not isfolder(f)then
makefolder(f)
end
end
end

function d.ListProfiles(e)
local f={}
if not filesystemAvailable()or listfiles==nil then
return f
end

pcall(function()
if not isfolder(e:ProfileFolder())then return end
for g,h in ipairs(listfiles(e:ProfileFolder()))do
local i=string.match(h,"([^/\\]+)%.json$")
if i then
table.insert(f,i)
end
end
end)

table.sort(f,function(g,h)
return string.lower(g)<string.lower(h)
end)
return f
end

function d.SaveProfile(e,f)
local g=d.CleanName(f)
if g==""or not filesystemAvailable()then
return false
end

local h=os.time()
local i=h
local j=e:ReadProfile(g)
if j and type(j.__meta)=="table"and type(j.__meta.Created)=="number"then
i=j.__meta.Created
end

local k=table.clone(e.Data)
k.__meta={Created=i,Updated=h}

return(pcall(function()
ensureFolderTree(e:ProfileFolder())
writefile(
e:ProfileFolder().."/"..g..".json",
b:JSONEncode(encodeValue(k))
)
end))
end

function d.ProfileDates(e,f)
local g=e:ReadProfile(f)
if g and type(g.__meta)=="table"then
return g.__meta.Created,g.__meta.Updated
end
return nil,nil
end

function d.ReadProfile(e,f)
if not filesystemAvailable()then return nil end

local g,h=pcall(function()
local g=e:ProfileFolder().."/"..d.CleanName(f)..".json"
if not isfile(g)then return nil end
return b:JSONDecode(readfile(g))
end)

if g and type(h)=="table"then
return decodeValue(h)
end
return nil
end

function d.DeleteProfile(e,f)
if not filesystemAvailable()or delfile==nil then
return false
end

local g=pcall(function()
delfile(e:ProfileFolder().."/"..d.CleanName(f)..".json")
end)

if g and e:GetAutoload()==d.CleanName(f)then
e:SetAutoload(nil)
end
return g
end

function d.GetAutoload(e)
if not filesystemAvailable()then return nil end

local f,g=pcall(function()
local f=e:ProfileFolder().."/autoload.txt"
if isfile(f)then
return readfile(f)
end
return nil
end)

if f and type(g)=="string"and g~=""then
return g
end
return nil
end

function d.SetAutoload(e,f)
if not filesystemAvailable()then return end
pcall(function()
ensureFolderTree(e:ProfileFolder())
writefile(e:ProfileFolder().."/autoload.txt",f or"")
end)
end

function d.SaveSoon(e)
if e._pending and coroutine.status(e._pending)~="dead"then
task.cancel(e._pending)
end
e._pending=task.delay(c,function()
e._pending=nil
e:Save()
end)
end

return d
end

function a.f()
local b=a.cache.config
if not b then
b={class=ConfigFactory()}
a.cache.config=b
end
return b.class
end
end




do
local function SignalFactory()
local b


local function runInCoroutine(c,...)
local d=b
b=nil
c(...)
b=d
end

local function coroutineBody(...)
runInCoroutine(...)
while true do
runInCoroutine(coroutine.yield())
end
end

local c={}
c.__index=c

function c.new(d,e)
return setmetatable({
Connected=true,
_signal=d,
_handler=e,
_next=nil,
},c)
end

function c.Disconnect(d)
if not d.Connected then return end
d.Connected=false

local e=d._signal
if e._head==d then
e._head=d._next
else
local f=e._head
while f and f._next~=d do
f=f._next
end
if f then
f._next=d._next
end
end
end

local d={}
d.__index=d

function d.new()
return setmetatable({_head=nil},d)
end

function d.Connect(e,f)
local g=c.new(e,f)
g._next=e._head
e._head=g
return g
end

function d.Once(e,f)
local g
g=e:Connect(function(...)
g:Disconnect()
f(...)
end)
return g
end

function d.Fire(e,...)
local f=e._head
while f do
if f.Connected then
if not b then
b=coroutine.create(coroutineBody)
end
task.spawn(b,f._handler,...)
end
f=f._next
end
end

function d.Wait(e)
local f=coroutine.running()
local g
g=e:Connect(function(...)
g:Disconnect()
task.spawn(f,...)
end)
return coroutine.yield()
end

function d.DisconnectAll(e)
local f=e._head
while f do
f.Connected=false
f=f._next
end
e._head=nil
end

d.Destroy=d.DisconnectAll
return d
end

function a.g()
local b=a.cache.signal
if not b then
b={class=SignalFactory()}
a.cache.signal=b
end
return b.class
end
end




do
local function ButtonFactory()
local b=a.Theme()
local c=a.Fonts()
local d=a.Icons()
local e=a.Creator()
local f=e.Create
local g=b.Token

local h={
Default={bg="Primary",rest=0.08,hover=0,fg="PrimaryForeground",border=true,glass=true},
Destructive={bg="Destructive",rest=0.08,hover=0,fg="DestructiveForeground",border=true,glass=true},
Outline={bg="Card",rest=0.52,hover=0.28,hoverBg="Accent",fg="Foreground",border=true,glass=true},
Secondary={bg="Secondary",rest=0.28,hover=0.14,fg="SecondaryForeground",border=true,glass=true},
Ghost={bg="Accent",rest=1,hover=0,fg="Foreground"},
Link={bg="Background",rest=1,hover=1,fg="Primary",underline=true},
}

local i={
Default={height=36,padX=16},
Sm={height=32,padX=12},
Lg={height=40,padX=24},
Icon={height=36,padX=0},
}

local j=0.5
local k={}
k.Sizes=i

function k.new(l,m)
local n=h[m.Variant or"Default"]or h.Default
local o=i[m.Size or"Default"]or i.Default
local p=m.Size=="Icon"

local q=m.Title or(if p then""else"Button")
local r=d.Get(m.Icon)
local s=d.Get"lock"
local t=b.TextSize.Sm
local u=m.Locked==true

local function measureWidth(v)
local w=r~=nil or(u and s~=nil)
return e.TextWidth(v,t,c.Regular)
+o.padX*2
+(if w then 26 else 0)
end

local v,w=f("TextButton",{
Name="Button",
AutoButtonColor=false,
BorderSizePixel=0,
Text="",
BackgroundColor3=g[n.bg],
BackgroundTransparency=n.rest,
Size=if m.FullWidth
then UDim2.new(1,0,0,o.height)
elseif p
then UDim2.fromOffset(o.height,o.height)
else UDim2.fromOffset(measureWidth(q),o.height),
LayoutOrder=m.LayoutOrder or 0,
},{e.Corner(b.Radius.Md)}),
if n.border then e.Stroke(if n.glass then g.Foreground else g.Input)else nil

v:SetAttribute("FitWidth",
if m.FullWidth then 0
elseif p then o.height
else measureWidth(q))

if w then
w.Parent=v
if n.glass then
f("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.68),
NumberSequenceKeypoint.new(0.45,0.84),
NumberSequenceKeypoint.new(1,0.90),
},
Parent=w,
})
end
end

if n.glass then
f("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(0.5,0.14),
NumberSequenceKeypoint.new(1,0.06),
},
Parent=v,
})
end

local x=f("Frame",{
Name="Content",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(0,o.height),
AutomaticSize=Enum.AutomaticSize.X,
ZIndex=2,
Parent=v,
},{
f("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local y=if r then f("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=r,
ImageColor3=g[n.fg],
Size=UDim2.fromOffset(18,18),
LayoutOrder=1,
Parent=x,
})else nil

local z=if s then f("ImageLabel",{
Name="Lock",
BackgroundTransparency=1,
Image=s,
ImageColor3=g[n.fg],
Size=UDim2.fromOffset(18,18),
LayoutOrder=0,
Visible=false,
Parent=x,
})else nil

local A=e.Text{
Text=q,
TextColor3=g[n.fg],
FontFace=c.Regular,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,o.height),
LayoutOrder=2,
Visible=not(p and r~=nil),
Parent=x,
}

local B=f("UIScale",{Parent=v})

local C=f("Frame",{
Name="Press",
BackgroundColor3=g[n.fg],
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=1,
Parent=v,
},{e.Corner(b.Radius.Md)})

local D=TweenInfo.new(0.06,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local E=TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local F=TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

local G=false
local H=false

local function restTransparency()
return if u then 1-(1-n.rest)*j else n.rest
end

local function refreshHover()
local I=H and not u
if n.hoverBg then
b.Rebind(v,"BackgroundColor3",if I then n.hoverBg else n.bg)
end
b.Tween(v,{
BackgroundTransparency=if I then n.hover else restTransparency(),
})
if n.underline then
A.Text=if I then"<u>"..q.."</u>"else q
end
end

local function pressDown()
if u then return end
G=true
b.Tween(C,{BackgroundTransparency=0.88},D)
b.Tween(B,{Scale=0.98},D)
end

local function pressUp()
if not G then return end
G=false
b.Tween(C,{BackgroundTransparency=1},E)
b.Tween(B,{Scale=1},F)
end

l:Connect(v.MouseEnter,function()
H=true
refreshHover()
end)
l:Connect(v.MouseLeave,function()
H=false
refreshHover()
pressUp()
end)
l:Connect(v.MouseButton1Down,pressDown)
l:Connect(v.MouseButton1Up,pressUp)

if m.Callback then
l:Connect(v.MouseButton1Click,function()
if not u then
task.spawn(m.Callback)
end
end)
end

local I
local function applyLocked()
local J=if u then j else 0
b.Tween(A,{TextTransparency=J})
if y then
y.Visible=not(u and z~=nil)
b.Tween(y,{ImageTransparency=J})
end
if z then
z.Visible=u
z.ImageTransparency=J
end
if w then
b.Tween(w,{Transparency=J})
end
v.AutoButtonColor=false
pressUp()
refreshHover()
if not m.FullWidth and not p then
v.Size=UDim2.fromOffset(measureWidth(q),o.height)
end
I.Locked=u
end

I={
Instance=v,
Locked=u,
SetTitle=function(J)
q=J
A.Text=J
if not m.FullWidth and not p then
v.Size=UDim2.fromOffset(measureWidth(J),o.height)
end
end,
SetLocked=function(J)
u=J==true
applyLocked()
end,
}

if u then
applyLocked()
end

return v,I
end

return k
end

function a.h()
local b=a.cache.button
if not b then
b={class=ButtonFactory()}
a.cache.button=b
end
return b.class
end
end




do
local function TileFactory()
local b=a.Theme()
local c=a.Fonts()
local d=a.Icons()
local e=a.Creator()
local f=e.Create

local g={}

g.Colors={
Blue=Color3.fromHex"0a84ff",
Purple=Color3.fromHex"bf5af2",
Orange=Color3.fromHex"ff9f0a",
Green=Color3.fromHex"30d158",
Pink=Color3.fromHex"ff375f",
Indigo=Color3.fromHex"5e5ce6",
Teal=Color3.fromHex"40c8e0",
Red=Color3.fromHex"ff453a",
Brown=Color3.fromHex"ac8e68",
Gray=Color3.fromHex"8e8e93",
}

g.Cycle={"Blue","Purple","Orange","Green","Pink","Indigo","Teal","Red","Brown","Gray"}

function g.Color(h,i)
if typeof(h)=="Color3"then
return h
end
if type(h)=="string"and g.Colors[h]then
return g.Colors[h]
end
return g.Colors[g.Cycle[(i-1)%#g.Cycle+1] ]
end

function g.new(h,i,j,k,l,m)
local n=k==nil

local o={
e.Corner(math.floor(l*0.27+0.5)),
}
if not n then
table.insert(o,f("UIGradient",{
Rotation=90,
Color=ColorSequence.new(Color3.new(1,1,1),Color3.new(0.82,0.82,0.82)),
}))
end

local p=f("Frame",{
Name="Tile",
BackgroundColor3=if n then b.Token.Foreground else k,
BackgroundTransparency=if n then 1 else 0,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(l,l),
ZIndex=5,
Parent=h,
},o)

f("UIStroke",{
Color=if n then b.Token.Border else k:Lerp(Color3.new(0,0,0),0.25),
Thickness=1,
Transparency=if n then 0.15 else 0.5,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=p,
})

local q=if n then b.Token.Foreground else Color3.new(1,1,1)
local r=d.Get(i)
local s

if r then
s=f("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=r,
ImageColor3=q,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(m,m),
ZIndex=6,
Parent=p,
})
else
s=e.Text{
Name="Icon",
Text=string.upper(string.sub(j,1,1)),
TextColor3=q,
FontFace=c.Bold,
TextSize=math.floor(m*0.7+0.5),
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.fromScale(1,1),
ZIndex=6,
Parent=p,
}
end

return p,s
end

return g
end

function a.i()
local b=a.cache.tile
if not b then
b={class=TileFactory()}
a.cache.tile=b
end
return b.class
end
end




do
local function IslandFactory()
local b=a.Theme()
local c=a.Fonts()
local d=a.Icons()
local e=a.Creator()
local f=a.i()
local g=e.Create
local h=b.Token

local i=42
local j=10
local k=38

local l=26

local m=13
local n=14
local o=Color3.new(0,0,0)
local p=Color3.fromHex"f5f5f7"
local q=Color3.fromHex"98989d"
local r=Color3.fromHex"2c2c2e"


local s={
Success={icon="checkmarkCircle",color=Color3.fromHex"30d158"},
Info={icon="infoCircle",color=Color3.fromHex"0a84ff"},
Warning={icon="exclamationmarkTriangle",color=Color3.fromHex"ffd60a"},
Error={icon="xmarkCircle",color=Color3.fromHex"ff453a"},
Loading={icon="arrowTriangle2Circlepath",color=Color3.fromHex"98989d"},
}

TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
local t=TweenInfo.new(0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local u=TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local v=TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local w=2.6

local x={}
x.__index=x

function x.new(y,z,A)
local B=setmetatable({
_shown=false,
_hovered=false,
_options=A,
_generation=0,
_announcing=nil,
},x)

local C=g("TextButton",{
Name="Island",
Text="",
AutoButtonColor=false,
BackgroundColor3=o,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0),
Position=UDim2.new(0.5,0,0,j),
Size=UDim2.fromOffset(k,i),
ClipsDescendants=true,
Visible=false,
ZIndex=50,
Parent=z,
},{e.Corner(b.Radius.Full)})

g("UIStroke",{
Color=Color3.new(1,1,1),
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=C,
},{
g("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new(0.75,0.95),
}),
})

B._scale=g("UIScale",{Parent=C})
B.Instance=C

local D=g("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=51,
Parent=C,
},{
g("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

B._padding=e.Padding(0,n,0,6)
B._padding.Parent=D


local E=g("Frame",{
Name="Logo",
BackgroundTransparency=1,
Size=UDim2.fromOffset(l,l),
LayoutOrder=1,
ZIndex=52,
Parent=D,
})

B._hasLogo=d.Get(A.Icon)~=nil
E.Visible=B._hasLogo

if B._hasLogo and d.IsImage(A.Icon)then
g("ImageLabel",{
Name="Picture",
BackgroundTransparency=1,
Image=d.Get(A.Icon)or"",
ScaleType=Enum.ScaleType.Crop,
Size=UDim2.fromScale(1,1),
ZIndex=52,
Parent=E,
},{e.Corner(999)})
elseif B._hasLogo then
local F=f.new(E,A.Icon,A.Title or"",b.Current.SidebarPrimary,l,16)
F.ZIndex=52
F:FindFirstChildOfClass"UICorner".CornerRadius=UDim.new(1,0)
b.Bind(F,"BackgroundColor3","SidebarPrimary")
end


B._kind=g("ImageLabel",{
Name="Kind",
BackgroundTransparency=1,
Size=UDim2.fromOffset(l-4,l-4),
LayoutOrder=1,
Visible=false,
ZIndex=52,
Parent=D,
})

local F=A.Title or""
B._titleText=F
B._title=e.Text{
Name="Title",
Text=F,
TextColor3=p,
FontFace=c.SemiBold,
TextSize=m,
TextTransparency=1,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.fromOffset(0,i),
LayoutOrder=2,
ZIndex=52,
Parent=D,
}


local G=g("Frame",{
Name="Hint",
BackgroundTransparency=1,
ClipsDescendants=true,
Size=UDim2.fromOffset(0,i),
LayoutOrder=3,
ZIndex=52,
Parent=D,
},{
g("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,6),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

B._hintOpen=e.Text{
Name="Open",
Text="Open",
TextColor3=q,
TextSize=12,
TextTransparency=1,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,i),
LayoutOrder=1,
ZIndex=52,
Parent=G,
}

B._keycap=e.Text{
Name="Key",
Text="",
TextColor3=p,
FontFace=c.Medium,
TextSize=11,
TextTransparency=1,
BackgroundColor3=r,
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,20),
LayoutOrder=2,
ZIndex=52,
Parent=G,
}
g("UICorner",{CornerRadius=UDim.new(0,5),Parent=B._keycap})
e.Padding(0,7,0,7).Parent=B._keycap


local H=g("Frame",{
Name="Dot",
BackgroundColor3=h.SidebarPrimary,
BorderSizePixel=0,
Size=UDim2.fromOffset(8,8),
LayoutOrder=4,
ZIndex=52,
Parent=D,
},{e.Corner(4)})

B._breath=y:Give(game:GetService"TweenService":Create(
H,
TweenInfo.new(1.1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
{BackgroundTransparency=0.7}
))

B._hint=G
B._dot=H
B._logo=E

y:Connect(C.MouseEnter,function()
B._hovered=true
B:_fit()
end)
y:Connect(C.MouseLeave,function()
B._hovered=false
B:_fit()
b.Tween(B._scale,{Scale=1},v)
end)
y:Connect(C.MouseButton1Down,function()
b.Tween(B._scale,{Scale=0.94},v)
end)
y:Connect(C.MouseButton1Up,function()
b.Tween(B._scale,{Scale=1},v)
end)
y:Connect(C.MouseButton1Click,function()
if B._shown then
A.Open()
end
end)

return B
end

function x._fit(y)
if not y._shown then return end

local z=y._titleText
local A=y._announcing~=nil
if A then
z=y._announcing
end

local B=math.min(
math.ceil(e.TextWidth(z,m,c.SemiBold)),
320
)
local C=0
local D=i

if y._hovered and not A then
local E=y._options.Hint()
y._keycap.Text=E
C=math.ceil(e.TextWidth("Open",12,c.Regular))
+6
+math.ceil(e.TextWidth(E,11,c.Medium))
+14
D=i+2
end

local E=if C>0 then 8 else 0
local F=0
local G=n
if y._logo.Visible or y._kind.Visible then
F=l+8
G=6
end
y._padding.PaddingLeft=UDim.new(0,G)

local H=G+F+B+8+C+E+8+14
H=math.ceil(H/2)*2

local I=if C>0 then 0 else 1

y._title.Text=z
b.Tween(y.Instance,{Size=UDim2.fromOffset(H,D)},u)
b.Tween(y._title,{Size=UDim2.fromOffset(B,i)},u)
b.Tween(y._hint,{Size=UDim2.fromOffset(C,i)},v)
b.Tween(y._hintOpen,{TextTransparency=I},v)
b.Tween(y._keycap,{
TextTransparency=I,
BackgroundTransparency=I,
},v)
end

function x.Announce(y,z,A)
if not y._shown or z==""then return end

local B=s[A or""]
y._announcing=z
y._generation+=1
local C=y._generation

y._kind.Visible=B~=nil
y._logo.Visible=B==nil and y._hasLogo

if B then
y._kind.Image=d.Get(B.icon)or""
y._kind.ImageColor3=B.color
end

y._title.TextTransparency=1
y:_fit()
b.Tween(y._title,{TextTransparency=0},v)

task.delay(w,function()
if y._generation~=C or not y._shown then return end
y._announcing=nil
y._kind.Visible=false
y._logo.Visible=y._hasLogo
y._title.TextTransparency=1
y:_fit()
b.Tween(y._title,{TextTransparency=0},v)
end)
end

function x.SetShown(y,z)
if y._shown==z then return end

y._shown=z
y._generation+=1
y._announcing=nil
y._kind.Visible=false
y._logo.Visible=y._hasLogo

local A=y._generation
local B=y.Instance

if z then
local C=B.Parent
B.Position=UDim2.new(0.5,-(C.AbsoluteSize.X%2)/2,0,j)
y._hovered=false
y._scale.Scale=1
B.Size=UDim2.fromOffset(k,i)
B.Visible=true
y._breath:Play()
y._title.TextTransparency=1
y:_fit()
b.Tween(y._title,{TextTransparency=0},
TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0.12))
else
b.Tween(y._title,{TextTransparency=1},t)
b.Tween(y._hintOpen,{TextTransparency=1},t)
b.Tween(y._keycap,{TextTransparency=1,BackgroundTransparency=1},t)
b.Tween(B,{Size=UDim2.fromOffset(k,i)},t)
task.delay(t.Time,function()
if y._generation==A then
B.Visible=false
y._breath:Pause()
end
end)
end
end

return x
end

function a.j()
local b=a.cache.island
if not b then
b={class=IslandFactory()}
a.cache.island=b
end
return b.class
end
end




do
local function DialogFactory()
local b=game:GetService"UserInputService"
local c=a.Theme()
local d=a.Fonts()
local e=a.Icons()
local f=a.Creator()
local g=a.h()
local h=f.Create
local i=c.Token

local j=384
local k=16
local l=TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local m=TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
local n={}

function n.open(o,p)
if o._dialog then
o._dialog.Close()
end

local q=o._maid:Sub()
local r=o._holder
local s=false
local t=p.Buttons

if not t then
local u="Default"
if p.Destructive then u="Destructive"end
t={
{Title=p.CancelText or"Cancel",Variant="Outline",Cancel=true},
{Title=p.ConfirmText or"Continue",Variant=u},
}
end

local u=q:Give(h("TextButton",{
Name="Dialog",
Text="",
AutoButtonColor=false,
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=40,
Parent=r,
},{f.Corner(c.Radius.Xl)}))

local v,w=h("Frame",{
Name="Card",
BackgroundColor3=i.Popover,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.new(1,-32,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ClipsDescendants=true,
ZIndex=41,
Parent=u,
},{
f.Corner(c.Radius.Xl),
f.List(0),
h("UISizeConstraint",{MaxSize=Vector2.new(j,math.huge)}),
}),f.Stroke(i.Foreground)
w.Parent=v
f.ApplyGlassStroke(w,maid)

local x=h("UIScale",{Scale=0.95,Parent=v})

local y=h("Frame",{
Name="Header",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
ZIndex=41,
Parent=v,
},{
f.Padding(k,k,k,k),
h("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Top,
Padding=UDim.new(0,14),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local z=e.Get(p.Icon)
if z then
local A=h("Frame",{
Name="Media",
BackgroundColor3=i.Muted,
BorderSizePixel=0,
Size=UDim2.fromOffset(40,40),
LayoutOrder=1,
ZIndex=41,
Parent=y,
},{f.Corner(c.Radius.Md)})

local B=i.Foreground
if p.Destructive then
B=i.Destructive
end

h("ImageLabel",{
BackgroundTransparency=1,
Image=z,
ImageColor3=B,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(24,24),
ZIndex=42,
Parent=A,
})
end

local A=h("Frame",{
Name="Text",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
ZIndex=41,
Parent=y,
},{
f.List(6),
h("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill}),
})

f.Text{
Name="Title",
Text=p.Title or"Are you sure?",
FontFace=d.SemiBold,
TextSize=c.TextSize.Base,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
ZIndex=42,
Parent=A,
}

if p.Description then
f.Text{
Name="Description",
Text=p.Description,
TextColor3=i.MutedForeground,
TextWrapped=true,
LineHeight=1.15,
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
ZIndex=42,
Parent=A,
}
end

local B=h("Frame",{
Name="Footer",
BackgroundColor3=i.Muted,
BackgroundTransparency=0.5,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
ZIndex=41,
Parent=v,
},{
f.Padding(12,k,12,k),
h("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

h("Frame",{
Name="Border",
BackgroundColor3=i.Foreground,
BackgroundTransparency=0.9,
BorderSizePixel=0,
Position=UDim2.fromOffset(-k,-12),
Size=UDim2.new(1,k*2,0,1),
ZIndex=42,
Parent=h("Folder",{Parent=B}),
})

local C={}
local D=1
for E,F in ipairs(t)do
if F.Cancel then
D=E
end
end

local function close(E)
if s then return end
s=true

if o._dialog==C then
o._dialog=nil
end

c.Tween(u,{BackgroundTransparency=1},m)
c.Tween(x,{Scale=0.95},m)
task.delay(m.Time,function()
q:Destroy()
end)

local F=t[E]
if F and F.Callback then
task.spawn(F.Callback)
end
if p.OnClose then
task.spawn(p.OnClose,E)
end
end

for E,F in ipairs(t)do
local G=g.new(q,{
Title=F.Title or"OK",
Variant=F.Variant or"Default",
Icon=F.Icon,
Size="Sm",
LayoutOrder=E,
Callback=function()
close(E)
end,
})
G.ZIndex=42
G.Parent=B
end

q:Connect(b.InputBegan,function(E)
if E.KeyCode==Enum.KeyCode.Escape or E.KeyCode==Enum.KeyCode.ButtonB then
close(D)
end
end)

function C.Close()
close(0)
end

q:Give(function()
if not s then
s=true
if p.OnClose then
task.spawn(p.OnClose,0)
end
end
end)

o._dialog=C
o:_closePopover()
c.Tween(u,{BackgroundTransparency=0.65},l)
c.Tween(x,{Scale=1},l)
return C
end

return n
end

function a.k()
local b=a.cache.dialog
if not b then
b={class=DialogFactory()}
a.cache.dialog=b
end
return b.class
end
end




do
local function AcrylicFactory()
local b=game:GetService"Workspace"
local c=game:GetService"Lighting"
local d=game:GetService"UserInputService"
local e={}
local f=0.001

local function screenToWorldPoint(g,h)
local i=(b.CurrentCamera):ViewportPointToRay(g.X,g.Y)
return i.Origin+i.Direction*h
end

function e.Supported()
return not(d.TouchEnabled and not d.MouseEnabled)
end

function e.new(g,h,i)
if not e.Supported()or not b.CurrentCamera then
return nil
end

local j=g:Give(Instance.new"Folder")
j.Name="shadcn-acrylic"

local k=Instance.new"Part"
k.Name="Glass"
k.Color=Color3.new(0,0,0)
k.Material=Enum.Material.Glass
k.Size=Vector3.new(1,1,0)
k.Anchored=true
k.CanTouch=false
k.CanCollide=false
k.CanQuery=false
k.Locked=true
k.CastShadow=false
k.Transparency=0.98

local l=Instance.new"SpecialMesh"
l.MeshType=Enum.MeshType.Brick
l.Offset=Vector3.new(0,0,-1E-6)
l.Parent=k

local m=g:Give(Instance.new"DepthOfFieldEffect")
m.Name="shadcn-acrylic"
m.FarIntensity=0
m.NearIntensity=1
m.InFocusRadius=0.1
m.Parent=c

k.Parent=j
j.Parent=b.CurrentCamera

local n={
topLeft=Vector2.zero,
topRight=Vector2.zero,
bottomRight=Vector2.zero,
}
local o=true

local function updateCFrame()
local p=b.CurrentCamera
if not p or not o then return end
local q=screenToWorldPoint(n.topLeft,f)
local r=screenToWorldPoint(n.topRight,f)
local s=screenToWorldPoint(n.bottomRight,f)
k.CFrame=CFrame.fromMatrix(
(q+s)/2,
p.CFrame.XVector,
p.CFrame.YVector,
p.CFrame.ZVector
)
l.Scale=Vector3.new((r-q).Magnitude,(r-s).Magnitude,0)
end

local function updateCorners()
local p=b.CurrentCamera
if not p then return end

local q=h:FindFirstChildOfClass"UICorner"
local r=0
if q then
r=q.CornerRadius.Offset
*(h.AbsoluteSize.X/math.max(h.Size.X.Offset,1))
end

local s=math.max(2,math.ceil(r*0.3)+1)
local t,u=s,s
if i and i.Right then
u=0
end

local v=game:GetService"GuiService":GetGuiInset()
local w=h.AbsoluteSize-Vector2.new(t+u,s*2)
local x=h.AbsolutePosition+v+Vector2.new(t,s)

n.topLeft=x
n.topRight=x+Vector2.new(w.X,0)
n.bottomRight=x+w

updateCFrame()
end

g:Connect(h:GetPropertyChangedSignal"AbsolutePosition",updateCorners)
g:Connect(h:GetPropertyChangedSignal"AbsoluteSize",updateCorners)

local p=b.CurrentCamera
g:Connect(p:GetPropertyChangedSignal"CFrame",updateCFrame)
g:Connect(p:GetPropertyChangedSignal"ViewportSize",updateCorners)
g:Connect(p:GetPropertyChangedSignal"FieldOfView",updateCFrame)

updateCorners()

local q={}

function q.SetVisible(r)
o=r
if r then
k.Transparency=0.98
m.Enabled=true
updateCorners()
else
k.Transparency=1
m.Enabled=false
end
end

function q.Destroy()
j:Destroy()
m:Destroy()
end

return q
end

return e
end

function a.l()
local b=a.cache.acrylic
if not b then
b={class=AcrylicFactory()}
a.cache.acrylic=b
end
return b.class
end
end




do
local function BadgeFactory()
local b=a.Theme()
local c=a.Fonts()
local d=a.Creator()
local e=d.Create
local f=b.Token

local g={
Default={bg="Primary",fg="PrimaryForeground"},
Secondary={bg="Secondary",fg="SecondaryForeground"},
Destructive={bg="Destructive",fg="DestructiveForeground"},
Outline={bg="Background",fg="Foreground",border=true,clear=true},
}

local h=22
local i=8
local j={}

function j.new(k)
local l=g[k.Variant or"Default"]or g.Default
local m=k.Text or"Badge"

local function measure(n)
return d.TextWidth(n,b.TextSize.Xs,c.Medium)+i*2
end

local n=e("Frame",{
Name="Badge",
BackgroundColor3=f[l.bg],
BackgroundTransparency=if l.clear then 1 else 0,
BorderSizePixel=0,
Size=UDim2.fromOffset(measure(m),h),
LayoutOrder=k.LayoutOrder or 0,
},{
d.Corner(b.Radius.Md),
if l.border then d.Stroke(f.Foreground)else nil,
})

local o=d.Text{
Text=m,
TextColor3=f[l.fg],
FontFace=c.Medium,
TextSize=b.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.fromScale(1,1),
Parent=n,
}

local p=n:FindFirstChildOfClass"UIStroke"or d.Stroke(f.Foreground)
p.Parent=n
p.Enabled=l.border==true
if l.border then
d.ApplyGlassStroke(p)
end

local function setText(q)
o.Text=q
n.Size=UDim2.fromOffset(measure(q),h)
end

local function setVariant(q)
local r=g[q]or g.Default
b.Rebind(n,"BackgroundColor3",r.bg)
b.Rebind(o,"TextColor3",r.fg)
n.BackgroundTransparency=if r.clear then 1 else 0
p.Enabled=r.border==true
end

return n,setText,setVariant
end

return j
end

function a.m()
local b=a.cache.badge
if not b then
b={class=BadgeFactory()}
a.cache.badge=b
end
return b.class
end
end




do
local function ComboboxFactory()
local b=game:GetService"UserInputService"
local c=a.Theme()
local d=a.Fonts()
local e=a.Icons()
local f=a.Creator()
local g=f.Create
local h=c.Token

local i=28
local j=28
local k=252
local l=TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

local m=20
local n={}

local function measureOptionWidth(o)
local p=n[o]
if not p then
p=math.ceil(f.TextWidth(o,c.TextSize.Xs,d.Medium))
n[o]=p
end
return p
end

local function normalizeChoice(o)
if type(o)=="table"then
return tostring(o.Text or o.Value or o.Title or""),o.Icon
end
return tostring(o),nil
end





local function flattenOptions(o)
local p,q,r={},{},{}

local function append(s)
local t,u=normalizeChoice(s)
table.insert(p,t)
table.insert(q,{choice=t})
if u then
r[t]=u
end
end

for s,t in ipairs(o)do
if type(t)=="table"and t.Options then
table.insert(q,{label=t.Title or""})
for u,v in ipairs(t.Options)do
append(v)
end
else
append(t)
end
end

return p,q,r
end

local function makeOptionIcon(o,p,q)
local r=g("ImageLabel",{
Name="OptionIcon",
BackgroundTransparency=1,
ScaleType=Enum.ScaleType.Fit,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(m,m),
ZIndex=q,
Parent=o,
})

local function setIcon(s)
local t=type(s)=="number"
or(type(s)=="string"and string.find(s,"://",1,true)~=nil)
local u=e.Get(s)or""
r.Image=u
if t then
r.ImageColor3=Color3.new(1,1,1)
if u~=""then
task.spawn(function()
for v=1,3 do
task.wait(2)
if r.Parent==nil or r.Image~=u or r.IsLoaded then
return
end
r.Image=""
task.wait()
r.Image=u
end
end)
end
else
c.Bind(r,"ImageColor3","Foreground")
end
end

if p~=nil then
setIcon(p)
end

return r,setIcon
end

local o={}

function o.new(p,q,r,s,t,u)
local v=s.Multi==true
local w
if v and type(s.Max)=="number"and s.Max>0 then
w=math.floor(s.Max)
end

local x
if s.Smart==true then
x="Smart"
elseif type(s.Smart)=="string"and s.Smart~=""then
x=s.Smart
end

local function applySmart(y)
if not x then return y end
local z={{Text=x,Icon="sparkles"}}
for A,B in ipairs(y)do
table.insert(z,B)
end
return z
end

local y,z,A=flattenOptions(applySmart(s.Options or{}))

local B=s.Placeholder or"Select"
local C=s.Search~=false

local D,E=g("TextButton",{
Name="Trigger",
Text="",
AutoButtonColor=false,
BackgroundColor3=h.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,i),
ClipsDescendants=true,
Parent=r,
},{f.Corner(c.Radius.Lg)}),f.Stroke(h.Foreground)
E.Parent=D
f.ApplyGlassStroke(E,q,p.Library and p.Library.ThemeChanged)

local F=g("Frame",{
Name="Body",
BackgroundTransparency=1,
Size=UDim2.new(1,-44,1,0),
Parent=D,
},{f.Padding(0,0,0,10)})

local G=f.Text{
Name="Display",
Text=B,
TextColor3=h.MutedForeground,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.fromScale(1,1),
Parent=F,
}

local H=makeOptionIcon(F,nil,2)
H.Visible=false

local I=f.Text{
Name="Count",
Text="",
BackgroundColor3=h.Muted,
BackgroundTransparency=0,
FontFace=d.Medium,
TextSize=c.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Center,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,20),
Visible=false,
ZIndex=2,
Parent=F,
}
g("UICorner",{CornerRadius=UDim.new(1,0),Parent=I})
g("UISizeConstraint",{MinSize=Vector2.new(20,20),Parent=I})
f.Padding(0,7,0,7).Parent=I

local J=g("ImageButton",{
Name="Clear",
BackgroundTransparency=1,
Image=e.Get"x"or"",
ImageColor3=h.MutedForeground,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-28,0.5,0),
Size=UDim2.fromOffset(14,14),
Visible=false,
ZIndex=2,
Parent=D,
})

local K=g("ImageLabel",{
Name="Chevron",
BackgroundTransparency=1,
Image=e.Get"chevron-down"or"",
ImageColor3=h.MutedForeground,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-8,0.5,0),
Size=UDim2.fromOffset(18,18),
Parent=D,
})

local function isOpen()
return p._popover~=nil and p._popover.anchor==D
end

local function isSelected(L)
if v then
return type(t.Value)=="table"and table.find(t.Value,L)~=nil
end
return t.Value==L
end

local L,M,N,O,P,Q,R,S
local T
local U,V,W={},{},{}local
X=0
local Y=function()
return v and x~=nil and isSelected(x)
end
local function selectedCount()
if v then return type(t.Value)=="table"and#t.Value or 0 end
return 0
end
local function atMax()
return w~=nil and selectedCount()>=w
end

local function paintHover()
for Z,_ in ipairs(V)do
local aa=if Z==X then 0.9 else 1
c.Tween(_.button,{BackgroundTransparency=aa},l)
end
end

local function refreshChecks()
local aa=atMax()or Y()
for Z,_ in ipairs(V)do
local ab=isSelected(_.choice)
local ac=if aa and not ab then 0.5 else 0
_.check.Visible=ab
_.label.TextTransparency=ac
end

if S then
local ab=#V>0
for ac,Z in ipairs(V)do
if not isSelected(Z.choice)then
ab=false
end
end
S.Text=if ab or aa then"Clear selection"else"Select all"
end
end

local function applyFilter()
local aa=""
if N then
aa=string.lower(N.Text)
end

table.clear(V)
local ab=0

for ac,Z in ipairs(U)do
local _=aa==""or string.find(string.lower(Z.choice),aa,1,true)~=nil
Z.button.Visible=_
if _ then
table.insert(V,Z)
ab+=j
end
end


for ac,Z in ipairs(W)do
local _=false
for ad,ae in ipairs(Z.members)do
for af,ag in ipairs(V)do
if ag.choice==ae then
_=true
end
end
end
Z.frame.Visible=_
if _ then
ab+=j
end
end

if X>#V then
X=#V
end

if P then
P.Size=UDim2.new(1,0,0,math.min(ab,k))
P.Visible=#V>0
end
if Q then
Q.Visible=#V==0
end
if R then
R.Visible=#V>0
end
if T then task.defer(T)end
paintHover()
refreshChecks()
end

local aa

local function rebuildPanel()
if L then
L:Destroy()
end
table.clear(U)
table.clear(V)
table.clear(W)

L=q:Give(g("Frame",{
Name="Combobox",
BackgroundColor3=h.Popover,
BackgroundTransparency=0.06,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.fromOffset(160,0),
ZIndex=20,
},{
f.Corner(c.Radius.Lg),
}))

f.AttachAurora(L,q,{
Radius=c.Radius.Lg,
ZIndex=20,
ThemeChanged=p.Library and p.Library.ThemeChanged,
})

M=g("Frame",{
Name="Body",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ZIndex=21,
Parent=L,
},{
f.Padding(4),
f.List(4),
})

q:Connect(M:GetPropertyChangedSignal"AbsoluteSize",function()
if L and M then
L.Size=UDim2.fromOffset(L.Size.X.Offset,M.AbsoluteSize.Y)
end
end)

local ab=f.Stroke(h.Foreground)
ab.Parent=L
f.ApplyGlassStroke(ab,q,p.Library and p.Library.ThemeChanged)

g("UIScale",{Parent=L})


if C then
local ac,ad=g("Frame",{
Name="Search",
BackgroundColor3=h.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,j),
LayoutOrder=1,
ZIndex=21,
Parent=M,
},{f.Corner(c.Radius.Md)}),f.Stroke(h.Foreground)
ad.Parent=ac
f.ApplyGlassStroke(ad,q,p.Library and p.Library.ThemeChanged)

g("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=e.Get"search"or"",
ImageColor3=h.MutedForeground,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,10,0.5,0),
Size=UDim2.fromOffset(16,16),
ZIndex=22,
Parent=ac,
})

local ae=g("TextBox",{
Name="Input",
BackgroundTransparency=1,
ClearTextOnFocus=false,
FontFace=d.Regular,
TextSize=c.TextSize.Sm,
TextColor3=h.Foreground,
PlaceholderColor3=h.MutedForeground,
PlaceholderText="Search",
Text="",
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
Position=UDim2.fromOffset(32,0),
Size=UDim2.new(1,-40,1,0),
ZIndex=22,
Parent=ac,
})

q:Connect(ae.Focused,function()
c.Rebind(ad,"Color","Ring")
ad.Transparency=0
end)

q:Connect(ae:GetPropertyChangedSignal"Text",function()
X=1
applyFilter()
end)

q:Connect(ae.FocusLost,function(af)
c.Rebind(ad,"Color","Foreground")
ad.Transparency=0
if af and isOpen()then
local ag=V[X]
if ag then
aa(ag.choice)
end
if v and isOpen()then
ae:CaptureFocus()
end
end
end)

N=ae
else
N=nil
end


R=nil
S=nil
if v then
local ac=g("TextButton",{
Name="SelectAll",
Text="",
AutoButtonColor=false,
BackgroundColor3=h.Foreground,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,j),
LayoutOrder=2,
ZIndex=22,
Parent=M,
},{
f.Corner(c.Radius.Md),
f.Padding(0,8,0,6),
})

g("ImageLabel",{
BackgroundTransparency=1,
Image=e.Get"sf:checklist"or e.Get"list-checks"or"",
ImageColor3=h.MutedForeground,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(16,16),
ZIndex=23,
Parent=ac,
})

S=f.Text{
Text="Select all",
FontFace=d.Medium,
Position=UDim2.fromOffset(24,0),
Size=UDim2.new(1,-24,1,0),
ZIndex=23,
Parent=ac,
}

if w then
f.Text{
Text="max "..w,
TextColor3=h.MutedForeground,
TextSize=c.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Right,
Size=UDim2.fromScale(1,1),
ZIndex=23,
Parent=ac,
}
end

ac.MouseEnter:Connect(function()
c.Tween(ac,{BackgroundTransparency=0.9},l)
end)
ac.MouseLeave:Connect(function()
c.Tween(ac,{BackgroundTransparency=1},l)
end)

ac.MouseButton1Click:Connect(function()
if t.Locked or Y()then return end

local ad={}
for ae,af in ipairs(V)do
if af.choice~=x then
ad[af.choice]=true
end
end

local ae=S.Text=="Clear selection"
local af={}
for ag,Z in ipairs(y)do
local _=isSelected(Z)
if ad[Z]then
_=not ae
end
if _ then
table.insert(af,Z)
end
end


if w and#af>w then
local ag={}
for Z,_ in ipairs(af)do
if isSelected(_)and#ag<w then
table.insert(ag,_)
end
end
for Z,_ in ipairs(af)do
if not isSelected(_)and#ag<w then
table.insert(ag,_)
end
end

local Z={}
for _,ah in ipairs(y)do
if table.find(ag,ah)then
table.insert(Z,ah)
end
end
af=Z
end

u(af)
refreshChecks()
end)

g("Frame",{
Name="Separator",
BackgroundColor3=h.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,-6,1,2),
Size=UDim2.new(1,14,0,1),
ZIndex=22,
Parent=ac,
})

R=ac
end

P=g("Frame",{
Name="ListHolder",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,j),
LayoutOrder=3,
ZIndex=21,
Parent=M,
})

O=g("ScrollingFrame",{
Name="List",
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollBarThickness=0,
ScrollingDirection=Enum.ScrollingDirection.Y,
ElasticBehavior=Enum.ElasticBehavior.Never,
ZIndex=21,
Parent=P,
},{f.List(0)})


local ac=g("Frame",{
Name="ScrollTrack",
BackgroundTransparency=1,
BorderSizePixel=0,
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-1,0,2),
Size=UDim2.new(0,5,1,-4),
Visible=false,
ZIndex=25,
Parent=P,
})

local ad=g("TextButton",{
Name="Thumb",
Text="",
AutoButtonColor=false,
BackgroundColor3=h.MutedForeground,
BackgroundTransparency=0.45,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,20),
ZIndex=26,
Parent=ac,
},{f.Corner(3)})

T=function()
if not(O and O.Parent)then return end
local ae=O.AbsoluteCanvasSize.Y
local af=O.AbsoluteWindowSize.Y
if af<=0 or ae<=af+1 then
ac.Visible=false
return
end
ac.Visible=true
local ag=math.max(ac.AbsoluteSize.Y,1)
local ah=math.max(ag*af/ae,20)
local Z=math.clamp(O.CanvasPosition.Y/(ae-af),0,1)
ad.Size=UDim2.new(1,0,0,ah)
ad.Position=UDim2.new(0,0,0,(ag-ah)*Z)
end

q:Connect(O:GetPropertyChangedSignal"CanvasPosition",T)
q:Connect(O:GetPropertyChangedSignal"AbsoluteCanvasSize",T)
q:Connect(O:GetPropertyChangedSignal"AbsoluteWindowSize",T)
q:Connect(ac:GetPropertyChangedSignal"AbsoluteSize",T)


q:Connect(ad.InputBegan,function(ae)
local af=ae.UserInputType==Enum.UserInputType.MouseButton1
or ae.UserInputType==Enum.UserInputType.Touch
if not af then return end

local ag=ae.Position.Y
local ah=O.CanvasPosition.Y
p._drag(ae,function(Z)
local _=O.AbsoluteCanvasSize.Y
local ai=O.AbsoluteWindowSize.Y
local aj=ac.AbsoluteSize.Y
local ak=ad.AbsoluteSize.Y
local al=math.max(aj-ak,1)
local am=(_-ai)/al
O.CanvasPosition=Vector2.new(0,math.clamp(ah+(Z.Y-ag)*am,0,_-ai))
end)
end)

Q=f.Text{
Name="Empty",
Text="No items found",
TextColor3=h.MutedForeground,
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.new(1,0,0,36),
LayoutOrder=4,
Visible=false,
ZIndex=21,
Parent=M,
}

local ae
for af,ag in ipairs(z)do
if ag.label then
local ah=f.Text{
Name="Label",
Text=ag.label,
TextColor3=h.MutedForeground,
TextSize=c.TextSize.Xs,
Size=UDim2.new(1,0,0,j),
LayoutOrder=af,
ZIndex=22,
Parent=O,
}
f.Padding(0,8,0,8).Parent=ah
ae={frame=ah,members={}}
table.insert(W,ae)
else
local ah=ag.choice
if ae then
table.insert(ae.members,ah)
end

local ai=g("TextButton",{
Name=ah,
Text="",
AutoButtonColor=false,
BackgroundColor3=h.Foreground,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,j),
LayoutOrder=af,
ZIndex=22,
Parent=O,
},{
f.Corner(c.Radius.Md),
f.Padding(0,32,0,6),
})

local aj=f.Text{
Text=ah,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.fromScale(1,1),
ZIndex=23,
Parent=ai,
}

if A[ah]then
makeOptionIcon(ai,A[ah],23)
end
if next(A)~=nil then
aj.Position=UDim2.fromOffset(m+8,0)
aj.Size=UDim2.new(1,-(m+8),1,0)
end

local ak=g("ImageLabel",{
Name="Check",
BackgroundTransparency=1,
Image=e.Get"check"or"",
ImageColor3=h.Foreground,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(1,8,0.5,0),
Size=UDim2.fromOffset(18,18),
Visible=false,
ZIndex=23,
Parent=ai,
})

local al={choice=ah,button=ai,check=ak,label=aj}

q:Connect(ai.MouseEnter,function()
X=table.find(V,al)or 0
paintHover()
end)

q:Connect(ai.MouseButton1Click,function()
aa(ah)
end)

table.insert(U,al)
end
end




paintHover()
refreshChecks()
end

local function refreshDisplay()
local ab
if v then
local ac=t.Value or{}
ab=#ac>0
I.Visible=ab
if ab then
local ad=tostring(#ac)
if w then
ad=#ac.."/"..w
end
I.Text=ad
G.Text=table.concat(ac,", ")
c.Rebind(G,"TextColor3","Foreground")
G.Size=UDim2.new(1,-(math.max(measureOptionWidth(ad)+14,20)+6),1,0)
else
G.Text=B
G.Size=UDim2.fromScale(1,1)
c.Rebind(G,"TextColor3","MutedForeground")
end
else
ab=t.Value~=nil
G.Visible=true
if ab then
G.Text=tostring(t.Value)
c.Rebind(G,"TextColor3","Foreground")
else
G.Text=B
c.Rebind(G,"TextColor3","MutedForeground")
end

local ac
if ab then
ac=A[tostring(t.Value)]
end
H.Visible=ac~=nil
if ac then
H.Image=ac
G.Position=UDim2.fromOffset(m+8,0)
G.Size=UDim2.new(1,-(m+8),1,0)
else
G.Position=UDim2.fromOffset(0,0)
G.Size=UDim2.fromScale(1,1)
end
end

J.Visible=ab and s.Clearable~=false
refreshChecks()
end

local function closePanel()
if isOpen()then
p:_closePopover()
end
end

local function openPanel()
if t.Locked or isOpen()then return end
if not L then
rebuildPanel()
end

L.Size=UDim2.fromOffset(
math.max(D.AbsoluteSize.X+28,160),
M and M.AbsoluteSize.Y or 0
)
X=0
if N then
N.Text=""
end
for ab,ac in ipairs(V)do
if isSelected(ac.choice)and X==0 then
X=ab
end
end

c.Rebind(E,"Color","Ring")
c.Tween(K,{Rotation=180})

p:_openPopover(L,D,function()
c.Rebind(E,"Color","Foreground")
c.Tween(K,{Rotation=0})
if N then
N:ReleaseFocus()
end
end)

local ab=L:FindFirstChildOfClass"UIScale"
if ab then
ab.Scale=0.95
c.Tween(ab,{Scale=1},l)
end
applyFilter()
end

aa=function(ab)
if v then
if x~=nil and ab==x then
if isSelected(ab)then
u{}
else
u{ab}
end
return
end
if Y()then return end
if atMax()and not isSelected(ab)then return end

local ac={}
for ad,ae in ipairs(y)do
local af=isSelected(ae)
if ae==ab then
af=not af
end
if af then
table.insert(ac,ae)
end
end
u(ac)
else
u(ab)
closePanel()
end
end

q:Connect(D:GetPropertyChangedSignal"AbsoluteSize",function()
if isOpen()and L then
L.Size=UDim2.fromOffset(
math.max(D.AbsoluteSize.X+28,160),
M and M.AbsoluteSize.Y or 0
)
end
end)

q:Connect(D.MouseButton1Click,function()
if isOpen()then
closePanel()
else
openPanel()
end
end)

q:Connect(J.MouseButton1Click,function()
if t.Locked then return end
if v then
u{}
else
u(nil)
end
end)

q:Connect(b.InputBegan,function(ab)
if not isOpen()or not(N and N:IsFocused())then return end
local ac=ab.KeyCode
if ac==Enum.KeyCode.Down then
X=math.min(X+1,#V)
paintHover()
elseif ac==Enum.KeyCode.Up then
X=math.max(X-1,1)
paintHover()
end

local ad=V[X]
if ad and O then
local ae=ad.button.AbsolutePosition.Y-O.AbsolutePosition.Y
local af=ae+j
if ae<0 then
O.CanvasPosition-=Vector2.new(0,-ae)
elseif af>O.AbsoluteSize.Y then
O.CanvasPosition+=Vector2.new(0,af-O.AbsoluteSize.Y)
end
end
end)

return{
Instance=D,
Refresh=refreshDisplay,
Close=closePanel,
SetOptions=function(ab)
y,z,A=flattenOptions(applySmart(ab))

L=nil
closePanel()
end,
Choices=function()
return y
end,
SetLocked=function(ab)
local ac=if ab then 0.5 else 0
c.Tween(G,{TextTransparency=ac})
c.Tween(K,{ImageTransparency=ac})
if ab then closePanel()end
end,
}
end

return o
end

function a.n()
local aa=a.cache.combobox
if not aa then
aa={class=ComboboxFactory()}
a.cache.combobox=aa
end
return aa.class
end
end




do
local function ColorPickerFactory()
local aa=a.Theme()
local ab=a.Fonts()
local ac=a.Icons()
local ad=a.Creator()
local ae=a.i()

local af=ad.Create
local ag=aa.Token

local ah=248
local ai=150
local aj=12
local ak=20
local al=32
local am=20
local b=TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

local c={}
local d=6

local function pushRecent(e)
for f,g in ipairs(c)do
if g:ToHex()==e:ToHex()then
table.remove(c,f)
break
end
end
table.insert(c,1,e)
while#c>d do
table.remove(c)
end
end

local e={}

function e.Hex(f,g)
local h="#"..string.upper(f:ToHex())
if g and g>0 then
h..=string.format("%02X",math.floor((1-g)*255+0.5))
end
return h
end

function e.Parse(f)
local g=string.gsub(string.gsub(f,"%s",""),"^#","")
if string.find(g,"[^%x]")then
return nil,nil
end
if#g==3 then
g=string.gsub(g,"%x","%0%0")
end
if#g==6 then
return Color3.fromHex(g),nil
end
if#g==8 then
local h=tonumber(string.sub(g,7,8),16)
return Color3.fromHex(string.sub(g,1,6)),1-h/255
end
return nil,nil
end

local function makeCanvas(f,g,h,i,j)
return af("CanvasGroup",{
Name=g,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=i,
ZIndex=j or 21,
Parent=f,
},{
af("UICorner",{CornerRadius=UDim.new(0,h)}),
})
end

local function makeCheckerboard(f,g,h,i)
local j=af("Frame",{
Name="Checker",
BackgroundColor3=ag.Muted,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
Parent=f,
})
for k=0,h-1 do
for l=0,g-1 do
if(l+k)%2==0 then
af("Frame",{
BackgroundColor3=ag.Border,
BorderSizePixel=0,
Position=UDim2.fromOffset(l*i,k*i),
Size=UDim2.fromOffset(i,i),
Parent=j,
})
end
end
end
return j
end

local function makeSliderThumb(f)
local g=af("Frame",{
Name="Thumb",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(16,16),
ZIndex=4,
Parent=f,
},{af("UICorner",{CornerRadius=UDim.new(1,0)})})

af("UIStroke",{
Color=Color3.new(0,0,0),
Transparency=0.75,
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=g,
})

af("Frame",{
Name="Fill",
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(10,10),
ZIndex=5,
Parent=g,
},{af("UICorner",{CornerRadius=UDim.new(1,0)})})

return g
end

function e.new(f,g,h,i,j,k,l)
local m,n=af("TextButton",{
Name="Trigger",
Text="",
AutoButtonColor=false,
BackgroundColor3=ag.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,al),
Parent=h,
},{ad.Corner(aa.Radius.Lg)}),ad.Stroke(ag.Foreground)
n.Parent=m
ad.ApplyGlassStroke(n,g,f.Library and f.Library.ThemeChanged)

local o=makeCanvas(m,"Swatch",5,UDim2.fromOffset(am,am),2)
o.AnchorPoint=Vector2.new(0,0.5)
o.Position=UDim2.new(0,6,0.5,0)
makeCheckerboard(o,4,4,5)

local p=af("Frame",{
Name="Color",
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=2,
Parent=o,
})
local q=ad.Stroke(ag.Foreground)
q.Transparency=0.85
q.Parent=o

local r=ad.Text{
Name="Hex",
Text="",
FontFace=ab.Medium,
TextSize=aa.TextSize.Sub,
TextTruncate=Enum.TextTruncate.AtEnd,
Position=UDim2.fromOffset(am+14,0),
Size=UDim2.new(1,-(am+20),1,0),
Parent=m,
}


local s=0
local t=0
local u=1
local v=0

local function syncFromValue()
local w,x,y=(i.Value):ToHSV()
if x>0 and y>0 then
s=w
end
if y>0 then
t=x
end
u=y
v=i.Transparency or 0
end

local function currentColor()
return Color3.fromHSV(s,t,u)
end

local w,x,y={}


local function isOpen()
return f._popover~=nil and f._popover.anchor==m
end

local function displayHex()
if j then
return e.Hex(currentColor(),v)
end
return e.Hex(currentColor())
end

local function refreshPanel()
local z=currentColor()
p.BackgroundColor3=z
p.BackgroundTransparency=v
r.Text=displayHex()

if not x then return end
w.hueLayer.BackgroundColor3=Color3.fromHSV(s,1,1)
w.cursor.Position=UDim2.fromScale(t,1-u)
w.cursor.BackgroundColor3=z
w.hueThumb.Position=UDim2.fromScale(s,0.5)
w.hueThumb.Fill.BackgroundColor3=Color3.fromHSV(s,1,1)
w.preview.BackgroundColor3=z
w.preview.BackgroundTransparency=v
if w.alphaBar then
w.alphaFill.BackgroundColor3=z
w.alphaThumb.Position=UDim2.fromScale(1-v,0.5)
w.alphaThumb.Fill.BackgroundColor3=z
w.alphaThumb.Fill.BackgroundTransparency=v
end
if not w.hexBox:IsFocused()then
w.hexBox.Text=displayHex()
end
end

local function commit(z)
refreshPanel()
k(currentColor(),v,z)
if z then
pushRecent(currentColor())
end
end

local function bindDrag(z,A)
g:Connect(z.InputBegan,function(B)
if i.Locked then return end
local C=B.UserInputType==Enum.UserInputType.MouseButton1
or B.UserInputType==Enum.UserInputType.Touch
if not C then return end

local function move(D)
local E=z.AbsolutePosition
local F=z.AbsoluteSize
A(
math.clamp((D.X-E.X)/math.max(F.X,1),0,1),
math.clamp((D.Y-E.Y)/math.max(F.Y,1),0,1)
)
commit(false)
end

f:_drag(B,move,function()
commit(true)
end)
move(B.Position)
end)
end

local function buildPanel()
x,panelStroke=g:Give(af("Frame",{
Name="ColorPicker",
BackgroundColor3=ag.Popover,
BackgroundTransparency=0.04,
BorderSizePixel=0,
Size=UDim2.fromOffset(ah,0),
AutomaticSize=Enum.AutomaticSize.Y,
ZIndex=20,
},{
ad.Corner(aa.Radius.Xl),
ad.Padding(12),
ad.List(12),
})),ad.Stroke(ag.Foreground)
panelStroke.Transparency=0.9
panelStroke.Parent=x

y=af("UIScale",{Parent=x})


local z=af("TextButton",{
Name="Square",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,ai),
LayoutOrder=1,
ZIndex=21,
Parent=x,
})

local A=makeCanvas(z,"Surface",aa.Radius.Lg,UDim2.fromScale(1,1),21)
local B=af("Frame",{
Name="Hue",
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=21,
Parent=A,
})

af("Frame",{
Name="White",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=22,
Parent=A,
},{af("UIGradient",{Transparency=NumberSequence.new(0,1)})})

af("Frame",{
Name="Black",
BackgroundColor3=Color3.new(0,0,0),
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=23,
Parent=A,
},{
af("UIGradient",{Rotation=90,Transparency=NumberSequence.new(1,0)}),
})

local C=ad.Stroke(ag.Foreground)
C.Transparency=0.9
C.Parent=A

local D=af("Frame",{
Name="Cursor",
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Size=UDim2.fromOffset(16,16),
ZIndex=25,
Parent=z,
},{
af("UICorner",{CornerRadius=UDim.new(1,0)}),
af("UIStroke",{Color=Color3.new(1,1,1),Thickness=2.5}),
})

af("Frame",{
Name="Shade",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.new(1,7,1,7),
ZIndex=24,
Parent=D,
},{
af("UICorner",{CornerRadius=UDim.new(1,0)}),
af("UIStroke",{Color=Color3.new(0,0,0),Thickness=1,Transparency=0.7}),
})

bindDrag(z,function(E,F)
t=E
u=1-F
end)


local E=af("Frame",{
Name="HueTrack",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,aj),
LayoutOrder=2,
ZIndex=21,
Parent=x,
})

local F=af("TextButton",{
Name="Hue",
Text="",
AutoButtonColor=false,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=21,
Parent=E,
},{
ad.Corner(aj/2),
af("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromHSV(0,1,1)),
ColorSequenceKeypoint.new(0.1667,Color3.fromHSV(0.1667,1,1)),
ColorSequenceKeypoint.new(0.3333,Color3.fromHSV(0.3333,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.fromHSV(0.5,1,1)),
ColorSequenceKeypoint.new(0.6667,Color3.fromHSV(0.6667,1,1)),
ColorSequenceKeypoint.new(0.8333,Color3.fromHSV(0.8333,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromHSV(1,1,1)),
},
}),
})

local G=makeSliderThumb(E)

bindDrag(F,function(H)
s=math.min(H,0.9999)
end)


if j then
local H=af("Frame",{
Name="Alpha",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,aj),
LayoutOrder=3,
ZIndex=21,
Parent=x,
})

local I=af("TextButton",{
Name="Bar",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=21,
Parent=H,
})

local J=makeCanvas(I,"Surface",aj/2,UDim2.fromScale(1,1),21)
makeCheckerboard(J,42,2,aj/2)

w.alphaFill=af("Frame",{
Name="Fill",
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=22,
Parent=J,
},{af("UIGradient",{Transparency=NumberSequence.new(1,0)})})

w.alphaBar=I
w.alphaThumb=makeSliderThumb(H)

bindDrag(I,function(K)
v=1-K
end)
end


local H=af("Frame",{
Name="Footer",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,32),
LayoutOrder=4,
ZIndex=21,
Parent=x,
},{
af("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local I=makeCanvas(H,"Preview",aa.Radius.Md,UDim2.fromOffset(32,32),21)
I.LayoutOrder=1
makeCheckerboard(I,4,4,8)
w.preview=af("Frame",{
Name="Color",
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=22,
Parent=I,
})

local J=ad.Stroke(ag.Foreground)
J.Transparency=0.85
J.Parent=I

local K=af("Frame",{
Name="Field",
BackgroundColor3=ag.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
Size=UDim2.new(1,-80,1,0),
LayoutOrder=2,
ZIndex=21,
Parent=H,
},{ad.Corner(aa.Radius.Lg)})

local L=af("TextButton",{
Name="Reset",
Text="",
AutoButtonColor=false,
BackgroundColor3=ag.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(32,32),
LayoutOrder=3,
ZIndex=21,
Parent=H,
},{ad.Corner(aa.Radius.Lg)})

af("ImageLabel",{
BackgroundTransparency=1,
Image=ac.Get"rotate-ccw"or"",
ImageColor3=ag.MutedForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(18,18),
ZIndex=22,
Parent=L,
})

L.MouseEnter:Connect(function()
aa.Tween(L,{BackgroundTransparency=0},b)
end)
L.MouseLeave:Connect(function()
aa.Tween(L,{BackgroundTransparency=1},b)
end)
L.MouseButton1Click:Connect(function()
if i.Locked then return end
s,t,u=l.color:ToHSV()
v=l.transparency
commit(true)
end)

local M=ad.Stroke(ag.Foreground)
M.Parent=K
ad.ApplyGlassStroke(M,g,f.Library and f.Library.ThemeChanged)

w.hexBox=af("TextBox",{
Name="Hex",
BackgroundTransparency=1,
ClearTextOnFocus=false,
FontFace=ab.Medium,
TextSize=aa.TextSize.Sm,
TextColor3=ag.Foreground,
PlaceholderColor3=ag.MutedForeground,
PlaceholderText="#RRGGBB",
Text="",
TextXAlignment=Enum.TextXAlignment.Left,
Size=UDim2.fromScale(1,1),
ZIndex=22,
Parent=K,
},{ad.Padding(0,10,0,10)})

g:Connect(w.hexBox.Focused,function()
aa.Rebind(M,"Color","Ring")
end)
g:Connect(w.hexBox.FocusLost,function()
aa.Rebind(M,"Color","Foreground")
local N,O=e.Parse(w.hexBox.Text)
if N and not i.Locked then
s,t,u=N:ToHSV()
if O and j then
v=O
end
commit(true)
else
refreshPanel()
end
end)


local N=af("Frame",{
Name="Swatches",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=5,
ZIndex=21,
Parent=x,
},{
af("UIGridLayout",{
CellSize=UDim2.fromOffset(ak,ak),
CellPadding=UDim2.fromOffset(4,4),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

w.swatches=N
w.square=z
w.hueLayer=B
w.cursor=D
w.hueThumb=G
end

local function rebuildSwatches()
local z=w.swatches
for A,B in ipairs(z:GetChildren())do
if B:IsA"GuiButton"then
B:Destroy()
end
end

local A={}
for B,C in ipairs(ae.Cycle)do
table.insert(A,ae.Colors[C])
end
table.insert(A,Color3.new(1,1,1))
table.insert(A,Color3.new(0,0,0))
for B,C in ipairs(c)do
table.insert(A,C)
end

for B,C in ipairs(A)do
local D,E=af("TextButton",{
Name="Swatch",
Text="",
AutoButtonColor=false,
BackgroundColor3=C,
BorderSizePixel=0,
LayoutOrder=B,
ZIndex=22,
Parent=z,
},{ad.Corner(5)}),ad.Stroke(ag.Foreground)
E.Transparency=0.85
E.Parent=D

D.MouseEnter:Connect(function()
aa.Tween(E,{Transparency=0.3},b)
end)
D.MouseLeave:Connect(function()
aa.Tween(E,{Transparency=0.85},b)
end)
D.MouseButton1Click:Connect(function()
if i.Locked then return end
s,t,u=C:ToHSV()
commit(true)
end)
end
end

local function showPanel()
if i.Locked or isOpen()then return end
if not x then
buildPanel()
end
syncFromValue()
rebuildSwatches()
refreshPanel()

aa.Rebind(n,"Color","Ring")
f:_openPopover(x,m,function()
aa.Rebind(n,"Color","Foreground")
if w.hexBox then
w.hexBox:ReleaseFocus()
end
end)

y.Scale=0.95
aa.Tween(y,{Scale=1},b)
end

g:Connect(m.MouseButton1Click,function()
if isOpen()then
f:_closePopover()
else
showPanel()
end
end)

return{
Instance=m,
Refresh=function()
syncFromValue()
refreshPanel()
end,
Close=function()
if isOpen()then
f:_closePopover()
end
end,
SetLocked=function(z)
local A=if z then 0.5 else 0
aa.Tween(r,{TextTransparency=A})
if z and isOpen()then
f:_closePopover()
end
end,
}
end

return e
end

function a.o()
local aa=a.cache.colorPicker
if not aa then
aa={class=ColorPickerFactory()}
a.cache.colorPicker=aa
end
return aa.class
end
end




do
local function TableFactory()
local aa=a.Theme()
local ab=a.Fonts()
local ac=a.Icons()
local ad=a.Creator()
local ae=a.g()
local af=ad.Create
local ag=aa.Token

local ah=38
local ai=40
local aj=32
local ak=12
local al=16
local am=20
local b=8
local c=12
local d=96



local e={
Left=Enum.TextXAlignment.Left,
Center=Enum.TextXAlignment.Center,
Right=Enum.TextXAlignment.Right,
}
local f={
Left=Enum.HorizontalAlignment.Left,
Center=Enum.HorizontalAlignment.Center,
Right=Enum.HorizontalAlignment.Right,
}

local g={
Default={bg="Primary",fg="PrimaryForeground"},
Secondary={bg="Secondary",fg="SecondaryForeground"},
Destructive={bg="Destructive",fg="DestructiveForeground"},
Outline={bg="Background",fg="Foreground",border=true},
}

local h={}

local function textWidth(i,j,k)
return math.ceil(ad.TextWidth(i,k or aa.TextSize.Sm,j))
end

local function cellValue(i)
if type(i)=="table"then
return tostring(i.Text or""),i
end
if i==nil then
return"",{}
end
return tostring(i),{}
end

function h.new(i,j,k)
local l={}
for m,n in ipairs(k.Columns or{})do
if type(n)=="string"then
n={Title=n}
end
local o=n.Align or"Left"
table.insert(l,{
key=n.Key or n.Title or m,
title=n.Title or tostring(n.Key or m),
width=n.Width,
grow=n.Grow or 1,
align=e[o]or Enum.TextXAlignment.Left,
hAlign=f[o]or Enum.HorizontalAlignment.Left,
sortable=n.Sortable~=false and k.Sortable~=false,
index=m,
})
end

local m=k.RowHeight or ai
local n=d
if k.Compact then
m=k.RowHeight or aj
n=m
end

local o={}
local p=k.Footer
local q
local r=false
local s=k.Selectable==true
local t={
RowClicked=i:Give(ae.new()),
SelectionChanged=i:Give(ae.new()),
Selected=nil,
}

local u=af("Frame",{
Name="Table",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ClipsDescendants=true,
Parent=j,
},{ad.List(0),ad.Corner(aa.Radius.Lg)})
t.Instance=u

local v=af("Frame",{
Name="Header",
BackgroundColor3=ag.Muted,
BackgroundTransparency=0.5,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.new(1,0,0,ah),
LayoutOrder=1,
Visible=k.Header~=false,
Parent=u,
},{ad.Corner(aa.Radius.Md)})

local w=af("Frame",{
Name="Strip",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Parent=v,
})

af("Frame",{
Name="Hairline",
BackgroundColor3=ag.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.fromScale(0,1),
Size=UDim2.new(1,0,0,1),
ZIndex=2,
Parent=v,
})

local x=af("ScrollingFrame",{
Name="Body",
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
CanvasSize=UDim2.new(),
ScrollBarThickness=4,
ScrollBarImageColor3=ag.Border,
ScrollingDirection=Enum.ScrollingDirection.XY,
VerticalScrollBarInset=Enum.ScrollBarInset.None,
HorizontalScrollBarInset=Enum.ScrollBarInset.None,
ElasticBehavior=Enum.ElasticBehavior.Never,
LayoutOrder=2,
Parent=u,
})

local y=af("Frame",{
Name="Rows",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=x,
},{ad.List(0)})

local z=af("Frame",{
Name="Footer",
BackgroundColor3=ag.Muted,
BackgroundTransparency=0.5,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.new(1,0,0,m),
LayoutOrder=3,
Visible=false,
Parent=u,
})

local A=af("Frame",{
Name="Strip",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Parent=z,
})

af("Frame",{
Name="Hairline",
BackgroundColor3=ag.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,1),
ZIndex=2,
Parent=z,
})

local B=ad.Text{
Name="Caption",
Text=k.Caption or"",
TextColor3=ag.MutedForeground,
TextXAlignment=Enum.TextXAlignment.Center,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,0),
LayoutOrder=4,
Visible=(k.Caption or"")~="",
Parent=u,
}
ad.Padding(12,12,12,12).Parent=B

local C=af("Frame",{
Name="Empty",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,n),
Visible=false,
Parent=x,
},{
af("UIListLayout",{
HorizontalAlignment=Enum.HorizontalAlignment.Center,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

af("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=ac.Get(k.EmptyIcon or"tray")or ac.Get"inbox"or"",
ImageColor3=ag.MutedForeground,
ImageTransparency=0.3,
Size=UDim2.fromOffset(28,28),
LayoutOrder=1,
Visible=n>=d,
Parent=C,
})

ad.Text{
Name="Note",
Text=k.Empty or"No results",
TextColor3=ag.MutedForeground,
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,18),
LayoutOrder=2,
Parent=C,
}

local D={}
local E={}
local F={}

local function cellAt(G,H)
if type(G)~="table"then return nil end
local I=G[H.key]
if I~=nil then return I end
return G[H.index]
end

local function measureCell(G,H)
local I,J=cellValue(G)
if J.Badge then
return textWidth(I,ab.Medium,aa.TextSize.Xs)+b*2
end
local K=textWidth(I,H)
if J.Icon and ac.IsImage(J.Icon)then
K+=al+6
elseif J.Icon then
K+=al+6
end
return K
end

local function measureColumns()
local G={}
for H,I in ipairs(l)do
if I.width then
G[H]=I.width
else
local J=textWidth(I.title,ab.Medium,aa.TextSize.Xs)
if I.sortable then
J+=c+4
end
for K,L in ipairs(o)do
local M=ab.Regular
if H==1 then M=ab.Medium end
J=math.max(J,measureCell(cellAt(L,I),M))
end
if p then
J=math.max(J,measureCell(cellAt(p,I),ab.Medium))
end
G[H]=J+ak*2
end
end
return G
end

local function buildCell(G,H,I,J,K)
local L,M=cellValue(H)
local N=af("Frame",{
Name=I.title,
BackgroundTransparency=1,
Size=UDim2.new(0,0,1,0),
Parent=G,
},{
ad.Padding(0,ak,0,ak),
af("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=I.hAlign,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,6),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

if M.Badge and typeof(M.Tint)=="Color3"then
local O=M.Tint
local P=af("Frame",{
Name="Badge",
BackgroundColor3=O,
BackgroundTransparency=0.84,
BorderSizePixel=0,
Size=UDim2.fromOffset(textWidth(L,ab.Medium,aa.TextSize.Xs)+b*2,am),
Parent=N,
},{ad.Corner(am)})
af("UIStroke",{
Color=O,
Transparency=0.6,
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=P,
})
ad.Text{
Name="Text",
Text=L,
TextColor3=O:Lerp(Color3.new(1,1,1),0.2),
FontFace=ab.Medium,
TextSize=aa.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.fromScale(1,1),
Parent=P,
}
return N
end

if M.Badge then
local O=g[M.Badge]or g.Default
local P=af("Frame",{
Name="Badge",
BackgroundColor3=ag[O.bg],
BorderSizePixel=0,
Size=UDim2.fromOffset(textWidth(L,ab.Medium,aa.TextSize.Xs)+b*2,am),
Parent=N,
},{ad.Corner(aa.Radius.Md)})
if O.border then
P.BackgroundTransparency=1
ad.Stroke(ag.Border).Parent=P
end
ad.Text{
Name="Text",
Text=L,
TextColor3=ag[O.fg],
FontFace=ab.Medium,
TextSize=aa.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.fromScale(1,1),
Parent=P,
}
return N
end

if M.Icon and ac.IsImage(M.Icon)then
local O=af("Frame",{
Name="Tile",
BackgroundColor3=ag.Muted,
BackgroundTransparency=0.4,
BorderSizePixel=0,
Size=UDim2.fromOffset(al,al),
LayoutOrder=1,
Parent=N,
},{ad.Corner(aa.Radius.Md)})
if typeof(M.Tint)=="Color3"then
O.BackgroundColor3=M.Tint
O.BackgroundTransparency=0.84
af("UIStroke",{
Color=M.Tint,
Transparency=0.6,
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=O,
})
end
af("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=ac.Get(M.Icon)or"",
ScaleType=Enum.ScaleType.Fit,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(al-4,al-4),
Parent=O,
})
elseif M.Icon then
af("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=ac.Get(M.Icon)or"",
ImageColor3=ag.MutedForeground,
Size=UDim2.fromOffset(al,al),
LayoutOrder=1,
Parent=N,
})
end

local O=aa.TextSize.Sm
local P="Foreground"
if K then
O=aa.TextSize.Xs
P="MutedForeground"
end

local Q=ad.Text{
Name="Text",
Text=L,
FontFace=J,
TextSize=O,
TextXAlignment=I.align,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,1,0),
LayoutOrder=2,
Parent=N,
}
aa.Bind(Q,"TextColor3",P)
af("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill,Parent=Q})

if M.Muted then
aa.Bind(Q,"TextColor3","MutedForeground")
elseif typeof(M.Color)=="Color3"then
Q.TextColor3=M.Color
elseif type(M.Color)=="string"and aa.Themes.Dark[M.Color]then
aa.Bind(Q,"TextColor3",M.Color)
end
if M.Bold then
Q.FontFace=ab.SemiBold
end

return N
end

local function layoutColumns(G)
local H=0
for I,J in ipairs(l)do
local K=G:FindFirstChild(J.title)
if K then
K.Position=UDim2.fromOffset(H,0)
K.Size=UDim2.new(0,D[I]or 0,1,0)
end
H+=D[I]or 0
end
end

local function resize()
local G=measureColumns()
local H=u.AbsoluteSize.X
local I,J=0,0
for K,L in ipairs(G)do
I+=L
J+=l[K].grow
end

local K=math.max(H-I,0)
for L,M in ipairs(G)do
local N=if J>0 then K*l[L].grow/J else 0
D[L]=math.floor(M+N)
end

local L=math.max(I,H)
w.Size=UDim2.new(0,L,1,0)
A.Size=UDim2.new(0,L,1,0)
y.Size=UDim2.new(0,L,0,#F*m)
C.Size=UDim2.new(0,H,0,n)

layoutColumns(w)
layoutColumns(A)
for M,N in ipairs(F)do
layoutColumns(N.strip)
end

local M=#F*m
if#F==0 then M=n end
local N=0
if I>H+0.5 then
N=x.ScrollBarThickness+2
end
local O=M+N
if k.MaxHeight then
O=math.min(O,k.MaxHeight)
end
x.Size=UDim2.new(1,0,0,O)
x.CanvasSize=UDim2.fromOffset(L,M)
end

local function refreshSortIcons()
for G,H in pairs(E)do
if H.sort then
if q==G then
H.sort.Image=ac.Get"chevron-up"or""
H.sort.ImageTransparency=0
aa.Bind(H.sort,"ImageColor3","Foreground")
if r then
H.sort.Image=ac.Get"chevron-down"or""
end
else
H.sort.Image=ac.Get"chevrons-up-down"or""
H.sort.ImageTransparency=0.55
aa.Bind(H.sort,"ImageColor3","MutedForeground")
end
end
end
end

local function paintRow(G,H)
local I=t.Selected==G.index
local J=1
if I then
aa.Rebind(G.frame,"BackgroundColor3","Primary")
J=0.88
else
aa.Rebind(G.frame,"BackgroundColor3","Muted")
if H then
J=0.6
end
end
aa.Tween(G.frame,{BackgroundTransparency=J})
G.bar.Visible=I
end

local G

local function rebuildHeader()
for H,I in ipairs(w:GetChildren())do
I:Destroy()
end
table.clear(E)

for H,I in ipairs(l)do
local J=buildCell(w,I.title,I,ab.Medium,true)
local K={}

if I.sortable then
K.sort=af("ImageLabel",{
Name="Mark",
BackgroundTransparency=1,
Image=ac.Get"chevrons-up-down"or"",
ImageColor3=ag.MutedForeground,
ImageTransparency=0.55,
Size=UDim2.fromOffset(c,c),
LayoutOrder=3,
Parent=J,
})

local L=J:FindFirstChild"Text"
L.Size=UDim2.new(0,textWidth(I.title,ab.Medium,aa.TextSize.Xs),1,0)
local M=L:FindFirstChildOfClass"UIFlexItem"
if M then M:Destroy()end

local N=af("TextButton",{
Name="Sort",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
Position=UDim2.fromOffset(-ak,0),
Size=UDim2.new(1,ak*2,1,0),
ZIndex=2,
Parent=af("Folder",{Parent=J}),
})

N.MouseEnter:Connect(function()
if q~=H and K.sort then
K.sort.ImageTransparency=0.2
end
end)
N.MouseLeave:Connect(function()
if q~=H and K.sort then
K.sort.ImageTransparency=0.55
end
end)
N.MouseButton1Click:Connect(function()
if q~=H then
t:Sort(H,false)
elseif not r then
t:Sort(H,true)
else
t:Sort(nil)
end
end)
end
E[H]=K
end
refreshSortIcons()
end

local function sortedRows()
local H={}
for I,J in ipairs(o)do
table.insert(H,{row=J,index=I})
end

if q then
local I=l[q]
local function sortValue(J)
if type(J)=="table"then
if J.Sort~=nil then return J.Sort end
return J.Text
end
return J
end
table.sort(H,function(J,K)
local L,M=sortValue(cellAt(J.row,I)),sortValue(cellAt(K.row,I))
local N,O=tonumber(L),tonumber(M)
local P,Q
if N and O then
P,Q=N<O,O<N
else
local R=string.lower(tostring(L or""))
local S=string.lower(tostring(M or""))
P,Q=R<S,S<R
end
if r then return Q end
return P
end)
end
return H
end

G=function()
for H,I in ipairs(F)do
I.frame:Destroy()
end
table.clear(F)

local H=sortedRows()
for I,J in ipairs(H)do
local K=af("TextButton",{
Name="Row"..I,
Text="",
AutoButtonColor=false,
BackgroundColor3=ag.Muted,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,m),
LayoutOrder=I,
Parent=y,
})

local L=af("Frame",{
Name="Strip",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Parent=K,
})

for M,N in ipairs(l)do
local O=if M==1 then ab.Medium else ab.Regular
buildCell(L,cellAt(J.row,N),N,O)
end

local M=af("Frame",{
Name="Bar",
BackgroundColor3=ag.Primary,
BorderSizePixel=0,
Size=UDim2.new(0,3,1,0),
Visible=false,
ZIndex=2,
Parent=K,
})

if I<#H then
af("Frame",{
Name="Hairline",
BackgroundColor3=ag.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.fromScale(0,1),
Size=UDim2.new(1,0,0,1),
Parent=K,
})
end

local N={
frame=K,
strip=L,
bar=M,
index=J.index,
}

K.MouseEnter:Connect(function()paintRow(N,true)end)
K.MouseLeave:Connect(function()paintRow(N,false)end)
K.MouseButton1Click:Connect(function()
t.RowClicked:Fire(N.index,o[N.index])
if s then
if t.Selected==N.index then
t:Select(nil)
else
t:Select(N.index)
end
end
end)

table.insert(F,N)
paintRow(N,false)
end

C.Visible=#o==0

for I,J in ipairs(A:GetChildren())do
J:Destroy()
end
z.Visible=p~=nil
if p then
for I,J in ipairs(l)do
buildCell(A,cellAt(p,J),J,ab.Medium)
end
end
resize()
end


local H=game:GetService"UserInputService"
local I=64
local J=TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local K
local L={}

local function tweenScroll(M,N)
L[M]=N
aa.Tween(M,{CanvasPosition=N},J)
end

local function currentScroll(M)
return L[M]or M.CanvasPosition
end

local function restoreScrolling()
if K then
K.ScrollingEnabled=true
K=nil
end
x.ScrollingEnabled=true
table.clear(L)
end

local function hasOverflow()
return x.AbsoluteCanvasSize.Y>x.AbsoluteWindowSize.Y+m/2
end

local function mouseInsideBody()
local M=H:GetMouseLocation()
local N=x:FindFirstAncestorWhichIsA"ScreenGui"
if not(N and N.IgnoreGuiInset)then
M-=game:GetService"GuiService":GetGuiInset()
end
local O=x.AbsolutePosition
local P=x.AbsoluteSize
return M.X>=O.X and M.X<=O.X+P.X
and M.Y>=O.Y and M.Y<=O.Y+P.Y
end

i:Connect(x.MouseEnter,function()
if H.TouchEnabled and not H.MouseEnabled then
return
end
if not hasOverflow()then return end
K=u:FindFirstAncestorWhichIsA"ScrollingFrame"
if K then
K.ScrollingEnabled=false
end
x.ScrollingEnabled=false
table.clear(L)
end)
i:Connect(x.MouseLeave,restoreScrolling)
i:Connect(u.AncestryChanged,restoreScrolling)
i:Give(restoreScrolling)

i:Connect(H.InputChanged,function(M)
if M.UserInputType~=Enum.UserInputType.MouseWheel or x.ScrollingEnabled then
return
end
if not mouseInsideBody()or not hasOverflow()then
restoreScrolling()
return
end

local N=-M.Position.Z*I
if H:IsKeyDown(Enum.KeyCode.LeftShift)or H:IsKeyDown(Enum.KeyCode.RightShift)then
local O=currentScroll(x)
local P=math.max(x.AbsoluteCanvasSize.X-x.AbsoluteWindowSize.X,0)
tweenScroll(x,Vector2.new(math.clamp(O.X+N,0,P),O.Y))
return
end

local O=currentScroll(x)
local P=math.max(x.AbsoluteCanvasSize.Y-x.AbsoluteWindowSize.Y,0)
local Q=math.clamp(O.Y+N,0,P)
if math.abs(Q-O.Y)>0.5 then
tweenScroll(x,Vector2.new(O.X,Q))
return
end

local R=K
if R then
local S=currentScroll(R)
local T=math.max(R.AbsoluteCanvasSize.Y-R.AbsoluteWindowSize.Y,0)
tweenScroll(R,Vector2.new(S.X,math.clamp(S.Y+N,0,T)))
end
end)

i:Connect(x:GetPropertyChangedSignal"CanvasPosition",function()
w.Position=UDim2.fromOffset(-x.CanvasPosition.X,0)
A.Position=UDim2.fromOffset(-x.CanvasPosition.X,0)
end)

local M=false
i:Connect(u:GetPropertyChangedSignal"AbsoluteSize",function()
if M then return end
M=true
task.defer(function()
M=false
if u.Parent then
resize()
end
end)
end)

function t.SetRows(N,O)
o=table.clone(O or{})
t.Selected=nil
G()
end

function t.AddRow(N,O)
table.insert(o,O)
G()
end

function t.RemoveRow(N,O)
if o[O]==nil then return end
table.remove(o,O)
if t.Selected==O then
t.Selected=nil
elseif t.Selected and t.Selected>O then
t.Selected-=1
end
G()
end

function t.Clear(N)
t:SetRows{}
end

function t.GetRows(N)
return table.clone(o)
end

function t.SetFooter(N,O)
p=O
G()
end

function t.SetCaption(N,O)
B.Text=O or""
B.Visible=(O or"")~=""
end

function t.Sort(N,O,P)
q=O
r=P==true
refreshSortIcons()
G()
end

function t.Select(N,O)
if t.Selected==O then return end
t.Selected=O
for P,Q in ipairs(F)do
paintRow(Q,false)
end
local P=if O then o[O]else nil
t.SelectionChanged:Fire(O,P)
end

rebuildHeader()
t:SetRows(k.Rows or{})
return t
end

return h
end

function a.p()
local aa=a.cache.table
if not aa then
aa={class=TableFactory()}
a.cache.table=aa
end
return aa.class
end
end




do
local function SectionFactory()
local aa=game:GetService"UserInputService"
local ab=a.Theme()
local ac=a.Fonts()
local ad=a.Icons()
local ae=a.Creator()
local af=a.g()
local ag=a.h()
local ah=a.m()
local ai=a.n()
local aj=a.i()
local ak=a.o()
local al=a.p()

local am=10
local b=12
local c=0.5


local d=180
local e=12

local f=28
local g=20
local h=0.92







local i=ae.Create
local j=ab.Token

local function measureText(k)
if not k or k==""then return 0 end
return math.ceil(ae.TextWidth(k,ab.TextSize.Title,ac.Regular))+2
end

local k={}
k.__index=k

function k.new(l,m,n,o)
local p=i("Frame",{
Name="Section",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=n,
Parent=o or l._page,
},{ae.List(12)})

local q=ae.Stroke(ab.Token.Foreground)
q.Transparency=0
local r=i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.86),
NumberSequenceKeypoint.new(0.35,0.93),
NumberSequenceKeypoint.new(0.75,0.96),
NumberSequenceKeypoint.new(1,0.91),
},
Parent=q,
})

local s=i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.76),
NumberSequenceKeypoint.new(0.5,0.88),
NumberSequenceKeypoint.new(1,0.82),
},
})

local t=i("Frame",{
Name="Group",
BackgroundColor3=j.Card,
BackgroundTransparency=0,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
Parent=p,
},{ae.Corner(ab.Radius.Xl),q,s,ae.List(0)})

local u=m.Glass~=false
local function applyGlassTheme(v)
local w=v or ab.Current
local x=w.Background or Color3.fromRGB(13,15,18)
local y=0.2126*x.R+0.7152*x.G+0.0722*x.B
local z=y<0.5

local A=w.Foreground or Color3.new(1,1,1)
local B=w.Card or x

if not u then
s.Enabled=false
r.Enabled=false
q.Transparency=h
t.BackgroundTransparency=0
ab.Rebind(t,"BackgroundColor3","Card")
return
end

s.Enabled=true
r.Enabled=true
q.Transparency=0
t.BackgroundTransparency=0
t.BackgroundColor3=if z then B:Lerp(A,0.08)else B

if z then
s.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.76),
NumberSequenceKeypoint.new(0.5,0.88),
NumberSequenceKeypoint.new(1,0.82),
}
r.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.86),
NumberSequenceKeypoint.new(0.35,0.93),
NumberSequenceKeypoint.new(0.75,0.96),
NumberSequenceKeypoint.new(1,0.91),
}
else
s.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.62),
NumberSequenceKeypoint.new(0.5,0.78),
NumberSequenceKeypoint.new(1,0.70),
}
r.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.78),
NumberSequenceKeypoint.new(0.35,0.88),
NumberSequenceKeypoint.new(0.75,0.93),
NumberSequenceKeypoint.new(1,0.85),
}
end
end

applyGlassTheme(ab.Current)
if l._window and l._window.Library and l._window.Library.ThemeChanged then
l._window._maid:Give(l._window.Library.ThemeChanged:Connect(applyGlassTheme))
end

local v
local w=m.Title or m.Description or m.Icon
if w then
local x=i("Frame",{
Name="Header",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=0,
Parent=t,
},{
ae.Padding(12,12,12,12),
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,10),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

if m.Icon then
local y=i("Frame",{
Name="Leading",
BackgroundTransparency=1,
Size=UDim2.fromOffset(f,f),
LayoutOrder=1,
Parent=x,
})
aj.new(y,m.Icon,m.Title or"",
if m.Color then aj.Color(m.Color,n)else nil,
f,g)
end

local y=i("Frame",{
Name="Text",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
Parent=x,
},{
ae.List(2),
i("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill}),
})

if m.Title then
ae.Text{
Text=m.Title,
FontFace=ac.SemiBold,
TextSize=ab.TextSize.Title,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
Parent=y,
}
end

v=ae.Text{
Name="Description",
Text=m.Description or"",
Visible=(m.Description or"")~="",
RichText=true,
TextColor3=j.MutedForeground,
TextSize=ab.TextSize.Sub,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
Parent=y,
}
end

if w then
i("Frame",{
Name="HeaderDivider",
BackgroundColor3=j.Foreground,
BackgroundTransparency=h,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,1),
LayoutOrder=1,
Parent=t,
})
end

local x=i("Frame",{
Name="Rows",
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
Parent=t,
},{ae.List(0)})

return setmetatable({
Instance=p,
_window=l._window,
_maid=l._window._maid,
_group=x,
_order=0,
_description=v,
_setGlass=function(y)
u=y~=false
applyGlassTheme(ab.Current)
end,
},k)
end

function k.SetGlass(l,m)
if l._setGlass then
l._setGlass(m)
end
end

function k.SetDescription(l,m)
local n=l._description
if n then
n.Text=m or""
n.Visible=n.Text~=""
end
end

function k._row(l,m,n,o)
l._order+=1
local p=i(if o then"TextButton"else"Frame",{
Name=m,
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=l._order,
Parent=l._group,
},{
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,e),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
ae.Padding(am,b,am,b),
})

local q=i("Folder",{Name="Decor",Parent=p})

if o then
p.Text=""
p.AutoButtonColor=false
i("Frame",{
Name="Highlight",
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.fromOffset(-b+4,-am+4),
Size=UDim2.new(1,b*2-8,1,am*2-8),
ZIndex=0,
Parent=q,
},{ae.Corner(ab.Radius.Lg)})
end

if l._order>1 then
i("Frame",{
Name="Divider",
BackgroundColor3=j.Foreground,
BackgroundTransparency=h,
BorderSizePixel=0,
Position=UDim2.new(0,0,0,-am),
Size=UDim2.new(1,0,0,1),
ZIndex=2,
Parent=q,
})
end

local r=i("Frame",{
Name="Left",
BackgroundTransparency=1,
Size=UDim2.new(0,0,0,0),
AutomaticSize=Enum.AutomaticSize.XY,
LayoutOrder=1,
Parent=p,
},{
ae.List(2),
i("UIFlexItem",{
FlexMode=Enum.UIFlexMode.Custom,
GrowRatio=1,
ShrinkRatio=0.01,
}),
})

local s=ae.Text{
Name="Title",
Text=n.Title or"",
TextColor3=if n.Muted then j.MutedForeground else j.Foreground,
TextSize=if n.Muted then ab.TextSize.Sub else ab.TextSize.Title,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
Visible=(n.Title or"")~="",
Parent=r,
}

local t=ae.Text{
Name="Description",
Text=n.Description or"",
TextColor3=j.MutedForeground,
TextSize=ab.TextSize.Sub,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,ab.TextSize.Sub+4),
LayoutOrder=2,
Visible=(n.Description or"")~="",
Parent=r,
}

local u=i("Frame",{
Name="Right",
BackgroundTransparency=1,
Size=UDim2.new(0,0,0,0),
AutomaticSize=Enum.AutomaticSize.XY,
LayoutOrder=2,
Parent=p,
},{
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

return p,u,s,t
end


local l=12
local m=100

function k._fitRight(n,o,p,q,r,s)
local t=p:FindFirstChildOfClass"UIListLayout"
local u=o:FindFirstChildOfClass"UIListLayout"
local v=o:FindFirstChild"Left"
local w=v:FindFirstChildOfClass"UIFlexItem"
local x=s==nil

p.AutomaticSize=Enum.AutomaticSize.Y

local function measureRight()
local y,z=0,0
for A,B in ipairs(p:GetChildren())do
if B:IsA"GuiObject"and B.Visible then
local C=B:GetAttribute"FitWidth"
if type(C)~="number"then
local D=B:GetAttribute"BaseWidth"
if B:GetAttribute"FullWidth"and type(D)=="number"then
C=D
else
C=math.max(B.Size.X.Offset,B.AbsoluteSize.X)
end
end
if C>0 then
y+=C
z+=1
end
end
end
return y+math.max(z-1,0)*t.Padding.Offset
end

local function recompute()
local y=o:FindFirstChildOfClass"UIPadding"
local z=1
local A=o.Parent
while A do
local B=A:FindFirstChildOfClass"UIScale"
if B and B.Scale>0 then
z*=B.Scale
end
A=A.Parent
end

local B=o.AbsoluteSize.X/z-y.PaddingLeft.Offset-y.PaddingRight.Offset
if B<=0 then return end

local C=measureText(q.Text)
if r.Visible then
C=math.max(C,math.min(
ae.TextWidth(r.Text,ab.TextSize.Sub,ac.Regular),
d
))
end

local D=B-l-C
local E=if x then measureRight()else s


local F=D<E


if u then
u.FillDirection=if F then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal
u.Padding=UDim.new(0,if F then 8 else e)
end

t.FillDirection=Enum.FillDirection.Horizontal
t.Padding=UDim.new(0,if F then 8 else l)
t.Wraps=F
t.HorizontalAlignment=if F
then Enum.HorizontalAlignment.Left
else Enum.HorizontalAlignment.Right

w.Parent=if F then nil else v
v.AutomaticSize=if F then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY
v.Size=if F
then UDim2.fromOffset(B,0)
else UDim2.fromOffset(measureText(q.Text),0)

if x then
p.Size=if F
then UDim2.fromOffset(B,0)
else UDim2.fromOffset(E,0)
for G,H in ipairs(p:GetChildren())do
local I=H:GetAttribute"FitWidth"
if type(I)=="number"and I>0 and H:IsA"GuiObject"then


local J=math.max(math.min(I,B),math.min(m,I))
if H.Size.X.Offset~=J then
H.Size=UDim2.new(0,J,H.Size.Y.Scale,H.Size.Y.Offset)
end
end
end
else
p.Size=if F
then UDim2.fromOffset(B,0)
else UDim2.fromOffset(math.min(E,D),0)
end




for G,H in ipairs(p:GetChildren())do
if H:IsA"GuiObject"and H:GetAttribute"FullWidth"then
if F then
H.Size=UDim2.new(1,0,H.Size.Y.Scale,H.Size.Y.Offset)
else
local I=H:GetAttribute"BaseWidth"
if type(I)=="number"then
H.Size=UDim2.new(0,I,H.Size.Y.Scale,H.Size.Y.Offset)
end
end
end
end
end

local y=n._maid
local z=false
local A=0.1

local function schedule()
if z then return end
z=true
task.defer(function()
z=false
if o.Parent then recompute()end
end)
task.delay(A,function()
if o.Parent then recompute()end
end)
end

y:Connect(o:GetPropertyChangedSignal"AbsoluteSize",schedule)
y:Connect(q:GetPropertyChangedSignal"Text",schedule)
y:Connect(r:GetPropertyChangedSignal"Text",schedule)

if x then
local function watch(B)
if B:IsA"GuiObject"then
y:Connect(B:GetPropertyChangedSignal"AbsoluteSize",schedule)
y:Connect(B:GetPropertyChangedSignal"Visible",schedule)
end
end
y:Connect(p.ChildAdded,function(B)
watch(B)
schedule()
end)
for B,C in ipairs(p:GetChildren())do
watch(C)
end
end

schedule()
end

local function collapseLeft(n,o)
local p=o:FindFirstChildOfClass"UIListLayout"
p.HorizontalAlignment=Enum.HorizontalAlignment.Left
p.Wraps=true
n:FindFirstChild"Left":Destroy()
o.AutomaticSize=Enum.AutomaticSize.Y
o.Size=UDim2.fromScale(1,0)
end

function k._confirmed(n,o,p,q)
if not o then return q end
return function()
local r={}
if type(o)=="table"then
r=table.clone(o)
end
r.Title=r.Title or((p or"Continue").."?")
if n._window:Confirm(r)then
q()
end
end
end

function k._pressable(n,o,p,q)
local r=n._maid
local s=((o:FindFirstChild"Decor"):FindFirstChild"Highlight")

local function setHighlight(t,u)
ab.Tween(s,{BackgroundTransparency=t},u)
end

r:Connect(o.MouseEnter,function()
if not q()then setHighlight(0.5)end
end)
r:Connect(o.MouseLeave,function()
setHighlight(1)
end)
r:Connect(o.MouseButton1Down,function()
if not q()then
setHighlight(0.2,TweenInfo.new(0.06))
end
end)
r:Connect(o.MouseButton1Up,function()
setHighlight(if q()then 1 else 0.5)
end)
r:Connect(o.MouseButton1Click,function()
if not q()then p()end
end)
end


local function wrapControl(n,o,p,q,r)
n.Instance=o
n.Locked=false

function n.SetVisible(s,t)
o.Visible=t
end

function n.Destroy(s)
if n.Changed then
n.Changed:Destroy()
end
o:Destroy()
end

if p then
function n.SetTitle(s,t)
p.Text=t
p.Visible=t~=""
local u=p.Parent
if u and u:IsA"GuiObject"then
u.Size=UDim2.new(0,measureText(t),0,0)
end
end
end

if q then
function n.SetDescription(s,t)
q.Text=t
q.Visible=t~=""
end
end

function n.SetLocked(s,t)
n.Locked=t==true
local u=if n.Locked then c else 0
for v,w in ipairs{p,q}do
if w then
ab.Tween(w,{TextTransparency=u})
end
end
local v=o:FindFirstChild"Decor"and o.Decor:FindFirstChild"Highlight"
if v and n.Locked then
ab.Tween(v,{BackgroundTransparency=1})
end
if r then r(n.Locked)end
end

return n
end

function k._value(n,o,p,q,r)
local s=n._window
local t=p.Flag

o.Changed=n._maid:Give(af.new())
o.Value=q

if t then
o.Value=s:GetFlag(t,q)
s.Controls[t]=o
end
r(o.Value,true)

return function(u,v)
o.Value=u
r(u,false)
if t then
s:_saveFlag(t,u)
end
if not v then
if p.Callback then
task.spawn(p.Callback,u)
end
o.Changed:Fire(u)
end
end
end

function k.AddLabel(n,o)
local p=if type(o)=="string"then{Text=o}else o local
q, r, s=n:_row("Label",{Title=p.Text or"Label",Muted=p.Muted})
local t=wrapControl({},q,s)
t.SetText=t.SetTitle
return t
end

function k.AddParagraph(n,o,p)
local q=if type(o)=="string"then{Title=o,Content=p}else o local
r, s, t, u=n:_row("Paragraph",{
Title=q.Title,
Description=q.Content,
})
local v=wrapControl({},r,t,u)
v.SetContent=v.SetDescription
return v
end

function k.AddBadge(n,o,p,q)
local r=if type(o)=="string"then{Title=o,Text=p,Variant=q}else o
local s,t,u,v=n:_row("Badges",r)

local w=r.Badges or{{Text=r.Text or r.Title,Variant=r.Variant}}
if not r.Title then
collapseLeft(s,t)
end

local x,y={},{}
for z,A in ipairs(w)do
local B=table.clone(A)
B.LayoutOrder=z
local C,D,E=ah.new(B)
C.Parent=t
x[z]=D
y[z]=E
end

if r.Title then
n:_fitRight(s,t,u,v)
end

local z=wrapControl({},s,u,v)
function z.SetText(A,B,C)
x[C or 1](B)
end
function z.SetVariant(A,B,C)
y[C or 1](B)
end
return z
end

function k.AddButton(n,o,p)
local q=if type(o)=="string"then{Title=o,Callback=p}else o
local r=n._maid

if not q.Buttons and not(q.ButtonText or q.Variant or q.Icon or q.Size)then
local s,t,u,v=n:_row("Button",q,true)
local w=i("ImageLabel",{
Name="Chevron",
BackgroundTransparency=1,
Image=ad.Get"chevron-right"or"",
ImageColor3=j.MutedForeground,
Size=UDim2.fromOffset(18,18),
Parent=t,
})

local x
x=wrapControl({},s,u,v,function(y)
w.Image=ad.Get(if y then"lock"else"chevron-right")or""
end)

n:_pressable(s,function()
if q.Callback then
task.spawn(n:_confirmed(q.Confirm,q.Title,q.Callback))
end
end,function()return x.Locked end)

if q.Locked then x:SetLocked(true)end
return x
end

local s=q.Buttons==nil or q.Title~=nil
local t,u,v,w=n:_row("Buttons",if s then q else{})
local x=q.Buttons or{q}
local y={}

if not s then
collapseLeft(t,u)
end

for z,A in ipairs(x)do
local B=table.clone(A)
B.LayoutOrder=z
B.Size=B.Size or"Sm"
if not q.Buttons then
B.Title=q.ButtonText or q.Title
end
local C=A.Confirm
if C==nil and not q.Buttons then
C=q.Confirm
end
if C and B.Callback then
B.Callback=n:_confirmed(C,B.Title or q.Title,B.Callback)
end
local D,E=ag.new(r,B)
D.Parent=u
D.Visible=true
y[z]=E
end

if s then
n:_fitRight(t,u,v,w)
end

local z=wrapControl({},t,v,w)
local A=z.SetLocked

function z.SetButtonText(B,C,D)
y[D or 1].SetTitle(C)
end

function z.SetLocked(B,C,D)
if D then
y[D].SetLocked(C)
return
end
A(z,C)
for E,F in ipairs(y)do
F.SetLocked(C)
end
end

if q.Locked then z:SetLocked(true)end
return z
end

local function buildGlassSwitch(n,o,p)
local q={
Name="Switch",
BackgroundColor3=j.Input,
BackgroundTransparency=0.25,
BorderSizePixel=0,
Size=UDim2.fromOffset(36,20),
Parent=n,
}
if o then
q.Text=""
q.AutoButtonColor=false
q.LayoutOrder=p
end
local r=i(if o then"TextButton"else"Frame",q,{
ae.Corner(10),
i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(0.55,0.16),
NumberSequenceKeypoint.new(1,0.08),
},
}),
})
local s=ae.Stroke(j.Foreground,1)
s.Parent=r
i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.68),
NumberSequenceKeypoint.new(0.45,0.85),
NumberSequenceKeypoint.new(1,0.90),
},
Parent=s,
})

local t=i("Frame",{
Name="Thumb",
BackgroundColor3=j.SwitchThumb,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,2,0.5,0),
Size=UDim2.fromOffset(16,16),
Parent=r,
},{
ae.Corner(8),
i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,0.14),
},
}),
})
local u=ae.Stroke(j.Foreground,1)
u.Transparency=0.78
u.Parent=t

local function paintSwitch(v,w,x)
local y=if x then TweenInfo.new(0)else nil
local z=if w then c else(if v then 0.10 else 0.25)
local A=if w then c else 0
ab.Rebind(r,"BackgroundColor3",if v then"Primary"else"Input")
ab.Rebind(t,"BackgroundColor3",if v then"PrimaryForeground"else"SwitchThumb")
ab.Tween(r,{BackgroundTransparency=z},y)
ab.Tween(s,{Transparency=if w then c else 0},y)
ab.Tween(t,{
Position=UDim2.new(0,if v then 18 else 2,0.5,0),
BackgroundTransparency=A,
},y)
ab.Tween(u,{Transparency=if w then 0.90 else 0.78},y)
end

return r,t,paintSwitch
end

function k.AddToggle(n,o,p,q)
local r=if type(o)=="string"then{Title=o,Default=p,Callback=q}else o
local s,t,u,v=n:_row("Toggle",r,true)local

w, x, y=buildGlassSwitch(t,false)

local z
z=wrapControl({},s,u,v,function(A)
y(z and z.Value==true,A)
end)local

A=n:_value(z,r,r.Default==true,function(A,B)
y(A==true,z.Locked,B)
end)

local B=false

local function needsConfirm(C)
local D=r.Confirm
if not D then return false end
local E="On"
if type(D)=="table"and D.When then
E=D.When
end
return E=="Both"or(E=="On"and C)or(E=="Off"and not C)
end

n:_pressable(s,function()
local C=not z.Value
if not needsConfirm(C)then
A(C)
return
end
if B then return end
B=true
task.spawn(function()
local D={}
if type(r.Confirm)=="table"then
D=table.clone(r.Confirm)
end
local E=if C then"on"else"off"
D.Title=D.Title or("Turn "..(r.Title or"this").." "..E.."?")
D.ConfirmText=D.ConfirmText or("Turn "..E)
local F=n._window:Confirm(D)
B=false
if F and not z.Locked then
A(C)
end
end)
end,function()return z.Locked end)

function z.Set(C,D,E)
A(D==true,E)
end
function z.Get(C)
return z.Value
end

if r.Locked then z:SetLocked(true)end
return z
end

function k.AddSlider(n,o)
local p,q,r,s=o.Min or 0,o.Max or 100,o.Step or 1,o.Suffix or""
local t=math.max(0,#(tostring(r):match"%.(%d+)$"or""))
local u,v,w,x=n:_row("Slider",o)
local y=v:FindFirstChildOfClass"UIListLayout"
y.Wraps=false

local z,A=i("Frame",{
Name="ValueField",
BackgroundColor3=j.Card,
BackgroundTransparency=0,
BorderSizePixel=0,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,28),
Parent=v,
},{
ae.Corner(ab.Radius.Lg),
ae.Padding(0,2,0,2),
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,0),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
}),ae.Stroke(j.Foreground,1)
A.Parent=z
ae.ApplyGlass(z,A,n._maid,n._window and n._window.Library and n._window.Library.ThemeChanged,{
DarkAlpha={0.48,0.68,0.56},
LightAlpha={0.36,0.56,0.44},
})

local function stepper(B,C,D)
local E=i("TextButton",{
Name=B,
Text="",
AutoButtonColor=false,
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(24,24),
LayoutOrder=D,
Parent=z,
},{ae.Corner(ab.Radius.Md)})
i("ImageLabel",{
BackgroundTransparency=1,
Image=ad.Get(C)or"",
ImageColor3=j.MutedForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(14,14),
Parent=E,
})
n._maid:Connect(E.MouseEnter,function()
ab.Tween(E,{BackgroundTransparency=0})
end)
n._maid:Connect(E.MouseLeave,function()
ab.Tween(E,{BackgroundTransparency=1})
end)
return E
end

local function hairline(B)
i("Frame",{
Name="Hairline",
BackgroundColor3=j.Foreground,
BackgroundTransparency=0.88,
BorderSizePixel=0,
Size=UDim2.fromOffset(1,16),
LayoutOrder=B,
Parent=z,
})
end

local B=stepper("Decrease","minus",1)
hairline(2)

local C=i("TextBox",{
Name="Value",
BackgroundTransparency=1,
BorderSizePixel=0,
ClearTextOnFocus=false,
FontFace=ac.Medium,
TextSize=ab.TextSize.Sub,
TextColor3=j.Foreground,
RichText=true,
Text="",
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(40,24),
LayoutOrder=3,
Parent=z,
},{
ae.Padding(0,8,0,8),
i("UISizeConstraint",{MinSize=Vector2.new(40,24)}),
})

hairline(4)
local D=stepper("Increase","plus",5)

local E=i("Frame",{
Name="Halo",
BackgroundTransparency=1,
Position=UDim2.new(0,-5,0,-3),
Size=UDim2.new(1,10,1,6),
ZIndex=0,
Parent=i("Folder",{Name="Decor",Parent=z}),
},{ae.Corner(ab.Radius.Lg+3)})
local F=i("UIStroke",{
Color=j.Ring,
Thickness=3,
Transparency=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=E,
})

local function formatValue(G)
local H=string.format("%."..t.."f",G)
if s==""then return H end
local I=ab.Color"MutedForeground":ToHex()
return H..'<font color="#'..I..'">'..s.."</font>"
end

local G=o.Bar~=false
local H=o.Steppers~=false
if not H then
for I,J in ipairs(z:GetChildren())do
if J.Name=="Hairline"or J==B or J==D then
J.Visible=false
end
end
C.Size=UDim2.fromOffset(56,24)
end

local I=i("TextButton",{
Name="Track",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
Size=UDim2.new(0,180,0,18),
LayoutOrder=10,
Visible=G,
Parent=v,
})

I:SetAttribute("FullWidth",true)
I:SetAttribute("BaseWidth",180)

local J=i("Frame",{
Name="Bar",
BackgroundColor3=j.Input,
BackgroundTransparency=0.35,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.new(1,0,0,7),
Parent=I,
},{ae.Corner(4)})
local K=ae.Stroke(j.Foreground,1)
K.Parent=J
i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.78),
NumberSequenceKeypoint.new(0.5,0.90),
NumberSequenceKeypoint.new(1,0.86),
},
Parent=K,
})

local L=i("Frame",{
Name="Range",
BackgroundColor3=j.Primary,
BackgroundTransparency=0.08,
BorderSizePixel=0,
Size=UDim2.fromScale(0,1),
Parent=J,
},{
ae.Corner(4),
i("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,0.20),
},
}),
})

local M=i("Frame",{
Name="Thumb",
BackgroundColor3=j.SwitchThumb,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(16,16),
ZIndex=2,
Parent=J,
},{
ae.Corner(16),
ae.Stroke(j.Primary,2),
i("UIGradient",{
Rotation=135,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,0.14),
},
}),
})

local N,O=i("Frame",{
Name="Bubble",
BackgroundColor3=j.Primary,
BackgroundTransparency=1,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,1),
Position=UDim2.new(0.5,0,0,-8),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,22),
ZIndex=5,
Parent=M,
},{ae.Corner(ab.Radius.Md),ae.Padding(0,8,0,8)}),ae.Stroke(j.Foreground,1)
O.Transparency=1
O.Parent=N

local P=ae.Text{
Name="Text",
Text="",
TextColor3=j.PrimaryForeground,
FontFace=ac.Medium,
TextSize=ab.TextSize.Xs,
TextTransparency=1,
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,22),
ZIndex=6,
Parent=N,
}

local Q=i("Frame",{
Name="Pointer",
BackgroundColor3=j.Primary,
BackgroundTransparency=1,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,1,0),
Rotation=45,
Size=UDim2.fromOffset(7,7),
ZIndex=5,
Parent=N,
})

local function showBubble(R)
local S=if R then 0.12 else 1
ab.Tween(N,{BackgroundTransparency=S})
ab.Tween(O,{Transparency=if R then 0.72 else 1})
ab.Tween(Q,{BackgroundTransparency=S})
ab.Tween(P,{TextTransparency=if R then 0 else 1})
end

local function positionForRatio(R)
return UDim2.new(R,(0.5-R)*16,0.5,0)
end

local function snap(R)
local S=p+math.floor((R-p)/r+0.5)*r
return math.clamp(tonumber(string.format("%."..t.."f",S)),p,q)
end

local R=wrapControl({},u,w,x,function(R)
local S=if R then c else 0
ab.Tween(J,{BackgroundTransparency=if R then 0.68 else 0.35})
ab.Tween(K,{Transparency=S})
ab.Tween(L,{BackgroundTransparency=if R then 0.54 else 0.08})
ab.Tween(M,{BackgroundTransparency=S})
ab.Tween(C,{TextTransparency=S})
ab.Tween(z,{BackgroundTransparency=S})
ab.Tween(A,{Transparency=S})
B.Visible=H and not R
D.Visible=H and not R
C.TextEditable=not R
if R then C:ReleaseFocus()end
end)

R.Released=n._maid:Give(af.new())

local S=n:_value(R,o,snap(o.Default or p),function(S)
local T=if q>p then(S-p)/(q-p)else 0
local U=positionForRatio(T)
L.Size=UDim2.new(U.X.Scale,U.X.Offset,1,0)
M.Position=U
if not C:IsFocused()then
C.Text=formatValue(S)
end
P.Text=string.format("%."..t.."f",S)..s
end)

n._maid:Connect(C.Focused,function()
ab.Rebind(A,"Color","Ring")
ab.Tween(F,{Transparency=0.5})
C.RichText=false
C.Text=string.format("%."..t.."f",R.Value)
C.CursorPosition=#C.Text+1
end)
n._maid:Connect(C.FocusLost,function()
ab.Rebind(A,"Color","Foreground")
ab.Tween(F,{Transparency=1})
local T=tonumber((C.Text:gsub("[^%d%.%-]","")))
local U=R.Value
if T then
U=math.clamp(tonumber(string.format("%."..t.."f",T)),p,q)
end
C.RichText=true
C.Text=formatValue(U)
if U~=R.Value then
S(U)
R.Released:Fire(U)
end
end)

I.NextSelectionLeft=I
I.NextSelectionRight=I
n._maid:Connect(aa.InputBegan,function(T)
if R.Locked or game:GetService"GuiService".SelectedObject~=I then return end
local U=0
if T.KeyCode==Enum.KeyCode.DPadLeft then U=-1
elseif T.KeyCode==Enum.KeyCode.DPadRight then U=1 end
if U~=0 then
local V=snap(R.Value+r*U)
if V~=R.Value then
S(V)
R.Released:Fire(V)
end
end
end)

for T,U in ipairs{{B,-1},{D,1}}do
n._maid:Connect(U[1].MouseButton1Click,function()
if R.Locked then return end
local V=snap(R.Value+r*U[2])
if V~=R.Value then
S(V)
R.Released:Fire(V)
end
end)
end

local function moveToPosition(T)
local U=I.AbsolutePosition.X
local V=math.max(I.AbsoluteSize.X,1)
local W=math.clamp((T.X-U)/V,0,1)
local X=snap(p+W*(q-p))
if X~=R.Value then S(X)end
end

local T=false
n._maid:Connect(I.InputBegan,function(U)
if R.Locked then return end
local V=U.UserInputType==Enum.UserInputType.MouseButton1
or U.UserInputType==Enum.UserInputType.Touch
if not V then return end
moveToPosition(U.Position)
T=true
showBubble(true)
ab.Tween(M,{Size=UDim2.fromOffset(18,18)})
end)
n._maid:Connect(aa.InputChanged,function(U)
if T and(U.UserInputType==Enum.UserInputType.MouseMovement or U.UserInputType==Enum.UserInputType.Touch)then
moveToPosition(U.Position)
end
end)
n._maid:Connect(aa.InputEnded,function(U)
if T and(U.UserInputType==Enum.UserInputType.MouseButton1 or U.UserInputType==Enum.UserInputType.Touch)then
T=false
showBubble(false)
ab.Tween(M,{Size=UDim2.fromOffset(16,16)})
R.Released:Fire(R.Value)
end
end)

function R.Set(U,V,W)
S(snap(V),W)
end
function R.Get(U)
return R.Value
end
n:_fitRight(u,v,w,x)
if o.Locked then R:SetLocked(true)end
return R
end

function k.AddInput(n,o)
local p=n._maid
local q,r,s,t=n:_row("Input",o)

local u,v=0
if o.Button then
local w=o.Button
local x=ag.new(p,{
Title=w.Title or"OK",
Icon=w.Icon,
Variant=w.Variant or"Default",
Size="Sm",
LayoutOrder=2,
Callback=function()
if w.Callback then
w.Callback(v.Text)
end
end,
})
x.Parent=r
u=x.Size.X.Offset+8
end

n:_fitRight(q,r,s,t,(o.Width or 180)+u)

local w,x=i("Frame",{
Name="Field",
BackgroundColor3=j.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,32),
Parent=r,
},{ae.Corner(ab.Radius.Lg)}),ae.Stroke(j.Foreground)
x.Parent=w
ae.ApplyGlassStroke(x,n._maid,n._window and n._window.Library and n._window.Library.ThemeChanged)

if o.Button then
i("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill,Parent=w})
end

local y=i("Frame",{
Name="Halo",
BackgroundTransparency=1,
Position=UDim2.fromOffset(-3,-3),
Size=UDim2.new(1,6,1,6),
ZIndex=0,
Parent=w,
},{ae.Corner(ab.Radius.Lg+3)})
local z=i("UIStroke",{
Color=j.Ring,
Thickness=3,
Transparency=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=y,
})

local A=10
local B=10
local C=ad.Get(o.Icon)
if C and not o.Numeric then
i("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=C,
ImageColor3=j.MutedForeground,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,9,0.5,0),
Size=UDim2.fromOffset(16,16),
Parent=w,
})
A=32
end

local D=i("Frame",{
Name="Controls",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-4,0.5,0),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,24),
ZIndex=2,
Parent=w,
},{
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local function smallButton(E,F,G)
local H=i("TextButton",{
Name=E,
Text="",
AutoButtonColor=false,
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(24,24),
LayoutOrder=G,
ZIndex=2,
Parent=D,
},{ae.Corner(ab.Radius.Md)})
i("ImageLabel",{
BackgroundTransparency=1,
Image=ad.Get(F)or"",
ImageColor3=j.MutedForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(14,14),
ZIndex=3,
Parent=H,
})
p:Connect(H.MouseEnter,function()
ab.Tween(H,{BackgroundTransparency=0})
end)
p:Connect(H.MouseLeave,function()
ab.Tween(H,{BackgroundTransparency=1})
end)
return H
end

local E,F,G
if o.Numeric then
E=smallButton("Decrease","minus",1)
F=smallButton("Increase","plus",2)
E.Parent=w
E.AnchorPoint=Vector2.new(0,0.5)
E.Position=UDim2.new(0,4,0.5,0)
for H,I in ipairs{{0,32},{1,-33}}do
i("Frame",{
Name="Hairline",
BackgroundColor3=j.Foreground,
BackgroundTransparency=0.88,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(I[1],I[2],0.5,0),
Size=UDim2.new(0,1,1,-12),
Parent=w,
})
end
A=34
B=34
elseif o.Clearable~=false then
G=smallButton("Clear","x",1)
G.Visible=false
B=34
end

v=i("TextBox",{
Name="Box",
BackgroundTransparency=1,
ClearTextOnFocus=false,
FontFace=ac.Regular,
TextSize=ab.TextSize.Sm,
TextColor3=j.Foreground,
PlaceholderColor3=j.MutedForeground,
PlaceholderText=o.Placeholder or"",
Text="",
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
Position=UDim2.fromOffset(A,0),
Size=UDim2.new(1,-(A+B),1,0),
Parent=w,
})

if o.Numeric then
v.TextXAlignment=Enum.TextXAlignment.Center
v.FontFace=ac.Medium
end

local H=wrapControl({},q,s,t,function(H)
v.TextEditable=not H
local I=if H then c else 0
ab.Tween(v,{TextTransparency=I})
ab.Tween(w,{BackgroundTransparency=0.7+0.3*I})
D.Visible=not H
if E then E.Visible=not H end
if H then v:ReleaseFocus()end
end)

local function coerce(I)
if o.Numeric then return tonumber(I)end
return I
end

local I=n:_value(H,o,o.Default or(if o.Numeric then nil else""),function(I)
v.Text=if I==nil then""else tostring(I)
end)

n._maid:Connect(v:GetPropertyChangedSignal"Text",function()
if o.Numeric then
local J=v.Text:gsub("[^%d%.%-]",""):gsub("(.)%-","%1")
local K=J:find(".",1,true)
if K then
J=J:sub(1,K)..J:sub(K+1):gsub("%.","")
end
if J~=v.Text then
v.Text=J
return
end
end
if o.Live and v:IsFocused()then
I(coerce(v.Text))
end
end)

n._maid:Connect(v.Focused,function()
ab.Rebind(x,"Color","Ring")
ab.Tween(z,{Transparency=0.5})
end)

n._maid:Connect(v.FocusLost,function(J)
ab.Rebind(x,"Color","Foreground")
ab.Tween(z,{Transparency=1})
local K=coerce(v.Text)
if K~=H.Value then
I(K)
end
if J and o.Button and o.Button.Callback and not H.Locked then
task.spawn(o.Button.Callback,v.Text)
end
end)

if G then
local function refreshClear()
G.Visible=v.Text~=""and not H.Locked
end
p:Connect(v:GetPropertyChangedSignal"Text",refreshClear)
refreshClear()
p:Connect(G.MouseButton1Click,function()
if H.Locked then return end
v.Text=""
I(coerce"")
end)
end

if E and F then
local J=o.Step or 1
local function step(K)
if H.Locked then return end
local L=(tonumber(v.Text)or 0)+J*K
if o.Min then L=math.max(L,o.Min)end
if o.Max then L=math.min(L,o.Max)end
local M=#(string.match(tostring(J),"%.(%d+)$")or"")
L=tonumber(string.format("%."..M.."f",L))
v.Text=tostring(L)
I(L)
end
p:Connect(E.MouseButton1Click,function()step(-1)end)
p:Connect(F.MouseButton1Click,function()step(1)end)
end

function H.Set(J,K,L)
I(K,L)
end
function H.Get(J)
return H.Value
end

if o.Locked then H:SetLocked(true)end
return H
end

function k.AddColorPicker(n,o)
local p=n._window
local q,r,s,t=n:_row("ColorPicker",o)
n:_fitRight(q,r,s,t,o.Width or 112)

local u=type(o.Transparency)=="number"
local v
if o.Flag then
v=o.Flag.."Transparency"
end

local w=o.Default
if type(w)=="string"then
w=ak.Parse(w)
end
if typeof(w)~="Color3"then
w=Color3.fromHex"0a84ff"
end

local x

local y=wrapControl({},q,s,t,function(y)
if x then x.SetLocked(y)end
end)

y.Transparency=o.Transparency or 0
if v then
y.Transparency=p:GetFlag(v,y.Transparency)
end

local z=n:_value(y,{
Flag=o.Flag,
Callback=function(z)
if o.Callback then
o.Callback(z,y.Transparency)
end
end,
},w,function()
if x then x.Refresh()end
end)

local function setColor(A,B,C)
y.Transparency=B
if v then
p:_saveFlag(v,B)
end
z(A,C)
end

x=ak.new(p,n._maid,r,y,u,function(A,B,C)
if o.Live==false and not C then
y.Value=A
y.Transparency=B
return
end
setColor(A,B)
end,{color=w,transparency=o.Transparency or 0})
x.Refresh()

function y.Reset(A)
setColor(w,o.Transparency or 0)
end

function y.Set(A,B,C,D)
local E,F=B
if type(B)=="string"then
E,F=ak.Parse(B)
end
if typeof(E)~="Color3"then return end
setColor(E,C or F or y.Transparency,D)
end

function y.Get(A)
return y.Value,y.Transparency
end

if o.Locked then y:SetLocked(true)end
return y
end

function k.AddImage(n,o)
local p=if type(o)=="string"then{Image=o}else(o or{})
local q=p.Image or p.Url or(type(p.Gif)=="string"and p.Gif or nil)
local r=p.IsGif==true or p.Gif==true or type(p.Gif)=="string"

n._order+=1
local s=i("Frame",{
Name="Image",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
Visible=p.Visible~=false,
LayoutOrder=n._order,
Parent=n._group,
},{
ae.Padding(8,12,8,12),
i("UIListLayout",{
FillDirection=Enum.FillDirection.Vertical,
HorizontalAlignment=p.Alignment or Enum.HorizontalAlignment.Left,
Padding=UDim.new(0,6),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

if n._order>1 then
i("Frame",{
Name="Divider",
BackgroundColor3=j.Foreground,
BackgroundTransparency=h,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,1),
Position=UDim2.fromOffset(0,-8),
Parent=i("Folder",{Parent=s}),
})
end

local t
if p.Title then
t=ae.Text{
Name="Title",
Text=p.Title,
TextColor3=j.Foreground,
FontFace=ac.Medium,
TextSize=ab.TextSize.Sm,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
Parent=s,
}
end

local u
if p.Description or p.Caption then
u=ae.Text{
Name="Description",
Text=p.Description or p.Caption,
TextColor3=j.MutedForeground,
FontFace=ac.Regular,
TextSize=ab.TextSize.Xs,
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
Parent=s,
}
end

local v=p.Height or 140
local w=p.Width
local x=if w
then UDim2.fromOffset(w,v)
else UDim2.new(1,0,0,v)

local y=i("Frame",{
Name="MediaFrame",
BackgroundColor3=j.Muted,
BackgroundTransparency=0.65,
BorderSizePixel=0,
ClipsDescendants=true,
Size=x,
LayoutOrder=3,
Parent=s,
},{
ae.Corner(p.CornerRadius or ab.Radius.Md),
})

local z=i("ImageLabel",{
Name="Image",
BackgroundTransparency=1,
Image="",
ScaleType=p.ScaleType or Enum.ScaleType.Fit,
Size=UDim2.fromScale(1,1),
Parent=y,
})

local A=0
local function applySource(B,C)
A+=1
local D=A
if not B or B==""then
z.Image=""
return
end

local function applyResolved(E,F)
if D~=A or not z.Parent then return end
z.Image=E or""
if E and E~=""then
y.BackgroundTransparency=1
end
if F and not p.Height and not p.Width then
local G=math.clamp(F.frameHeight,48,280)
y.Size=UDim2.new(1,0,0,G)
end
end

local E=type(B)=="string"and string.find(B,"://",1,true)~=nil
if E then
task.spawn(function()
local F,G
if C or ad.IsGif(B)then
F,G=ad.GetGif(B)
else
F=ad.Get(B)
end
applyResolved(F,G)
end)
else
local F=if C then ad.GetGif(B)else ad.Get(B)
local G=ad.GetGifMeta(F or B)
applyResolved(F,G)
end
end

if q then
applySource(q,r)
end

local B={
Instance=s,
ImageLabel=z,
}
function B.SetImage(C,D,E)
applySource(D,E==true)
end
function B.SetGif(C,D)
applySource(D,true)
end
function B.SetTitle(C,D)
if t then t.Text=D or""end
end
function B.SetDescription(C,D)
if u then u.Text=D or""end
end
function B.SetHeight(C,D)
if type(D)=="number"then
y.Size=if w
then UDim2.fromOffset(w,D)
else UDim2.new(1,0,0,D)
end
end
function B.SetVisible(C,D)
s.Visible=D
end
function B.Destroy(C)
A+=1
s:Destroy()
end
return B
end

function k.AddGif(n,o)
local p=if type(o)=="string"then{Image=o,IsGif=true}else table.clone(o or{})
p.IsGif=true
return n:AddImage(p)
end

function k.AddTable(n,o)
n._order+=1
local p=i("Frame",{
Name="Table",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=n._order,
Parent=n._group,
},{ae.Padding(4,4,4,4)})

if n._order>1 then
i("Frame",{
Name="Divider",
BackgroundColor3=j.Foreground,
BackgroundTransparency=h,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,1),
Position=UDim2.fromOffset(0,-4),
Parent=i("Folder",{Parent=p}),
})
end

local q=al.new(n._maid,p,o)

function q.SetVisible(r,s)p.Visible=s end
function q.Destroy(r)p:Destroy()end
return q
end

function k.AddDropdown(n,o)
local p=o.Multi==true
local q,r,s,t=n:_row("Dropdown",o)
n:_fitRight(q,r,s,t,o.Width or 200)

local u,v
v=wrapControl({},q,s,t,function(w)
if u then u.SetLocked(w)end
end)

local w=o.Default
if p and type(w)~="table"then w={}end

local x=n:_value(v,o,w,function()
if u then u.Refresh()end
end)

if p and type(v.Value)~="table"then
v.Value={}
if o.Flag then
n._window:_saveFlag(o.Flag,v.Value)
end
end

u=ai.new(n._window,n._maid,r,o,v,function(y)
x(y)
end)
u.Refresh()

function v.Set(y,z,A)x(z,A)end
function v.Get(y)return v.Value end

function v.SetOptions(y,z)
u.SetOptions(z)
local A=u.Choices()
if p then
local B={}
for C,D in ipairs(v.Value or{})do
if table.find(A,D)then
table.insert(B,D)
end
end
x(B,true)
elseif v.Value~=nil and not table.find(A,v.Value)then
x(nil,true)
end
end

if o.Locked then v:SetLocked(true)end
return v
end


local n={
MouseButton1="Mouse 1",MouseButton2="Mouse 2",MouseButton3="Mouse 3",
LeftShift="L Shift",RightShift="R Shift",
LeftControl="L Ctrl",RightControl="R Ctrl",
LeftAlt="L Alt",RightAlt="R Alt",
Return="Enter",Backspace="Backspace",Backquote="`",
Space="Space",CapsLock="Caps",
PageUp="Pg Up",PageDown="Pg Down",
One="1",Two="2",Three="3",Four="4",Five="5",
Six="6",Seven="7",Eight="8",Nine="9",Zero="0",
Minus="-",Equals="=",LeftBracket="[",RightBracket="]",
Semicolon=";",Quote="'",Comma=",",Period=".",Slash="/",BackSlash="\\",
}

local function prettyKeyName(o)
if not o then return"None"end
return n[o]or o
end

local o={MouseButton2=true,MouseButton3=true}

local function keyOfInput(p)
if p.UserInputType==Enum.UserInputType.Keyboard and p.KeyCode~=Enum.KeyCode.Unknown then
return p.KeyCode.Name
end
local q=p.UserInputType.Name
if o[q]or q=="MouseButton1"then
return q
end
return nil
end

function k.AddKeybind(p,q,r,s)
local t=if type(q)=="string"then{Title=q,Default=r,Callback=s}else q
local u=t.Mode or"Press"
local v=p._window
local w=p._maid
local x,y,z,A=p:_row("Keybind",t)
local B=28
local C=2

if u~="Press"then
local D=ae.Text{
Name="Mode",
Text=u,
TextColor3=j.MutedForeground,
FontFace=ac.Medium,
TextSize=ab.TextSize.Xs,
BackgroundColor3=j.Muted,
BackgroundTransparency=0,
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,20),
LayoutOrder=1,
Parent=y,
}
i("UICorner",{CornerRadius=UDim.new(1,0),Parent=D})
ae.Padding(0,8,0,8).Parent=D
end

local D=i("TextButton",{
Name="Key",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
Size=UDim2.fromOffset(64,B+C),
LayoutOrder=2,
Parent=y,
})

local E=i("Frame",{
Name="Base",
BackgroundColor3=j.Border,
BorderSizePixel=0,
Position=UDim2.fromOffset(0,C),
Size=UDim2.new(1,0,0,B),
Parent=D,
},{ae.Corner(ab.Radius.Md)})

local F=i("TextLabel",{
Name="Cap",
BackgroundColor3=j.Card,
BorderSizePixel=0,
FontFace=ac.Medium,
TextSize=ab.TextSize.Sub,
TextColor3=j.Foreground,
Text="",
Size=UDim2.new(1,0,0,B),
ZIndex=2,
Parent=D,
},{ae.Corner(ab.Radius.Md)})

local G=ae.Stroke(j.Foreground)
G.Parent=F
ae.ApplyGlassStroke(G,w,p._window and p._window.Library and p._window.Library.ThemeChanged)

local H=wrapControl({Active=false},x,z,A,function(H)
local I=if H then c else 0
ab.Tween(F,{TextTransparency=I,BackgroundTransparency=I})
ab.Tween(E,{BackgroundTransparency=I})
if H and control.Active then
control.Active=false
paintActive(false)
end
end)
H.Pressed=w:Give(af.new())
H.Released=w:Give(af.new())

local function setKeyText(I)
F.Text=I
D.Size=UDim2.fromOffset(
math.max(44,ae.TextWidth(I,ab.TextSize.Sub,ac.Medium)+24),
B+C
)
end

local function paintActive(I)
if I then
ab.Rebind(F,"BackgroundColor3","Primary")
ab.Rebind(F,"TextColor3","PrimaryForeground")
ab.Rebind(G,"Color","Primary")
ab.Tween(F,{Position=UDim2.fromOffset(0,C)})
else
ab.Rebind(F,"BackgroundColor3","Card")
ab.Rebind(F,"TextColor3","Foreground")
ab.Rebind(G,"Color","Foreground")
ab.Tween(F,{Position=UDim2.fromOffset(0,0)})
end
end

local function normalize(I)
if typeof(I)=="EnumItem"then return I.Name end
return I
end

local I=p:_value(H,{Flag=t.Flag},normalize(t.Default),function(I)
H.Value=normalize(I)
setKeyText(prettyKeyName(H.Value))
end)

local J=false
local K

local function setKey(L,M)
I(normalize(L),M)
end

local function finishListening(L,M)
J=false
if K then
K:Cancel()
K=nil
end
F.TextTransparency=0
ab.Rebind(F,"TextColor3","Foreground")
ab.Rebind(G,"Color","Input")
if L or M then
setKey(L)
else
setKeyText(prettyKeyName(H.Value))
end
end

local function beginListening()
if H.Locked or J then return end
task.defer(function()
J=true
paintActive(false)
setKeyText"Press a key"
ab.Rebind(F,"TextColor3","MutedForeground")
ab.Rebind(G,"Color","Ring")
K=ab.Tween(F,{TextTransparency=0.6},
TweenInfo.new(0.6,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true))
end)
end

w:Connect(D.MouseButton1Click,beginListening)

local L=i("TextButton",{
Name="Options",
Text="",
AutoButtonColor=false,
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(26,26),
LayoutOrder=3,
Parent=y,
},{ae.Corner(ab.Radius.Md)})

i("ImageLabel",{
BackgroundTransparency=1,
Image=ad.Get"ellipsis"or"",
ImageColor3=j.MutedForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(18,18),
Parent=L,
})
w:Connect(L.MouseEnter,function()
ab.Tween(L,{BackgroundTransparency=0})
end)
w:Connect(L.MouseLeave,function()
ab.Tween(L,{BackgroundTransparency=1})
end)

local function openMenu(M)
if H.Locked then return end
if J then finishListening()end

local N=t.Default
local O="Reset to default"
if N then
O="Reset to "..prettyKeyName(N)
end
local P=v:_menu{
{Title="Change key",Icon="keyboard",Callback=beginListening},
{Title=O,Icon="rotate-ccw",Disabled=H.Value==N,Callback=function()H:Reset()end},
false,
{Title="Clear",Icon="trash-2",Destructive=true,Disabled=H.Value==nil,Callback=function()H:Clear()end},
}
P.Size=UDim2.fromOffset(200,0)
v:_openPopover(P,M,function()P:Destroy()end)
end

w:Connect(L.MouseButton1Click,function()openMenu(L)end)
w:Connect(D.MouseButton2Click,function()openMenu(D)end)

local function triggerCallback(...)
if t.Callback then task.spawn(t.Callback,...)end
end

local M={
began=function(M,N)
local O=keyOfInput(M)
if not O then return end

if J then
if M.KeyCode==Enum.KeyCode.Escape or O=="MouseButton1"then
finishListening()
elseif M.KeyCode==Enum.KeyCode.Backspace then
finishListening(nil,true)
else
finishListening(O)
end
return
end

if H.Locked or O~=H.Value or(N and not o[O])then
return
end

if u=="Toggle"then
H.Active=not H.Active
paintActive(H.Active)
triggerCallback(H.Active)
elseif u=="Hold"then
H.Active=true
paintActive(true)
triggerCallback(true)
else
paintActive(true)
task.delay(0.15,function()
if not J then paintActive(false)end
end)
triggerCallback()
end
H.Pressed:Fire()
end,
ended=function(M)
if J or keyOfInput(M)~=H.Value or H.Value==nil then
return
end
if u=="Hold"and H.Active then
H.Active=false
paintActive(false)
triggerCallback(false)
end
H.Released:Fire()
end,
}

table.insert(v._keybinds,M)

local N=H.Destroy
function H.Destroy(O)
local P=table.find(v._keybinds,M)
if P then table.remove(v._keybinds,P)end
N(H)
end

function H.Set(O,P,Q)setKey(P,Q)end
function H.Reset(O)setKey(t.Default)end
function H.Clear(O)
if H.Active then
H.Active=false
paintActive(false)
triggerCallback(false)
end
setKey(nil)
end
function H.Get(O)return H.Value end

p:_fitRight(x,y,z,A)
if t.Locked then H:SetLocked(true)end
return H
end

function k.AddRow(p,q)
local r=q or{}
local s=p._window
local t=p._maid

local u,v,w,x=p:_row("Row",{
Title=r.Title or"",
Description=r.Description,
})

local y,z={},0
local A=wrapControl({},u,w,x,function(A)
for B,C in ipairs(y)do
if C.SetLocked then C:SetLocked(A)end
end
end)
p:_fitRight(u,v,w,x)

local function nextOrder()
z+=1
return z
end

local function track(B)
table.insert(y,B)
if A.Locked and B.SetLocked then B:SetLocked(true)end
return B
end

local function fireCallback(B,...)
if B then task.spawn(B,...)end
end

function A.Toggle(B,C)
local D=C.Value==true
local E={Locked=false}local

F, G, H=buildGlassSwitch(v,true,nextOrder())

local function paint(I)
H(D,E.Locked,I)
end

function E.Set(I,J,K)
D=J==true
E.Value=D
paint()
if not K then
fireCallback(C.Callback,D)
end
end
function E.Get(I)return D end
function E.SetLocked(I,J)
E.Locked=J
paint()
end

t:Connect(F.MouseButton1Click,function()
if not E.Locked and not A.Locked then
E:Set(not D)
end
end)

t:Connect(u.InputBegan,function(I)
if I.UserInputType~=Enum.UserInputType.MouseButton1
and I.UserInputType~=Enum.UserInputType.Touch then
return
end
if#y~=1 or y[1]~=E or E.Locked or A.Locked then
return
end
local J=Vector2.new(I.Position.X,I.Position.Y)
local K,L=F.AbsolutePosition,F.AbsoluteSize
if J.X>=K.X and J.X<=K.X+L.X and J.Y>=K.Y and J.Y<=K.Y+L.Y then
return
end
E:Set(not D)
end)

E.Value=D
E.Instance=F
paint(true)
return track(E)
end

function A.Button(B,C)
local D,E=ag.new(t,{
Title=C.Title,
Icon=C.Icon,
Variant=C.Variant or"Default",
Size=C.Size or"Sm",
LayoutOrder=nextOrder(),
Callback=C.Callback,
})
D.Parent=v
local F={
Instance=D,
SetTitle=function(F,G)E.SetTitle(G)end,
SetLocked=function(F,G)E.SetLocked(G)end,
}
return track(F)
end

function A.Label(B,C)
local D=C
if type(C)=="table"then D=C.Text or""end
local E=ae.Text{
Name="Value",
Text=tostring(D),
TextColor3=j.MutedForeground,
TextXAlignment=Enum.TextXAlignment.Right,
Size=UDim2.fromOffset(0,20),
LayoutOrder=nextOrder(),
Parent=v,
}
local F={Instance=E}
function F.SetText(G,H)
E.Text=tostring(H)
E.Size=UDim2.fromOffset(math.ceil(ae.TextWidth(E.Text,ab.TextSize.Sm,ac.Regular))+2,20)
end
function F.Get(G)return E.Text end
F:SetText(tostring(D))
return track(F)
end

function A.Dropdown(B,C)
local D=i("Frame",{
Name="Dropdown",
BackgroundTransparency=1,
Size=UDim2.fromOffset(C.Width or 200,32),
LayoutOrder=nextOrder(),
Parent=v,
})
D:SetAttribute("FitWidth",C.Width or 200)

local E={Locked=false,Value=C.Value}
if C.Multi and type(E.Value)~="table"then
E.Value={}
end

local F
local function setValue(G,H)
E.Value=G
if F then F.Refresh()end
if not H then fireCallback(C.Callback,G)end
end

F=ai.new(s,t,D,C,E,setValue)
F.Refresh()

function E.Set(G,H,I)setValue(H,I)end
function E.Get(G)return E.Value end
function E.SetOptions(G,H)
F.SetOptions(H)
F.Refresh()
end
function E.SetLocked(G,H)
E.Locked=H
F.SetLocked(H)
end
E.Instance=D
return track(E)
end

function A.Input(B,C)
local D=i("Frame",{
Name="Field",
BackgroundColor3=j.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
Size=UDim2.fromOffset(C.Width or 160,32),
LayoutOrder=nextOrder(),
Parent=v,
},{ae.Corner(ab.Radius.Lg)})
D:SetAttribute("FitWidth",C.Width or 160)

local E=ae.Stroke(j.Foreground)
E.Parent=D
ae.ApplyGlassStroke(E,t,B._window and B._window.Library and B._window.Library.ThemeChanged)

local F=i("TextBox",{
Name="Box",
BackgroundTransparency=1,
ClearTextOnFocus=false,
FontFace=ac.Regular,
TextSize=ab.TextSize.Sm,
TextColor3=j.Foreground,
PlaceholderColor3=j.MutedForeground,
PlaceholderText=C.Placeholder or"",
Text=tostring(C.Value or""),
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.fromScale(1,1),
Parent=D,
},{ae.Padding(0,10,0,10)})

local G={Locked=false,Value=F.Text,Instance=D}
local function coerce()
if C.Numeric then return tonumber(F.Text)end
return F.Text
end

t:Connect(F.Focused,function()
ab.Rebind(E,"Color","Ring")
end)
t:Connect(F.FocusLost,function()
ab.Rebind(E,"Color","Foreground")
G.Value=coerce()
if not C.Live then
fireCallback(C.Callback,G.Value)
end
end)
t:Connect(F:GetPropertyChangedSignal"Text",function()
if C.Numeric then
local H=string.gsub(F.Text,"[^%d%.%-]","")
if H~=F.Text then
F.Text=H
return
end
end
G.Value=coerce()
if C.Live and F:IsFocused()then
fireCallback(C.Callback,G.Value)
end
end)

function G.Set(H,I,J)
F.Text=tostring(I or"")
G.Value=coerce()
if not J then fireCallback(C.Callback,G.Value)end
end
function G.Get(H)return coerce()end
function G.Focus(H)F:CaptureFocus()end
function G.SetLocked(H,I)
G.Locked=I
F.TextEditable=not I
local J=if I then c else 0
if I then F:ReleaseFocus()end
ab.Tween(F,{TextTransparency=J})
end
return track(G)
end

function A.Stepper(B,C)
local D,E,F,G=C.Min or 0,C.Max or 100,C.Step or 1,C.Suffix or""
local H=#(string.match(tostring(F),"%.(%d+)$")or"")
local I=C.Value or D

local J=i("Frame",{
Name="Stepper",
BackgroundColor3=j.Input,
BackgroundTransparency=0.7,
BorderSizePixel=0,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,28),
LayoutOrder=nextOrder(),
Parent=v,
},{
ae.Corner(ab.Radius.Lg),
ae.Padding(0,2,0,2),
i("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})
local K=ae.Stroke(j.Foreground)
K.Parent=J
ae.ApplyGlassStroke(K,t,B._window and B._window.Library and B._window.Library.ThemeChanged)

local function makeBtn(L,M)
local N=i("TextButton",{
Name=L,
Text="",
AutoButtonColor=false,
BackgroundColor3=j.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(24,24),
LayoutOrder=M,
Parent=J,
},{ae.Corner(ab.Radius.Md)})
i("ImageLabel",{
BackgroundTransparency=1,
Image=ad.Get(L)or"",
ImageColor3=j.MutedForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(14,14),
Parent=N,
})
t:Connect(N.MouseEnter,function()ab.Tween(N,{BackgroundTransparency=0})end)
t:Connect(N.MouseLeave,function()ab.Tween(N,{BackgroundTransparency=1})end)
return N
end

local L=makeBtn("minus",1)
local M=i("TextBox",{
Name="Value",
BackgroundTransparency=1,
ClearTextOnFocus=false,
TextEditable=C.Field~=false,
FontFace=ac.Medium,
TextSize=ab.TextSize.Sub,
TextColor3=j.Foreground,
TextXAlignment=Enum.TextXAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(40,24),
LayoutOrder=2,
Parent=J,
},{
ae.Padding(0,8,0,8),
i("UISizeConstraint",{MinSize=Vector2.new(40,24)}),
})
local N=makeBtn("plus",3)
local O={Locked=false,Instance=J}

local function snap(P)
local Q=D+math.floor((P-D)/F+0.5)*F
return math.clamp(tonumber(string.format("%."..H.."f",Q)),D,E)
end
local function clampValue(P)
return math.clamp(tonumber(string.format("%."..H.."f",P)),D,E)
end
local function paint()
M.Text=string.format("%."..H.."f",I)..G
end

function O.Set(P,Q,R)
I=clampValue(tonumber(Q)or I)
O.Value=I
paint()
if not R then fireCallback(C.Callback,I)end
end
function O.Get(P)return I end
function O.SetLocked(P,Q)
O.Locked=Q
L.Visible=not Q
N.Visible=not Q
M.TextEditable=C.Field~=false and not Q
end

t:Connect(L.MouseButton1Click,function()
if not O.Locked then O:Set(snap(I-F))end
end)
t:Connect(N.MouseButton1Click,function()
if not O.Locked then O:Set(snap(I+F))end
end)
t:Connect(M.Focused,function()
M.Text=string.format("%."..H.."f",I)
end)
t:Connect(M.FocusLost,function()
local P=tonumber((string.gsub(M.Text,"[^%d%.%-]","")))
if P then O:Set(P)else paint()end
end)

I=clampValue(I)
O.Value=I
paint()
return track(O)
end

function A.Keybind(B,C)
local D=C.Value
local E=false

local F=i("TextButton",{
Name="Key",
AutoButtonColor=false,
BackgroundColor3=j.Card,
BorderSizePixel=0,
FontFace=ac.Medium,
TextSize=ab.TextSize.Sub,
TextColor3=j.Foreground,
Text="",
Size=UDim2.fromOffset(64,28),
LayoutOrder=nextOrder(),
Parent=v,
},{ae.Corner(ab.Radius.Md)})
local G=ae.Stroke(j.Foreground)
G.Parent=F
ae.ApplyGlassStroke(G,t,B._window and B._window.Library and B._window.Library.ThemeChanged)

local H={Locked=false,Value=D,Instance=F}

local function paint(I)
F.Text=I
F.Size=UDim2.fromOffset(math.max(44,ae.TextWidth(I,ab.TextSize.Sub,ac.Medium)+24),28)
end

function H.Set(I,J,K)
D=J
H.Value=J
paint(prettyKeyName(J))
if not K then fireCallback(C.Callback,J)end
end
function H.Get(I)return D end
function H.SetLocked(I,J)H.Locked=J end

t:Connect(F.MouseButton1Click,function()
if H.Locked or E then return end
task.defer(function()
E=true
paint"Press a key"
ab.Rebind(G,"Color","Ring")
end)
end)

t:Connect(aa.InputBegan,function(I)
if not E then return end
local J=keyOfInput(I)
if not J then return end
E=false
ab.Rebind(G,"Color","Foreground")
if I.KeyCode==Enum.KeyCode.Escape or J=="MouseButton1"then
paint(prettyKeyName(D))
elseif I.KeyCode==Enum.KeyCode.Backspace then
H:Set(nil)
else
H:Set(J)
end
end)

paint(prettyKeyName(D))
return track(H)
end

return A
end

return k
end

function a.q()
local aa=a.cache.section
if not aa then
aa={class=SectionFactory()}
a.cache.section=aa
end
return aa.class
end
end




do
local function ThemeSettingsFactory()
local aa=a.Theme()
local ab=a.f()
local ac=a.Creator()
local ad={}

local function prettify(ae)
local af=string.gsub(ae,"(%l)(%u)","%1 %2")
return string.sub(af,1,1)..string.lower(string.sub(af,2))
end

local ae={
"Default","Zinc","Slate","Gray","Neutral","Stone",
"Red","Rose","Pink","Fuchsia","Purple","Violet","Indigo",
"Blue","Sky","Cyan","Teal","Emerald","Green","Lime",
"Yellow","Amber","Orange",
}

local af={}
for ag,ah in ipairs(ae)do
if aa.Accents[ah]then
table.insert(af,ah)
end
end

for ag in pairs(aa.Accents)do
if not table.find(af,ag)then
table.insert(af,ag)
end
end

function ad.Theme(ag)
local ah=ag._window
local ai=ah.Library
local aj=false

local ak=ag:AddSection{
Title="Appearance",
Description="The mode and the accent; saved with your settings",
Icon="paintbrush",
Color="Blue",
}

local al=ak:AddDropdown{
Title="Mode",
Description="Dark, a soft Light, or shadcn's pure White",
Options={"Dark","Light","White"},
Default=aa.Mode,
Search=false,
Clearable=false,
Callback=function(al)
if al and not aj then
ai:SetTheme(al)
end
end,
}

local am=table.clone(af)
table.insert(am,"Custom")

local function currentAccentName()
if typeof(aa.Accent)=="Color3"then
return"Custom"
end
return tostring(aa.Accent)
end

local b=ak:AddDropdown{
Title="Accent",
Description="shadcn's colour themes for buttons, switches and the sidebar",
Options=am,
Default=currentAccentName(),
Search=false,
Clearable=false,
Callback=function(b)
if not b or aj then return end
if b=="Custom"then
ai:SetAccent(aa.Current.Primary)
else
ai:SetAccent(b)
end
end,
}

local c=ak:AddColorPicker{
Title="Custom accent",
Description="Any colour; the text on it turns black or white to stay readable",
Default=aa.Current.Primary,
Callback=function(c)
if not aj then
ai:SetAccent(c,true)
end
end,
}

ak:AddToggle{
Title="Aurora",
Description="Ambient multi-hue aurora light behind the UI",
Default=ah._auroraEnabled~=false,
Callback=function(d)
if not aj and ah.SetAurora then
ah:SetAurora(d)
end
end,
}

ak:AddSlider{
Title="Aurora intensity",
Description="Adjust the glow strength of the aurora background",
Min=10,
Max=200,
Step=10,
Default=math.round((ah._auroraIntensity or 1)*100),
Suffix="%",
Callback=function(d)
if not aj and ah.SetAuroraIntensity then
ah:SetAuroraIntensity(d/100)
end
end,
}

ak:AddToggle{
Title="Grid",
Description="Subtle architectural dot grid overlay",
Default=ah._gridEnabled==true,
Callback=function(d)
if not aj and ah.SetGrid then
ah:SetGrid(d)
end
end,
}

ak:AddButton{
Title="Random theme",
Description="One random hue, worked into every colour so they still belong together",
Buttons={
{
Title="Shuffle",
Icon="shuffle",
Callback=function()ai:RandomTheme()end,
},
{
Title="Dark",
Variant="Outline",
Callback=function()ai:RandomTheme"Dark"end,
},
{
Title="Light",
Variant="Outline",
Callback=function()ai:RandomTheme"Light"end,
},
},
}

local d={}

for e,f in ipairs(ai.ThemeTokens)do
local g=(e<=2)and"Left"or"Right"

local h=ag:AddSection{
Title="Colours: "..f.Title,
Description="Each colour of the theme, live; its reset puts back what the mode and accent give",
Icon="paintpalette",
Color=({"Blue","Green","Orange","Indigo"})[e]or"Gray",
Column=g,
}

for i,j in ipairs(f.Tokens)do
local k=h:AddColorPicker{
Title=prettify(j),
Default=ai:DefaultColor(j)or aa.Current[j],
Callback=function(k)
if not aj then
ai:SetColor(j,k,true)
end
end,
}

k:Set(aa.Current[j],nil,true)
d[j]=k
end
end

local e=ag:AddSection{
Title="Reset and share",
Description="Start over, or pass a theme around as a line of text",
Icon="squareAndArrowUp",
Color="Purple",
}

e:AddButton{
Title="Reset theme",
Description="Mode, accent and every colour back to the defaults",
ButtonText="Reset",
Icon="rotate-ccw",
Variant="Outline",
Confirm={
Title="Reset the theme?",
Description="Your mode, accent and colour changes are dropped",
ConfirmText="Reset",
Destructive=true,
},
Callback=function()
ai:ResetTheme()
ai:Toast{Title="Theme reset",Type="Success",Duration=2}
end,
}

e:AddButton{
Title="Export",
Description="Copies the theme to the clipboard",
ButtonText="Copy",
Icon="doc-on-doc",
Variant="Outline",
Callback=function()
local f=ai:ExportTheme()
local g=pcall(function()setclipboard(f)end)
if g then
ai:Toast{
Title="Theme copied",
Description="Paste it into Import to use it elsewhere",
Type="Success",
}
else
ai:Toast{Title="No clipboard here",Description=f,Type="Warning",Duration=10}
end
end,
}

e:AddInput{
Title="Import",
Description="Paste a copied theme and press Enter",
Placeholder='{"Mode":"Dark",...}',
Icon="squareAndArrowDown",
Width=200,
Callback=function(f)
if f==""then return end
if ai:ImportTheme(f)then
ai:Toast{Title="Theme imported",Type="Success",Duration=2}
else
ai:Toast{
Title="That is not a theme",
Description="Copy one with Export first",
Type="Error",
}
end
end,
}

local f=ai.ThemeChanged:Connect(function(f)
if aj then return end
aj=true
local g,h=pcall(function()
al:Set(aa.Mode,true)
b:Set(currentAccentName(),true)
if typeof(aa.Accent)=="Color3"and c.Value~=aa.Accent then
c:Set(aa.Accent,nil,true)
end
for g,h in pairs(d)do
if h.Value~=f[g]then
h:Set(f[g],nil,true)
end
end
end)
aj=false
if not g then
warn("[shadcn] theme sync failed: "..tostring(h))
end
end)
ah:Track(f)
end


local function toLua(ag,ah)
local ai=typeof(ag)
if ai=="string"then
return string.format("%q",ag)
elseif ai=="number"or ai=="boolean"or ai=="nil"then
return tostring(ag)
elseif ai=="Color3"then
return string.format('Color3.fromHex("%s")',ag:ToHex())
elseif ai=="EnumItem"then
return tostring(ag)
elseif ai=="UDim2"then
return string.format("UDim2.new(%s, %s, %s, %s)",ag.X.Scale,ag.X.Offset,ag.Y.Scale,ag.Y.Offset)
elseif ai=="Vector2"then
return string.format("Vector2.new(%s, %s)",ag.X,ag.Y)
elseif ai~="table"then
return"nil"
end

local aj=ah.."\t"
local ak={}
if#ag>0 then
for al,am in ipairs(ag)do
table.insert(ak,aj..toLua(am,aj)..",")
end
else
local al={}
for am in pairs(ag)do
table.insert(al,am)
end
table.sort(al,function(am,b)return tostring(am)<tostring(b)end)
for am,b in ipairs(al)do
local c=tostring(b)
if type(b)~="string"or not string.match(c,"^[%a_][%w_]*$")then
c="["..toLua(b,aj).."]"
end
table.insert(ak,aj..c.." = "..toLua(ag[b],aj)..",")
end
end
if#ak==0 then
return"{}"
end
return"{\n"..table.concat(ak,"\n").."\n"..ah.."}"
end


local function fileConfigProvider(ag,ah)
local ai=game:GetService"HttpService"

local function encodeConfig(aj,ak)
return ac.Base64Encode(ai:JSONEncode{Name=aj,Data=ab.Encode(ak)})
end

return{
LoadOnStart=true,
List=function()return ah:ListProfiles()end,
Read=function(aj)return ah:ReadProfile(aj)end,
Dates=function(aj)
local ak=ah:ReadProfile(aj)
if ak and type(ak.__meta)=="table"then
return ak.__meta.Created,ak.__meta.Updated
end
return nil,nil
end,
Load=function(aj)return ag:LoadProfile(aj)end,
Save=function(aj)return ag:SaveProfile(aj)end,
Delete=function(aj)ah:DeleteProfile(aj)end,
Code=function(aj)
local ak=ah:ReadProfile(aj)
return ak and encodeConfig(aj,ak)
end,
Import=function(aj)
local ak=ac.Base64Decode(aj or"")
local al,am=pcall(function()return ai:JSONDecode(ak or"")end)
if not al or type(am)~="table"or type(am.Data)~="table"then
return false,nil
end
local b=ab.CleanName(tostring(am.Name or"Imported"))
if b==""then b="Imported"end
local c,d,e=b,ah:ListProfiles(),2
while table.find(d,c)do
c=b.." "..e
e+=1
end
local f=ah.Data
ah.Data=ab.Decode(am.Data)
local g=ah:SaveProfile(c)
ah.Data=f
return g,c
end,
Current=function()
return encodeConfig("Shared",ah.Data)
end,
Loader=function()
return"getgenv().Configs = "..toLua(ah.Data,"")
end,
GetAutoload=function()return ah:GetAutoload()end,
SetAutoload=function(aj)ah:SetAutoload(aj)end,
}
end

function ad.Configs(ag,ah)
local ai=ag._window
local aj=ai.Library
local ak=ai.Config
if not ak and not ah then
ag:AddSection{Title="Configs",Icon="folder",Color="Orange"}:AddParagraph(
"No saving",
"This window was opened with Config = false, so there is nothing to keep"
)
return
end

local al=ah or fileConfigProvider(ai,ak)

local function notify(am,b,c)
aj:Toast{Title=am,Type=b,Description=c,Duration=2.5}
end

local function copyToClipboard(am,b)
local c=pcall(function()setclipboard(am)end)
if c then
notify(b.." copied","Success")
else
notify("No clipboard in this executor","Warning")
end
end

local am=ag:AddSection{
Title="Saved configs",
Description="Select one, then load, overwrite, export, auto-load or delete it",
Icon="folder",
Color="Green",
}

local b,c,d

local function countSettings(e)
if type(e)~="table"then return 1 end
if#e>0 then return 1 end
local f=0
for g,h in pairs(e)do
if g~="__shadcn"and g~="__meta"then
f+=countSettings(h)
end
end
return f
end

local function relativeTime(e)
if type(e)~="number"then
return{Text="-",Muted=true,Sort=0}
end
local f=os.time()-e
local g
if f<60 then
g="just now"
elseif f<3600 then
g=math.floor(f/60).."m ago"
elseif f<86400 then
g=math.floor(f/3600).."h ago"
elseif f<172800 then
g="Yesterday"
elseif os.date("%Y",e)==os.date"%Y"then
g=os.date("%b %d",e)
else
g=os.date("%b %d %Y",e)
end
return{Text=g,Muted=true,Sort=e}
end

local e=am:AddTable{
Columns={
{Key="Name",Title="Config",Grow=3},
{Key="Settings",Title="Settings",Align="Right"},
{Key="Created",Title="Created"},
{Key="Updated",Title="Updated"},
{Key="Start",Title="On start",Grow=1},
},
Selectable=true,
Empty="No configs yet, create one below",
MaxHeight=260,
}

local function updateLockState()
if c then
c:SetLocked(d==nil)
end
end

e.SelectionChanged:Connect(function(f,g)
if g then
d=g.Name.Text
else
d=nil
end
updateLockState()
end)

local function requireSelection()
if not d then
notify("Select a config first","Warning")
end
return d
end

c=am:AddButton{
Title="Selected config",
Buttons={
{
Title="Load",
Icon="squareAndArrowUp",
Callback=function()
local f=requireSelection()
if not f then return end
if al.Load(f)then
notify("Loaded "..f,"Success")
else
notify("Could not load "..f,"Error")
end
end,
},
{
Title="Save",
Variant="Secondary",
Confirm={
Title="Overwrite the selected config?",
Description="It is replaced with your settings as they are now",
ConfirmText="Overwrite",
},
Callback=function()
local f=requireSelection()
if f and al.Save(f)then
refreshConfigList()
notify("Saved "..f,"Success")
end
end,
},
{
Title="Export",
Variant="Secondary",
Callback=function()
local f=requireSelection()
local g=f and al.Code(f)
if f and g then
copyToClipboard(g,f.."'s code")
end
end,
},
{
Title="Auto",
Icon="bolt",
Variant="Ghost",
Callback=function()
local f=requireSelection()
if f then
al.SetAutoload(f)
refreshConfigList()
notify(f.." loads on start","Success")
end
end,
},
{
Title="Delete",
Variant="Destructive",
Confirm={
Title="Delete the selected config?",
Description="The saved config is removed for good",
ConfirmText="Delete",
Destructive=true,
Icon="trash-2",
},
Callback=function()
local f=requireSelection()
if f then
al.Delete(f)
d=nil
refreshConfigList()
notify("Deleted "..f)
end
end,
},
},
}

local function refreshConfigList()
local f,g=al.List(),al.GetAutoload()
local h,i={}

for j,k in ipairs(f)do
local l=""
if k==g then
l={Text="Loads on start",Badge="Default",Sort=1}
end
local m=al.Read(k)
local n,o=al.Dates(k)
table.insert(h,{
Name={Text=k,Icon="doc"},
Settings=countSettings(m),
Created=relativeTime(n),
Updated=relativeTime(o),
Start=l,
})
if k==d then
i=j
end
end

e:SetRows(h)
if i then
e:Select(i)
else
d=nil
end
updateLockState()
if b then
if g then
b:SetText(g)
b:SetVariant"Default"
else
b:SetText"None"
b:SetVariant"Outline"
end
end
end

local f=ag:AddSection{
Title="Manage",
Description="Create a config, bring one in from a code, or share your settings",
Icon="gearshape",
Color="Pink",
}

f:AddInput{
Title="New config",
Description="Saves the settings as they are now under a name",
Placeholder="Config name",
Icon="pencil",
Width=170,
Button={
Title="Create",
Icon="plus",
Callback=function(g)
local h=ab.CleanName(g)
if h==""then
notify("Name it first","Warning")
return
end
if table.find(al.List(),h)
and not aj:Confirm{
Title=h.." exists",
Description="Overwrite it with your settings as they are now?",
ConfirmText="Overwrite",
}
then
return
end
if al.Save(h)then
newConfigInput:Set("",true)
refreshConfigList()
notify("Created "..h,"Success")
else
notify("Could not save","Error","This executor cannot write files")
end
end,
},
}

f:AddInput{
Title="Import",
Description="Paste a config code to add it as a config",
Placeholder="Paste a code",
Icon="squareAndArrowDown",
Width=170,
Button={
Title="Import",
Variant="Secondary",
Callback=function(g)
local h,i=al.Import(g or"")
if h and i then
importInput:Set("",true)
refreshConfigList()
notify("Imported "..i,"Success","Load it from Saved configs")
else
notify("That is not a config code","Error","Copy one with Export first")
end
end,
},
}

f:AddButton{
Title="Export current",
Description="Your settings now, as a code to share or keep",
ButtonText="Copy code",
Icon="docOnDoc",
Variant="Outline",
Callback=function()
copyToClipboard(al.Current(),"Code")
end,
}

f:AddButton{
Title="Copy loader",
Description="Your settings as getgenv().Configs = { ... }, for a loader script",
ButtonText="Copy loader",
Icon="chevronLeftForwardslashChevronRight",
Variant="Outline",
Callback=function()
copyToClipboard(al.Loader(),"Loader")
end,
}

b=f:AddBadge{
Title="Loads on start",
Description="Set it with Auto under the table",
Badges={{Text="None",Variant="Outline"}},
}

f:AddButton{
Title="Stop loading on start",
ButtonText="Clear",
Variant="Ghost",
Callback=function()
al.SetAutoload(nil)
refreshConfigList()
notify"Nothing loads on start"
end,
}

refreshConfigList()

local g=al.LoadOnStart~=false and al.GetAutoload()
if g and not ai._autoloaded then
ai._autoloaded=true
task.defer(function()
if al.Load(g)then
aj:Toast{
Title="Loaded "..g,
Description="Your config for start",
Duration=3,
}
end
end)
end
end

return ad
end

function a.r()
local aa=a.cache.settings
if not aa then
aa={class=ThemeSettingsFactory()}
a.cache.settings=aa
end
return aa.class
end
end




do
local function TabFactory()
local aa=a.q()
local ab=a.r()
local ac=a.Creator()
local ad=ac.Create
local ae=a.Theme().Token
local af={}
af.__index=af

local ag=16
local ah=16

local function columnSide(ai)
if ai==nil or ai==false then return nil end
if ai==1 then return"Left"end
if ai==2 then return"Right"end
local aj=string.lower(tostring(ai))
if aj=="left"then return"Left"end
if aj=="right"then return"Right"end
return nil
end

function af.new(ai,aj,ak,al,am)
return setmetatable({
Title=am,
_window=ai,
_page=aj,
_item=ak,
_label=al,
_order=0,
},af)
end

function af._ensureColumns(ai,aj)
if ai._columns then return ai._columns end
aj=aj or{}
local ak=aj.Gap or ag
local al=aj.Spacing or ah
local am=ai._window
local b=ai._page
local c=17
ai._order+=1
local d=ad("Frame",{
Name="Columns",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,300),
LayoutOrder=ai._order,
Parent=b,
},{ac.List(ak,Enum.FillDirection.Horizontal)})

local function makeColumn(e,f)
return ad("ScrollingFrame",{
Name=e,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(0.5,-ak/2,1,0),
CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollBarThickness=3,
ScrollBarImageColor3=ae.Border,
ScrollingDirection=Enum.ScrollingDirection.Y,
VerticalScrollBarInset=Enum.ScrollBarInset.None,
ElasticBehavior=Enum.ElasticBehavior.Never,
LayoutOrder=f,
Parent=d,
},{
ac.Padding(1,6,1,1),
ac.List(al),
})
end


local function fitHeight()
local e=am._fit or 1
if e<=0 then e=1 end
local f=b.AbsoluteSize.Y/e-c
if f>50 then
d.Size=UDim2.new(1,0,0,math.floor(f))
end
end
am._maid:Connect(b:GetPropertyChangedSignal"AbsoluteSize",fitHeight)
fitHeight()

ai._columns={
Instance=d,
Left=makeColumn("Left",1),
Right=makeColumn("Right",2),
}
return ai._columns
end

local function makeColumnHandle(ai,aj,ak)
local al={Instance=aj,Side=ak}
function al.AddSection(am,b,c)
return ai:AddSection(b,c,ak)
end
return al
end






function af.AddColumns(ai,aj)
local ak=ai:_ensureColumns(aj)
return{
Instance=ak.Instance,
Left=makeColumnHandle(ai,ak.Left,"Left"),
Right=makeColumnHandle(ai,ak.Right,"Right"),
}
end

function af.AddSection(ai,aj,ak,al)
local am={}
if type(aj)=="string"then
am={Title=aj,Description=ak}
elseif type(aj)=="table"then
am=aj
end
local b=columnSide(al or am.Column or am.Side)
local c
if b then
c=ai:_ensureColumns()[b]
end
ai._order+=1
return aa.new(ai,am,ai._order,c)
end
function af.Select(ai)
ai._window:SelectTab(ai)
end


function af.AddThemeSettings(ai)
assert(type(ab)=="table",
"AddThemeSettings: ThemeSettings is not a table")

assert(type(ab.Theme)=="function",
"AddThemeSettings: ThemeSettings.Theme is missing or not a function")

return ab.Theme(ai)
end


function af.AddConfigSettings(ai,aj)
ab.Configs(ai,aj)
end

function af.SetBadge(ai,aj)
local ak=ai._badge
local al=""
if aj~=nil then
al=tostring(aj)
end
if ak:IsA"TextLabel"then
ak.Text=al
end
if ak:IsA"Frame"then
ak.Visible=al~=""
return
end
ak.Visible=al~=""and not ai._window._collapsed
end

return af
end

function a.s()
local aa=a.cache.tab
if not aa then
aa={class=TabFactory()}
a.cache.tab=aa
end
return aa.class
end
end




do
local function WindowFactory()
local aa=game:GetService"Players"
local ab=game:GetService"UserInputService"
local ac=game:GetService"RunService"
local ad=a.Theme()
local ae=a.Fonts()
local af=a.Creator()
local ag=a.Icons()
local ah=a.f()
local ai=a.g()
a.h()
local aj=a.j()
local ak=a.i()
local al=a.k()
local am=a.l()
a.m()
a.n()
a.o()
a.p()
local b=a.s()
local c=game:GetService"TweenService"

local d=af.Create
local e=ad.Token

local f=232
local g=52

local h=32

local i=48
local j=62
local k=34
local l=18
local m=44
local n=12
local o=8

local p=120
local q=4
local r=10
local s=34
local t=0.08 local u=
r+q+10

local v=38
local w=28
local x=100
local y=150
local z=42
local A=80
local B=Vector2.new(480,320)
local C=520
local D=16
local E=TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

local F={}
F.__index=F

local G=20
local H=16

local function makeGlyph(I,J,K,L,M)
local N=I:Icon(K)
if N then
return d("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=N,
ImageColor3=M,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(G,G),
ZIndex=5,
Parent=J,
})
end
return af.Text{
Name="Icon",
Text=string.upper(string.sub(L,1,1)),
TextColor3=M,
FontFace=ae.Medium,
TextSize=ad.TextSize.Sm,
TextXAlignment=Enum.TextXAlignment.Center,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(G,G),
ZIndex=5,
Parent=J,
}
end


local function maskName(I)
local J=utf8.len(I)or#I
if J<=2 then
return string.rep("\u{2022}",J)
end
local K=2
if J<=5 then K=1 end
local L=string.sub(I,1,utf8.offset(I,K+1)-1)
local M=string.sub(I,utf8.offset(I,J-K+1))
return L..string.rep("\u{2022}",J-K*2)..M
end

local I=30
local J=22

local function colorPropName(K)
if K:IsA"ImageLabel"then
return"ImageColor3"
end
return"TextColor3"
end

function F.new(K,L,M)
local N=setmetatable({
Library=K,
Flags={},
Title=M.Title or"Window",
_maid=L,
_tabs={},
_groups={},
_selected=nil,
_visible=true,
_destroyed=false,
_dockMode=true,
Controls={},
Closing=ai.new(),
VisibilityChanged=ai.new(),
},F)

if M.Config~=false then
N.Config=ah.new(M.Config,L)
N.Flags=N.Config.Data
end

if M.BeforeBuild then
M.BeforeBuild(N)
end

local O=L:Give(d("ScreenGui",{
Name="shadcn",
ResetOnSpawn=false,
IgnoreGuiInset=true,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
DisplayOrder=100,
}))
N.Instance=O

local P=d("Frame",{
Name="Holder",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=M.Size or UDim2.fromOffset(760,500),
Parent=O,
})
N._holder=P

local Q=af.Stroke(e.Foreground)
local R=d("Frame",{
Name="Window",
BackgroundColor3=e.Background,
Size=UDim2.fromScale(1,1),
BorderSizePixel=0,
ClipsDescendants=true,
ZIndex=2,
Parent=P,
},{af.Corner(ad.Radius.Xl),Q})
af.ApplyGlassStroke(Q,N._maid,N.Library and N.Library.ThemeChanged,{
DarkSeq={0.74,0.88,0.94,0.85},
LightSeq={0.66,0.82,0.90,0.78},
})
N._root=R
N:_initBackgroundAnimation(M.BackgroundAnimation)

N._overlay=d("Frame",{
Name="Popovers",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=20,
Parent=O,
})
N._popover=nil

N._tooltip=af.Text{
Name="Tooltip",
Text="",
BackgroundColor3=e.Foreground,
BackgroundTransparency=0,
TextColor3=e.Background,
TextSize=ad.TextSize.Xs,
FontFace=ae.Medium,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,26),
AnchorPoint=Vector2.new(0,0.5),
Visible=false,
ZIndex=30,
Parent=N._overlay,
}
d("UICorner",{CornerRadius=UDim.new(0,ad.Radius.Md),Parent=N._tooltip})
af.Padding(0,12,0,12).Parent=N._tooltip


local S=d("Frame",{
Name="Sidebar",
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(0,f,1,0),
Visible=false,
ZIndex=3,
Parent=R,
},{
d("Frame",{
Name="Backdrop",
BackgroundTransparency=1,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.fromScale(1,1),
ZIndex=2,
},{
d("Frame",{
Name="Body",
BackgroundColor3=e.Sidebar,
BorderSizePixel=0,
Size=UDim2.new(1,ad.Radius.Xl,1,0),
ZIndex=2,
},{af.Corner(ad.Radius.Xl)}),
}),
})
N._sidebarBody=S.Backdrop.Body
N._sidebar=S

d("Frame",{
Name="Edge",
BackgroundColor3=e.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
AnchorPoint=Vector2.new(1,0),
Position=UDim2.fromScale(1,0),
Size=UDim2.new(0,1,1,0),
ZIndex=3,
Parent=S,
})

local T=d("Frame",{
Name="Header",
BackgroundTransparency=1,
Size=UDim2.new(1,-1,0,g),
ZIndex=3,
Parent=S,
},{af.Padding(4,8,4,10)})
N._brand=T

local U=d("Frame",{
Name="Brand",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,h),
ClipsDescendants=true,
ZIndex=3,
Parent=T,
})

local V=K:Icon(M.Icon)
local W=2
if V then
local X=d("Frame",{
Name="Logo",
BackgroundColor3=e.SidebarPrimary,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
Size=UDim2.fromOffset(32,32),
ZIndex=4,
Parent=U,
},{af.Corner(ad.Radius.Lg)})

if ag.IsImage(M.Icon)then
X.BackgroundTransparency=1
d("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=V,
ScaleType=Enum.ScaleType.Crop,
Size=UDim2.fromScale(1,1),
ZIndex=5,
Parent=X,
},{af.Corner(ad.Radius.Lg)})
else
d("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=V,
ImageColor3=e.SidebarPrimaryForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(18,18),
ZIndex=5,
Parent=X,
})
end
W=40
end

local X=d("Frame",{
Name="Text",
BackgroundTransparency=1,
Position=UDim2.fromOffset(W,0),
Size=UDim2.new(1,-W,1,0),
ZIndex=4,
Parent=U,
},{
d("UIListLayout",{
VerticalAlignment=Enum.VerticalAlignment.Center,
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

af.Text{
Name="Title",
Text=N.Title,
TextColor3=e.SidebarForeground,
FontFace=ae.SemiBold,
TextSize=ad.TextSize.Base,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,19),
LayoutOrder=1,
ZIndex=4,
Parent=X,
}

if M.Subtitle then
af.Text{
Name="Subtitle",
Text=M.Subtitle,
TextColor3=e.MutedForeground,
FontFace=ae.Medium,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,16),
LayoutOrder=2,
ZIndex=4,
Parent=X,
}
end

local Y=M.Footer
local Z=0
if Y~=false then
Z=h+16
end

N._nav=d("ScrollingFrame",{
Name="Content",
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.fromOffset(0,g),
Size=UDim2.new(1,-1,1,-(g+Z)),
CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollBarThickness=0,
ScrollingDirection=Enum.ScrollingDirection.Y,
ZIndex=3,
Parent=S,
},{af.List(0)})

N._navLabel=M.NavigationLabel
N._tabIcons=M.TabIcons or"Accent"

if Y~=false and not N._dockMode then
N:_buildFooter(S,Y,Z)
end


local _=d("Frame",{
Name="Main",
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,0),
Size=UDim2.new(1,0,1,0),
ZIndex=2,
Parent=R,
})
N._main=_

N._surface=d("Frame",{
Name="Surface",
BackgroundColor3=e.Background,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
Visible=false,
ZIndex=1,
Parent=_,
},{
af.Corner(ad.Radius.Xl),
d("Frame",{
Name="Filler",
BackgroundColor3=e.Background,
BorderSizePixel=0,
Size=UDim2.new(0,ad.Radius.Xl,1,0),
ZIndex=1,
}),
})

local an=d("Frame",{
Name="Topbar",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,g),
ZIndex=3,
Parent=_,
})

d("Frame",{
Name="Edge",
BackgroundColor3=e.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.fromScale(0,1),
Size=UDim2.new(1,0,0,1),
ZIndex=3,
Parent=an,
})

local ao=K:Icon(M.Icon)
local ap=d("Frame",{
Name="Brand",
BackgroundColor3=e.SidebarPrimary,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,12,0.5,0),
Size=UDim2.fromOffset(26,26),
ZIndex=4,
Parent=an,
},{af.Corner(ad.Radius.Md)})

if ao then
if ag.IsImage(M.Icon)then
ap.BackgroundTransparency=1
d("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=ao,
ScaleType=Enum.ScaleType.Crop,
Size=UDim2.fromScale(1,1),
ZIndex=5,
Parent=ap,
},{af.Corner(ad.Radius.Md)})
else
d("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=ao,
ImageColor3=e.SidebarPrimaryForeground,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(15,15),
ZIndex=5,
Parent=ap,
})
end
else
af.Text{
Name="Icon",
Text=string.upper(string.sub(N.Title,1,1)),
TextColor3=e.SidebarPrimaryForeground,
FontFace=ae.SemiBold,
TextSize=ad.TextSize.Sub,
TextXAlignment=Enum.TextXAlignment.Center,
Size=UDim2.fromScale(1,1),
ZIndex=5,
Parent=ap,
}
end

af.Text{
Name="Title",
Text=N.Title,
TextColor3=e.SidebarForeground,
FontFace=ae.SemiBold,
TextSize=ad.TextSize.Base,
TextTruncate=Enum.TextTruncate.AtEnd,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,46,0.5,0),
Size=UDim2.fromOffset(96,20),
ZIndex=4,
Parent=an,
}

d("Frame",{
Name="Separator",
BackgroundColor3=e.Border,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,150,0.5,0),
Size=UDim2.fromOffset(1,16),
ZIndex=4,
Parent=an,
})

local aq=d("Frame",{
Name="Heading",
BackgroundTransparency=1,
Position=UDim2.fromOffset(162,0),
Size=UDim2.new(1,-234,1,0),
ZIndex=3,
Parent=an,
})

N._headingFrame=aq

local ar=d("Frame",{
Name="Breadcrumb",
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,16),
Size=UDim2.new(1,0,0,20),
ZIndex=3,
Parent=aq,
},{
d("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,6),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

N._crumbGroup=af.Text{
Name="Group",
Text="",
TextColor3=e.MutedForeground,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,20),
LayoutOrder=1,
Visible=false,
ZIndex=3,
Parent=ar,
}

local as=K:Icon"chevron-right"
N._crumbChevron=d("ImageLabel",{
Name="Chevron",
BackgroundTransparency=1,
Image=as or"",
ImageColor3=e.MutedForeground,
Size=UDim2.fromOffset(16,16),
LayoutOrder=2,
Visible=false,
ZIndex=3,
Parent=ar,
})

N._heading=af.Text{
Name="Title",
Text="",
FontFace=ae.HeadingMedium,
TextTruncate=Enum.TextTruncate.AtEnd,
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(0,20),
LayoutOrder=3,
ZIndex=3,
Parent=ar,
}

N._subheading=af.Text{
Name="Description",
Text="",
TextColor3=e.MutedForeground,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Position=UDim2.fromOffset(0,35),
Size=UDim2.new(1,0,0,15),
Visible=false,
ZIndex=3,
Parent=aq,
}


local at=d("Frame",{
Name="Controls",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-16,0.5,0),
Size=UDim2.fromOffset(52,28),
ZIndex=3,
Parent=an,
},{
d("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local au={}
for av,aw in ipairs{
{name="Close",color="ff5f57",ring="e0443e",glyph="x",press=function()N:Destroy"Close"end},
{name="Minimize",color="febc2e",ring="dea123",glyph="minus",press=function()N:SetVisible(false)end},
{name="Zoom",color="28c840",ring="1aab29",glyph="maximize-2",press=function()N:_toggleZoom()end},
}do
local ax=Color3.fromHex(aw.color)
local ay=d("TextButton",{
Name=aw.name,
Text="",
AutoButtonColor=false,
BackgroundColor3=ax,
BorderSizePixel=0,
Size=UDim2.fromOffset(12,12),
LayoutOrder=av,
ZIndex=4,
Parent=at,
},{af.Corner(6),af.Stroke(Color3.fromHex(aw.ring),0.5)})

local az=d("ImageLabel",{
Name="Glyph",
BackgroundTransparency=1,
Image=K:Icon(aw.glyph)or"",
ImageColor3=Color3.new(0,0,0),
ImageTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(8,8),
ZIndex=5,
Parent=ay,
})

L:Connect(ay.MouseButton1Down,function()
ay.BackgroundColor3=ax:Lerp(Color3.new(0,0,0),0.2)
end)
L:Connect(ay.MouseButton1Up,function()
ay.BackgroundColor3=ax
end)
L:Connect(ay.MouseLeave,function()
ay.BackgroundColor3=ax
end)
L:Connect(ay.MouseButton1Click,function()
task.spawn(aw.press)
end)

table.insert(au,az)
end
N._zoomGlyph=au[3]

local function setGlyphVisibility(av)
local aw=if av then 0.45 else 1
for ax,ay in ipairs(au)do
ad.Tween(ay,{ImageTransparency=aw})
end
end
L:Connect(at.MouseEnter,function()setGlyphVisibility(true)end)
L:Connect(at.MouseLeave,function()setGlyphVisibility(false)end)

if Y~=false then
N:_buildProfileCard(an,Y)
end

local av=r+q+10
local aw=j
if ab.TouchEnabled and not ab.MouseEnabled then
av=j
end
N._footerCollapsed=av
N._footerExpanded=aw

N._pages=d("Frame",{
Name="Pages",
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,g),
Size=UDim2.new(1,0,1,-(g+av)),
ClipsDescendants=true,
ZIndex=2,
Parent=_,
})














local ax=d("Frame",{
Name="Dock",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.fromScale(0,1),
Size=UDim2.new(1,0,0,av),
ClipsDescendants=true,
ZIndex=6,
Parent=R,
})
N._dock=ax


d("Frame",{
Name="Edge",
BackgroundColor3=e.Foreground,
BackgroundTransparency=0.92,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,1),
ZIndex=6,
Parent=ax,
})


local function ordinal(ay)
ay=tonumber(ay)or 0
if ay%100>=11 and ay%100<=13 then return"th"end
local az=ay%10
return az==1 and"st"or az==2 and"nd"or az==3 and"rd"or"th"
end

local function dateText()
local ay=os.time()
local az=tonumber(os.date("%d",ay))
return os.date("%A, %B ",ay)..string.format("%02d",az)..ordinal(az)..os.date(", %Y.",ay)
end


local ay=af.Text{
Name="Date",
Text=dateText(),
TextColor3=e.MutedForeground,
FontFace=ae.Medium,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,14,0.5,1),
Size=UDim2.new(0.28,0,0,16),
ZIndex=6,
Parent=ax,
}


af.Text{
Name="Brand",
Text="ui by feyeeiei",
TextColor3=e.MutedForeground,
FontFace=ae.Medium,
TextSize=ad.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Right,
TextTruncate=Enum.TextTruncate.AtEnd,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-14,0.5,1),
Size=UDim2.new(0.28,0,0,16),
ZIndex=6,
Parent=ax,
}


L:Give(task.spawn(function()
while true do
task.wait(60)
if ay.Parent then
ay.Text=dateText()
end
end
end))


local az=d("Frame",{
Name="Grabber",
BackgroundColor3=e.MutedForeground,
BackgroundTransparency=0.45,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,1),
Position=UDim2.new(0.5,0,1,-r),
Size=UDim2.fromOffset(p,q),
ZIndex=6,
Parent=ax,
},{af.Corner(q/2)})
N._grabber=az


local aA=af.Stroke(e.Foreground,1)
local aB=d("CanvasGroup",{
Name="Tabs",
BackgroundColor3=e.Sidebar,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,s),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.new(0,0,0,m),
GroupTransparency=1,
Visible=false,
Active=true,
ZIndex=7,
Parent=ax,
},{
af.Corner(n),
aA,
af.Padding(5),
af.List(4,Enum.FillDirection.Horizontal),
})
af.ApplyGlass(aB,aA,N._maid,N.Library and N.Library.ThemeChanged,{
DarkAlpha={0.42,0.62,0.50},
LightAlpha={0.34,0.52,0.42},
})
N._dockTabs=aB

local aC=d("UIScale",{Scale=0.5,Parent=aB})
N._dockScale=aC

N._dockShown=false
N._touchOnly=ab.TouchEnabled and not ab.MouseEnabled

local aD=0
local aE=TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
local aF=TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
local aG=TweenInfo.new(0.22,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
local aH=TweenInfo.new(0.35,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0,false,0.1)

function N._setDock(aI)
if N._dockShown==aI then return end
N._dockShown=aI
aD+=1
local aJ=aD

local aK=if aI then N._footerExpanded else N._footerCollapsed
local aL=if aI then aE else aG
ad.Tween(ax,{Size=UDim2.new(1,0,0,aK)},aL)
ad.Tween(N._pages,{
Size=UDim2.new(1,0,1,-(g+aK)),
},aL)

if aI then
aB.Visible=true
ad.Tween(az,{
BackgroundTransparency=1,
Size=UDim2.fromOffset(p*0.35,q),
},TweenInfo.new(0.2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out))
ad.Tween(aB,{
GroupTransparency=0,
Position=UDim2.new(0.5,0,0.5,0),
},aE)
ad.Tween(aC,{Scale=1},aF)
else
N:_hideTooltip()
ad.Tween(aB,{
GroupTransparency=1,
Position=UDim2.new(0.5,0,0.5,s),
},aG)
ad.Tween(aC,{Scale=0.5},aG)
ad.Tween(az,{
BackgroundTransparency=0.45,
Size=UDim2.fromOffset(p,q),
},aH)
task.delay(aG.Time,function()
if aD==aJ and not N._dockShown then
aB.Visible=false
end
end)
end
end

if N._touchOnly then
az.Visible=false
N._setDock(true)
end

N._dockTabs=aB


local aI
local aJ
local function isPressInput(aK)
return aK.UserInputType==Enum.UserInputType.MouseButton1
or aK.UserInputType==Enum.UserInputType.Touch
end
N._isPress=isPressInput

local function beginDrag(aK,aL)
if not isPressInput(aL)then return end
aI={
kind=aK,
start=aL.Position,
position=P.Position,
size=Vector2.new(P.Size.X.Offset,P.Size.Y.Offset),
}
aJ=nil
if aK=="move"then
N:_closePopover()
end
end

function N._drag(aK,aL,aM)
if not isPressInput(aK)then return end
aI={
kind="custom",
start=aK.Position,
position=P.Position,
size=P.AbsoluteSize,
move=aL,
finish=aM,
}
aJ=aK.Position
end

L:Connect(an.InputBegan,function(aK)beginDrag("move",aK)end)
L:Connect(T.InputBegan,function(aK)beginDrag("move",aK)end)
L:Connect(ax.InputBegan,function(aK)
if N._dockShown then beginDrag("move",aK)end
end)
L:Connect(ab.InputChanged,function(aK)
if aI and(aK.UserInputType==Enum.UserInputType.MouseMovement
or aK.UserInputType==Enum.UserInputType.Touch)then
aJ=aK.Position
end
end)

L:Connect(ab.InputEnded,function(aK)
if not isPressInput(aK)then return end
local aL=aI
aI=nil
aJ=nil
if aL and aL.finish then
task.spawn(aL.finish)
end
end)


N._toggleKey=M.ToggleKey or Enum.KeyCode.RightShift
N._gamepadToggleKey=M.GamepadToggleKey
if N._gamepadToggleKey==nil then
N._gamepadToggleKey=Enum.KeyCode.ButtonSelect
end
N._keybinds={}

L:Connect(ab.InputEnded,function(aK)
for aL,aM in ipairs(N._keybinds)do
aM.ended(aK)
end
end)

L:Connect(ab.InputBegan,function(aK,aL)
if(not aL and aK.KeyCode==N._toggleKey)
or aK.KeyCode==N._gamepadToggleKey then
N:SetVisible(not N._visible)
if N._visible
and aK.UserInputType.Name:match"^Gamepad"
and N._selected then
pcall(function()
game:GetService"GuiService".SelectedObject=N._selected._item
end)
end
end

for aM,aN in ipairs(N._keybinds)do
aN.began(aK,aL)
end

local aM=N._popover
if aM and isPressInput(aK)then
local aN=Vector2.new(aK.Position.X,aK.Position.Y)
local function inside(aO)
local aP,aQ=aO.AbsolutePosition,aO.AbsoluteSize
return aN.X>=aP.X and aN.Y>=aP.Y
and aN.X<=aP.X+aQ.X and aN.Y<=aP.Y+aQ.Y
end
if not inside(aM.panel)and not inside(aM.anchor)then
N:_closePopover()
end
end
if aM and(aK.KeyCode==Enum.KeyCode.Escape or aK.KeyCode==Enum.KeyCode.ButtonB)then
N:_closePopover()
end
end)


local function viewportSize()
local aK=workspace.CurrentCamera
local aL=Vector2.new(1920,1080)
if aK then aL=aK.ViewportSize end
return Vector2.new(
math.max(aL.X-D*2,0),
math.max(aL.Y-D*2,0)
)
end

N._fit=1

local function fitScale(aK)
return math.clamp(math.min(aK.X/B.X,aK.Y/B.Y),0.3,1)
end

local function clampPreferred(aK)
local aL=viewportSize()/N._fit
local aM=math.min(math.max(aK.X,B.X),aL.X)
local aN=math.min(math.max(aK.Y,B.Y),aL.Y)
return Vector2.new(math.floor(aM/2)*2,math.floor(aN/2)*2)
end

local function applySize(aK)
P.Size=UDim2.fromOffset(aK.X,aK.Y)
end

local aK

function N._zoom()
local aL=aK~=nil
local aM="maximize-2"
if aL then
local aN=aK
aK=nil
ad.Tween(P,{Size=aN.size,Position=aN.position},E)
else
aK={size=P.Size,position=P.Position}
local aN=clampPreferred(viewportSize()/N._fit)
local aO=O.AbsoluteSize
aM="minimize-2"
ad.Tween(P,{
Size=UDim2.fromOffset(aN.X,aN.Y),
Position=UDim2.fromOffset(math.floor(aO.X/2),math.floor(aO.Y/2)),
},E)
end
if N._zoomGlyph then
N._zoomGlyph.Image=K:Icon(aM)or""
end
end

L:Connect(ac.RenderStepped,function()
N:_updateProfileCard()
N:_updateDockHover()
if N._popover then
N:_placePopover()
end

N:_updateProfileCard()

local aL=aI
if not(aL and aJ)then return end

local aM=aJ-aL.start
if aL.kind=="custom"then
local aN=aJ
aJ=nil
(aL.move)(aN)
return
end

aJ=nil
if aL.kind=="move"then
P.Position=aL.position+UDim2.fromOffset(math.round(aM.X),math.round(aM.Y))
else
local aN,aO=aM.X/N._fit,aM.Y/N._fit
if aL.kind=="resizeY"then aN=0
elseif aL.kind=="resizeX"then aO=0 end
local aP=clampPreferred(aL.size+Vector2.new(aN,aO))
local aQ=(aP-aL.size)*N._fit
applySize(aP)
N._preferred=aP
P.Position=aL.position+UDim2.fromOffset(math.round(aQ.X/2),math.round(aQ.Y/2))
end
end)

N._preferred=Vector2.new(P.Size.X.Offset,P.Size.Y.Offset)

local function fitToScreen()
local aL=viewportSize()
local aM=fitScale(aL)
N._fit=aM
if N._scale then
N._scale.Scale=aM
end
local aN=clampPreferred(N._preferred)
if aK~=nil then
aN=clampPreferred(aL/aM)
end
applySize(aN)

local aO=O.AbsoluteSize
if aO.X<1 or aO.Y<1 then return end

local aP=P.Position
local aQ=aN*aM/2
local aR=aP.X.Scale*aO.X+aP.X.Offset
local aS=aP.Y.Scale*aO.Y+aP.Y.Offset
local aT=aQ.X+D
local aU=aO.X-aQ.X-D
local aV=aQ.Y+D
local aW=aO.Y-aQ.Y-D

if aT>aU then aR=aO.X/2 else aR=math.clamp(aR,aT,aU)end
if aV>aW then aS=aO.Y/2 else aS=math.clamp(aS,aV,aW)end
P.Position=UDim2.fromOffset(math.round(aR),math.round(aS))
end
N._fitToScreen=fitToScreen

local aL,aM

local function watchCamera()
local aN=workspace.CurrentCamera
if aN==aL then return end
aL=aN
if aM then
aM:Disconnect()
end
if aN then
aM=L:Connect(aN:GetPropertyChangedSignal"ViewportSize",fitToScreen)
end
fitToScreen()
end

L:Connect(workspace:GetPropertyChangedSignal"CurrentCamera",watchCamera)
L:Connect(O:GetPropertyChangedSignal"AbsoluteSize",fitToScreen)
task.defer(watchCamera)


if M.Resizable~=false then
local aN=ab.TouchEnabled and not ab.MouseEnabled
local aO=10
local aP=22
if aN then
aO=28
aP=44
end

local function makeHandle(aQ,aR,aS,aT,aU)
local aV=d("TextButton",{
Name=aQ,
Text="",
BackgroundTransparency=1,
AutoButtonColor=false,
AnchorPoint=aS,
Position=aT,
Size=aU,
ZIndex=8,
Parent=P,
})
L:Connect(aV.InputBegan,function(aW)beginDrag(aR,aW)end)
return aV
end

makeHandle("ResizeRight","resizeX",
Vector2.new(0.3,0),
UDim2.new(1,0,0,g),
UDim2.new(0,aO,1,-(g+aP/2)))

makeHandle("ResizeBottom","resizeY",
Vector2.new(0,0.3),
UDim2.new(0,ad.Radius.Xl,1,0),
UDim2.new(1,-(ad.Radius.Xl+aP/2),0,aO))

local aQ=makeHandle("Resize","resize",
Vector2.new(0.5,0.5),
UDim2.fromScale(1,1),
UDim2.fromOffset(aP,aP))

local aR=11
local aS=4
local aT=3
if aN then
aR=14
aS=4
end

local aU=d("Frame",{
Name="ResizeArc",
BackgroundTransparency=1,
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,1),
Position=UDim2.new(1,-aR,1,-aR),
Visible=false,
Size=UDim2.fromOffset(aR+aT,aR+aT),
ZIndex=7,
Parent=R,
})

local aV=d("Frame",{
Name="Ring",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(1,1),
Position=UDim2.fromScale(1,1),
Size=UDim2.fromOffset((aR+aT)*2,(aR+aT)*2),
ZIndex=7,
Parent=aU,
},{af.Corner(aR+aT)})

local aW,aX=d("UIStroke",{
Color=e.MutedForeground,
Thickness=aS,
Transparency=0.55,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=aV,
}),0.55
if aN then aX=0.25 end
aW.Transparency=aX

L:Connect(aQ.MouseEnter,function()
ad.Rebind(aW,"Color","Foreground")
ad.Tween(aW,{Transparency=0.15})
end)
L:Connect(aQ.MouseLeave,function()
ad.Rebind(aW,"Color","MutedForeground")
ad.Tween(aW,{Transparency=aX})
end)

local aY
L:Connect(ab.TouchPinch,function(aZ,a_,a0,a1)
if a1==Enum.UserInputState.Begin then
aY=nil
local a2,a3,a4=P.AbsolutePosition,P.AbsoluteSize,#aZ>0
for a5,a6 in ipairs(aZ)do
if a6.X<a2.X or a6.Y<a2.Y
or a6.X>a2.X+a3.X or a6.Y>a2.Y+a3.Y then
a4=false
end
end
if a4 and N._visible then
aY=a3
N:_closePopover()
end
elseif a1==Enum.UserInputState.Change and aY then
applySize(clampPreferred(aY*a_))
else
aY=nil
end
end)
end





local function watchViewport()
local aN=workspace.CurrentCamera
if aN then
L:Connect(aN:GetPropertyChangedSignal"ViewportSize",fitToScreen)
end
end
watchViewport()
L:Connect(workspace:GetPropertyChangedSignal"CurrentCamera",watchViewport)

N._collapsed=false
N._userCollapsed=nil
local aN=false
L:Connect(P:GetPropertyChangedSignal"AbsoluteSize",function()
local aO=P.AbsoluteSize.X<C
if aO~=aN then
aN=aO
N._userCollapsed=nil
N:SetSidebarCollapsed(aO)
elseif N._userCollapsed==nil then
N:SetSidebarCollapsed(aO)
end
end)

applySize(clampPreferred(Vector2.new(P.Size.X.Offset,P.Size.Y.Offset)))

if M.Island~=false then
N._island=aj.new(L,O,{
Title=N.Title,
Icon=M.Icon,
Library=K,
Hint=function()return N._toggleKey.Name end,
Open=function()N:SetVisible(true)end,
})
end

O.Parent=af.GuiParent()

local aO=Vector2.new(1920,1080)
if workspace.CurrentCamera then
aO=workspace.CurrentCamera.ViewportSize
end
P.Position=UDim2.fromOffset(
math.floor(aO.X/2),
math.floor(aO.Y/2)
)

if P.AbsoluteSize.X<C then
aN=true
N:SetSidebarCollapsed(true)
end

N._scale=d("UIScale",{Scale=0.96*N._fit,Parent=P})
ad.Tween(
N._scale,
{Scale=N._fit},
TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
)

if M.Glass then
N:SetGlass(true)
end
if M.Loading then
N:SetLoading(true)
end
return N
end


local an=TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true)
local ao=TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local ap=0.25
local aq=0.6

local function makeSkeletonBar(ar,as,at,au,av)
local aw=d("Frame",{
Name="Bar",
BackgroundColor3=e.Muted,
BackgroundTransparency=ap,
BorderSizePixel=0,
Position=as,
Size=at,
ZIndex=21,
Parent=ar,
},{af.Corner(au)})
table.insert(av,aw)
return aw
end

function F.SetLoading(ar,as)
if as then
if ar._skeleton then return end
local at={}
local au=d("Frame",{
Name="Skeleton",
BackgroundTransparency=1,
Position=ar._nav.Position,
Size=ar._nav.Size,
ZIndex=20,
Parent=ar._nav.Parent,
})
for av=0,7 do
local aw=12+av*36
local ax=({0.55,0.42,0.6,0.5,0.38,0.58,0.46,0.52})[av+1]
makeSkeletonBar(au,UDim2.fromOffset(16,aw),UDim2.fromOffset(16,16),ad.Radius.Sm,at)
makeSkeletonBar(au,UDim2.new(0,42,0,aw+3),UDim2.new(ax,-42,0,10),ad.Radius.Full,at)
end

local av=d("Frame",{
Name="Skeleton",
BackgroundColor3=e.Background,
BackgroundTransparency=0,
BorderSizePixel=0,
Position=ar._pages.Position,
Size=ar._pages.Size,
ZIndex=20,
Parent=ar._pages.Parent,
})
makeSkeletonBar(av,UDim2.fromOffset(20,18),UDim2.new(0.32,0,0,14),ad.Radius.Full,at)
makeSkeletonBar(av,UDim2.fromOffset(20,40),UDim2.new(0.5,0,0,10),ad.Radius.Full,at)

local aw={}
for ax=0,1 do
local ay=d("Frame",{
Name="Card",
BackgroundColor3=e.Card,
BorderSizePixel=0,
Position=UDim2.fromOffset(16,70+ax*150),
Size=UDim2.new(1,-32,0,134),
ZIndex=21,
Parent=av,
},{af.Corner(ad.Radius.Xl)})
table.insert(aw,ay)
for az=0,2 do
local aA=16+az*40
makeSkeletonBar(ay,UDim2.fromOffset(16,aA),UDim2.new(0.38,0,0,12),ad.Radius.Full,at).ZIndex=22
makeSkeletonBar(ay,UDim2.fromOffset(16,aA+18),UDim2.new(0.56,0,0,9),ad.Radius.Full,at).ZIndex=22
makeSkeletonBar(ay,UDim2.new(1,-60,0,aA+4),UDim2.fromOffset(44,20),ad.Radius.Full,at).ZIndex=22
end
end

local ax={}
for ay,az in ipairs(at)do
local aA=c:Create(az,an,{BackgroundTransparency=aq})
aA:Play()
table.insert(ax,aA)
end

ar._nav.Visible=false
ar._skeleton={
nav=au,
page=av,
bars=at,
cards=aw,
tweens=ax,
}
return
end

local at=ar._skeleton
if not at then return end
ar._skeleton=nil
ar._nav.Visible=true

for au,av in ipairs(at.tweens)do
av:Cancel()
end
for au,av in ipairs(at.bars)do
ad.Tween(av,{BackgroundTransparency=1},ao)
end
for au,av in ipairs(at.cards)do
ad.Tween(av,{BackgroundTransparency=1},ao)
end
ad.Tween(at.page,{BackgroundTransparency=1},ao)
task.delay(ao.Time+0.05,function()
at.nav:Destroy()
at.page:Destroy()
end)
end

function F._buildProfileCard(ar,as,at)
local au=ar._maid
local av=aa.LocalPlayer
local aw={}
if type(at)=="table"then
aw=at
end

local ax,ay=aw.Title,aw.Subtitle
if not ax and av then
ax=av.DisplayName
if aw.Mask~=false then
ax=maskName(ax)
end
end

local az=af.Stroke(e.Foreground,1)
local aA=d("TextButton",{
Name="Profile",
Text="",
AutoButtonColor=false,
BackgroundColor3=e.Sidebar,
BackgroundTransparency=0,
BorderSizePixel=0,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-A,0.5,0),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.new(0,0,0,v),
ClipsDescendants=true,
ZIndex=4,
Parent=as,
},{
af.Corner(ad.Radius.Xl),
az,
af.Padding(4,10,4,4),
af.List(8,Enum.FillDirection.Horizontal),
})
af.ApplyGlass(aA,az,au,ar.Library and ar.Library.ThemeChanged,{
DarkAlpha={0.58,0.76,0.66},
LightAlpha={0.44,0.64,0.54},
})
local aB=aA:FindFirstChildOfClass"UIListLayout"
if aB then
aB.VerticalAlignment=Enum.VerticalAlignment.Center
end

local aC=d("ImageLabel",{
Name="Avatar",
BackgroundColor3=e.Muted,
BackgroundTransparency=0,
BorderSizePixel=0,
Image="",
ScaleType=Enum.ScaleType.Crop,
Size=UDim2.fromOffset(w,w),
ZIndex=5,
Parent=aA,
},{af.Corner(ad.Radius.Full)})

local aD=aw.Image
if aD==nil then
aD=aw.Icon
end
if aD==nil then
aD=aw.Avatar
end

if aD~=nil and aD~=false then
aC.Image=ar.Library:Icon(aD)or tostring(aD)
elseif av then
task.spawn(function()
local aE,aF=pcall(function()
return aa:GetUserThumbnailAsync(
av.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size150x150
)
end)
if aE and aC.Parent then
aC.Image=aF
aC.BackgroundTransparency=1
end
end)
else
aC.BackgroundTransparency=1
end

local aE=d("Frame",{
Name="Text",
BackgroundTransparency=1,
Size=UDim2.fromOffset(x,v-8),
ZIndex=5,
Parent=aA,
},{
d("UIListLayout",{
VerticalAlignment=Enum.VerticalAlignment.Center,
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})
ar._profileText=aE
ar._footerText=aE

af.Text{
Name="Name",
Text=ax or"",
TextColor3=e.SidebarForeground,
FontFace=ae.Medium,
TextSize=ad.TextSize.Sub,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,15),
LayoutOrder=1,
ZIndex=5,
Parent=aE,
}

if ay then
af.Text{
Name="Subtitle",
Text=ay,
TextColor3=e.MutedForeground,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,14),
LayoutOrder=2,
ZIndex=5,
Parent=aE,
}
end

au:Connect(aA.MouseEnter,function()
ad.Rebind(aA,"BackgroundColor3","SidebarAccent")
ad.Rebind(az,"Color","SidebarPrimary")
ad.Tween(az,{Transparency=0.2})
if ax and not aE.Visible then
ar:_showTooltip(aA,ax,true)
end
end)
au:Connect(aA.MouseLeave,function()
ad.Rebind(aA,"BackgroundColor3","Sidebar")
ad.Rebind(az,"Color","Border")
ad.Tween(az,{Transparency=0})
ar:_hideTooltip()
end)

au:Connect(aA.MouseButton1Click,function()
if ar._footerOpen then
ar:_closePopover()
return
end
ar._footerOpen=true

local aF=ar:_menu({
{
Title="Toggle theme",
Icon="sun-moon",
Callback=function()
local aF="Dark"
if ad.Mode=="Dark"then aF="Light"end
ar.Library:SetTheme(aF)
end,
},
{
Title="Hide",
Icon="eye-off",
Shortcut=ar._toggleKey.Name,
Callback=function()ar:SetVisible(false)end,
},
false,
{
Title="Close",
Icon="log-out",
Destructive=true,
Callback=function()ar:Destroy"Close"end,
},
},ax,ay)

ar:_openPopover(aF,aA,function()
ar._footerOpen=false
end,"bottom")
end)

ar._footer=aA
ar._profileCard=aA
ar._profileAvatar=aC

if ar._headingFrame then
ar._headingFrame.Size=UDim2.new(1,-(162+A+y+12),1,0)
end
end

function F._updateDockHover(ar)
if ar._touchOnly or not ar._visible or not ar._dockScale then return end

local as=game:GetService"GuiService":GetGuiInset()
local at=ab:GetMouseLocation()

local au=ar._grabber
local av=if ar._dockShown then ar._dockTabs else au

local aw,ax=av.AbsolutePosition,av.AbsoluteSize
if ar._dockShown then
local ay=math.max(ar._dockScale.Scale,0.5)
ax=ax/ay
aw=aw-(ax-av.AbsoluteSize)/2
end


local ay,az,aA
if ar._dockShown then
ay,az,aA=8,8,12
else
ay,az,aA=40,14,60
end

local function hit(aB)
return at.X>=aw.X-ay and at.X<=aw.X+ax.X+ay
and aB>=aw.Y-az and aB<=aw.Y+ax.Y+aA
end

local aB=hit(at.Y)or hit(at.Y-as.Y)

if aB then
ar._dockLeaveAt=nil
ar._setDock(true)
elseif ar._dockShown then
ar._dockLeaveAt=ar._dockLeaveAt or os.clock()
if os.clock()-ar._dockLeaveAt>t then
ar._dockLeaveAt=nil
ar._setDock(false)
end
end
end

function F._updateProfileCard(ar)
local as=ar._profileText
local at=ar._holder
if not as or not at then return end

local au=ar._fit or 1
if au<=0 then au=1 end
local av=at.AbsoluteSize.X/au
if av<1 then return end

local aw=av>=600
if as.Visible==aw then return end

as.Visible=aw
local ax=if aw then y else z
local ay=ar._headingFrame
if ay then

ay.Size=UDim2.new(1,-(162+A+ax+12),1,0)
end
end

function F._buildFooter(ar,as,at,au)
local av=ar._maid
local aw=aa.LocalPlayer
local ax={}
if type(at)=="table"then
ax=at
end

local ay,az=ax.Title,ax.Subtitle
if not ay and aw then
ay=aw.DisplayName
if ax.Mask~=false then
ay=maskName(ay)
end
end

local aA=d("Frame",{
Name="Footer",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0,1),
Position=UDim2.fromScale(0,1),
Size=UDim2.new(1,-1,0,au),
ZIndex=3,
Parent=as,
},{af.Padding(8,8,8,10)})

local aB=d("TextButton",{
Name="User",
Text="",
AutoButtonColor=false,
BackgroundColor3=e.SidebarAccent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ClipsDescendants=true,
ZIndex=4,
Parent=aA,
},{af.Corner(ad.Radius.Md)})

local aC=d("ImageLabel",{
Name="Avatar",
BackgroundColor3=e.Muted,
BorderSizePixel=0,
Image="",
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
Size=UDim2.fromOffset(32,32),
ZIndex=5,
Parent=aB,
},{af.Corner(ad.Radius.Lg)})

local aD=ax.Image
if aD==nil then
aD=ax.Icon
end
if aD==nil then
aD=ax.Avatar
end

if aD~=nil and aD~=false then
aC.Image=ar.Library:Icon(aD)or tostring(aD)
elseif aw then
task.spawn(function()
local aE,aF=pcall(function()
return aa:GetUserThumbnailAsync(
aw.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size100x100
)
end)
if aE and aC.Parent then
aC.Image=aF
end
end)
end

local aE=d("Frame",{
Name="Text",
BackgroundTransparency=1,
Position=UDim2.fromOffset(40,0),
Size=UDim2.new(1,-64,1,0),
ZIndex=5,
Parent=aB,
},{
d("UIListLayout",{
VerticalAlignment=Enum.VerticalAlignment.Center,
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

af.Text{
Name="Name",
Text=ay or"",
TextColor3=e.SidebarForeground,
FontFace=ae.Medium,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,18),
LayoutOrder=1,
ZIndex=5,
Parent=aE,
}

if az then
af.Text{
Name="Subtitle",
Text=az,
TextColor3=e.MutedForeground,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,16),
LayoutOrder=2,
ZIndex=5,
Parent=aE,
}
end
ar._footerText=aE

local aF=ar.Library:Icon"chevrons-up-down"
if aF then
ar._footerChevron=d("ImageLabel",{
Name="Chevron",
BackgroundTransparency=1,
Image=aF,
ImageColor3=e.MutedForeground,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-8,0.5,0),
Size=UDim2.fromOffset(18,18),
ZIndex=5,
Parent=aB,
})
end

av:Connect(aB.MouseEnter,function()
ad.Tween(aB,{BackgroundTransparency=0})
end)
av:Connect(aB.MouseLeave,function()
if not ar._footerOpen then
ad.Tween(aB,{BackgroundTransparency=1})
end
end)

av:Connect(aB.MouseButton1Click,function()
if ar._footerOpen then
ar:_closePopover()
return
end
ar._footerOpen=true
ad.Tween(aB,{BackgroundTransparency=0})

local aG=ar:_menu({
{
Title="Toggle theme",
Icon="sun-moon",
Callback=function()
local aG="Dark"
if ad.Mode=="Dark"then aG="Light"end
ar.Library:SetTheme(aG)
end,
},
{
Title="Hide",
Icon="eye-off",
Shortcut=ar._toggleKey.Name,
Callback=function()ar:SetVisible(false)end,
},
false,
{
Title="Close",
Icon="log-out",
Destructive=true,
Callback=function()ar:Destroy"Close"end,
},
},ay,az)

local aH="top"
if ar._collapsed then aH="right"end

ar:_openPopover(aG,aB,function()
ar._footerOpen=false
ad.Tween(aB,{BackgroundTransparency=1})
aG:Destroy()
end,aH)
end)

ar._footer=aA
end

function F._menu(ar,as,at,au)
local av=af.Stroke(e.Foreground)
av.Transparency=0.9
local aw,ax=d("Frame",{
Name="Menu",
BackgroundColor3=e.Popover,
BackgroundTransparency=0.08,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.fromOffset(224,0),
ZIndex=21,
},{
af.Corner(ad.Radius.Lg),
av,
}),0

af.AttachAurora(aw,ar._maid,{
Radius=ad.Radius.Lg,
ZIndex=21,
ThemeChanged=ar.Library and ar.Library.ThemeChanged,
})

local ay=d("Frame",{
Name="Body",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ZIndex=22,
Parent=aw,
},{
af.Padding(4),
af.List(0),
})

ay:GetPropertyChangedSignal"AbsoluteSize":Connect(function()
aw.Size=UDim2.fromOffset(224,ay.AbsoluteSize.Y)
end)

local function nextOrder()ax+=1;return ax end

if at then
local az=d("Frame",{
Name="Label",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=nextOrder(),
ZIndex=22,
Parent=ay,
},{af.Padding(6,8,6,8),af.List(0)})

af.Text{
Text=at,
FontFace=ae.Medium,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,18),
LayoutOrder=1,
ZIndex=22,
Parent=az,
}
if au then
af.Text{
Text=au,
TextColor3=e.MutedForeground,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,16),
LayoutOrder=2,
ZIndex=22,
Parent=az,
}
end
d("Frame",{
Name="Separator",
BackgroundColor3=e.Border,
BorderSizePixel=0,
Size=UDim2.new(1,8,0,1),
Position=UDim2.fromOffset(-4,0),
LayoutOrder=nextOrder(),
ZIndex=22,
Parent=ay,
})
end

for az,aA in ipairs(as)do
if aA==false then
d("Frame",{
Name="Gap",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,9),
LayoutOrder=nextOrder(),
ZIndex=22,
Parent=ay,
},{
d("Frame",{
BackgroundColor3=e.Border,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,-4,0.5,0),
Size=UDim2.new(1,8,0,1),
ZIndex=22,
}),
})
else
local aB=e.Foreground
if aA.Destructive then aB=e.Destructive end

local aC=d("TextButton",{
Name=aA.Title,
Text="",
AutoButtonColor=false,
BackgroundColor3=e.Accent,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,32),
LayoutOrder=nextOrder(),
ZIndex=22,
Parent=ay,
},{af.Corner(ad.Radius.Md),af.Padding(0,8,0,8)})

local aD=ar.Library:Icon(aA.Icon)
local aE=0
if aD then
aE=26
d("ImageLabel",{
BackgroundTransparency=1,
Image=aD,
ImageColor3=aB,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(18,18),
ZIndex=23,
Parent=aC,
})
end
af.Text{
Text=aA.Title,
TextColor3=aB,
Position=UDim2.fromOffset(aE,0),
Size=UDim2.new(1,-aE,1,0),
ZIndex=23,
Parent=aC,
}

if aA.Shortcut then
af.Text{
Text=aA.Shortcut,
TextColor3=e.MutedForeground,
TextSize=ad.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Right,
Size=UDim2.fromScale(1,1),
ZIndex=23,
Parent=aC,
}
end

if aA.Disabled then
for aF,aG in ipairs(aC:GetChildren())do
if aG:IsA"TextLabel"then
aG.TextTransparency=0.5
elseif aG:IsA"ImageLabel"then
aG.ImageTransparency=0.5
end
end
end

aC.MouseEnter:Connect(function()
if not aA.Disabled then
ad.Tween(aC,{BackgroundTransparency=0})
end
end)
aC.MouseLeave:Connect(function()
ad.Tween(aC,{BackgroundTransparency=1})
end)
aC.MouseButton1Click:Connect(function()
if aA.Disabled then return end
ar:_closePopover()
if aA.Callback then task.spawn(aA.Callback)end
end)
end
end
return aw
end

function F.Track(ar,as)
return ar._maid:Give(as)
end

function F.SetToggleKey(ar,as)
if typeof(as)=="EnumItem"then
ar._toggleKey=as
else
ar._toggleKey=(Enum.KeyCode)[as]
end
end

function F.GetFlag(ar,as,at)
if ar.Config then
local au=ar.Config:Get(as)
if au~=nil then
return au
end
end
return at
end

function F.SetFlag(ar,as,at)
local au=ar.Controls[as]
if au and au.Value~=at then
au:Set(at)
return
end
ar:_saveFlag(as,at)
end

function F.SaveProfile(ar,as)
if not ar.Config then return false end
return ar.Config:SaveProfile(as)
end

function F.LoadProfile(ar,as)
if not ar.Config then return false end
local at=ar.Config:ReadProfile(as)
if not at then return false end
local au={Data=at}
for av in pairs(ar.Controls)do
local aw=ah.Get(au,av)
if aw~=nil then
ar:SetFlag(av,aw)
end
end
ar.Library:_applySavedTheme(at.__shadcn)
return true
end

function F._saveFlag(ar,as,at)
if ar.Config then
ar.Config:Set(as,at)
end
end

function F.AddGroup(ar,as)
local at=#ar._groups+1
local au=d("Frame",{
Name=as or"Group",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=at,
ZIndex=3,
Parent=ar._nav,
},{af.Padding(8,8,0,8),af.List(0)})

local av
if as and as~=""then
av=af.Text{
Name="Label",
Text=as,
TextColor3=e.SidebarForeground,
TextTransparency=0.3,
FontFace=ae.Bold,
TextSize=ad.TextSize.Xs,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,H),
LayoutOrder=0,
ZIndex=4,
Parent=au,
}
af.Padding(0,8,0,8).Parent=av
end

local aw=d("Frame",{
Name="Menu",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=1,
ZIndex=3,
Parent=au,
},{af.List(2)})

local ax={Title=as,Instance=au,_label=av,_menu=aw,_window=ar}

function ax.AddTab(ay,az,aA)
return ar:_addTab(ax,az,aA)
end

table.insert(ar._groups,ax)

if av and ar._collapsed then
av.Size=UDim2.new(1,0,0,0)
av.TextTransparency=1
end
return ax
end

function F.AddTab(ar,as,at)
local au
local av
if type(as)=="table"then
av=as.Group
end
if av then
for aw,ax in ipairs(ar._groups)do
if ax.Title==av then
au=ax
end
end
if not au then
au=ar:AddGroup(av)
end
else
au=ar._defaultGroup
if not au then
au=ar:AddGroup(ar._navLabel)
ar._defaultGroup=au
end
end
return ar:_addTab(au,as,at)
end

function F._addTab(ar,as,at,au)
local av={}
if type(at)=="string"then
av={Title=at,Icon=au}
else
av=at
end

local aw=#ar._tabs+1
local ax=av.Title or("Tab "..aw)
local ay=ar._maid

local az=ar._tabIcons~="Plain"
local aA=ar.Library:Icon(av.Icon)~=nil
local aB,aC,aD
local aE=ar._dockMode==true local
aF, aG, aH

if aE then
aF=d("TextButton",{
Name=ax,
BackgroundColor3=e.SidebarPrimary,
BackgroundTransparency=1,
AutoButtonColor=false,
BorderSizePixel=0,
Text="",
Size=UDim2.fromOffset(k+6,k),
ClipsDescendants=true,
LayoutOrder=aw,
ZIndex=7,
Parent=ar._dockTabs,
},{af.Corner(o)})

aC=makeGlyph(ar.Library,aF,av.Icon,ax,e.MutedForeground)
aC.AnchorPoint=Vector2.new(0.5,0.5)
aC.Position=UDim2.new(0.5,0,0.5,-2)
aC.Size=UDim2.fromOffset(l,l)
d("UIScale",{Name="Pop",Parent=aC})


d("Frame",{
Name="Dot",
BackgroundColor3=e.SidebarPrimary,
BackgroundTransparency=1,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,1),
Position=UDim2.new(0.5,0,1,-4),
Size=UDim2.fromOffset(2,2),
ZIndex=8,
Parent=aF,
},{d("UICorner",{CornerRadius=UDim.new(1,0)})})

aD=I

aG=af.Text{
Name="Label",
Text=ax,
Visible=false,
Size=UDim2.fromScale(0,0),
Parent=aF,
}

aH=d("Frame",{
Name="Badge",
BackgroundColor3=e.Primary,
BorderSizePixel=0,
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-6,0,5),
Size=UDim2.fromOffset(7,7),
Visible=false,
ZIndex=9,
Parent=aF,
},{d("UICorner",{CornerRadius=UDim.new(1,0)})})
else
aF=d("TextButton",{
Name=ax,
BackgroundColor3=e.SidebarAccent,
BackgroundTransparency=1,
AutoButtonColor=false,
BorderSizePixel=0,
Text="",
Size=UDim2.new(1,0,0,I),
ClipsDescendants=true,
LayoutOrder=aw,
ZIndex=4,
Parent=as._menu,
},{af.Corner(ad.Radius.Md)})

if not aA then
af.Padding(0,8,0,10).Parent=aF
aC=makeGlyph(ar.Library,aF,nil,ax,e.SidebarForeground)
aC.Visible=ar._collapsed==true
aC.Position=UDim2.new(0,-3,0.5,0)
aD=-8
elseif ar._tabIcons=="Accent"then
af.Padding(0,8,0,10).Parent=aF
aC=makeGlyph(ar.Library,aF,av.Icon,ax,e.MutedForeground)
aC.Size=UDim2.fromOffset(H,H)
aD=H
d("Frame",{
Name="AccentBar",
BackgroundColor3=e.Primary,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,-10,0.5,0),
Size=UDim2.new(0,3,0.6,0),
Visible=false,
ZIndex=5,
Parent=aF,
},{d("UICorner",{CornerRadius=UDim.new(1,0)})})
elseif az then
af.Padding(0,8,0,3).Parent=aF
aB,aC=ak.new(aF,av.Icon,ax,ak.Color(av.Color,aw),I,J)
aD=I
else
af.Padding(0,8,0,8).Parent=aF
aC=makeGlyph(ar.Library,aF,av.Icon,ax,e.SidebarForeground)
aD=G
end

aG=af.Text{
Text=ax,
FontFace=ae.Regular,
TextSize=ad.TextSize.Title,
TextColor3=e.SidebarForeground,
TextTruncate=Enum.TextTruncate.AtEnd,
Position=UDim2.fromOffset(aD+8,0),
Size=UDim2.new(1,-(aD+8),1,0),
ZIndex=5,
Parent=aF,
}

aH=af.Text{
Name="Badge",
Text="",
TextColor3=e.SidebarForeground,
FontFace=ae.Medium,
TextSize=ad.TextSize.Xs,
TextXAlignment=Enum.TextXAlignment.Center,
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,4,0.5,0),
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.fromOffset(20,20),
Visible=false,
ZIndex=5,
Parent=aF,
}
d("UISizeConstraint",{MinSize=Vector2.new(20,20),Parent=aH})
af.Padding(0,4,0,4).Parent=aH
end

local aI=d("ScrollingFrame",{
Name=ax,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollBarThickness=4,
ScrollBarImageColor3=e.Border,
ScrollingDirection=Enum.ScrollingDirection.Y,
ZIndex=2,
},{af.Padding(17,17,0,17),af.List(25)})
local aJ=b.new(ar,aI,aF,aG,ax)
aJ.Description=av.Description
aJ.Group=as
aJ._icon=aC
aJ._tile=aB
aJ._iconless=not aA
aJ._badge=aH

if av.Badge~=nil then
aJ:SetBadge(av.Badge)
end
if ar._collapsed then
aG.TextTransparency=1
aH.Visible=false
end

ay:Connect(aF.MouseEnter,function()
if ar._selected~=aJ then
ar:_paintTab(aJ,true)
end
if ar._collapsed or aE then
ar:_showTooltip(aF,aJ.Title)
end
end)





ay:Connect(aF.MouseLeave,function()
if ar._selected~=aJ then
ar:_paintTab(aJ,false)
end
ar:_hideTooltip()
end)
ay:Connect(aF.MouseButton1Click,function()
ar:SelectTab(aJ)
end)

table.insert(ar._tabs,aJ)
if not ar._selected then
ar:SelectTab(aJ)
end
return aJ
end

function F._paintTab(ar,as,at,au)
local av=au
if av==nil then
av=ar._selected==as
end

local aw=as._item

if ar._dockMode then
local ax,ay,az=1,"SidebarAccent","MutedForeground"local
aA, aB, aC=1, 2, 1
local aD=-2

if av then
ax,ay,az=0.88,"SidebarPrimary","SidebarPrimary"
aA,aB,aC=1.1,4,0
aD=-3
elseif at then
ax,az=0.7,"SidebarForeground"
aA=1.12
end

local aE=TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

ad.Rebind(aw,"BackgroundColor3",ay)
ad.Tween(aw,{BackgroundTransparency=ax})

local aF=aw:FindFirstChild"Dot"
if aF then
ad.Tween(aF,{
BackgroundTransparency=aC,
Size=UDim2.fromOffset(aB,aB),
},aE)
end

if as._icon then
ad.Rebind(as._icon,colorPropName(as._icon),az)
ad.Tween(as._icon,{Position=UDim2.new(0.5,0,0.5,aD)},aE)
local aG=as._icon:FindFirstChild"Pop"
if aG then
ad.Tween(aG,{Scale=aA},aE)
end
end
return
end

local ax=ar._glassOn==true
local ay=1
local az=ar._tabIcons=="Accent"

if az then
if av then
ad.Rebind(aw,"BackgroundColor3","Primary")
ay=0.88
else
ad.Rebind(aw,"BackgroundColor3","Foreground")
if at then ay=0.95 end
end
elseif ax then
ad.Rebind(aw,"BackgroundColor3","Foreground")
if av then
ay=0.88
elseif at then
ay=0.94
end
else
ad.Rebind(aw,"BackgroundColor3","SidebarAccent")
if av then ay=0
elseif at then ay=0.4 end
end
ad.Tween(aw,{BackgroundTransparency=ay})

local aA=aw:FindFirstChild"GlassRim"
if ax and av and not az and not aA then
aA=d("UIStroke",{
Name="GlassRim",
Color=e.Foreground,
Thickness=1,
Transparency=0.88,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=aw,
})
end
if aA then
aA.Enabled=ax and av and not az
end

if ar._tabIcons=="Accent"and as._icon and not as._iconless then
local aB="MutedForeground"
if av then aB="Primary"
elseif at then aB="SidebarForeground"end
if as._icon:IsA"ImageLabel"then
ad.Rebind(as._icon,"ImageColor3",aB)
else
ad.Rebind(as._icon,"TextColor3",aB)
end
local aC=aw:FindFirstChild"AccentBar"
if aC then
aC.Visible=av==true
end
end
end

function F._hideTooltip(ar)
local as=ar._tooltip
if not as or not as.Visible then return end
ar._tooltipGen=(ar._tooltipGen or 0)+1
local at=ar._tooltipGen
ad.Tween(as,{
TextTransparency=1,
BackgroundTransparency=1,
},TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out))
task.delay(0.12,function()
if ar._tooltipGen==at then
as.Visible=false
end
end)
end

function F._showTooltip(ar,as,at,au)
local av=ar._tooltip
if not av then return end
ar._tooltipGen=(ar._tooltipGen or 0)+1
local aw=ar._tooltipGen

local ax=ar._overlay.AbsolutePosition
av.Text=at

if ar._dockMode then
av.AnchorPoint=if au then Vector2.new(0.5,0)else Vector2.new(0.5,1)
local ay=as.AbsolutePosition.X+as.AbsoluteSize.X/2-ax.X
local az
local aA
if au then
az=as.AbsolutePosition.Y+as.AbsoluteSize.Y-ax.Y+8
aA=az-4
else
az=as.AbsolutePosition.Y-ax.Y-8
aA=az+4
end

local aB=ar._holder
local aC=if aB then aB.AbsolutePosition-ax else Vector2.zero
local aD=if aB then aB.AbsoluteSize else ar.Instance.AbsoluteSize

local aE=av.Visible and av.BackgroundTransparency<0.5
av.Visible=true

if aE then
ad.Tween(av,{
Position=UDim2.fromOffset(ay,az),
TextTransparency=0,
BackgroundTransparency=0,
},TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out))
else
av.Position=UDim2.fromOffset(ay,aA)
av.TextTransparency=1
av.BackgroundTransparency=1

ad.Tween(av,{
Position=UDim2.fromOffset(ay,az),
TextTransparency=0,
BackgroundTransparency=0,
},TweenInfo.new(0.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out))
end

task.defer(function()
if ar._tooltipGen==aw and av.Visible and av.Text==at then
local aF=av.AbsoluteSize.X/2
local aG=math.max(6,aC.X+aF+6)
local aH=math.min(ar.Instance.AbsoluteSize.X-aF-6,aC.X+aD.X-aF-6)
if aH>=aG then
local aI=math.clamp(ay,aG,aH)
if math.abs(aI-ay)>0.5 then
av.Position=UDim2.fromOffset(aI,az)
end
end
end
end)
return
end

av.AnchorPoint=Vector2.new(0,0.5)
local ay=as.AbsolutePosition.X+as.AbsoluteSize.X+10-ax.X
local az=as.AbsolutePosition.Y+as.AbsoluteSize.Y/2-ax.Y
local aA=av.Visible and av.BackgroundTransparency<0.5
av.Visible=true

if aA then
ad.Tween(av,{
Position=UDim2.fromOffset(ay,az),
TextTransparency=0,
BackgroundTransparency=0,
},TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out))
else
av.Position=UDim2.fromOffset(ay-4,az)
av.TextTransparency=1
av.BackgroundTransparency=1

ad.Tween(av,{
Position=UDim2.fromOffset(ay,az),
TextTransparency=0,
BackgroundTransparency=0,
},TweenInfo.new(0.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out))
end
end

function F.SelectTab(ar,as)
if ar._selected==as then return end

local at=ar._selected
ar:_closePopover()

if at then
at._page.Parent=nil
at._label.FontFace=ae.Regular
if not at._tile then
ad.Rebind(at._icon,colorPropName(at._icon),"SidebarForeground")
end
ar:_paintTab(at,false,false)
end

ar._selected=as
as._label.FontFace=ae.Regular
if not as._tile then
ad.Rebind(as._icon,colorPropName(as._icon),"SidebarPrimary")
end
ar:_paintTab(as,false)

local au=as.Group and as.Group.Title
local av=type(au)=="string"and au~=""
ar._crumbGroup.Text=au or""
ar._crumbGroup.Visible=av
ar._crumbChevron.Visible=av

ar._heading.Text=as.Title
ar._subheading.Text=as.Description or""
ar._subheading.Visible=(as.Description or"")~=""

as._page.Position=UDim2.fromOffset(0,6)
as._page.Parent=ar._pages
ad.Tween(as._page,{Position=UDim2.fromOffset(0,0)})
end

function F.SetSidebarCollapsed(ar,as,at)
if at then
ar._userCollapsed=as
end
if ar._dockMode then

ar._collapsed=false
return
end
if ar._collapsed==as then return end

ar._collapsed=as


local au=ar._brand and ar._brand:FindFirstChild"Brand"
local av=au and au:FindFirstChild"Text"
if av then
av.Visible=not as
end

ar._tooltip.Visible=false
ar:_closePopover()

local aw=f
local ax=0
if as then
aw=i
ax=1
end

ad.Tween(ar._sidebar,{Size=UDim2.new(0,aw,1,0)},E)
ar._main.Position=UDim2.fromOffset(aw,0)
ar._main.Size=UDim2.new(1,-aw,1,0)

for ay,az in ipairs(ar._groups)do
local aA=az._label
if aA then
local aB=H
if as then aB=0 end
ad.Tween(aA,{
TextTransparency=0.3+0.7*ax,
Size=UDim2.new(1,0,0,aB),
},E)
end
end

for ay,az in ipairs(ar._tabs)do
ad.Tween(az._label,{TextTransparency=ax},E)
if az._iconless then
az._icon.Visible=as
end
if az._badge:IsA"TextLabel"then
az._badge.Visible=not as and az._badge.Text~=""
else
az._badge.Visible=not as
end
end

if ar._footerText then
ar._footerText.Visible=not as
end
if ar._footerChevron then
ar._footerChevron.Visible=not as
end
end

function F._openPopover(ar,as,at,au,av)
ar:_closePopover()
as.Parent=ar._overlay
ar._popover={
panel=as,
anchor=at,
onClose=au,
placement=av or"bottom",
}
ar:_placePopover()
end

function F._closePopover(ar)
local as=ar._popover
if not as then return end
ar._popover=nil
as.panel.Parent=nil
if as.onClose then
task.spawn(as.onClose)
end
end

function F._placePopover(ar)
local as=ar._popover
if not as then return end

local at,au=as.anchor,as.panel
if not at:IsDescendantOf(ar.Instance)or not at.Visible or not ar._visible then
ar:_closePopover()
return
end

local av=workspace.CurrentCamera
local aw=Vector2.new(1920,1080)
if av then aw=av.ViewportSize end

local ax=at.AbsolutePosition
local ay=at.AbsoluteSize
local az=au.AbsoluteSize
local aA,aB

if as.placement=="top"then
aA=ax.X
aB=ax.Y-4-az.Y
elseif as.placement=="topRight"then
aA=ax.X+ay.X-az.X
aB=ax.Y-4-az.Y
elseif as.placement=="right"then
aA=ax.X+ay.X+8
aB=ax.Y+ay.Y-az.Y
else
aB=ax.Y+ay.Y+4
if aB+az.Y>aw.Y-8 and ax.Y-4-az.Y>8 then
aB=ax.Y-4-az.Y
end
aA=ax.X+ay.X-az.X
end

local aC=ar._overlay.AbsolutePosition
aA=math.clamp(aA,8,math.max(8,aw.X-az.X-8))-aC.X
aB=math.clamp(aB,8+aC.Y,math.max(8+aC.Y,aw.Y+aC.Y-az.Y-8))-aC.Y

au.Position=UDim2.fromOffset(aA,aB)
end

function F.Dialog(ar,as)
if not ar._visible then ar:SetVisible(true)end
return al.open(ar,as)
end

function F.Confirm(ar,as)
local at=coroutine.running()
local au=false
local av=table.clone(as)
av.Buttons=nil
av.OnClose=function(aw)
if au then return end
au=true
task.spawn(at,aw==2)
end
ar:Dialog(av)
return coroutine.yield()
end

function F._toggleZoom(ar)
ar._zoom()
end

function F.SetGlass(ar,as)
as=as==true
if ar._glassOn==as then return end
ar._glassOn=as

local at=0
if as then
at=0.15
if ad.Mode~="Dark"then
at=0.2
end
ar._root.BackgroundTransparency=1
else
ar._root.BackgroundTransparency=0
end

ar._surface.Visible=as
ar._sidebarBody.BackgroundTransparency=at

for au,av in ipairs(ar._tabs)do
ar:_paintTab(av,false)
end

if as and not ar._acrylic then
ar._acrylic=am.new(ar._maid,ar._sidebar,{Right=true})
if ar._acrylic then
ar._acrylic.SetVisible(ar._visible)
end
elseif not as and ar._acrylic then
ar._acrylic.Destroy()
ar._acrylic=nil
end
end

function F._initBackgroundAnimation(ar,as)
local at=ar._root
if not at then return end

local au=d("Frame",{
Name="BackgroundAnimation",
BackgroundTransparency=1,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.fromScale(1,1),
ZIndex=1,
Parent=at,
},{af.Corner(ad.Radius.Xl)})

local av=d("Frame",{
Name="AuroraLayer",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=1,
Parent=au,
})

local aw=d("Frame",{
Name="TopSheen",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0),
Position=UDim2.fromScale(0.5,-5E-2),
Size=UDim2.fromScale(1.4,0.65),
ZIndex=1,
Parent=av,
})
local ax=d("UIGradient",{
Rotation=90,
Parent=aw,
})

local ay=d("Frame",{
Name="PrimaryRibbon",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.32,0.24),
Size=UDim2.fromScale(1.65,1.65),
ZIndex=1,
Parent=av,
})
local az=d("UIGradient",{
Rotation=-24,
Parent=ay,
})

local aA=d("Frame",{
Name="SecondaryRibbon",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.68,0.72),
Size=UDim2.fromScale(1.55,1.55),
ZIndex=1,
Parent=av,
})
local aB=d("UIGradient",{
Rotation=32,
Parent=aA,
})

local aC=d("Frame",{
Name="CurtainRibbon",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.45),
Size=UDim2.fromScale(1.5,1.5),
ZIndex=1,
Parent=av,
})
local aD=d("UIGradient",{
Rotation=8,
Parent=aC,
})

local aE=d("Frame",{
Name="GridLayer",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Visible=false,
ZIndex=1,
Parent=au,
})

local aF=false
local aG={}
local function ensureGrid()
if aF then return end
aF=true
local aH,aI=14,8
for aJ=1,aI do
for aK=1,aH do
local aL=d("Frame",{
Name="Dot",
BackgroundColor3=e.Foreground,
BackgroundTransparency=0.94,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale((aK-0.5)/aH,(aJ-0.5)/aI),
Size=UDim2.fromOffset(2,2),
ZIndex=1,
Parent=aE,
},{af.Corner(999)})
table.insert(aG,aL)
end
end
end

local function applyPalette(aH)
local aI=af.AuroraPalette(aH)
local aJ=ar._auroraIntensity or 1
local function scale(aK)
return af.ScaleAuroraAlpha(aK,aJ)
end

aw.BackgroundColor3=aI.topColor
ax.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,scale(aI.topAlpha)),
NumberSequenceKeypoint.new(0.45,scale(0.962)),
NumberSequenceKeypoint.new(1,1),
}

ay.BackgroundColor3=Color3.new(1,1,1)
az.Color=aI.primarySeq
az.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.22,scale(0.945)),
NumberSequenceKeypoint.new(0.5,scale(if aI.isDark then 0.77 else 0.85)),
NumberSequenceKeypoint.new(0.78,scale(0.945)),
NumberSequenceKeypoint.new(1,1),
}

aA.BackgroundColor3=Color3.new(1,1,1)
aB.Color=aI.secondarySeq
aB.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.24,scale(0.955)),
NumberSequenceKeypoint.new(0.5,scale(if aI.isDark then 0.81 else 0.88)),
NumberSequenceKeypoint.new(0.76,scale(0.955)),
NumberSequenceKeypoint.new(1,1),
}

aC.BackgroundColor3=Color3.new(1,1,1)
aD.Color=aI.curtainSeq
aD.Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,scale(0.968)),
NumberSequenceKeypoint.new(0.5,scale(if aI.isDark then 0.85 else 0.90)),
NumberSequenceKeypoint.new(0.75,scale(0.968)),
NumberSequenceKeypoint.new(1,1),
}

local aK=if aI.isDark then 0.935 else 0.92
for aL,aM in ipairs(aG)do
aM.BackgroundTransparency=aK
end
end

ar._auroraIntensity=1
ar._refreshAuroraPalette=function()
applyPalette(ad.Current)
end

applyPalette(ad.Current)
ar._maid:Give(ar.Library.ThemeChanged:Connect(applyPalette))

ar._bgLayer=au
ar._auroraLayer=av
ar._auroraEnabled=true
ar._gridEnabled=false

local aH=0
local aI,aJ=0,0
ar._maid:Give(ac.Heartbeat:Connect(function(aK)
if ar._destroyed or not ar._visible or not ar._auroraEnabled or not at.Parent then
return
end
aH+=math.min(aK,0.05)

local aL,aM=0,0
local aN=at.AbsolutePosition
local aO=at.AbsoluteSize
if aO.X>0 and aO.Y>0 then
local aP=ab:GetMouseLocation()
local aQ=(aP.X-aN.X)/aO.X
local aR=(aP.Y-aN.Y)/aO.Y
if aQ>=0 and aQ<=1 and aR>=0 and aR<=1 then
aL=(aQ-0.5)*2
aM=(aR-0.5)*2
end
end

local aP=math.min(aK*3.5,1)
aI+=(aL-aI)*aP
aJ+=(aM-aJ)*aP

ay.Position=UDim2.fromScale(
0.32+math.sin(aH*0.23)*0.14+aI*0.035,
0.24+math.cos(aH*0.17)*0.10+aJ*0.035
)
az.Rotation=-24+math.sin(aH*0.19)*18

aA.Position=UDim2.fromScale(
0.68+math.cos(aH*0.21)*0.14-aI*0.025,
0.72+math.sin(aH*0.15)*0.10-aJ*0.025
)
aB.Rotation=32+math.cos(aH*0.16)*20

aC.Position=UDim2.fromScale(
0.50+math.sin(aH*0.14+1.2)*0.12+aI*0.02,
0.46+math.cos(aH*0.18+0.7)*0.12+aJ*0.02
)
aD.Rotation=8+math.sin(aH*0.13)*24
end))

ar._setGridEnabled=function(aK)
if aK then
ensureGrid()
applyPalette(ad.Current)
end
aE.Visible=aK
end

ar._syncBackgroundLayers=function()
av.Visible=ar._auroraEnabled==true
if ar._setGridEnabled then
ar._setGridEnabled(ar._gridEnabled==true)
end
au.Visible=ar._auroraEnabled==true or ar._gridEnabled==true
af.SetAuroraEnabled(ar._auroraEnabled==true)
end

ar:SetBackgroundAnimation(if as==nil then"Aurora"else as)
end

function F.SetAurora(ar,as)
ar._auroraEnabled=as~=false
if ar._syncBackgroundLayers then
ar._syncBackgroundLayers()
end
end

function F.SetAuroraIntensity(ar,as)
local at=tonumber(as)or 1
if at>2 then
at=at/100
end
ar._auroraIntensity=math.clamp(at,0,2)
af.SetAuroraIntensity(ar._auroraIntensity)
if ar._refreshAuroraPalette then
ar._refreshAuroraPalette()
end
end

function F.SetGrid(ar,as)
ar._gridEnabled=as==true
if ar._syncBackgroundLayers then
ar._syncBackgroundLayers()
end
end

function F.SetBackgroundAnimation(ar,as)
if not ar._bgLayer then return end
if as==false or as=="None"or as=="Off"then
ar._auroraEnabled=false
ar._gridEnabled=false
elseif as=="Grid"then
ar._auroraEnabled=true
ar._gridEnabled=true
else
ar._auroraEnabled=true
ar._gridEnabled=false
end
if ar._syncBackgroundLayers then
ar._syncBackgroundLayers()
end
end

function F.SetVisible(ar,as)
if ar._destroyed or ar._visible==as then return end

if not as then
ar:_closePopover()
ar._tooltip.Visible=false
end

ar._visible=as
ar._holder.Visible=as

if as then
ar._scale.Scale=0.96*ar._fit
ad.Tween(ar._scale,{Scale=ar._fit},
TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out))
end

if ar._island then
ar._island:SetShown(not as)
end
if ar._acrylic then
ar._acrylic.SetVisible(as)
end

ar.VisibilityChanged:Fire(as)
end

function F.Destroy(ar,as)
if ar._destroyed then return end
ar._destroyed=true

ar.Closing:Fire(as or"Destroy")

if ar.Config then
ar.Config:Save()
end

ar._maid:Destroy()
ar.Closing:Destroy()
ad.Prune()
ar.Library:_forget(ar)
end

return F
end

function a.t()
local aa=a.cache.window
if not aa then
aa={class=WindowFactory()}
a.cache.window=aa
end
return aa.class
end
end




do
local function ToastFactory()
local aa=game:GetService"UserInputService"
local ab=game:GetService"RunService"
local ac=a.Theme()
local ad=a.Fonts()
local ae=a.Icons()
local af=a.Creator()
local ag=a.h()

local ah=af.Create
local ai=ac.Token

local aj=360
local ak=16
local al=12
local am=3
local an=5
local ao=5
local ap=48
local aq=8
local ar=TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
local as=TweenInfo.new(0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)

local at={
Success={icon="circle-check",color="Foreground"},
Info={icon="info",color="Foreground"},
Warning={icon="alert-circle",color="Foreground"},
Error={icon="circle-x",color="Destructive"},
Loading={icon="arrowTriangle2Circlepath",color="Foreground"},
}

local au={}
au.__index=au

function au.new(av,aw)
local ax=setmetatable({
_maid=av,
_themeChanged=aw,
_toasts={},
_hovered=false,
_nextId=0,
_hitHeight=0,
_layoutQueued=false,
},au)

local ay=av:Give(ah("ScreenGui",{
Name="shadcn-toasts",
ResetOnSpawn=false,
IgnoreGuiInset=true,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
DisplayOrder=200,
}))
ax._gui=ay

ax._viewport=ah("Frame",{
Name="Viewport",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(1,1),
Position=UDim2.new(1,-ak,1,-ak),
Size=UDim2.fromOffset(aj,0),
Parent=ay,
})
ay.Parent=af.GuiParent()
ax.Instance=ay

av:Connect(ab.RenderStepped,function(az)
ax:_step(az)
end)

return ax
end



function au._inside(av)
if aa.TouchEnabled and not aa.MouseEnabled then
return false
end
if av._hitHeight<=0 then return false end

local aw=av._gui.AbsoluteSize
if aw.X<=0 or aw.Y<=0 then return false end

local ax=aa:GetMouseLocation()
local ay=if av._hovered then aq else 0

local az=aw.X-ak+ay
local aA=aw.X-ak-aj-ay
local aB=aw.Y-ak+ay
local aC=aw.Y-ak-av._hitHeight-ay

return ax.X>=aA and ax.X<=az
and ax.Y>=aC and ax.Y<=aB
end

function au._scheduleLayout(av)
if av._layoutQueued then return end
av._layoutQueued=true
task.defer(function()
av._layoutQueued=false
av:_layout()
end)
end

function au._step(av,aw)
if#av._toasts==0 then
av._hovered=false
return
end

local ax=av:_inside()
if ax~=av._hovered then
av._hovered=ax
av:_layout()
end
if ax then return end

for ay,az in ipairs(table.clone(av._toasts))do
if not az.leaving and az.remaining then
az.remaining-=aw
if az.remaining<=0 then
av:_remove(az)
end
end
end
end


local function measureNatural(av)
local aw=av.scale.Scale
if aw>0.5 then
local ax=av.content.AbsoluteSize.Y/aw
if ax>0 then
av.natural=math.max(ax,ap)
end
end
return av.natural or ap
end

local function setFaded(av,aw)
if av.faded==aw then return end
av.faded=aw
ac.Tween(av.title,{TextTransparency=aw},as)
ac.Tween(av.description,{TextTransparency=aw},as)
ac.Tween(av.icon,{ImageTransparency=aw},as)
local ax=aw<1
if av.action then
av.action.Visible=ax
end
av.closeVisible=ax
if av.updateClose then av.updateClose()end
end

function au._layout(av)
local aw={}
for ax,ay in ipairs(av._toasts)do
if not ay.leaving then
table.insert(aw,ay)
end
end

local ax=aw[1]
if not ax then
av._hitHeight=0
av._hovered=false
return
end

local ay=measureNatural(ax)
local az=av._hovered
local aA=0

for aB,aC in ipairs(aw)do
local aD=aB-1
local aE,aF,aG,aH

if az then
aE=measureNatural(aC)
aF=-aA
aG=1
aH=0
aA+=aE+al
else
aG=math.max(0,1-aD*0.1)
aE=ay
aF=-(aD*an)-(1-aG)*ay
aH=if aD>0 then 1 else 0
end

aC.frame.ZIndex=1000-aD
ac.Tween(aC.frame,{
Position=UDim2.new(0.5,0,1,aF),
Size=UDim2.new(1,0,0,aE),
},ar)
ac.Tween(aC.scale,{Scale=aG},ar)
setFaded(aC,aH)
end

local aB
if az then
aB=math.max(aA-al,ay)
av._hitHeight=aB
else
aB=ay

av._hitHeight=ay+(math.min(#aw,am)-1)*an
end
av._viewport.Size=UDim2.fromOffset(aj,aB)
end

function au._remove(av,aw)
if aw.leaving then return end
aw.leaving=true

ac.Tween(
aw.frame,
{Position=aw.frame.Position+UDim2.fromOffset(0,aw.frame.AbsoluteSize.Y*1.5+ak)},
ar
)
setFaded(aw,1)
ac.Tween(aw.card,{BackgroundTransparency=1},ar)

task.delay(0.35,function()
local ax=table.find(av._toasts,aw)
if ax then
table.remove(av._toasts,ax)
end
aw.maid:Destroy()
end)

av:_layout()

if aw.onClose then
task.spawn(aw.onClose)
end
end

function au._fill(av,aw,ax)
local ay=at[ax.Type or""]
if aw.spin then
aw.spin:Cancel()
aw.spin=nil
end
aw.icon.Visible=false

local az=ae.Get(ax.Icon)
if az and not ay then
ay={icon=ax.Icon,color="Foreground"}
end

if ay then
local aA=az or ae.Get(ay.icon)
if aA then
aw.icon.Image=aA
aw.icon.Visible=true
aw.icon.Rotation=0
ac.Bind(aw.icon,"ImageColor3",ay.color)
if ax.Type=="Loading"then
aw.spin=ac.Tween(
aw.icon,
{Rotation=360},
TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,-1)
)
end
end
end

aw.title.Text=ax.Title or""
aw.description.Text=ax.Description or""
aw.description.Visible=(ax.Description or"")~=""

if aw.action then
aw.action:Destroy()
aw.action=nil
end

local aA=ax.Action
if aA then
local aB=ag.new(aw.maid,{
Title=aA.Title or"Undo",
Variant="Outline",
Size="Sm",
LayoutOrder=3,
Callback=function()
if aA.Callback then
task.spawn(aA.Callback)
end
av:_remove(aw)
end,
})
aB.Size=UDim2.fromOffset(aB.Size.X.Offset,28)
aB.Parent=aw.row
aw.action=aB
end

local aB=ax.Duration
if aB==nil then aB=ao end
if ax.Type=="Loading"or aB==math.huge or aB<=0 then
aw.remaining=nil
else
aw.remaining=aB
end
end

function au.Add(av,aw)
local ax
if type(aw)=="string"then
ax={Title=aw}
else
ax=aw or{}
end

av._nextId+=1
local ay=av._maid:Sub()

local az={
id=av._nextId,
maid=ay,
leaving=false,
onClose=ax.OnClose,
closeVisible=true,
}

az.frame=ay:Give(ah("Frame",{
Name="Toast",
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,1),
Position=UDim2.new(0.5,0,1,160),
Size=UDim2.new(1,0,0,64),
Parent=av._viewport,
}))
az.scale=ah("UIScale",{Parent=az.frame})

local aA=af.Stroke(ai.Foreground)
local aB=ah("Frame",{
Name="Card",
BackgroundColor3=ai.Popover,
BackgroundTransparency=0.06,
BorderSizePixel=0,
ClipsDescendants=true,
Size=UDim2.fromScale(1,1),
ZIndex=2,
Parent=az.frame,
},{af.Corner(ac.Radius.Xxl),aA})
af.ApplyGlassStroke(aA,ay,av._themeChanged)
az.card=aB

af.AttachAurora(aB,ay,{
Radius=ac.Radius.Xxl,
ZIndex=2,
Phase=(av._nextId%7)*1.3,
ThemeChanged=av._themeChanged,
})

az.fade=ah("Frame",{
Name="Fade",
BackgroundTransparency=1,
ClipsDescendants=true,
Size=UDim2.fromScale(1,1),
ZIndex=3,
Parent=aB,
})

local aC=ah("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ZIndex=2,
Parent=az.fade,
},{af.Padding(16)})
az.content=aC

local aD=ah("Frame",{
Name="Row",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
ZIndex=2,
Parent=aC,
},{
ah("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,12),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})
az.row=aD

az.icon=ah("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Size=UDim2.fromOffset(20,20),
LayoutOrder=1,
Visible=false,
ZIndex=3,
Parent=aD,
})

local aE=ah("Frame",{
Name="Text",
BackgroundTransparency=1,
Size=UDim2.new(1,-110,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
LayoutOrder=2,
ZIndex=2,
Parent=aD,
},{ah("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill}),af.List(4)})

az.title=af.Text{
Name="Title",
Text="",
TextColor3=ai.Foreground,
FontFace=ad.Medium,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,18),
LayoutOrder=1,
ZIndex=3,
Parent=aE,
}

az.description=af.Text{
Name="Description",
Text="",
TextColor3=ai.MutedForeground,
TextWrapped=true,
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,18),
LayoutOrder=2,
ZIndex=3,
Parent=aE,
}


local aF,aG=ah("TextButton",{
Name="Close",
Text="",
AutoButtonColor=false,
BackgroundColor3=ai.Popover,
BackgroundTransparency=1,
BorderSizePixel=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromOffset(6,6),
Size=UDim2.fromOffset(20,20),
Visible=false,
ZIndex=6,
Parent=az.frame,
},{ah("UICorner",{CornerRadius=UDim.new(1,0)})}),af.Stroke(ai.Border)
aG.Transparency=1
aG.Parent=aF

local aH=ah("ImageLabel",{
Name="Glyph",
BackgroundTransparency=1,
Image=ae.Get"x"or"",
ImageColor3=ai.MutedForeground,
ImageTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(10,10),
ZIndex=7,
Parent=aF,
})
local aI=ah("UIScale",{Scale=0.6,Parent=aF})
local aJ=TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

local aK,aL=false,false
local aM=false

local function updateClose()
local aN=(aK or aL)and az.closeVisible~=false and not az.leaving
if aN==aM then return end
aM=aN

if aN then
aF.Visible=true
ac.Tween(aF,{BackgroundTransparency=0},as)
ac.Tween(aG,{Transparency=0},as)
ac.Tween(aH,{ImageTransparency=0},as)
ac.Tween(aI,{Scale=1},aJ)
else
ac.Tween(aF,{BackgroundTransparency=1},as)
ac.Tween(aG,{Transparency=1},as)
ac.Tween(aH,{ImageTransparency=1},as)
ac.Tween(aI,{Scale=0.6},as)
task.delay(as.Time,function()
if not aM and aF.Parent then
aF.Visible=false
end
end)
end
end
az.updateClose=updateClose

ay:Connect(aB.MouseEnter,function()aK=true;updateClose()end)
ay:Connect(aB.MouseLeave,function()aK=false;updateClose()end)
ay:Connect(aF.MouseEnter,function()
aL=true
updateClose()
ac.Rebind(aH,"ImageColor3","Destructive")
ac.Rebind(aG,"Color","Destructive")
end)
ay:Connect(aF.MouseLeave,function()
aL=false
updateClose()
ac.Rebind(aH,"ImageColor3","MutedForeground")
ac.Rebind(aG,"Color","Border")
end)
ay:Connect(aF.MouseButton1Down,function()
ac.Tween(aI,{Scale=0.85},as)
end)
ay:Connect(aF.MouseButton1Click,function()
av:_remove(az)
end)



ay:Connect(aC:GetPropertyChangedSignal"AbsoluteSize",function()
local aN=az.scale.Scale
if aN<=0.5 then return end
local aO=math.max(aC.AbsoluteSize.Y/aN,ap)
if not az.natural or math.abs(aO-az.natural)>1 then
az.natural=aO
av:_scheduleLayout()
end
end)

av:_fill(az,ax)
table.insert(av._toasts,1,az)


local aN=0
for aO,aP in ipairs(table.clone(av._toasts))do
if not aP.leaving then
aN+=1
if aN>am then
av:_remove(aP)
end
end
end

av:_scheduleLayout()


local aO={}
function aO.Update(aP,aQ)
if az.leaving then return end
local aR=if aP==aO then aQ else aP
local aS
if type(aR)=="string"then
aS={Title=aR}
else
aS=aR or{}
end
av:_fill(az,aS)
av:_scheduleLayout()
end
function aO.Close()
av:_remove(az)
end
return aO
end

function au.Promise(av,aw,ax)
local function resolve(ay,az)
if type(ay)=="function"then
return ay(az)
end
return ay
end

local ay=av:Add{
Title=resolve(ax.Loading,nil)or"Loading",
Type="Loading",
Description=ax.Description,
}

task.spawn(function()
local az,aA=pcall(aw)
if az then
ay.Update{Title=resolve(ax.Success,aA)or"Done",Type="Success"}
else
ay.Update{
Title=resolve(ax.Error,aA)or"Failed",
Type="Error",
Description=tostring(aA),
}
end
end)
return ay
end

function au.Clear(av)
for aw,ax in ipairs(table.clone(av._toasts))do
av:_remove(ax)
end
end

return au
end

function a.u()
local aa=a.cache.toast
if not aa then
aa={class=ToastFactory()}
a.cache.toast=aa
end
return aa.class
end
end
end



local aa=a.Maid()
local ab=a.Theme()
local ac=a.Fonts()
local ad=a.Icons()
local ae=a.Creator()
local af=a.t()
local ag=a.u()
local ah=a.g()

local ai="__shadcn.Theme"
local aj="__shadcn.Accent"
local ak="__shadcn.Colors"
local al="__shadcn.RandomColors"


local am={"Primary","PrimaryForeground","Ring","SidebarPrimary","SidebarPrimaryForeground"}

local an={
Version="0.1.0",
Themes=ab.Themes,
Accents=ab.Accents,
Fonts=ac,
Create=ae.Create,
Token=ab.Token,
Windows={},
Unloading=ah.new(),
}

local ao=aa.new()

an.ThemeChanged=ah.new()
an.Features={ConfigStore=true}

an.ThemeTokens={
{
Title="Surfaces",
Tokens={"Background","Card","Popover","Muted","Accent","Secondary","Border","Input"},
},
{
Title="Text",
Tokens={"Foreground","MutedForeground","CardForeground","AccentForeground","SecondaryForeground"},
},
{
Title="Brand",
Tokens={"Primary","PrimaryForeground","Ring","Destructive","DestructiveForeground","SwitchThumb"},
},
{
Title="Sidebar",
Tokens={
"Sidebar","SidebarForeground","SidebarAccent",
"SidebarBorder","SidebarPrimary","SidebarPrimaryForeground",
},
},
}


local function persistTheme()
for ap,aq in ipairs(an.Windows)do
aq:SetFlag(ai,ab.Mode)
aq:SetFlag(aj,ab.Accent)
aq:SetFlag(ak,table.clone(ab.Overrides))
aq:SetFlag(al,table.clone(ab.RandomKeys))
end
end

local function rebuildTheme(ap)
ab.Apply(ab.Build(),ap)
persistTheme()
an.ThemeChanged:Fire(ab.Current)
end

function an.CreateWindow(ap,aq)
local ar=aq or{}
local as=ao:Sub()

ac.Load(ar.Font)

if ar.IconSet=="SF"or ar.IconSet=="Lucide"then
ad.Set=ar.IconSet
end

ar.BeforeBuild=function(at)
ab.Defaults={Mode=ar.Theme or"Dark",Accent=ar.Accent or"Default"}
ab.Mode=at:GetFlag(ai,ar.Theme or ab.Mode)
ab.Accent=at:GetFlag(aj,ar.Accent or ab.Accent)

local au={}
if type(ar.Palette)=="table"then
for av,aw in pairs(ar.Palette)do
if ab.Themes[av]and type(aw)=="table"then
au[av]={}
for ax,ay in pairs(aw)do
if typeof(ay)=="Color3"and ab.Themes.Dark[ax]then
au[av][ax]=ay
end
end
end
end
end
ab.Palette=au

local av=at:GetFlag(ak,nil)
local aw={}
if type(av)=="table"then
for ax,ay in pairs(av)do
if typeof(ay)=="Color3"and ab.Themes.Dark[ax]then
aw[ax]=ay
end
end
end
ab.Overrides=aw

local ax=at:GetFlag(al,nil)
local ay={}
if type(ax)=="table"then
for az,aA in pairs(ax)do
if aA and aw[az]~=nil then
ay[az]=true
end
end
end
ab.RandomKeys=ay

ab.Apply(ab.Build())
end

local at=af.new(an,as,ar)
table.insert(an.Windows,at)
return at
end

function an._forget(ap,aq)
local ar=table.find(an.Windows,aq)
if ar then
table.remove(an.Windows,ar)
end
end

function an.SetTheme(ap,aq)
if type(aq)=="string"then
if not ab.Themes[aq]then return end
ab.Mode=aq


for ar in pairs(ab.RandomKeys)do
ab.Overrides[ar]=nil
end
ab.RandomKeys={}
else
local ar={}
for as,at in pairs(aq)do
if as=="Base"then
ab.Mode=at
elseif typeof(at)=="Color3"then
ar[as]=at
end
end
ab.Overrides=ar
ab.RandomKeys={}
end
rebuildTheme()
end

function an.SetAccent(ap,aq,ar)
if type(aq)=="string"and not ab.Accents[aq]then
return
end

for as,at in ipairs(am)do
ab.Overrides[at]=nil
ab.RandomKeys[at]=nil
end
ab.Accent=aq
rebuildTheme(ar)
end

function an.SetColor(ap,aq,ar,as)
if not ab.Themes.Dark[aq]or typeof(ar)~="Color3"then
return
end
ab.Overrides[aq]=ar
ab.RandomKeys[aq]=nil
rebuildTheme(as)
end

function an.ResetColor(ap,aq)
if aq then
ab.Overrides[aq]=nil
ab.RandomKeys[aq]=nil
else
ab.Overrides={}
ab.RandomKeys={}
end
rebuildTheme()
end

function an.ResetTheme(ap)
ab.Mode=ab.Defaults.Mode
ab.Accent=ab.Defaults.Accent
ab.Overrides={}
ab.RandomKeys={}
rebuildTheme()
end

function an.DefaultColor(ap,aq)
local ar=ab.Overrides
ab.Overrides={}
local as=ab.Build()
ab.Overrides=ar
return as[aq]
end

function an.RandomTheme(ap,aq)
local ar=(aq or ab.Mode)=="Dark"
local as=math.random()
local at=0.55+math.random()*0.3

local function hsv(au,av)
return Color3.fromHSV(as,math.clamp(au,0,1),math.clamp(av or 1,0,1))
end

local function contrastFor(au)
local av=0.2126*au.R+0.7152*au.G+0.0722*au.B
if av>0.55 then
return Color3.fromHex"0a0a0c"
end
return Color3.fromHex"fafafa"
end

local au={}
if ar then
local av=hsv(at,0.72+math.random()*0.18)
au.Background=hsv(0.25,0.07)
au.Sidebar=hsv(0.22,0.095)
au.Card=hsv(0.22,0.105)
au.Popover=hsv(0.2,0.125)
au.Muted=hsv(0.18,0.17)
au.Accent=au.Muted
au.Secondary=au.Muted
au.SidebarAccent=hsv(0.18,0.16)
au.Border=hsv(0.15,0.21)
au.Input=au.Border
au.SidebarBorder=au.Border
au.Foreground=hsv(0.05,0.87)
au.MutedForeground=hsv(0.08,0.58)
au.Primary=av
au.SidebarPrimary=hsv(at*0.85,0.95)
au.Ring=hsv(at*0.5,0.55)
au.SwitchThumb=au.Foreground
else
local av=hsv(at,0.55+math.random()*0.15)
au.Background=hsv(0.04,0.96)
au.Sidebar=hsv(0.06,0.935)
au.Card=hsv(0.03,0.985)
au.Popover=au.Card
au.Muted=hsv(0.06,0.91)
au.Accent=au.Muted
au.Secondary=au.Muted
au.SidebarAccent=hsv(0.08,0.88)
au.Border=hsv(0.08,0.85)
au.Input=au.Border
au.SidebarBorder=au.Border
au.Foreground=hsv(0.3,0.13)
au.MutedForeground=hsv(0.1,0.45)
au.Primary=av
au.SidebarPrimary=hsv(at,0.62)
au.Ring=av
au.SwitchThumb=Color3.new(1,1,1)
end

au.CardForeground=au.Foreground
au.AccentForeground=au.Foreground
au.SecondaryForeground=au.Foreground
au.SidebarForeground=au.Foreground
au.PrimaryForeground=contrastFor(au.Primary)
au.SidebarPrimaryForeground=contrastFor(au.SidebarPrimary)

if aq and ab.Themes[aq]then
ab.Mode=aq
end
ab.Accent=au.Primary
ab.Overrides=au
ab.RandomKeys={}
for av in pairs(au)do
ab.RandomKeys[av]=true
end
rebuildTheme()
return as
end

function an._applySavedTheme(ap,aq)
if type(aq)~="table"then return end
if type(aq.Theme)=="string"and ab.Themes[aq.Theme]then
ab.Mode=aq.Theme
end
if typeof(aq.Accent)=="Color3"
or(type(aq.Accent)=="string"and ab.Accents[aq.Accent])then
ab.Accent=aq.Accent
end
local ar={}
if type(aq.Colors)=="table"then
for as,at in pairs(aq.Colors)do
if typeof(at)=="Color3"and ab.Themes.Dark[as]then
ar[as]=at
end
end
end
ab.Overrides=ar
ab.RandomKeys={}
rebuildTheme()
end

function an.ExportTheme(ap)
local aq={}
for ar,as in pairs(ab.Overrides)do
aq[ar]="#"..string.upper(as:ToHex())
end
local ar=ab.Accent
if typeof(ar)=="Color3"then
ar="#"..string.upper(ar:ToHex())
end
return game:GetService"HttpService":JSONEncode{
Mode=ab.Mode,
Accent=ar,
Colors=aq,
}
end

function an.ImportTheme(ap,aq)
local ar,as=pcall(function()
return game:GetService"HttpService":JSONDecode(aq)
end)
if not ar or type(as)~="table"then
return false
end

if type(as.Mode)=="string"and ab.Themes[as.Mode]then
ab.Mode=as.Mode
end
if type(as.Accent)=="string"then
if ab.Accents[as.Accent]then
ab.Accent=as.Accent
elseif string.match(as.Accent,"^#?%x%x%x%x%x%x$")then
ab.Accent=Color3.fromHex((string.gsub(as.Accent,"#","")))
end
end
local at={}
if type(as.Colors)=="table"then
for au,av in pairs(as.Colors)do
if ab.Themes.Dark[au]and type(av)=="string"
and string.match(av,"^#?%x%x%x%x%x%x$")then
at[au]=Color3.fromHex((string.gsub(av,"#","")))
end
end
end
ab.Overrides=at
ab.RandomKeys={}
rebuildTheme()
return true
end

function an.AddTheme(ap,aq,ar,as)
local at=table.clone(ab.Themes[as or"Dark"]or ab.Themes.Dark)
for au,av in pairs(ar)do
at[au]=av
end
ab.Themes[aq]=at
end

function an.GetColor(ap,aq)
return ab.Color(aq)
end

function an.Icon(ap,aq)
return ad.Get(aq)
end

function an.Gif(ap,aq)
return ad.GetGif(aq)
end

function an.LoadIcons(ap,aq)
return ad.Load(aq)
end

local ap
local function getToast()
if not ap then
ap=ag.new(ao,an.ThemeChanged)
end
return ap
end

local function announceIsland(aq)
local ar,as=aq
if type(aq)=="table"then
ar,as=aq.Title,aq.Type
end
for at,au in ipairs(an.Windows)do
if au._island and not au._visible then
au._island:Announce(tostring(ar or""),as)
end
end
end

function an.Toast(aq,ar)
announceIsland(ar)
return getToast():Add(ar)
end

function an.Notify(aq,ar)
announceIsland(ar)
return getToast():Add(ar)
end

function an.Promise(aq,ar,as)
return getToast():Promise(ar,as)
end


setmetatable(an,{
__index=function(aq,ar)
if ar=="IconsUrl"then return ad.Url end
if ar=="FontsUrl"then return ac.Url end
if ar=="SFIconsUrl"then return ad.SFUrl end
if ar=="IconSet"then return ad.Set end
if ar=="GifEndpoint"then return ad.GifEndpoint end
return nil
end,
__newindex=function(aq,ar,as)
if ar=="IconsUrl"then
ad.Url=as
elseif ar=="SFIconsUrl"then
ad.SFUrl=as
elseif ar=="IconSet"then
ad.Set=as
elseif ar=="FontsUrl"then
ac.Url=as
elseif ar=="GifEndpoint"then
ad.GifEndpoint=as
else
rawset(aq,ar,as)
end
end,
})

local aq=false
function an.Unload(ar)
if aq then return end
aq=true

an.Unloading:Fire()
for as=#an.Windows,1,-1 do
an.Windows[as]:Destroy"Unload"
end
aq=false

an.ThemeChanged:DisconnectAll()
ao:Clean()
ap=nil
ab.Reset()
ad.Reset()
ac.Reset()
end

function an._maidCount(ar)
return ao:Count()
end

return an
