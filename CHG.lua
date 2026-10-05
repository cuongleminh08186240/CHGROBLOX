local CHG_INTRO_SOURCE = [=[

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local ASSET_LOGO = "rbxassetid://133842491002442"
local TELEGRAM_LINK = "https://t.me/CHGPINGPRX"

-- Auto-copy Telegram link to clipboard
if setclipboard then
    pcall(function()
        setclipboard(TELEGRAM_LINK)
    end)
end

-- ScreenGui Setup (Supports Executor Parent Safeguards)
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiParent = (gethui and gethui()) or (syn and syn.protect_gui and PlayerGui) or PlayerGui

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CHGHubIntro"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

-- Fullscreen Background Dim/Blur
local DarkOverlay = Instance.new("Frame")
DarkOverlay.Name = "DarkOverlay"
DarkOverlay.Size = UDim2.fromScale(1, 1)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DarkOverlay.BackgroundTransparency = 1
DarkOverlay.Parent = ScreenGui

-- Central Card Frame
local Card = Instance.new("Frame")
Card.Name = "Card"
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.fromScale(0.5, 0.54) -- Slightly lower for smooth pop-up tween
Card.Size = UDim2.fromOffset(360, 220)
Card.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
Card.BackgroundTransparency = 1
Card.ClipsDescendants = true
Card.Parent = ScreenGui

-- Strong black/white background sweep for the loading card.
-- A broad WHITE band enters from the RIGHT, crosses the whole loading background,
-- leaves to the LEFT, the background becomes BLACK again, and the cycle repeats forever.
local LoadingBgGradient = Instance.new("UIGradient")
LoadingBgGradient.Name = "LoadingBlackWhiteSweep"
LoadingBgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.28, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(70, 70, 70)),
    ColorSequenceKeypoint.new(0.46, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.54, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(70, 70, 70)),
    ColorSequenceKeypoint.new(0.72, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
})
LoadingBgGradient.Rotation = 0
LoadingBgGradient.Offset = Vector2.new(1.35, 0)
LoadingBgGradient.Parent = Card

task.spawn(function()
    while ScreenGui.Parent and Card.Parent do
        -- Start with a completely dark loading background.
        LoadingBgGradient.Offset = Vector2.new(1.35, 0)
        local sweep = TweenService:Create(
            LoadingBgGradient,
            TweenInfo.new(2.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            {Offset = Vector2.new(-1.35, 0)}
        )
        sweep:Play()
        sweep.Completed:Wait()
        -- Brief dark reset before the next white pass enters from the right.
        LoadingBgGradient.Offset = Vector2.new(1.35, 0)
        task.wait(0.18)
    end
end)

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 14)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(255, 255, 255)
CardStroke.Transparency = 1
CardStroke.Thickness = 1.2
CardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CardStroke.Parent = Card

-- Logo Image
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.AnchorPoint = Vector2.new(0.5, 0)
Logo.Position = UDim2.new(0.5, 0, 0.12, 0)
Logo.Size = UDim2.fromOffset(56, 56)
Logo.BackgroundTransparency = 1
Logo.Image = ASSET_LOGO
Logo.ImageTransparency = 1
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Card

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = Logo

-- Title Text
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.Position = UDim2.new(0.5, 0, 0.43, 0)
Title.Size = UDim2.new(0.9, 0, 0, 24)
Title.BackgroundTransparency = 1
Title.Text = "HELLO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextTransparency = 1
Title.Font = Enum.Font.GothamMedium
Title.TextSize = 20
Title.Parent = Card

-- Telegram Link Text
local TelegramText = Instance.new("TextLabel")
TelegramText.Name = "TelegramText"
TelegramText.AnchorPoint = Vector2.new(0.5, 0)
TelegramText.Position = UDim2.new(0.5, 0, 0.56, 0)
TelegramText.Size = UDim2.new(0.9, 0, 0, 18)
TelegramText.BackgroundTransparency = 1
TelegramText.Text = "t.me/CHGPINGPRX • Link Copied"
TelegramText.TextColor3 = Color3.fromRGB(160, 160, 165)
TelegramText.TextTransparency = 1
TelegramText.Font = Enum.Font.GothamMedium
TelegramText.TextSize = 12
TelegramText.Parent = Card

-- Progress Bar Background
local ProgressBg = Instance.new("Frame")
ProgressBg.Name = "ProgressBg"
ProgressBg.AnchorPoint = Vector2.new(0.5, 0)
ProgressBg.Position = UDim2.new(0.5, 0, 0.76, 0)
ProgressBg.Size = UDim2.new(0.78, 0, 0, 5)
ProgressBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ProgressBg.BackgroundTransparency = 1
ProgressBg.BorderSizePixel = 0
ProgressBg.Parent = Card

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressBg

-- Progress Bar Fill
local ProgressFill = Instance.new("Frame")
ProgressFill.Name = "ProgressFill"
ProgressFill.Position = UDim2.new(0, 0, 0, 0)
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressFill.BackgroundTransparency = 1
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBg

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = ProgressFill

-- Status Text
local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.Position = UDim2.new(0.5, 0, 0.84, 0)
Status.Size = UDim2.new(0.8, 0, 0, 14)
Status.BackgroundTransparency = 1
Status.Text = "Initializing CHG Hub..."
Status.TextColor3 = Color3.fromRGB(120, 120, 125)
Status.TextTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.Parent = Card

-- ======================================================
--                 ANIMATION SEQUENCE
-- ======================================================

local tweenFast = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenPop = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- 1. Dim Background
TweenService:Create(DarkOverlay, tweenFast, {BackgroundTransparency = 0.45}):Play()
task.wait(0.05)

-- 2. Pop-up Intro Card
TweenService:Create(Card, tweenPop, {
    Position = UDim2.fromScale(0.5, 0.5),
    BackgroundTransparency = 0.05
}):Play()
TweenService:Create(CardStroke, tweenFast, {Transparency = 0.88}):Play()
task.wait(0.15)

-- 3. Fade elements in
TweenService:Create(Logo, tweenFast, {ImageTransparency = 0}):Play()
TweenService:Create(Title, tweenFast, {TextTransparency = 0}):Play()
TweenService:Create(TelegramText, tweenFast, {TextTransparency = 0}):Play()
TweenService:Create(ProgressBg, tweenFast, {BackgroundTransparency = 0}):Play()
TweenService:Create(ProgressFill, tweenFast, {BackgroundTransparency = 0}):Play()
TweenService:Create(Status, tweenFast, {TextTransparency = 0}):Play()

task.wait(0.25)

-- 4. Animate Loading Bar
Status.Text = "Loading scripts & assets..."
TweenService:Create(ProgressFill, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.wait(1.1)

-- 5. Complete Status
Status.Text = "CHG"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)

task.wait(0.7)

-- 6. Fade Out Animation
local tweenOut = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

TweenService:Create(Card, tweenOut, {
    Position = UDim2.fromScale(0.5, 0.46),
    BackgroundTransparency = 1
}):Play()
TweenService:Create(CardStroke, tweenOut, {Transparency = 1}):Play()
TweenService:Create(DarkOverlay, tweenOut, {BackgroundTransparency = 1}):Play()
TweenService:Create(Logo, tweenOut, {ImageTransparency = 1}):Play()
TweenService:Create(Title, tweenOut, {TextTransparency = 1}):Play()
TweenService:Create(TelegramText, tweenOut, {TextTransparency = 1}):Play()
TweenService:Create(ProgressBg, tweenOut, {BackgroundTransparency = 1}):Play()
TweenService:Create(ProgressFill, tweenOut, {BackgroundTransparency = 1}):Play()
TweenService:Create(Status, tweenOut, {TextTransparency = 1}):Play()

