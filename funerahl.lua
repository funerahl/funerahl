local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicate injection
if playerGui:FindFirstChild("PentagonistBigCredit") then
	return -- Don't create again if already exists
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PentagonistBigCredit"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Create Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 500, 0, 100)
Frame.Position = UDim2.new(0.5, -250, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(0, 85, 170) -- Blue
Frame.BackgroundTransparency = 1 -- Start transparent
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- UI stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 0, 0)
UIStroke.Transparency = 1 -- Start transparent
UIStroke.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, -20, 0, 50)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.Text = "eject/funerahl & exial made this"
Title.TextWrapped = true
Title.TextTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = Frame
Subtitle.Size = UDim2.new(1, -20, 0, 30)
Subtitle.Position = UDim2.new(0, 10, 0, 55)
Subtitle.BackgroundTransparency = 1
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 16
Subtitle.Text = "- creds to fed"
Subtitle.TextWrapped = true
Subtitle.TextTransparency = 1
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.TextYAlignment = Enum.TextYAlignment.Top

-- Fade-in animation
local fadeIn = TweenService:Create(Frame, TweenInfo.new(1, Enum.EasingStyle.Sine), {
	BackgroundTransparency = 0.1
})
local titleFadeIn = TweenService:Create(Title, TweenInfo.new(1), {TextTransparency = 0})
local subtitleFadeIn = TweenService:Create(Subtitle, TweenInfo.new(1), {TextTransparency = 0})
local strokeFadeIn = TweenService:Create(UIStroke, TweenInfo.new(1), {Transparency = 0.4})

fadeIn:Play()
titleFadeIn:Play()
subtitleFadeIn:Play()
strokeFadeIn:Play()

-- Delay, then fade-out and shrink
task.delay(5, function()
	local fadeOut = TweenService:Create(Frame, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 460, 0, 80),
		Position = UDim2.new(0.5, -230, 0.5, -40)
	})
	local titleFadeOut = TweenService:Create(Title, TweenInfo.new(1.2), {TextTransparency = 1})
	local subtitleFadeOut = TweenService:Create(Subtitle, TweenInfo.new(1.2), {TextTransparency = 1})
	local strokeFadeOut = TweenService:Create(UIStroke, TweenInfo.new(1.2), {Transparency = 1})

	fadeOut:Play()
	titleFadeOut:Play()
	subtitleFadeOut:Play()
	strokeFadeOut:Play()

	fadeOut.Completed:Wait()
	ScreenGui:Destroy()
end)

getgenv().Pentagonist = {
    ['KOCheck'] = true,
    ['Silent Aim'] = {
        ['Enabled'] = true,
        ['Prediction'] = 0.122,
        ['Part'] = "HumanoidRootPart",
        ['EnableJumpPart'] = true,
        ['JumpPart'] = "Head",
        ['Sync Camlock'] = true,
        ['Field Of View'] = {
            ['Visible'] = false,
            ['Color'] = Color3.new(255, 255, 255),
            ['Radius'] = 180,
            ['Transparency'] = 0.07
        },
    },
    ['Camlock'] = {
        ['Enabled'] = true,
        ['Keybind'] = "Q",
        ['Prediction'] = 0.122,
        ['Part'] = "HumanoidRootPart",
        ['Key'] = "Q",
        ['EnableJumpPart'] = true,
        ['JumpPart'] = "Head",
        ['Easing'] = Enum.EasingStyle.Exponential,
        ['Smoothness'] = 0.04,
        ['Field Of View'] = {
            ['Visible'] = false,
            ['Color'] = Color3.new(255, 255, 255),
            ['Radius'] = 90,
            ['Transparency'] = 0.07
        },
    },
}

local players = game.Players
local lp = players.LocalPlayer
local rs = game:GetService("RunService")
local p = getgenv().Pentagonist
local m = lp:GetMouse()
local c = workspace.CurrentCamera
local SilentTarget, CamlockTarget = nil
local CamToggle = false

local Circle = Drawing.new("Circle")
local Circle2 = Drawing.new("Circle")

getgenv().Pentagonist_Connections = {}

local renderSteppedConnection = rs.RenderStepped:Connect(function()
    Circle.Visible = p['Silent Aim']['Field Of View'].Visible
    Circle.Color = p['Silent Aim']['Field Of View'].Color
    Circle.Radius = p['Silent Aim']['Field Of View'].Radius
    Circle.Transparency = p['Silent Aim']['Field Of View'].Transparency
    Circle.Position = Vector2.new(m.X, m.Y + (game:GetService("GuiService"):GetGuiInset().Y))

    Circle2.Visible = p['Camlock']['Field Of View'].Visible
    Circle2.Color = p['Camlock']['Field Of View'].Color
    Circle2.Radius = p['Camlock']['Field Of View'].Radius
    Circle2.Transparency = p['Camlock']['Field Of View'].Transparency
    Circle2.Position = Vector2.new(m.X, m.Y + (game:GetService("GuiService"):GetGuiInset().Y))
end)

table.insert(getgenv().Pentagonist_Connections, renderSteppedConnection)

