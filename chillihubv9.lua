local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local executorName = "Unknown"
local success, result = pcall(function()
    if identifyexecutor then
        return tostring((identifyexecutor()))
    elseif getexecutorname then
        return tostring((getexecutorname()))
    elseif syn and syn.name then
        return tostring((syn.name()))
    elseif Krnl then
        return "KRNL"
    elseif fluxus then
        return "Fluxus"
    end
    return "Unknown"
end)

if success and result and type(result) == "string" and result ~= "" then
    executorName = result
else
    if _G.DeltaLoaded or (identifyexecutor and string.find(string.lower(tostring((identifyexecutor()))), "delta")) then
        executorName = "Delta"
    elseif _G.HydrogenLoaded then
        executorName = "Hydrogen"
    elseif _G.CodexLoaded then
        executorName = "Codex"
    else
        executorName = "Custom / Other Executor"
    end
end

print("Excutor: " .. executorName)

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = Lighting
TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = 20}):Play()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChilliHubLoader"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 130)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -65)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 55, 55)
UIStroke.Transparency = 0.2
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local Glow = Instance.new("UIStroke")
Glow.Color = Color3.fromRGB(255, 30, 30)
Glow.Transparency = 0.7
Glow.Thickness = 4
Glow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 16)
Title.BackgroundTransparency = 1
Title.Text = "CHILLI HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 18)
SubTitle.Position = UDim2.new(0, 0, 0, 42)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "By nmtkiet"
SubTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextSize = 13
SubTitle.Parent = MainFrame

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, -40, 0, 20)
PercentLabel.Position = UDim2.new(0, 20, 0, 70)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "Loading... 0%"
PercentLabel.TextColor3 = Color3.fromRGB(170, 170, 185)
PercentLabel.Font = Enum.Font.GothamSemibold
PercentLabel.TextSize = 12
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.Parent = MainFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -40, 0, 10)
BarBackground.Position = UDim2.new(0, 20, 0, 98)
BarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = MainFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBackground

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = BarBackground

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = ProgressBar

local loadDuration = 3
local startTime = tick()

TweenService:Create(ProgressBar, TweenInfo.new(loadDuration, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()

while true do
    local elapsed = tick() - startTime
    local percent = math.clamp(math.floor((elapsed / loadDuration) * 100), 0, 100)
    PercentLabel.Text = "Loading... " .. percent .. "%"
    
    if elapsed >= loadDuration then
        break
    end
    task.wait()
end

PercentLabel.Text = "Hoàn tất!"
task.wait(0.25)

local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
TweenService:Create(BlurEffect, TweenInfo.new(0.4), {Size = 0}):Play()

task.wait(0.4)
BlurEffect:Destroy()
ScreenGui:Destroy()

loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