task.wait(0.45)

-- Clean up intro GUI
ScreenGui:Destroy()

-- ======================================================
--          PUT YOUR MAIN CHG HUB UI SCRIPT BELOW
-- ======================================================
-- Example:
-- loadstring(game:HttpGet("YOUR_MAIN_HUB_SCRIPT_URL_HERE"))()

]=]

-- CHG menu logo asset
local ASSET_LOGO = "rbxassetid://133842491002442"

--[[
    CHG SCRIPT HUB
    Built from Steal_An_Egg_All_Scripts.txt

    Features:
    - Small mobile-friendly GUI
    - Scripts tab with all named entries from the source file
    - Config tab
    - GUI size controls
    - Color/theme controls
    - Touch + mouse dragging
    - Open / close / minimize animations
    - Individual execute buttons
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local CHGSoundFolder = Instance.new("Folder")
CHGSoundFolder.Name = "CHGSounds"
CHGSoundFolder.Parent = SoundService

-- One sound only: every click/option change produces exactly one immediate sound.
local CHGClickSound = Instance.new("Sound")
CHGClickSound.Name = "CHGClick"
CHGClickSound.SoundId = "rbxassetid://6026984224"
CHGClickSound.Volume = 0.30
CHGClickSound.Parent = CHGSoundFolder

local function CHGPlayClick(speed, volume)
    pcall(function()
        CHGClickSound:Stop()
        CHGClickSound.TimePosition = 0
        CHGClickSound.PlaybackSpeed = speed or 1
        CHGClickSound.Volume = volume or 0.30
        CHGClickSound:Play()
    end)
end

local function CHGPlayExecute()
    CHGPlayClick(1.18, 0.34)
end

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("CHG")
if old then
    old:Destroy()
end

local Scripts = {}

local Themes = {
    {Name = "CHG Red", Main = Color3.fromRGB(18, 18, 20), Panel = Color3.fromRGB(30, 30, 33), Accent = Color3.fromRGB(255, 59, 48), ButtonDark = Color3.fromRGB(126, 30, 38)},
    {Name = "CHG Purple", Main = Color3.fromRGB(18, 17, 25), Panel = Color3.fromRGB(27, 24, 36), Accent = Color3.fromRGB(160, 100, 255), ButtonDark = Color3.fromRGB(72, 35, 120)},
    {Name = "CHG Blue", Main = Color3.fromRGB(15, 19, 26), Panel = Color3.fromRGB(23, 29, 40), Accent = Color3.fromRGB(75, 145, 255), ButtonDark = Color3.fromRGB(18, 55, 105)},
    {Name = "CHG Gold", Main = Color3.fromRGB(22, 20, 16), Panel = Color3.fromRGB(31, 28, 21), Accent = Color3.fromRGB(255, 190, 65), ButtonDark = Color3.fromRGB(105, 72, 12)},
    {Name = "CHG Green", Main = Color3.fromRGB(15, 22, 19), Panel = Color3.fromRGB(22, 32, 27), Accent = Color3.fromRGB(75, 220, 135), ButtonDark = Color3.fromRGB(18, 92, 55)},
}

local ThemeIndex = 1
local SizeIndex = 2
local Sizes = {
    UDim2.fromOffset(320, 250),
    UDim2.fromOffset(360, 285),
    UDim2.fromOffset(410, 325),
}

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local gui = Instance.new("ScreenGui")
gui.Name = "CHG"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local scale = Instance.new("UIScale")
scale.Scale = 0.88
scale.Parent = gui

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.52)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(94, 94, 108)
shadow.BackgroundTransparency = 0.84
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 20)
shadowCorner.Parent = shadow

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Themes[ThemeIndex].Main
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(255, 59, 48)
stroke.Transparency = 0.08
stroke.Parent = main

local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 55)
top.BackgroundTransparency = 1
top.Parent = main
local topDivider = Instance.new("Frame")
topDivider.Name = "TopDivider"
topDivider.Position = UDim2.new(0, 14, 0, 55)
topDivider.Size = UDim2.new(1, -28, 0, 1)
topDivider.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
topDivider.BackgroundTransparency = 0.72
topDivider.BorderSizePixel = 0
topDivider.Parent = main

local menuLogo = Instance.new("ImageLabel")
menuLogo.Name = "MenuLogo"
menuLogo.Position = UDim2.fromOffset(14, 9)
menuLogo.Size = UDim2.fromOffset(36, 36)
menuLogo.BackgroundTransparency = 1
menuLogo.Image = ASSET_LOGO
menuLogo.ScaleType = Enum.ScaleType.Fit
menuLogo.Parent = top
local menuLogoCorner = Instance.new("UICorner")
menuLogoCorner.CornerRadius = UDim.new(0, 8)
menuLogoCorner.Parent = menuLogo

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(74, 3)
title.Size = UDim2.new(1, -148, 0, 28)
title.Font = Enum.Font.GothamBold
title.Text = "CHG"
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextColor3 = Color3.new(1,1,1)
title.Parent = top

local titleGradient = Instance.new("UIGradient")
titleGradient.Rotation = 0
titleGradient.Offset = Vector2.new(1.2, 0)
titleGradient.Parent = title

local CHGRed = Color3.fromRGB(255, 72, 72)
local CHGSoft = Color3.fromRGB(255, 145, 145)

-- CHG: seamless red -> white -> red -> white.
-- Both ends are red so the loop can restart without a visible red snap.
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, CHGRed),
    ColorSequenceKeypoint.new(0.18, CHGRed),
    ColorSequenceKeypoint.new(0.34, CHGSoft),
    ColorSequenceKeypoint.new(0.50, CHGRed),
    ColorSequenceKeypoint.new(0.66, CHGRed),
    ColorSequenceKeypoint.new(0.82, CHGSoft),
    ColorSequenceKeypoint.new(1.00, CHGRed)
})

task.spawn(function()
    while gui.Parent and title.Parent do
        titleGradient.Offset = Vector2.new(1.2, 0)
        local t = tween(titleGradient, TweenInfo.new(1.15, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(-1.2, 0)
        })
        t.Completed:Wait()
        -- Endpoints are both red, so the restart is visually continuous.
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 58, 0, 29)
subtitle.Size = UDim2.new(1, -116, 0, 16)
subtitle.Font = Enum.Font.GothamMedium
subtitle.Text = "SCRIPT HUB"
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextColor3 = Color3.fromRGB(145,145,155)
subtitle.Parent = top

local function topButton(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(28, 28)
    b.Position = UDim2.new(1, x, 0, 8)
    b.AnchorPoint = Vector2.new(1, 0)
    b.BackgroundColor3 = Color3.fromRGB(43, 43, 47)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 14)
    c.Parent = b
    return b
end

local minimize = topButton("—", -52)
local close = topButton("×", -8)
minimize.BackgroundColor3 = Color3.fromRGB(43, 43, 47)
close.BackgroundColor3 = Color3.fromRGB(112, 35, 42)

-- Dedicated drag line OUTSIDE the main GUI, slightly below it.
-- It follows the whole window and remains available while the GUI is open.
local dragHandle = Instance.new("TextButton")
dragHandle.Name = "CHGDragHandle"
dragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
dragHandle.Size = UDim2.fromOffset(110, 16)
dragHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dragHandle.BackgroundTransparency = 0.94
dragHandle.BorderSizePixel = 0
dragHandle.Text = ""
dragHandle.AutoButtonColor = false
dragHandle.ZIndex = 60
dragHandle.Visible = false
dragHandle.Parent = gui