local function Flags(Plr)
    local Dead = nil
    if Plr and Plr.Character and game.PlaceId == 2788229376 or 7213786345 or 16033173781 or 9825515356 and p.KOCheck then
        if Plr.Character:FindFirstChild("BodyEffects") then
            if Plr.Character.BodyEffects:FindFirstChild("K.O") then
                Dead = Plr.Character.BodyEffects["K.O"].Value
            elseif Plr.Character.BodyEffects:FindFirstChild("KO") then
                Dead = Plr.Character.BodyEffects.KO.Value
            end
        end
    end
    return Dead
end

local function GetClosetsPlr()
    local ClosestTarget = nil
    local MaxDistance = math.huge

    for _, index in pairs(players:GetPlayers()) do
        if index.Name ~= lp.Name and index.Character and index.Character:FindFirstChild("HumanoidRootPart") then
            local Position, OnScreen = c:WorldToScreenPoint(index.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(m.X, m.Y)).Magnitude

            if not OnScreen then
                continue
            end

            if Circle.Radius > Distance and Distance < MaxDistance then
                ClosestTarget = index
                MaxDistance = Distance
            end
        end
    end
    return ClosestTarget
end

local function GetClosetsPlr2()
    local ClosestTarget = nil
    local MaxDistance = math.huge

    for _, index in pairs(players:GetPlayers()) do
        if index.Name ~= lp.Name and index.Character and index.Character:FindFirstChild("HumanoidRootPart") then
            local Position, OnScreen = c:WorldToScreenPoint(index.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(m.X, m.Y)).Magnitude

            if not OnScreen then
                continue
            end

            if Circle2.Radius > Distance and Distance < MaxDistance then
                ClosestTarget = index
                MaxDistance = Distance
            end
        end
    end
    return ClosestTarget
end

local renderSteppedSilentAimConnection = rs.RenderStepped:Connect(function()
    if p['Silent Aim'].Enabled and not p['Silent Aim']['Sync Camlock'] then
        SilentTarget = GetClosetsPlr()
    end
end)

table.insert(getgenv().Pentagonist_Connections, renderSteppedSilentAimConnection)

local inputBeganConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, Processed)
    if Processed then return end

    if input.KeyCode == Enum.KeyCode[p.Camlock.Keybind] then
        CamToggle = not CamToggle

        if p['Silent Aim'].Enabled and p['Silent Aim']['Sync Camlock'] and p.Camlock.Enabled then
            if CamToggle then
                SilentTarget = GetClosetsPlr()
                CamlockTarget = GetClosetsPlr2()
            else
                SilentTarget = nil
                CamlockTarget = nil
            end
        end
    end
end)

table.insert(getgenv().Pentagonist_Connections, inputBeganConnection)

local function args()
    local arg = nil

    if game.PlaceId == 2788229376 then
        arg = "UpdateMousePosI"
    elseif game.PlaceId == 16033173781 then
        arg = "UpdateMousePosI"
    elseif game.PlaceId == 7213786345 then
        arg = "UpdateMousePosI"
    elseif game.PlaceId == 9825515356 then
        arg = "MousePosUpdate"
    else
        arg = "MousePosUpdate"
    end

    return arg
end

local function Velocity(Plr, Part)
    local VELLLL = Plr.Character[Part].Velocity
    return VELLLL
end

local OldPart = p['Silent Aim'].Part
local function SilentMain(index)
    local Event = game.ReplicatedStorage:FindFirstChild("MainEvent")
    local Arguements = args()
    if index:IsA("Tool") then
        index.Activated:Connect(function()
            if SilentTarget and SilentTarget.Character and Event and not Flags(SilentTarget) then
                if p['Silent Aim'].EnableJumpPart then
                    if SilentTarget.Character[p['Silent Aim'].Part].Velocity.Y < -20 then
                        p['Silent Aim'].Part = p['Silent Aim'].JumpPart
                    else
                        p['Silent Aim'].Part = OldPart
                    end
                end

                local EndPosition = SilentTarget.Character[p['Silent Aim'].Part].Position + Velocity(SilentTarget, p['Silent Aim'].Part) * p['Silent Aim'].Prediction
                Event:FireServer(Arguements, EndPosition)
            end
        end)
    end
end

local OldPart2 = p.Camlock.Part
local function Camlock()
    if CamlockTarget and CamlockTarget.Character and not Flags(CamlockTarget) then
        if p.Camlock.EnableJumpPart then
            if CamlockTarget.Character[p.Camlock.Part].Velocity.Y < -20 then
                p.Camlock.Part = p.Camlock.JumpPart
            else
                p.Camlock.Part = OldPart2
            end
        end

        local EndPosition = CFrame.new(c.CFrame.Position, CamlockTarget.Character[p.Camlock.Part].Position + Velocity(CamlockTarget, p.Camlock.Part) * p.Camlock.Prediction)
        c.CFrame = c.CFrame:Lerp(EndPosition, p.Camlock.Smoothness)
    end
end

local renderSteppedCamlockConnection = rs.RenderStepped:Connect(Camlock)

table.insert(getgenv().Pentagonist_Connections, renderSteppedCamlockConnection)

local function onCharacterAdded(character)
    character.ChildAdded:Connect(SilentMain)
    for _, tool in pairs(character:GetChildren()) do
        SilentMain(tool)
    end
end

local characterAddedConnection = lp.CharacterAdded:Connect(onCharacterAdded)

table.insert(getgenv().Pentagonist_Connections, characterAddedConnection)

if lp.Character then
    onCharacterAdded(lp.Character)
end
