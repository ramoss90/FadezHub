-- Fadez Hub - الإصدار المعدل (يعمل بشكل كامل)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- إنشاء الواجهة الرئيسية
local FadezHub = Instance.new("ScreenGui")
FadezHub.Name = "FadezHub"
FadezHub.Parent = game.CoreGui
FadezHub.ResetOnSpawn = false

-- الألوان
local MainColor = Color3.fromRGB(30, 30, 40)
local AccentColor = Color3.fromRGB(0, 120, 215)

-- النافذة الرئيسية (مخفية في البداية)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = FadezHub
MainFrame.BackgroundColor3 = MainColor
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Visible = false

-- شريط العنوان (لسحب النافذة)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = AccentColor
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Fadez Hub v1.1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14

-- النافذة الصغيرة (FH)
local MiniToggle = Instance.new("TextButton") -- تغيير إلى TextButton لتفعيل النقر
MiniToggle.Name = "MiniToggle"
MiniToggle.Parent = FadezHub
MiniToggle.BackgroundColor3 = AccentColor
MiniToggle.BorderSizePixel = 0
MiniToggle.Position = UDim2.new(0, 10, 0.5, -25)
MiniToggle.Size = UDim2.new(0, 50, 0, 50)
MiniToggle.Text = ""
MiniToggle.AutoButtonColor = false

local ToggleIcon = Instance.new("TextLabel")
ToggleIcon.Name = "ToggleIcon"
ToggleIcon.Parent = MiniToggle
ToggleIcon.BackgroundTransparency = 1
ToggleIcon.Size = UDim2.new(1, 0, 1, 0)
ToggleIcon.Font = Enum.Font.GothamBold
ToggleIcon.Text = "FH"
ToggleIcon.TextColor3 = Color3.new(1, 1, 1)
ToggleIcon.TextSize = 16

-- خاصية سحب النافذة الرئيسية
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- خاصية سحب النافذة الصغيرة
local miniDragging
local miniDragInput
local miniDragStart
local miniStartPos

local function updateMiniInput(input)
    local delta = input.Position - miniDragStart
    MiniToggle.Position = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y)
end

MiniToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        miniDragging = true
        miniDragStart = input.Position
        miniStartPos = MiniToggle.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                miniDragging = false
            end
        end)
    end
end)

MiniToggle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        miniDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == miniDragInput and miniDragging then
        updateMiniInput(input)
    end
end)

-- تفعيل/إخفاء النافذة الرئيسية
MiniToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- إضافة محتوى بسيط للنافذة الرئيسية
local SampleText = Instance.new("TextLabel")
SampleText.Name = "SampleText"
SampleText.Parent = MainFrame
SampleText.BackgroundTransparency = 1
SampleText.Position = UDim2.new(0.5, 0, 0.5, 0)
SampleText.Size = UDim2.new(0, 200, 0, 50)
SampleText.Font = Enum.Font.GothamBold
SampleText.Text = "Fadez Hub يعمل الآن!"
SampleText.TextColor3 = Color3.new(1, 1, 1)
SampleText.TextSize = 18
SampleText.AnchorPoint = Vector2.new(0.5, 0.5)

-- جعل النافذة الصغيرة مرئية والنافذة الرئيسية مخفية عند البدء
MiniToggle.Visible = true
MainFrame.Visible = false