local dragVisual = Instance.new("Frame")
dragVisual.Name = "Line"
dragVisual.AnchorPoint = Vector2.new(0.5, 0.5)
dragVisual.Position = UDim2.fromScale(0.5, 0.5)
dragVisual.Size = UDim2.fromOffset(76, 3)
dragVisual.BackgroundColor3 = Color3.fromRGB(248, 248, 252)
dragVisual.BackgroundTransparency = 0.03
dragVisual.BorderSizePixel = 0
dragVisual.ZIndex = 61
dragVisual.Parent = dragHandle
local dragVisualCorner = Instance.new("UICorner")
dragVisualCorner.CornerRadius = UDim.new(1, 0)
dragVisualCorner.Parent = dragVisual

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(1, 0)
dragCorner.Parent = dragHandle
local dragStroke = Instance.new("UIStroke")
dragStroke.Color = Color3.fromRGB(255, 255, 255)
dragStroke.Transparency = 0.78
dragStroke.Thickness = 1
dragStroke.Parent = dragHandle

-- Bottom-right resize handle. It stays OUTSIDE the GUI and follows it exactly.
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "CHGResizeHandle"
resizeHandle.AnchorPoint = Vector2.new(0.5, 0.5)
resizeHandle.Size = UDim2.fromOffset(30, 30)
resizeHandle.BackgroundTransparency = 1
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "↘"
resizeHandle.Font = Enum.Font.GothamBlack
resizeHandle.TextSize = 18
resizeHandle.TextColor3 = Themes[ThemeIndex].Accent
resizeHandle.AutoButtonColor = false
resizeHandle.ZIndex = 70
resizeHandle.Visible = false
resizeHandle.Parent = gui

local resizeDragging = false
local resizeStartInput
local resizeStartSize

-- Keep the main outline red with a soft iOS-style glow pulse.
task.spawn(function()
    while gui.Parent and main.Parent do
        stroke.Color = Color3.fromRGB(255, 59, 48)
        local dim = tween(stroke, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.30
        })
        dim.Completed:Wait()
        local glow = tween(stroke, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.07
        })
        glow.Completed:Wait()
    end
end)

local function updateFloatingControls()
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 12)
    resizeHandle.Position = UDim2.new(x, ox + halfW + 15, y, oy + halfH + 15)
end

local function updateDragHandlePosition()
    updateFloatingControls()
end

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 61)
sidebar.Size = UDim2.new(0, 98, 1, -69)
sidebar.BackgroundColor3 = Themes[ThemeIndex].Panel
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 14)
sideCorner.Parent = sidebar
local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(255, 59, 48)
sidebarStroke.Thickness = 1
sidebarStroke.Transparency = 0.82
sidebarStroke.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 7)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 9)
sidePad.PaddingBottom = UDim.new(0, 8)
sidePad.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 114, 0, 61)
content.Size = UDim2.new(1, -122, 1, -69)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "Scripts"
local pages = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1,1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Themes[ThemeIndex].Accent
    page.CanvasSize = UDim2.new()
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "Scripts")
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 7)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = page

    pages[name] = page
    return page
end

local scriptsPage = makePage("Scripts")
local configPage = makePage("Config")

local tabButtons = {}

local tabSweepTokens = {}

local function makeTab(text, icon)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 39)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = b
    local tabStroke = Instance.new("UIStroke")
    tabStroke.Color = Color3.fromRGB(255, 59, 48)
    tabStroke.Thickness = 1
    tabStroke.Transparency = 0.88
    tabStroke.Parent = b

    local sweepBg = Instance.new("Frame")
    sweepBg.Name = "SelectedDarkBlueWhiteSweep"
    sweepBg.Size = UDim2.fromScale(1, 1)
    sweepBg.BackgroundColor3 = Color3.fromRGB(8, 16, 30)
    sweepBg.BorderSizePixel = 0
    sweepBg.Visible = false
    sweepBg.ZIndex = b.ZIndex + 1
    sweepBg.Parent = b
    local sweepCorner = Instance.new("UICorner")
    sweepCorner.CornerRadius = UDim.new(0, 9)
    sweepCorner.Parent = sweepBg
    local sweep = Instance.new("UIGradient")
    sweep.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(0.40, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.60, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(1.00, Themes[ThemeIndex].Accent)
    })
    sweepBg.BackgroundColor3 = Themes[ThemeIndex].Accent
    sweep.Rotation = 0
    sweep.Offset = Vector2.new(1.15, 0)
    sweep.Parent = sweepBg

    local label = Instance.new("TextLabel")
    label.Name = "TabLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Text = icon .. "  " .. text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.fromOffset(10, 0)
    label.ZIndex = b.ZIndex + 2
    label.Parent = b

    tabButtons[text] = b
    return b
end

local scriptsTab = makeTab("Scripts", "🛡")
local configTab = makeTab("Config", "⚙")
-- Pin Scripts at the top and Config at the absolute bottom of the sidebar.
sideLayout:Destroy()
scriptsTab.LayoutOrder = 1
configTab.LayoutOrder = 2
scriptsTab.Position = UDim2.fromOffset(6, 9)
configTab.Position = UDim2.new(0, 6, 1, -52)

local function refreshTabs()
    for name, b in pairs(tabButtons) do
        local selected = (name == "Scripts" and currentTab == "Scripts")
            or (name == "Config" and currentTab == "Config")
        local sweepBg = b:FindFirstChild("SelectedDarkBlueWhiteSweep")
        local sweep = sweepBg and sweepBg:FindFirstChildOfClass("UIGradient")
        local tabLabel = b:FindFirstChild("TabLabel")
        if selected then
            b.BackgroundColor3 = Themes[ThemeIndex].Panel
            if sweepBg then sweepBg.Visible = true end
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(255,255,255); tabLabel.TextSize = 12 end
            tween(b, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, 44)})
            if sweep then
                tabSweepTokens[name] = (tabSweepTokens[name] or 0) + 1
                local token = tabSweepTokens[name]
                task.spawn(function()
                    while gui.Parent and currentTab == name and tabSweepTokens[name] == token and b.Parent do
                        sweep.Offset = Vector2.new(1.15, 0)
                        local tw = tween(sweep, TweenInfo.new(1.8, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.15, 0)})
                        tw.Completed:Wait()
                    end
                end)
            end
        else
            tabSweepTokens[name] = (tabSweepTokens[name] or 0) + 1
            if sweepBg then sweepBg.Visible = false end
            b.BackgroundColor3 = Themes[ThemeIndex].Panel
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(255,255,255); tabLabel.TextSize = 11 end
            tween(b, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -12, 0, 39)})
        end
    end

    for name, page in pairs(pages) do
        page.Visible = (name == currentTab)
        if page.Visible then
            page.CanvasPosition = Vector2.zero
        end
    end
end

local function switchTab(tab)
    currentTab = tab
    refreshTabs()
end

scriptsTab.Activated:Connect(function() CHGPlayClick(); switchTab("Scripts") end)
configTab.Activated:Connect(function() CHGPlayClick(); switchTab("Config") end)

local function execute(code, button)
    CHGPlayExecute()
    local oldText = button.Text
    button.Text = "LOADING..."
    task.spawn(function()
        local ok, fnOrErr = pcall(loadstring, code)
        if ok and type(fnOrErr) == "function" then
            task.spawn(function()
                local ran, err = pcall(fnOrErr)
                if not ran then warn("[CHG] Script error:", err) end
            end)
            button.Text = "EXECUTED ✓"
        else
            warn("[CHG] Load error:", fnOrErr)
            button.Text = "ERROR"
        end
        task.wait(0.8)
        if button and button.Parent then
            button.Text = oldText
        end
    end)
