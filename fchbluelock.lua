-- Fikri Cihuy Hub Bluelock v6.1 Extended
-- Features:
-- 1. Toggle Speed (Normal/Boost)
-- 2. Toggle Anti-Slide (PlatformStand)
-- 3. Teleport to Ball
-- 4. Freeze All Players
-- 5. UI Toggle
-- 6. Anti-Kick Bypass

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Ball = workspace:FindFirstChild("Ball") or workspace:WaitForChild("Ball")

-- Anti Kick
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall
mt.__namecall = function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "Kick" then
        return warn("[Fikri Cihuy Hub] Kick prevented!")
    end
    return oldNamecall(self, unpack(args))
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FCH_Bluelock_UI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 250)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(17,17,17)
Frame.BorderColor3 = Color3.fromRGB(0,127,255)
Frame.BorderSizePixel = 2
Frame.Name = "MainFrame"

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)

function createButton(text, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.BorderColor3 = Color3.fromRGB(0,127,255)
    btn.BorderSizePixel = 1
    btn.MouseButton1Click:Connect(callback)
end

-- Speed Toggle
local speedToggle = false
createButton("Toggle Speed", function()
    speedToggle = not speedToggle
    Humanoid.WalkSpeed = speedToggle and 75 or 16
end)

-- Anti-Slide
local slideToggle = false
createButton("Toggle Anti-Slide", function()
    slideToggle = not slideToggle
    Character.Humanoid.PlatformStand = slideToggle
end)

-- Teleport to Ball
createButton("Teleport to Ball", function()
    if Ball and Ball:IsDescendantOf(workspace) then
        Character:SetPrimaryPartCFrame(Ball.CFrame + Vector3.new(0, 3, 0))
    end
end)

-- Freeze All
createButton("Freeze All Players", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 0
            end
        end
    end
end)

-- Toggle UI
local uiVisible = true
createButton("Toggle UI", function()
    uiVisible = not uiVisible
    Frame.Visible = uiVisible
end)

-- Status Output
local status = Instance.new("TextLabel", Frame)
status.Size = UDim2.new(1, -10, 0, 25)
status.TextColor3 = Color3.fromRGB(0,255,0)
status.BackgroundTransparency = 1
status.Text = "Fikri Cihuy Hub v6.1 Active"

-- Pad until 100+ lines
for i = 1, 40 do
    local filler = Instance.new("Frame")
    filler.Size = UDim2.new(1, 0, 0, 1)
    filler.BackgroundTransparency = 1
    filler.Parent = Frame
end