end

local function addScriptCard(parent, name, code)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 58)
    card.BackgroundColor3 = Themes[ThemeIndex].Panel
    card.BorderSizePixel = 0
    card.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = card

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 59, 48)
    s.Thickness = 1
    s.Transparency = 0.84
    s.Parent = card

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(10, 7)
    label.Size = UDim2.new(1, -95, 0, 40)
    label.Font = Enum.Font.GothamMedium
    label.Text = name
    label.TextSize = 11
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = card

    local run = Instance.new("TextButton")
    run.Name = "RUN"
    run.Size = UDim2.fromOffset(72, 31)
    run.Position = UDim2.new(1, -82, 0.5, 0)
    run.AnchorPoint = Vector2.new(0, 0.5)
    run.BackgroundTransparency = 1
    run.BorderSizePixel = 0
    run.Text = ""
    run.AutoButtonColor = false
    run.Parent = card

    local runBg = Instance.new("Frame")
    runBg.Name = "RunBackground"
    runBg.Size = UDim2.fromScale(1,1)
    runBg.BackgroundColor3 = Color3.fromRGB(95, 8, 18)
    runBg.BorderSizePixel = 0
    runBg.ZIndex = run.ZIndex
    runBg.Parent = run
    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 10)
    runCorner.Parent = runBg
    local runGradient = Instance.new("UIGradient")
    runGradient.Name = "RunWhiteDarkRedSweep"
    runGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Themes[ThemeIndex].ButtonDark),
        ColorSequenceKeypoint.new(0.40, Themes[ThemeIndex].ButtonDark),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.60, Themes[ThemeIndex].ButtonDark),
        ColorSequenceKeypoint.new(1.00, Themes[ThemeIndex].ButtonDark)
    })
    runGradient.Rotation = 0
    runGradient.Offset = Vector2.new(1.15, 0)
    runGradient.Parent = runBg
    local runLabel = Instance.new("TextLabel")
    runLabel.Name = "RunLabel"
    runLabel.BackgroundTransparency = 1
    runLabel.Size = UDim2.fromScale(1,1)
    runLabel.Text = "RUN"
    runLabel.Font = Enum.Font.GothamMedium
    runLabel.TextSize = 10
    runLabel.TextColor3 = Color3.new(1,1,1)
    runLabel.ZIndex = run.ZIndex + 1
    runLabel.Parent = run
    task.spawn(function()
        while gui.Parent and run.Parent do
            runGradient.Offset = Vector2.new(1.15, 0)
            local tw = tween(runGradient, TweenInfo.new(2.0, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.15, 0)})
            tw.Completed:Wait()
            task.wait(0.10)
        end
    end)


    run.Activated:Connect(function()
        execute(code, run)
    end)

    run.MouseEnter:Connect(function()
        tween(run, TweenInfo.new(0.12), {Size = UDim2.fromOffset(75, 33)})
    end)
    run.MouseLeave:Connect(function()
        tween(run, TweenInfo.new(0.12), {Size = UDim2.fromOffset(72, 31)})
    end)
end

-- ============================================================
-- CHG TELEPORT ROUTE
-- Replaced the old script library with the Teleport Route feature.
-- Route logic is based on the supplied CHG Teleport Route source.
-- ============================================================

local ProximityPromptService = game:GetService("ProximityPromptService")

local TeleportRouteEnabled = false
local IsTeleportRouteRunning = false
local TELEPORT_ROUTE_SPEED = 0.005

local teleportRouteCard = Instance.new("TextButton")
teleportRouteCard.Name = "TeleportRoute"
teleportRouteCard.Size = UDim2.new(1, -8, 0, 58)
teleportRouteCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
teleportRouteCard.BorderSizePixel = 0
teleportRouteCard.Text = ""
teleportRouteCard.AutoButtonColor = false
teleportRouteCard.Parent = scriptsPage

local teleportRouteCorner = Instance.new("UICorner")
teleportRouteCorner.CornerRadius = UDim.new(0, 11)
teleportRouteCorner.Parent = teleportRouteCard

local teleportRouteSweep = Instance.new("UIGradient")
teleportRouteSweep.Name = "TeleportRouteSweep"
teleportRouteSweep.Rotation = 0
teleportRouteSweep.Offset = Vector2.new(1.15, 0)
teleportRouteSweep.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(105, 8, 18))
})
teleportRouteSweep.Parent = teleportRouteCard

local teleportRouteTitle = Instance.new("TextLabel")
teleportRouteTitle.BackgroundTransparency = 1
teleportRouteTitle.Position = UDim2.fromOffset(13, 5)
teleportRouteTitle.Size = UDim2.new(1, -26, 0, 25)
teleportRouteTitle.Text = "↗  TELEPORT ROUTE"
teleportRouteTitle.Font = Enum.Font.GothamMedium
teleportRouteTitle.TextSize = 15
teleportRouteTitle.TextColor3 = Color3.new(1,1,1)
teleportRouteTitle.TextXAlignment = Enum.TextXAlignment.Left
teleportRouteTitle.ZIndex = teleportRouteCard.ZIndex + 2
teleportRouteTitle.Parent = teleportRouteCard

local teleportRouteStatus = Instance.new("TextLabel")
teleportRouteStatus.BackgroundTransparency = 1
teleportRouteStatus.Position = UDim2.fromOffset(14, 31)
teleportRouteStatus.Size = UDim2.new(1, -28, 0, 18)
teleportRouteStatus.Text = "OFF"
teleportRouteStatus.Font = Enum.Font.GothamMedium
teleportRouteStatus.TextSize = 10
teleportRouteStatus.TextColor3 = Color3.fromRGB(255, 170, 175)
teleportRouteStatus.TextXAlignment = Enum.TextXAlignment.Left
teleportRouteStatus.ZIndex = teleportRouteCard.ZIndex + 2
teleportRouteStatus.Parent = teleportRouteCard

local TeleportRouteSound = Instance.new("Sound")
TeleportRouteSound.Name = "TeleportRouteEnabledSound"
TeleportRouteSound.SoundId = "rbxassetid://6026984224"
TeleportRouteSound.Volume = 0.42
TeleportRouteSound.PlaybackSpeed = 1.25
TeleportRouteSound.Parent = CHGSoundFolder

local teleportRouteSweepToken = 0
local function startTeleportRouteVisual(enabled)
    teleportRouteSweepToken += 1
    local token = teleportRouteSweepToken
    teleportRouteSweep.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(0.40, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.60, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(1.00, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18))
    })
    task.spawn(function()
        while gui.Parent and teleportRouteCard.Parent and teleportRouteSweepToken == token do
            teleportRouteSweep.Offset = Vector2.new(1.15, 0)
            local tw = tween(teleportRouteSweep, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.15, 0)})
            tw.Completed:Wait()
        end
    end)
end

local function setTeleportRouteVisual(enabled)
    if enabled then
        teleportRouteStatus.Text = "ON"
        teleportRouteStatus.TextColor3 = Color3.fromRGB(110,255,145)
        teleportRouteCard.BackgroundColor3 = Color3.fromRGB(35,170,75)
        -- The click sound already fires immediately when the button is pressed.
        -- Do not add a second delayed sound here.
    else
        teleportRouteStatus.Text = "OFF"
        teleportRouteStatus.TextColor3 = Color3.fromRGB(255,170,175)
        teleportRouteCard.BackgroundColor3 = Color3.fromRGB(105,8,18)
    end
    startTeleportRouteVisual(enabled)
end

-- Editable route configuration.
-- Speed is the delay between points; lower values move faster.
local TeleportRouteConfig = {
    Speed = 0, -- ULTRA: task.wait(0) giữa các điểm
    Points = {
        Vector3.new(500.62, 241.28, -366.64),
        Vector3.new(504.45, 155.80, -366.35),
        Vector3.new(508.30, 70.28, -366.03),
        Vector3.new(513.86, 70.28, -366.25),
        Vector3.new(519.43, 70.28, -366.47),
        Vector3.new(524.32, 70.28, -366.59),
        Vector3.new(529.22, 70.28, -366.71),
        Vector3.new(538.01, 70.28, -365.55),
        Vector3.new(546.80, 70.28, -364.40)
    }
}

local TeleportRouteDefaultSpeed = TeleportRouteConfig.Speed
local TeleportRouteDefaultPoints = table.clone(TeleportRouteConfig.Points)
local TeleportRouteRunToken = 0

local function cancelTeleportRoute()
    TeleportRouteRunToken += 1
    IsTeleportRouteRunning = false
end

local function TeleportRoute(character)
    if not TeleportRouteEnabled or not character or not character.Parent then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root or not root:IsA("BasePart") then return end

    TeleportRouteRunToken += 1
    local runToken = TeleportRouteRunToken
    IsTeleportRouteRunning = true

    for _, position in ipairs(TeleportRouteConfig.Points) do
        if runToken ~= TeleportRouteRunToken
            or not TeleportRouteEnabled
            or not character.Parent
            or not root.Parent
            or not Player.Character
            or Player.Character ~= character then
            IsTeleportRouteRunning = false
            return
        end

        local ok = pcall(function()
            root.CFrame = CFrame.new(position)
        end)
        if not ok then
            IsTeleportRouteRunning = false
            return
        end
        task.wait(math.max(0, tonumber(TeleportRouteConfig.Speed) or TeleportRouteDefaultSpeed))
    end

    if runToken == TeleportRouteRunToken then
        IsTeleportRouteRunning = false
    end
end

teleportRouteCard.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        CHGPlayClick(1.0, 0.30)
        TeleportRouteEnabled = not TeleportRouteEnabled
        if not TeleportRouteEnabled then
            cancelTeleportRoute()
        end
        setTeleportRouteVisual(TeleportRouteEnabled)
    end
end)

ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player ~= Player then return end
    if not TeleportRouteEnabled or IsTeleportRouteRunning then return end
    local character = Player.Character
    if not character or not character.Parent then return end
    task.spawn(function()
        TeleportRoute(character)
    end)
end)

Player.CharacterAdded:Connect(function()
    cancelTeleportRoute()
end)

setTeleportRouteVisual(false)

configLabel("TELEPORT ROUTE CONFIG")

local routeSpeedValues = {0, 0.0005, 0.001, 0.005}
local routeSpeedLabels = {"ULTRA", "0.0005s", "0.001s", "0.005s"}
local routeSpeedIndex = 1
local routeSpeedButton = configButton("Route speed: ULTRA")
routeSpeedButton.Activated:Connect(function()
    CHGPlayClick()
    routeSpeedIndex = routeSpeedIndex % #routeSpeedValues + 1
    TeleportRouteConfig.Speed = routeSpeedValues[routeSpeedIndex]
    routeSpeedButton.Text = "Route speed: " .. routeSpeedLabels[routeSpeedIndex]
end)

local routeResetButton = configButton("Reset route coordinates")
routeResetButton.Activated:Connect(function()
    CHGPlayClick()
    TeleportRouteConfig.Speed = TeleportRouteDefaultSpeed
    TeleportRouteConfig.Points = table.clone(TeleportRouteDefaultPoints)
    routeSpeedIndex = 1
    routeSpeedButton.Text = "Route speed: " .. routeSpeedLabels[routeSpeedIndex]
end)

local function configLabel(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -8, 0, 25)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamMedium
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(190,190,200)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

local function configButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -8, 0, 38)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 11
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = false
    b.Parent = configPage
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 11)
    c.Parent = b
    local configStroke = Instance.new("UIStroke")
    configStroke.Color = Color3.fromRGB(255, 59, 48)
    configStroke.Thickness = 1
    configStroke.Transparency = 0.86
    configStroke.Parent = b
    return b
end

configLabel("GUI SIZE")

local sizeRow = Instance.new("Frame")
sizeRow.Size = UDim2.new(1, -8, 0, 42)
sizeRow.BackgroundTransparency = 1
sizeRow.Parent = configPage

local sizeMinus = configButton("−")
sizeMinus.Parent = sizeRow
sizeMinus.Position = UDim2.fromOffset(0,0)
sizeMinus.Size = UDim2.new(0.31, -3, 1, 0)

local sizeText = configButton("MEDIUM")
sizeText.Parent = sizeRow
sizeText.Position = UDim2.new(0.31, 2, 0, 0)
sizeText.Size = UDim2.new(0.38, -3, 1, 0)

local sizePlus = configButton("+")
sizePlus.Parent = sizeRow
sizePlus.Position = UDim2.new(0.69, 2, 0, 0)
sizePlus.Size = UDim2.new(0.31, -2, 1, 0)

local sizeNames = {"SMALL", "MEDIUM", "LARGE"}

local function setSize(index)
    SizeIndex = math.clamp(index, 1, #Sizes)
    sizeText.Text = sizeNames[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    task.defer(updateDragHandlePosition)
end

sizeMinus.Activated:Connect(function() CHGPlayClick(); setSize(SizeIndex - 1) end)
sizePlus.Activated:Connect(function() CHGPlayClick(); setSize(SizeIndex + 1) end)

configLabel("COLOR")

local colorButton = configButton("Choose Color • CHG Red")

local colorPopup = Instance.new("Frame")
colorPopup.Name = "ColorPicker"
colorPopup.Size = UDim2.new(1, -8, 0, 0)
colorPopup.BackgroundTransparency = 1
colorPopup.ClipsDescendants = true
colorPopup.Parent = configPage

local colorGrid = Instance.new("UIGridLayout")
colorGrid.CellSize = UDim2.new(0.48, -4, 0, 34)
colorGrid.CellPadding = UDim2.new(0.02, 0, 0, 6)
colorGrid.SortOrder = Enum.SortOrder.LayoutOrder
colorGrid.Parent = colorPopup

local function applyTheme(index)
    ThemeIndex = index
    local th = Themes[ThemeIndex]
    colorButton.Text = "Choose Color • " .. th.Name
    -- Keep the CHG title's own animated red/lilac sweep; theme changes do not reset it.
    tween(main, TweenInfo.new(0.2), {BackgroundColor3 = th.Main})
    tween(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 59, 48)})
    dragVisual.BackgroundColor3 = th.Accent
    resizeHandle.TextColor3 = th.Accent
    notificationBar.BackgroundColor3 = th.Accent
    notificationStroke.Color = th.Accent
    openStroke.Color = Color3.fromRGB(255, 59, 48)
    openButton.TextColor3 = Color3.fromRGB(255,255,255)
    sidebar.BackgroundColor3 = th.Panel
    for _, b in pairs(tabButtons) do
        if b then
            b.BackgroundColor3 = th.Panel
            local sweepBg = b:FindFirstChild("SelectedDarkBlueWhiteSweep")
            if sweepBg then
                sweepBg.BackgroundColor3 = th.Accent
                local sweep = sweepBg:FindFirstChildOfClass("UIGradient")
                if sweep then
                    sweep.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.00, th.Accent),
                        ColorSequenceKeypoint.new(0.40, th.Accent),
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
                        ColorSequenceKeypoint.new(0.60, th.Accent),
                        ColorSequenceKeypoint.new(1.00, th.Accent)
                    })
                end
            end
        end
    end
    if teleportRouteCard and teleportRouteCard.Parent then
        -- Teleport Route keeps its own red/green state colors; only its outline follows the theme.
        local teleportRouteStroke = teleportRouteCard:FindFirstChildOfClass("UIStroke")
        if teleportRouteStroke then teleportRouteStroke.Color = th.Accent end
    end
    for _, page in pairs(pages) do
        page.ScrollBarImageColor3 = th.Accent
        for _, child in ipairs(page:GetChildren()) do
            if child:IsA("Frame") then
                child.BackgroundColor3 = th.Panel
                local run = child:FindFirstChild("RUN")
                if run then
                    local runBg = run:FindFirstChild("RunBackground")
                    if runBg then
                        runBg.BackgroundColor3 = th.ButtonDark
                        local rg = runBg:FindFirstChild("RunWhiteDarkRedSweep")
                        if rg then
                            rg.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0.00, th.ButtonDark),
                                ColorSequenceKeypoint.new(0.40, th.ButtonDark),
                                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
                                ColorSequenceKeypoint.new(0.60, th.ButtonDark),
                                ColorSequenceKeypoint.new(1.00, th.ButtonDark)
                            })
                        end
                    end
                end
            elseif child:IsA("TextButton") and child.Name ~= "RUN" then
                -- Config/action buttons follow the selected theme too.
                child.BackgroundColor3 = th.Panel
                child.TextColor3 = Color3.fromRGB(255,255,255)
            end
        end
    end
    refreshTabs()
end

for i, th in ipairs(Themes) do
    local b = Instance.new("TextButton")
    b.Name = th.Name
    b.Text = th.Name
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 10
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = th.Accent
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = colorPopup
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b
    b.Activated:Connect(function()
        CHGPlayClick()
        applyTheme(i)
        tween(colorPopup, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, 0)})
    end)
end

local colorsOpen = false
colorButton.Activated:Connect(function()
    CHGPlayClick()
    colorsOpen = not colorsOpen
    local h = colorsOpen and 5 * 34 + 4 * 6 or 0
    tween(colorPopup, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, h)})
end)

configLabel("WINDOW")

local closeInfo = configButton("Close / Reopen: X or the CHG button")
closeInfo.TextColor3 = Color3.fromRGB(145,145,155)

local dragging = false
local dragStart
local startPos
local dragSource

local function beginDrag(input, source)
    dragging = true
    dragSource = source
    dragStart = input.Position
    startPos = main.Position
    if source == dragHandle then
        tween(dragHandle, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(136, 22),
            BackgroundTransparency = 0.90
        })
        tween(dragVisual, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(108, 6),
            BackgroundTransparency = 0
        })
    end
end

local function updateDrag(input)
    if not dragging then return end
    local delta = input.Position - dragStart
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    local minX = -viewport.X * 0.5 + halfW + 4
    local maxX = viewport.X * 0.5 - halfW - 4
    local minY = -viewport.Y * 0.5 + halfH + 4
    local maxY = viewport.Y * 0.5 - halfH - 4
    local ox = math.clamp(startPos.X.Offset + delta.X, minX, maxX)
    local oy = math.clamp(startPos.Y.Offset + delta.Y, minY, maxY)
    local newPos = UDim2.new(0.5, ox, 0.5, oy)
    main.Position = newPos
    shadow.Position = newPos
    updateDragHandlePosition()
    if notification and notification.Visible then
        updateNotificationPosition()
    end
end

local function endDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then return end
    dragging = false
    if dragSource == dragHandle then
        tween(dragHandle, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(110, 16),
            BackgroundTransparency = 0.94
        })
        tween(dragVisual, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(76, 3),
            BackgroundTransparency = 0.10
        })
    end
    dragSource = nil
end

-- The bottom line is the dedicated drag area.
dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input, dragHandle)
    end
end)

-- Mobile drag follows the finger 1:1; no snapping or automatic repositioning while dragging.
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        updateDrag(input)
    end
end)

-- Drag the outside ↘ handle to resize the GUI with a finger/mouse.
resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        resizeDragging = true
        CHGPlayClick()
        resizeStartInput = input.Position
        resizeStartSize = main.Size
    end
end)

local function updateResize(input)
    if not resizeDragging then return end
    local delta = input.Position - resizeStartInput
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920,1080)
    local centerX = main.AbsolutePosition.X + main.AbsoluteSize.X * 0.5
    local centerY = main.AbsolutePosition.Y + main.AbsoluteSize.Y * 0.5
    local maxW = math.max(300, math.min(540, 2 * math.min(centerX - 8, viewport.X - centerX - 8)))
    local maxH = math.max(230, math.min(430, 2 * math.min(centerY - 8, viewport.Y - centerY - 8)))
    local w = math.clamp(resizeStartSize.X.Offset + delta.X * 2, 300, maxW)
    local h = math.clamp(resizeStartSize.Y.Offset + delta.Y * 2, 230, maxH)
    -- LOCKED: resizing changes only size. The GUI never moves while this handle is held.
    main.Size = UDim2.fromOffset(w, h)
    shadow.Size = UDim2.fromOffset(w, h)
    updateFloatingControls()
end

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
        updateResize(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    endDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizeDragging = false
    end
end)

-- Floating circular CHG button shown after minimizing/closing.
local openButton = Instance.new("TextButton")
openButton.Name = "OpenCHG"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(64, 64)
openButton.BackgroundColor3 = Color3.fromRGB(30, 22, 24)
openButton.BorderSizePixel = 0
openButton.Text = "CHG"
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 19
openButton.TextColor3 = Color3.fromRGB(255,255,255)
openButton.TextStrokeTransparency = 0.15
openButton.TextStrokeColor3 = Color3.fromRGB(0,0,0)
openButton.AutoButtonColor = false
openButton.Visible = false
openButton.ZIndex = 85
openButton.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(1, 0)
oc.Parent = openButton
local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 1.5
openStroke.Color = Color3.fromRGB(255, 59, 48)
openStroke.Transparency = 0.08
openStroke.Parent = openButton
local openInnerStroke = Instance.new("UIStroke")
openInnerStroke.Thickness = 1
openInnerStroke.Color = Color3.fromRGB(255,255,255)
openInnerStroke.Transparency = 0.72
openInnerStroke.Parent = openButton
task.spawn(function()
    while gui.Parent and openButton.Parent do
        openButton.BackgroundColor3 = Color3.fromRGB(30, 22, 24)
        local toWarm = tween(openButton, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(52, 25, 30)
        })
        toWarm.Completed:Wait()
        local toBase = tween(openButton, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(30, 22, 24)
        })
        toBase.Completed:Wait()
    end
end)

local mainScale = Instance.new("UIScale")
mainScale.Scale = 1
mainScale.Parent = main

local shadowScale = Instance.new("UIScale")
shadowScale.Scale = 1
shadowScale.Parent = shadow

local function closeGui()
    if not main.Visible then return end
    local outInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    local savedClosePosition = main.Position
    local leftExitPosition = UDim2.new(
        savedClosePosition.X.Scale, savedClosePosition.X.Offset - 42,
        savedClosePosition.Y.Scale, savedClosePosition.Y.Offset
    )
    local closeW = math.max(320, main.Size.X.Offset)
    local closeH = math.max(245, main.Size.Y.Offset)
    tween(mainScale, outInfo, {Scale = 0.94})
    tween(shadowScale, outInfo, {Scale = 0.94})
    tween(main, outInfo, {BackgroundTransparency = 1, Position = leftExitPosition, Size = UDim2.fromOffset(closeW, closeH)})
    tween(shadow, outInfo, {BackgroundTransparency = 1, Position = leftExitPosition, Size = UDim2.fromOffset(closeW, closeH)})
    task.wait(0.33)
    main.Visible = false
    shadow.Visible = false
    dragHandle.Visible = false
    resizeHandle.Visible = false
    if notification then notification.Visible = false end
    -- Ensure no transparent black layer remains after closing.
    main.BackgroundTransparency = 1
    shadow.BackgroundTransparency = 1
    main.Size = Sizes[SizeIndex]
    shadow.Size = Sizes[SizeIndex]
    main.Position = savedClosePosition
    shadow.Position = savedClosePosition
    mainScale.Scale = 1
    shadowScale.Scale = 1
    updateFloatingControls()
    openButton.Visible = true
    updateDragHandlePosition()
    tween(openButton, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(64,64)
    })
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    mainScale.Scale = 0.72
    shadowScale.Scale = 0.72
    main.BackgroundTransparency = 0
    shadow.BackgroundTransparency = 0.84
    dragHandle.Visible = true
    resizeHandle.Visible = true
    updateFloatingControls()
    tween(mainScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    tween(shadowScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
end

local minimized = false
local savedSize = main.Size

close.Activated:Connect(function() CHGPlayClick(); closeGui() end)
local chgDragging = false
local chgDragStart
local chgStartPos
openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        chgDragging = true
        chgDragStart = input.Position
        chgStartPos = openButton.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if chgDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - chgDragStart
        openButton.Position = UDim2.new(chgStartPos.X.Scale, chgStartPos.X.Offset + d.X, chgStartPos.Y.Scale, chgStartPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        chgDragging = false
    end
end)

openButton.Activated:Connect(function()
    CHGPlayClick()
    if minimized then
        minimized = false
        openButton.Visible = false
        main.Visible = true
        shadow.Visible = true
        sidebar.Visible = true
        content.Visible = true
        resizeHandle.Visible = true
        dragHandle.Visible = true
            main.Size = UDim2.fromOffset(190,45)
        shadow.Size = UDim2.fromOffset(190,45)
        mainScale.Scale = 0.72
        shadowScale.Scale = 0.72
        main.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.84
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateDragHandlePosition)
    else
        openGui()
    end
end)

RunService.RenderStepped:Connect(function()
    if gui.Parent and (main.Visible or dragHandle.Visible or resizeHandle.Visible) then
        updateFloatingControls()
    end
end)

minimize.Activated:Connect(function()
    CHGPlayClick()
    if minimized then
        minimized = false
        openButton.Visible = false
        main.Visible = true
        shadow.Visible = true
        sidebar.Visible = true
        content.Visible = true
        resizeHandle.Visible = true
        dragHandle.Visible = true
            main.Size = UDim2.fromOffset(190,45)
        shadow.Size = UDim2.fromOffset(190,45)
        mainScale.Scale = 0.72
        shadowScale.Scale = 0.72
        main.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.84
        tween(main, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateDragHandlePosition)
    else
        minimized = true
        savedSize = main.Size
        sidebar.Visible = false
        content.Visible = false
        resizeHandle.Visible = false
        dragHandle.Visible = false
            local miniInfo = TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        tween(mainScale, miniInfo, {Scale = 0.78})
        tween(shadowScale, miniInfo, {Scale = 0.78})
        tween(main, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1,1)})
        tween(shadow, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1,1)})
        task.wait(0.25)
        main.Visible = false
        shadow.Visible = false
        main.Size = savedSize
        shadow.Size = savedSize
        mainScale.Scale = 1
        shadowScale.Scale = 1
        openButton.Visible = true
        openButton.Size = UDim2.fromOffset(8,8)
        tween(openButton, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(64,64)})
    end
end)

-- Sound is intentionally NOT globally bound. Each real button/option below fires one sound once.
refreshTabs()

-- ======================================================
-- MOBILE-STYLE SUPPORT NOTIFICATION
-- Appears above CHG after the intro and slides away smoothly.
-- ======================================================
local notification = Instance.new("Frame")
notification.Name = "SupportNotification"
notification.AnchorPoint = Vector2.new(0.5, 0.5)
notification.Size = UDim2.fromOffset(270, 48)
notification.BackgroundColor3 = Color3.fromRGB(18,18,23)
notification.BackgroundTransparency = 1
notification.BorderSizePixel = 0
notification.ZIndex = 90
notification.Visible = false
notification.Parent = gui
local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 14)
notificationCorner.Parent = notification
local notificationStroke = Instance.new("UIStroke")
notificationStroke.Thickness = 1
notificationStroke.Transparency = 1
notificationStroke.Color = Themes[ThemeIndex].Accent
notificationStroke.Parent = notification
local notificationBar = Instance.new("Frame")
notificationBar.Size = UDim2.new(0, 3, 0.58, 0)
notificationBar.Position = UDim2.new(0, 8, 0.21, 0)
notificationBar.BackgroundColor3 = Themes[ThemeIndex].Accent
notificationBar.BorderSizePixel = 0
notificationBar.ZIndex = 91
notificationBar.Parent = notification
local notificationBarCorner = Instance.new("UICorner")
notificationBarCorner.CornerRadius = UDim.new(1,0)
notificationBarCorner.Parent = notificationBar
local notificationText = Instance.new("TextLabel")
notificationText.BackgroundTransparency = 1
notificationText.Position = UDim2.fromOffset(20, 0)
notificationText.Size = UDim2.new(1, -30, 1, 0)
notificationText.Font = Enum.Font.GothamMedium
notificationText.Text = "Thanks for all support guys :)"
notificationText.TextSize = 12
notificationText.TextColor3 = Color3.new(1,1,1)
notificationText.TextTransparency = 1
notificationText.TextXAlignment = Enum.TextXAlignment.Left
notificationText.ZIndex = 91
notificationText.Parent = notification

-- Support message: green -> white -> green -> white, continuously.
local notificationGradient = Instance.new("UIGradient")
notificationGradient.Rotation = 0
notificationGradient.Offset = Vector2.new(1.1, 0)
notificationGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 255, 120))
})
notificationGradient.Parent = notificationText

task.spawn(function()
    while gui.Parent and notificationText.Parent do
        notificationGradient.Offset = Vector2.new(1.1, 0)
        local t = tween(notificationGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(-1.1, 0)
        })
        t.Completed:Wait()
    end
end)

function updateNotificationPosition()
    if not notification then return end
    local y = math.floor(-(main.Size.Y.Offset * 0.5) - 38)
    notification.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, main.Position.Y.Offset + y)
end

function showSupportNotification()
    updateNotificationPosition()
    notification.Visible = true
    -- One sound exactly when the notification becomes visible.
    pcall(function() CHGPlaySound("click", 1.0, 0.30) end)
    notification.BackgroundTransparency = 1
    notificationText.TextTransparency = 1
    notificationStroke.Transparency = 1
    local startY = notification.Position.Y.Offset - 18
    local endY = notification.Position.Y.Offset
    notification.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, startY)
    tween(notification, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, endY),
        BackgroundTransparency = 0.08
    })
    tween(notificationText, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    tween(notificationStroke, TweenInfo.new(0.20), {Transparency = 0.45})
    task.delay(2.6, function()
        if not notification or not notification.Parent or not notification.Visible then return end
        local outY = notification.Position.Y.Offset - 14
        tween(notification, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, outY),
            BackgroundTransparency = 1
        })
        tween(notificationText, TweenInfo.new(0.18), {TextTransparency = 1})
        tween(notificationStroke, TweenInfo.new(0.18), {Transparency = 1})
        task.wait(0.27)
        if notification then notification.Visible = false end
    end)
end

-- ======================================================
-- ONE-SCREEN INTRO -> MAIN GUI HANDOFF
-- The intro and CHG hub use the SAME ScreenGui, so the
-- main GUI is not destroyed/recreated after the intro.
-- ======================================================
main.Visible = false
shadow.Visible = false
dragHandle.Visible = false
resizeHandle.Visible = false
notification.Visible = false

local intro = Instance.new("Frame")
intro.Name = "CHGIntro"
intro.Size = UDim2.fromScale(1, 1)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)
intro.BackgroundTransparency = 0.18
intro.BorderSizePixel = 0
intro.ZIndex = 100
intro.Parent = gui

-- Loading background: black -> white -> black sweeping right -> left forever.
local introBgGradient = Instance.new("UIGradient")
introBgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0,0,0))
})
introBgGradient.Rotation = 0
introBgGradient.Offset = Vector2.new(1.2,0)
introBgGradient.Parent = intro

-- Subtle diagonal CHG texture: clean, dark, cinematic, no external assets.
local textureLayer = Instance.new("Frame")
textureLayer.Name = "CHGTexture"
textureLayer.Size = UDim2.fromScale(1,1)
textureLayer.BackgroundTransparency = 1
textureLayer.ZIndex = 100
textureLayer.Parent = intro
for i = -8, 18 do
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = Color3.fromRGB(255,255,255)
    line.BackgroundTransparency = 0.965
    line.Size = UDim2.new(0, 2, 1.6, 0)
    line.Position = UDim2.new(i * 0.07, 0, -0.3, 0)
    line.Rotation = 24
    line.ZIndex = 100
    line.Parent = textureLayer
end
local textureGlow = Instance.new("Frame")
textureGlow.Size = UDim2.new(0, 280, 1, 0)
textureGlow.Position = UDim2.new(0.5, -140, 0, 0)
textureGlow.BackgroundColor3 = Color3.fromRGB(255,45,65)
textureGlow.BackgroundTransparency = 0.93
textureGlow.BorderSizePixel = 0
textureGlow.ZIndex = 100
textureGlow.Parent = textureLayer

task.spawn(function()
    while gui.Parent and intro.Parent do
        introBgGradient.Offset = Vector2.new(1.2,0)
        local tw = tween(introBgGradient, TweenInfo.new(2.2, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.2,0)})
        tw.Completed:Wait()
        task.wait(0.08)
    end
end)

local introCard = Instance.new("Frame")
introCard.AnchorPoint = Vector2.new(0.5,0.5)
introCard.Position = UDim2.fromScale(0.5,0.53)
introCard.Size = UDim2.fromOffset(250,150)
introCard.BackgroundColor3 = Color3.fromRGB(14,14,18)
introCard.BorderSizePixel = 0
introCard.ZIndex = 101
introCard.Parent = intro
local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0,18)
introCorner.Parent = introCard
local introStroke = Instance.new("UIStroke")
introStroke.Color = Color3.fromRGB(255,255,255)
introStroke.Transparency = 0.72
introStroke.Parent = introCard

local introTitle = Instance.new("TextLabel")
introTitle.BackgroundTransparency = 1
introTitle.Size = UDim2.new(1,-20,0,45)
introTitle.Position = UDim2.fromOffset(10,42)
introTitle.Font = Enum.Font.GothamBlack
introTitle.Text = "CHG"
introTitle.TextSize = 34
introTitle.TextColor3 = Color3.new(1,1,1)
introTitle.ZIndex = 102
introTitle.Parent = introCard
local introGrad = Instance.new("UIGradient")
introGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,55,75)),
    ColorSequenceKeypoint.new(0.32, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255,55,75)),
    ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,55,75))
})
introGrad.Offset = Vector2.new(1.1,0)
task.spawn(function()
    while gui.Parent and introTitle.Parent do
        introGrad.Offset = Vector2.new(1.1,0)
        local tw = tween(introGrad, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.1,0)})
        tw.Completed:Wait()
    end
end)
introGrad.Parent = introTitle

local introStatus = Instance.new("TextLabel")
introStatus.BackgroundTransparency = 1
introStatus.Size = UDim2.new(1,-30,0,18)
introStatus.Position = UDim2.fromOffset(15,91)
introStatus.Font = Enum.Font.GothamMedium
introStatus.Text = "CHG • INITIALIZING"
introStatus.TextSize = 10
introStatus.TextColor3 = Color3.fromRGB(150,150,160)
introStatus.ZIndex = 102
introStatus.Parent = introCard

local introBar = Instance.new("Frame")
introBar.Size = UDim2.new(0.72,0,0,4)
introBar.Position = UDim2.new(0.14,0,1,-25)
introBar.BackgroundColor3 = Color3.fromRGB(40,40,48)
introBar.BorderSizePixel = 0
introBar.ZIndex = 102
introBar.Parent = introCard
local ibc = Instance.new("UICorner")
ibc.CornerRadius = UDim.new(1,0)
ibc.Parent = introBar
local introFill = Instance.new("Frame")
introFill.Size = UDim2.new(0,0,1,0)
introFill.BackgroundColor3 = Color3.fromRGB(255,255,255)
introFill.BorderSizePixel = 0
introFill.ZIndex = 103
introFill.Parent = introBar
local ifc = Instance.new("UICorner")
ifc.CornerRadius = UDim.new(1,0)
ifc.Parent = introFill

local introScale = Instance.new("UIScale")
introScale.Scale = 0.82
introScale.Parent = introCard
introCard.BackgroundTransparency = 1
introTitle.TextTransparency = 1
introStatus.TextTransparency = 1
introBar.BackgroundTransparency = 1
introFill.BackgroundTransparency = 1

tween(introScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1})
tween(introCard, TweenInfo.new(0.28), {BackgroundTransparency=0.03})
tween(introTitle, TweenInfo.new(0.25), {TextTransparency=0})
tween(introStatus, TweenInfo.new(0.25), {TextTransparency=0})
tween(introBar, TweenInfo.new(0.25), {BackgroundTransparency=0})
tween(introFill, TweenInfo.new(0.25), {BackgroundTransparency=0})
tween(introFill, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size=UDim2.new(1,0,1,0)})

task.wait(0.55)
task.wait(2.6)
introStatus.Text = "CHG • READY"
task.wait(1.5)

-- Fade the intro away while the MAIN GUI fades in underneath it.
main.Visible = true
shadow.Visible = true
-- The main GUI sound happens at the exact frame the GUI becomes visible.
CHGPlayClick(1.35,0.24)
mainScale.Scale = 0.78
shadowScale.Scale = 0.78
main.BackgroundTransparency = 0
shadow.BackgroundTransparency = 0.84
local handoff = TweenInfo.new(0.52, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tween(mainScale, handoff, {Scale=1})
tween(shadowScale, handoff, {Scale=1})

task.spawn(function()
    task.wait(0.05)
    tween(introScale, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale=0.9})
    tween(intro, TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency=1})
    tween(introCard, TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency=1})
    tween(introTitle, TweenInfo.new(0.25), {TextTransparency=1})
    tween(introStatus, TweenInfo.new(0.25), {TextTransparency=1})
    task.wait(0.4)
    intro:Destroy()
    updateDragHandlePosition()
    dragHandle.Visible = true
    resizeHandle.Visible = true
    task.wait(0.08)
    showSupportNotification()
end)
