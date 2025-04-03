
local MacLib = {}

--// Services
local RunService 		= game:GetService("RunService")
local HttpService 		= game:GetService("HttpService")
local UserInputService 	= game:GetService("UserInputService")
local Players 			= game:GetService("Players")
local Player 			= Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer		= game:GetService("StarterPlayer")
local Mouse					= Player:GetMouse()
local VirtualUser				= game:GetService("VirtualUser")

Player.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	task.wait(0.25)
	VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

--// Variables

local icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/src/Icons.lua"))()
local isStudio = RunService:IsStudio()
local LocalPlayer = Players.LocalPlayer

local windowState
local acrylicBlur
local hasGlobalSetting

local tabs = {}
local currentTabInstance = nil
local tabIndex = 0

--// Functions

function Defaults(Default, Settings)
	Settings = Settings or {}
	for k,v in pairs(Default) do
		if Settings[k] == nil then
			Settings[k] = v
		end
	end
	return Settings
end

-- // Addons

local SectionFunctions = {}

do
	local Funcs = {}

	function Funcs:Button(Settings)
		Settings = Defaults({
			Name = "Test Button",
			Callback = function() end
		}, Settings)

		local ButtonFunctions = {}

		local section = self.addons or self.section


		local button = Instance.new("Frame")
		button.Name = "Button"
		button.AutomaticSize = Enum.AutomaticSize.Y
		button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		button.BackgroundTransparency = 1
		button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		button.BorderSizePixel = 0
		button.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		button.Parent = section

		local buttonInteract = Instance.new("TextButton")
		buttonInteract.Name = "ButtonInteract"
		buttonInteract.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		buttonInteract.TextColor3 = Color3.fromRGB(255, 255, 255)
		buttonInteract.TextSize = 13
		buttonInteract.TextTransparency = 0.5
		buttonInteract.TextTruncate = Enum.TextTruncate.AtEnd
		buttonInteract.TextXAlignment = Enum.TextXAlignment.Left
		buttonInteract.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		buttonInteract.BackgroundTransparency = 1
		buttonInteract.BorderColor3 = Color3.fromRGB(0, 0, 0)
		buttonInteract.BorderSizePixel = 0
		buttonInteract.Size = UDim2.fromScale(1, 1)
		buttonInteract.Parent = button
		buttonInteract.Text = tostring(Settings.Name)

		local buttonImage = Instance.new("ImageLabel")
		buttonImage.Name = "ButtonImage"
		buttonImage.Image = "rbxassetid://10709791437"
		buttonImage.ImageTransparency = 0.5
		buttonImage.AnchorPoint = Vector2.new(1, 0.5)
		buttonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		buttonImage.BackgroundTransparency = 1
		buttonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		buttonImage.BorderSizePixel = 0
		buttonImage.Position = UDim2.fromScale(1, 0.5)
		buttonImage.Size = UDim2.fromOffset(15, 15)
		buttonImage.Parent = button

		local TweenSettings = {
			DefaultTransparency = 0.5,
			HoverTransparency = 0.3,

			EasingStyle = Enum.EasingStyle.Sine
		}

		local function ChangeState(State)
			if State == "Idle" then
				buttonInteract.TextTransparency = 0.5
				buttonImage.ImageTransparency = 0.5

			elseif State == "Hover" then
				buttonInteract.TextTransparency = 0.3
				buttonImage.ImageTransparency = 0.3

			end
		end

		local function Callback()
			if Settings.Callback then
				task.spawn(Settings.Callback)
			end
		end

		buttonInteract.MouseEnter:Connect(function()
			ChangeState("Hover")
		end)
		buttonInteract.MouseLeave:Connect(function()
			ChangeState("Idle")
		end)

		buttonInteract.MouseButton1Click:Connect(Callback)
		function ButtonFunctions:UpdateName(Name)
			buttonInteract.Text = tostring(Name)
		end
		return ButtonFunctions

	end

	function Funcs:Toggle(Settings)
		Settings = Defaults({
			Name = "Test Toggle",
			Default = false,
			Callback = function(bool) end
		}, Settings)

		local ToggleFunctions = {}

		local section = self.addons or self.section

		local toggle = Instance.new("Frame")
		toggle.Name = "Toggle"
		toggle.AutomaticSize = Enum.AutomaticSize.Y
		toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		toggle.BackgroundTransparency = 1
		toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		toggle.BorderSizePixel = 0
		toggle.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		toggle.Parent = section

		local toggleName = Instance.new("TextLabel")
		toggleName.Name = "ToggleName"
		toggleName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		toggleName.Text = tostring(Settings.Name)
		toggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggleName.TextSize = 13
		toggleName.TextTransparency = 0.5
		toggleName.TextTruncate = Enum.TextTruncate.AtEnd
		toggleName.TextXAlignment = Enum.TextXAlignment.Left
		toggleName.TextYAlignment = Enum.TextYAlignment.Top
		toggleName.AnchorPoint = Vector2.new(0, 0.5)
		toggleName.AutomaticSize = Enum.AutomaticSize.Y
		toggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		toggleName.BackgroundTransparency = 1
		toggleName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		toggleName.BorderSizePixel = 0
		toggleName.Position = UDim2.fromScale(0, 0.5)
		toggleName.Size = UDim2.new(1, -50, 0, 0)
		toggleName.Parent = toggle

		local toggle1 = Instance.new("ImageButton")
		toggle1.Name = "Toggle"
		toggle1.Image = "rbxassetid://18772190202"
		toggle1.ImageColor3 = Color3.fromRGB(61, 61, 61)
		toggle1.AutoButtonColor = false
		toggle1.AnchorPoint = Vector2.new(1, 0.5)
		toggle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		toggle1.BackgroundTransparency = 1
		toggle1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		toggle1.BorderSizePixel = 0
		toggle1.Position = UDim2.fromScale(1, 0.5)
		toggle1.Size = UDim2.fromOffset(41, 21)

		local toggleUIPadding = Instance.new("UIPadding")
		toggleUIPadding.Name = "ToggleUIPadding"
		toggleUIPadding.PaddingBottom = UDim.new(0, 1)
		toggleUIPadding.PaddingLeft = UDim.new(0, -2)
		toggleUIPadding.PaddingRight = UDim.new(0, 3)
		toggleUIPadding.PaddingTop = UDim.new(0, 1)
		toggleUIPadding.Parent = toggle1

		local togglerHead = Instance.new("ImageLabel")
		togglerHead.Name = "TogglerHead"
		togglerHead.Image = "rbxassetid://18772309008"
		togglerHead.ImageColor3 = Color3.fromRGB(91, 91, 91)
		togglerHead.AnchorPoint = Vector2.new(1, 0.5)
		togglerHead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		togglerHead.BackgroundTransparency = 1
		togglerHead.BorderColor3 = Color3.fromRGB(0, 0, 0)
		togglerHead.BorderSizePixel = 0
		togglerHead.Position = UDim2.fromScale(0.5, 0.5)
		togglerHead.Size = UDim2.fromOffset(15, 15)
		togglerHead.ZIndex = 2
		togglerHead.Parent = toggle1

		toggle1.Parent = toggle

		local TweenSettings = {

			EnabledColors = {Toggle = Color3.fromRGB(87, 86, 86), ToggleHead = Color3.fromRGB(255, 255, 255)},
			DisabledColors = {Toggle = Color3.fromRGB(61, 61, 61), ToggleHead = Color3.fromRGB(91, 91, 91)},

			EnabledPosition = UDim2.new(1, 0, 0.5, 0),
			DisabledPosition = UDim2.new(0.5, 0, 0.5, 0),
		}

		local function ToggleState(State)
			if State then
				toggle1.ImageColor3 = TweenSettings.EnabledColors.Toggle
				togglerHead.ImageColor3 = TweenSettings.EnabledColors.ToggleHead
				togglerHead.Position = TweenSettings.EnabledPosition

			else
				toggle1.ImageColor3 = TweenSettings.DisabledColors.Toggle
				togglerHead.ImageColor3 = TweenSettings.DisabledColors.ToggleHead
				togglerHead.Position = TweenSettings.DisabledPosition

			end
		end

		local togglebool = Settings.Default
		ToggleState(togglebool)

		local function Toggle()
			togglebool = not togglebool
			ToggleState(togglebool)
			if Settings.Callback then
				task.spawn(Settings.Callback, togglebool)
			end
		end

		if togglebool == true then
			if Settings.Callback then
				task.delay(0.05, Settings.Callback, togglebool)
			end
		end

		toggle1.MouseButton1Click:Connect(Toggle)

		function ToggleFunctions:Toggle()
			Toggle()
		end
		function ToggleFunctions:UpdateState(State)
			togglebool = State
			ToggleState(togglebool)
			if Settings.Callback then
				task.spawn(Settings.Callback, togglebool)
			end
		end
		function ToggleFunctions:GetState()
			return togglebool
		end
		function ToggleFunctions:UpdateName(Name)
			toggleName.Text = tostring(Name)
		end

		function ToggleFunctions:CreateAddon()
			local addons = {}

			local MainGUI = game.CoreGui:FindFirstChild("MacLibAddon")
			if not MainGUI then
				MainGUI = Instance.new("ScreenGui")
				MainGUI.Parent = (isStudio and LocalPlayer.PlayerGui) or game.CoreGui
				MainGUI.Name = "MacLibAddon"
				MainGUI.DisplayOrder = 2000
				local uiScale = Instance.new("UIScale")
				uiScale.Scale = MacLib.scale.Scale or 1
				uiScale.Parent = MainGUI
				
				MacLib.scale.Changed:Connect(function()
					uiScale.Scale = MacLib.scale.Scale
				end)
			end
			
			local toggle2 = Instance.new("ImageButton")
			toggle2.Name = "Toggle"
			toggle2.Image = "rbxassetid://10734950309"
			toggle2.ImageColor3 = Color3.fromRGB(120, 120, 120)
			toggle2.AutoButtonColor = false
			toggle2.AnchorPoint = Vector2.new(1, 0.5)
			toggle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggle2.BackgroundTransparency = 1
			toggle2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			toggle2.BorderSizePixel = 0
			toggle2.Position = UDim2.fromScale(0.8, 0.5)
			toggle2.Size = UDim2.fromOffset(21, 18)
			toggle2.Parent = toggle
			toggle2.ZIndex = 999

			local MainFrame = Instance.new("Frame")
			MainFrame.Name = "AddonsFrame"
			MainFrame.AutomaticSize = Enum.AutomaticSize.XY
			MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			MainFrame.BackgroundTransparency = 0.2
			MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MainFrame.BorderSizePixel = 0
			MainFrame.Parent = MainGUI
			MainFrame.ZIndex = 999
			
			MainFrame.DescendantAdded:Connect(function(cc)
				if cc:IsA("GuiObject") then
					cc.ZIndex = 1005
				end
			end)

			local globalSettingsUIStroke = Instance.new("UIStroke")
			globalSettingsUIStroke.Name = "GlobalSettingsUIStroke"
			globalSettingsUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			globalSettingsUIStroke.Color = Color3.fromRGB(255, 255, 255)
			globalSettingsUIStroke.Transparency = 0.9
			globalSettingsUIStroke.Parent = MainFrame

			local globalSettingsUICorner = Instance.new("UICorner")
			globalSettingsUICorner.Name = "GlobalSettingsUICorner"
			globalSettingsUICorner.CornerRadius = UDim.new(0, 10)
			globalSettingsUICorner.Parent = MainFrame

			local globalSettingsUIPadding = Instance.new("UIPadding")
			globalSettingsUIPadding.Name = "GlobalSettingsUIPadding"
			globalSettingsUIPadding.PaddingBottom = UDim.new(0, 20)
			globalSettingsUIPadding.PaddingTop = UDim.new(0, 22)
			globalSettingsUIPadding.PaddingLeft = UDim.new(0, 25)
			globalSettingsUIPadding.PaddingRight = UDim.new(0, 20)
			globalSettingsUIPadding.Parent = MainFrame

			local globalSettingsUIListLayout = Instance.new("UIListLayout")
			globalSettingsUIListLayout.Name = "GlobalSettingsUIListLayout"
			globalSettingsUIListLayout.Padding = UDim.new(0, 5)
			globalSettingsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			globalSettingsUIListLayout.Parent = MainFrame

			local globalSettingsUIScale = Instance.new("UIScale")
			globalSettingsUIScale.Name = "UIScale"
			globalSettingsUIScale.Scale = 1e-07
			globalSettingsUIScale.Parent = MainFrame
			
			local function tog_e2()
				globalSettingsUIScale.Scale = globalSettingsUIScale.Scale == 1 and 1e-07 or 1
			end

			local function updateFramePosition()
				local screenSize = MainGUI.AbsoluteSize
				local buttonPos = toggle2.AbsolutePosition
				local buttonSize = toggle2.AbsoluteSize
				
				local posXScale = (buttonPos.X + buttonSize.X) / screenSize.X
				local posYScale = (buttonPos.Y + buttonSize.Y) / screenSize.Y
				local sizeXScale = buttonSize.X / screenSize.X
				local sizeYScale = buttonSize.Y / screenSize.Y
				
				MainFrame.Position = UDim2.new(posXScale, 0, posYScale, 0)
			end

			local function isOutOfFrame()
				local buttonPos = toggle2.AbsolutePosition
				local buttonSize = toggle2.AbsoluteSize
				local containerPos = section.Parent.Parent.AbsolutePosition
				local containerSize = section.Parent.Parent.AbsoluteSize

				local outOfBounds = 
					buttonPos.Y + buttonSize.Y < containerPos.Y or
					buttonPos.Y > containerPos.Y + containerSize.Y or
					buttonPos.X + buttonSize.X < containerPos.X or
					buttonPos.X > containerPos.X + containerSize.X

				return outOfBounds
			end

			updateFramePosition()

			toggle2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				updateFramePosition()
				local s, e = pcall(isOutOfFrame)
				if s and e then
					globalSettingsUIScale.Scale = 1e-07
				end
			end)
			toggle2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				updateFramePosition()
				local s, e = pcall(isOutOfFrame)
				if s and e then
					globalSettingsUIScale.Scale = 1e-07
				end
			end)
			
			MacLib.base:GetPropertyChangedSignal("Visible"):Connect(function()
				if not MacLib.base.Visible then
					globalSettingsUIScale.Scale = 1e-07
				end
			end)
			
			toggle2.AncestryChanged:Connect(function()
				globalSettingsUIScale.Scale = 1e-07
			end)
			
			toggle2.MouseEnter:Connect(function()
				toggle2.ImageColor3 = Color3.fromRGB(209, 209, 209)
			end)
			toggle2.MouseLeave:Connect(function()
				toggle2.ImageColor3 = Color3.fromRGB(120, 120, 120)
			end)
			
			toggle2.MouseButton1Click:Connect(tog_e2)

			addons.addons = MainFrame

			setmetatable(addons, SectionFunctions)

			return addons

		end

		return ToggleFunctions

	end

	function Funcs:Slider(Settings)
		Settings = Defaults({
			Name = "Test Slider",
			Default = 0,
			Minimum = 0,
			Maximum = 10,
			DisplayMethod = "Value",
			Callback = function(num) end
		}, Settings)

		local SliderFunctions = {}

		local section = self.addons or self.section

		local slider = Instance.new("Frame")
		slider.Name = "Slider"
		slider.AutomaticSize = Enum.AutomaticSize.Y
		slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		slider.BackgroundTransparency = 1
		slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		slider.BorderSizePixel = 0
		slider.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		slider.ClipsDescendants = true
		slider.Parent = section

		local sliderName = Instance.new("TextLabel")
		sliderName.Name = "SliderName"
		sliderName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		sliderName.Text = tostring(Settings.Name)
		sliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
		sliderName.TextSize = 13
		sliderName.TextTransparency = 0.5
		sliderName.TextTruncate = Enum.TextTruncate.AtEnd
		sliderName.TextXAlignment = Enum.TextXAlignment.Left
		sliderName.TextYAlignment = Enum.TextYAlignment.Top
		sliderName.AnchorPoint = Vector2.new(0, 0.5)
		sliderName.AutomaticSize = Enum.AutomaticSize.XY
		sliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderName.BackgroundTransparency = 1
		sliderName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderName.BorderSizePixel = 0
		sliderName.Position = UDim2.fromScale(1.3e-07, 0.15)
		sliderName.Parent = slider

		local sliderElements = Instance.new("Frame")
		sliderElements.Name = "SliderElements"
		sliderElements.AnchorPoint = Vector2.new(1, 0)
		sliderElements.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderElements.BackgroundTransparency = 1
		sliderElements.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderElements.BorderSizePixel = 0
		sliderElements.Position = UDim2.fromScale(1, 0)
		sliderElements.Size = UDim2.fromScale(1, 1)

		local sliderValue = Instance.new("TextBox")
		sliderValue.Name = "SliderValue"
		sliderValue.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		sliderValue.Text = "100%"
		sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
		sliderValue.TextSize = 12
		sliderValue.TextTransparency = 0.4
		sliderValue.TextTruncate = Enum.TextTruncate.AtEnd
		sliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderValue.BackgroundTransparency = 0.95
		sliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderValue.BorderSizePixel = 0
		sliderValue.LayoutOrder = 1
		sliderValue.Position = UDim2.fromScale(-0.0789, 0.171)
		sliderValue.Size = UDim2.fromOffset(41, 21)

		local sliderValueUICorner = Instance.new("UICorner")
		sliderValueUICorner.Name = "SliderValueUICorner"
		sliderValueUICorner.CornerRadius = UDim.new(0, 4)
		sliderValueUICorner.Parent = sliderValue

		local sliderValueUIStroke = Instance.new("UIStroke")
		sliderValueUIStroke.Name = "SliderValueUIStroke"
		sliderValueUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		sliderValueUIStroke.Color = Color3.fromRGB(255, 255, 255)
		sliderValueUIStroke.Transparency = 0.9
		sliderValueUIStroke.Parent = sliderValue

		local sliderValueUIPadding = Instance.new("UIPadding")
		sliderValueUIPadding.Name = "SliderValueUIPadding"
		sliderValueUIPadding.PaddingLeft = UDim.new(0, 2)
		sliderValueUIPadding.PaddingRight = UDim.new(0, 2)
		sliderValueUIPadding.Parent = sliderValue

		sliderValue.Parent = sliderElements

		local sliderElementsUIListLayout = Instance.new("UIListLayout")
		sliderElementsUIListLayout.Name = "SliderElementsUIListLayout"
		sliderElementsUIListLayout.Padding = UDim.new(0, 20)
		sliderElementsUIListLayout.FillDirection = Enum.FillDirection.Horizontal
		sliderElementsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		sliderElementsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		sliderElementsUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		sliderElementsUIListLayout.Parent = sliderElements

		local sliderBar = Instance.new("ImageLabel")
		sliderBar.Name = "SliderBar"
		sliderBar.Image = "rbxassetid://18772615246"
		sliderBar.ImageColor3 = Color3.fromRGB(87, 86, 86)
		sliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderBar.BackgroundTransparency = 1
		sliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderBar.BorderSizePixel = 0
		sliderBar.Position = UDim2.fromScale(0.219, 0.457)
		sliderBar.Size = UDim2.fromOffset(160, 3)

		local sliderHead = Instance.new("ImageButton")
		sliderHead.Name = "SliderHead"
		sliderHead.Image = "rbxassetid://18772834246"
		sliderHead.AnchorPoint = Vector2.new(0.5, 0.5)
		sliderHead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderHead.BackgroundTransparency = 1
		sliderHead.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderHead.BorderSizePixel = 0
		sliderHead.Position = UDim2.fromScale(1, 0.5)
		sliderHead.Size = UDim2.fromOffset(12, 12)
		sliderHead.Parent = sliderBar
		sliderHead.Active = true

		sliderBar.Parent = sliderElements

		local sliderElementsUIPadding = Instance.new("UIPadding")
		sliderElementsUIPadding.Name = "SliderElementsUIPadding"
		sliderElementsUIPadding.PaddingTop = UDim.new(0, 3)
		sliderElementsUIPadding.Parent = sliderElements

		sliderElements.Parent = slider

		local dragging = false

		local DisplayMethods = {
			Hundredths = function(sliderValue)
				return string.format("%.2f", sliderValue)
			end,
			Tenths = function(sliderValue)
				return string.format("%.1f", sliderValue)
			end,
			Round = function(sliderValue)
				return tostring(math.round(sliderValue))
			end,
			Degrees = function(sliderValue)
				return tostring(math.round(sliderValue)) .. "°"
			end,
			Percent = function(sliderValue)
				local percentage = (sliderValue - Settings.Minimum) / (Settings.Maximum - Settings.Minimum) * 100
				return tostring(math.round(percentage)) .. "%"
			end,
			Value = function(sliderValue)
				return tostring(sliderValue)
			end
		}

		local ValueDisplayMethod = DisplayMethods[Settings.DisplayMethod]
		local finalValue

		local function SetValue(val, ignorecallback)
			local posXScale

			if typeof(val) == "Instance" then
				local input = val
				posXScale = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
			else
				local value = val
				posXScale = (value - Settings.Minimum) / (Settings.Maximum - Settings.Minimum)
			end

			local pos = UDim2.new(posXScale, 0, 0.5, 0)
			sliderHead.Position = pos

			finalValue = posXScale * (Settings.Maximum - Settings.Minimum) + Settings.Minimum
			sliderValue.Text = tostring(ValueDisplayMethod(finalValue))

			if not ignorecallback then
				if Settings.Callback then
					task.spawn(Settings.Callback, finalValue)
				end
			end
		end

		SetValue(Settings.Default, true)

		local dragInput;

		sliderHead.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				SetValue(input)

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		sliderHead.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		sliderValue.FocusLost:Connect(function(enterPressed)
			local inputText = sliderValue.Text
			local value, isPercent = inputText:match("^(%-?%d+%.?%d*)(%%?)$")

			if value then
				value = tonumber(value)
				isPercent = isPercent == "%"

				if isPercent then
					value = Settings.Minimum + (value / 100) * (Settings.Maximum - Settings.Minimum)
				end

				local newValue = math.clamp(value, Settings.Minimum, Settings.Maximum)
				SetValue(newValue)
			else
				sliderValue.Text = tostring(ValueDisplayMethod(sliderValue))
			end
		end)

		RunService.RenderStepped:Connect(function()
			if dragging and dragInput then
				SetValue(dragInput)
			end
		end)

		function SliderFunctions:UpdateName(Name)
			sliderName = Name
		end
		function SliderFunctions:UpdateValue(Value)
			SetValue(Value)
		end
		function SliderFunctions:GetState()
			return finalValue
		end
		return SliderFunctions
	end

	function Funcs:Input(Settings)
		Settings = Defaults({
			Name = "Test Input",
			Placeholder = "Placeholder",
			AcceptedCharacters = "All",
			Callback = function(str) end
		}, Settings)

		local InputFunctions = {}

		local section = self.addons or self.section

		local input = Instance.new("Frame")
		input.Name = "Input"
		input.AutomaticSize = Enum.AutomaticSize.XY
		input.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		input.BackgroundTransparency = 1
		input.BorderColor3 = Color3.fromRGB(0, 0, 0)
		input.BorderSizePixel = 0
		input.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		input.Parent = section

		local inputName = Instance.new("TextLabel")
		inputName.Name = "InputName"
		inputName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		inputName.Text = tostring(Settings.Name)
		inputName.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName.TextSize = 13
		inputName.TextTransparency = 0.5
		inputName.TextTruncate = Enum.TextTruncate.AtEnd
		inputName.TextXAlignment = Enum.TextXAlignment.Left
		inputName.TextYAlignment = Enum.TextYAlignment.Top
		inputName.AnchorPoint = Vector2.new(0, 0.5)
		inputName.AutomaticSize = Enum.AutomaticSize.XY
		inputName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName.BackgroundTransparency = 1
		inputName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName.BorderSizePixel = 0
		inputName.Position = UDim2.fromScale(0, 0.5)
		inputName.Parent = input

		local inputBox = Instance.new("TextBox")
		inputBox.Name = "InputBox"
		inputBox.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		inputBox.Text = "Hello world!"
		inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox.TextSize = 12
		inputBox.TextTransparency = 0.4
		inputBox.AnchorPoint = Vector2.new(1, 0.5)
		inputBox.AutomaticSize = Enum.AutomaticSize.X
		inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox.BackgroundTransparency = 0.95
		inputBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox.BorderSizePixel = 0
		inputBox.ClipsDescendants = true
		inputBox.LayoutOrder = 1
		inputBox.Position = UDim2.fromScale(1, 0.5)
		inputBox.Size = UDim2.fromOffset(21, 21)

		local inputBoxUICorner = Instance.new("UICorner")
		inputBoxUICorner.Name = "InputBoxUICorner"
		inputBoxUICorner.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner.Parent = inputBox

		local inputBoxUIStroke = Instance.new("UIStroke")
		inputBoxUIStroke.Name = "InputBoxUIStroke"
		inputBoxUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke.Transparency = 0.9
		inputBoxUIStroke.Parent = inputBox

		local inputBoxUIPadding = Instance.new("UIPadding")
		inputBoxUIPadding.Name = "InputBoxUIPadding"
		inputBoxUIPadding.PaddingLeft = UDim.new(0, 5)
		inputBoxUIPadding.PaddingRight = UDim.new(0, 5)
		inputBoxUIPadding.Parent = inputBox

		local inputBoxUISizeConstraint = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint.Parent = inputBox

		inputBox.Parent = input

		local Input = input
		local InputBox = inputBox
		local InputName = inputName
		local Constraint = inputBoxUISizeConstraint

		local CharacterSubs = {
			All = function(value)
				return value
			end,
			Numeric = function(value)
				return value:match("^%-?%d*$") and value or value:gsub("[^%d-]", ""):gsub("(%-)", function(match, pos, original)
					if pos == 1 then
						return match
					else
						return ""
					end
				end)
			end,
			Alphabetic = function(value)
				return value:gsub("[^a-zA-Z ]", "")
			end,
		}

		local AcceptedCharacters = CharacterSubs[Settings.AcceptedCharacters] or CharacterSubs.All

		InputBox.AutomaticSize = Enum.AutomaticSize.X

		local function checkSize()
			local nameWidth = InputName.AbsoluteSize.X
			local totalWidth = Input.AbsoluteSize.X

			local maxWidth = totalWidth - nameWidth - 20
			Constraint.MaxSize = Vector2.new(maxWidth, 9e9)
		end

		checkSize()
		InputName:GetPropertyChangedSignal("AbsoluteSize"):Connect(checkSize)

		InputBox.FocusLost:Connect(function()
			local inputText = InputBox.Text
			local filteredText = AcceptedCharacters(inputText)
			InputBox.Text = tostring(filteredText)
			if Settings.Callback then
				task.spawn(Settings.Callback, tostring(filteredText))
			end
		end)
		InputBox.Text = tostring(Settings.Default) or ""
		InputBox.PlaceholderText = Settings.Placeholder or ""

		InputBox:GetPropertyChangedSignal("Text"):Connect(function()
			InputBox.Text = tostring(AcceptedCharacters(InputBox.Text))
		end)

		function InputFunctions:UpdateName(Name)
			inputName.Text = tostring(Name)
		end
		function InputFunctions:GetInput()
			return InputBox.Text
		end
		function InputFunctions:UpdatePlaceholder(Placeholder)
			inputBox.PlaceholderText = Placeholder
		end
		function InputFunctions:UpdateText(Text)
			inputBox.Text = tostring(Text)
		end
		return InputFunctions

	end

	function Funcs:Keybind(Settings)
		Settings = Defaults({
			Name = "Test Keybind",
			Default = Enum.KeyCode.X,
			Callback = function(key) end
		}, Settings)

		local KeybindFunctions = {}

		local section = self.addons or self.section

		local keybind = Instance.new("Frame")
		keybind.Name = "Keybind"
		keybind.AutomaticSize = Enum.AutomaticSize.XY
		keybind.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		keybind.BackgroundTransparency = 1
		keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		keybind.BorderSizePixel = 0
		keybind.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		keybind.Parent = section

		local keybindName = Instance.new("TextLabel")
		keybindName.Name = "KeybindName"
		keybindName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		keybindName.Text = tostring(Settings.Name)
		keybindName.TextColor3 = Color3.fromRGB(255, 255, 255)
		keybindName.TextSize = 13
		keybindName.TextTransparency = 0.5
		keybindName.TextTruncate = Enum.TextTruncate.AtEnd
		keybindName.TextXAlignment = Enum.TextXAlignment.Left
		keybindName.TextYAlignment = Enum.TextYAlignment.Top
		keybindName.AnchorPoint = Vector2.new(0, 0.5)
		keybindName.AutomaticSize = Enum.AutomaticSize.XY
		keybindName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		keybindName.BackgroundTransparency = 1
		keybindName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		keybindName.BorderSizePixel = 0
		keybindName.Position = UDim2.fromScale(0, 0.5)
		keybindName.Parent = keybind

		local binderBox = Instance.new("TextBox")
		binderBox.Name = "BinderBox"
		binderBox.CursorPosition = -1
		binderBox.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		binderBox.PlaceholderText = "..."
		binderBox.Text = ""
		binderBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		binderBox.TextSize = 12
		binderBox.TextTransparency = 0.4
		binderBox.AnchorPoint = Vector2.new(1, 0.5)
		binderBox.AutomaticSize = Enum.AutomaticSize.X
		binderBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		binderBox.BackgroundTransparency = 0.95
		binderBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		binderBox.BorderSizePixel = 0
		binderBox.ClipsDescendants = true
		binderBox.LayoutOrder = 1
		binderBox.Position = UDim2.fromScale(1, 0.5)
		binderBox.Size = UDim2.fromOffset(21, 21)

		local binderBoxUICorner = Instance.new("UICorner")
		binderBoxUICorner.Name = "BinderBoxUICorner"
		binderBoxUICorner.CornerRadius = UDim.new(0, 4)
		binderBoxUICorner.Parent = binderBox

		local binderBoxUIStroke = Instance.new("UIStroke")
		binderBoxUIStroke.Name = "BinderBoxUIStroke"
		binderBoxUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		binderBoxUIStroke.Color = Color3.fromRGB(255, 255, 255)
		binderBoxUIStroke.Transparency = 0.9
		binderBoxUIStroke.Parent = binderBox

		local binderBoxUIPadding = Instance.new("UIPadding")
		binderBoxUIPadding.Name = "BinderBoxUIPadding"
		binderBoxUIPadding.PaddingLeft = UDim.new(0, 5)
		binderBoxUIPadding.PaddingRight = UDim.new(0, 5)
		binderBoxUIPadding.Parent = binderBox

		local binderBoxUISizeConstraint = Instance.new("UISizeConstraint")
		binderBoxUISizeConstraint.Name = "BinderBoxUISizeConstraint"
		binderBoxUISizeConstraint.Parent = binderBox

		binderBox.Parent = keybind

		local focused
		local binded = Settings.Default
		if binded then
			binderBox.Text = tostring(binded.Name)
		end

		binderBox.Focused:Connect(function()
			focused = true
		end)
		binderBox.FocusLost:Connect(function()
			focused = false
		end)

		UserInputService.InputEnded:Connect(function(inp)
			if MacLib.macLib ~= nil then
				if focused and inp.KeyCode.Name ~= "Unknown" then
					binded = inp.KeyCode
					binderBox.Text = tostring(inp.KeyCode.Name)
					binderBox:ReleaseFocus()
				elseif inp.KeyCode == binded then
					if Settings.Callback then
						task.spawn(Settings.Callback, binded)
					end
				end
			end
		end)
		function KeybindFunctions:Bind(Key)
			binded = Key
			binderBox.Text = tostring(Key.Name)
		end
		function KeybindFunctions:Unbind()
			binded = nil
			binderBox.Text = ""
		end
		function KeybindFunctions:GetBind()
			return binded
		end
		function KeybindFunctions:UpdateName(Name)
			keybindName = Name
		end

		return KeybindFunctions
	end

	function Funcs:Destroy()
		if self.section ~= nil then
			pcall(function()
				self.section:Destroy()
			end)
		end
	end

	function Funcs:Dropdown(Settings)
		Settings = Defaults({
			Name = "Test Dropdown",
			Multi = false,
			Required = false,
			Options = {"1", "2", "3"},
			Default = 1,
			Callback = function(str) end
		}, Settings)

		local DropdownFunctions = {}
		local Selected = {}
		local OptionObjs = {}
		local _dropdown_callback = Settings.Callback

		local section = self.addons or self.section

		local dropdown = Instance.new("Frame")
		dropdown.Name = "Dropdown"
		dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdown.BackgroundTransparency = 0.985
		dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dropdown.BorderSizePixel = 0
		dropdown.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		dropdown.Parent = section
		dropdown.ClipsDescendants = true

		local interact = Instance.new("TextButton")
		interact.Name = "Interact"
		interact.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		interact.Text = ""
		interact.TextColor3 = Color3.fromRGB(0, 0, 0)
		interact.TextSize = 14
		interact.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		interact.BackgroundTransparency = 1
		interact.BorderColor3 = Color3.fromRGB(0, 0, 0)
		interact.BorderSizePixel = 0
		interact.Size = UDim2.new(1, 0, 0, 38)
		interact.Parent = dropdown

		local dropdownName = Instance.new("TextLabel")
		dropdownName.Name = "DropdownName"
		dropdownName.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		dropdownName.Text = tostring(Settings.Name)
		dropdownName.RichText = true
		dropdownName.TextColor3 = Color3.fromRGB(255, 255, 255)
		dropdownName.TextSize = 13
		dropdownName.TextTransparency = 0.5
		dropdownName.TextTruncate = Enum.TextTruncate.SplitWord
		dropdownName.TextXAlignment = Enum.TextXAlignment.Left
		dropdownName.AutomaticSize = Enum.AutomaticSize.Y
		dropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdownName.BackgroundTransparency = 1
		dropdownName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dropdownName.BorderSizePixel = 0
		dropdownName.Size = UDim2.new(1, -20, 0, 38)
		dropdownName.Parent = dropdown

		local dropdownUIStroke = Instance.new("UIStroke")
		dropdownUIStroke.Name = "DropdownUIStroke"
		dropdownUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		dropdownUIStroke.Color = Color3.fromRGB(255, 255, 255)
		dropdownUIStroke.Transparency = 0.95
		dropdownUIStroke.Parent = dropdown

		local dropdownUICorner = Instance.new("UICorner")
		dropdownUICorner.Name = "DropdownUICorner"
		dropdownUICorner.CornerRadius = UDim.new(0, 6)
		dropdownUICorner.Parent = dropdown

		local dropdownImage = Instance.new("ImageLabel")
		dropdownImage.Name = "DropdownImage"
		dropdownImage.Image = "rbxassetid://18865373378"
		dropdownImage.ImageTransparency = 0.5
		dropdownImage.AnchorPoint = Vector2.new(1, 0)
		dropdownImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdownImage.BackgroundTransparency = 1
		dropdownImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dropdownImage.BorderSizePixel = 0
		dropdownImage.Position = UDim2.new(1, 0, 0, 12)
		dropdownImage.Size = UDim2.fromOffset(14, 14)
		dropdownImage.Parent = dropdown

		local dropdownFrame = Instance.new("Frame")
		dropdownFrame.Name = "DropdownFrame"
		dropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdownFrame.BackgroundTransparency = 1
		dropdownFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dropdownFrame.BorderSizePixel = 0
		dropdownFrame.ClipsDescendants = true
		dropdownFrame.Size = UDim2.fromScale(1, 1)
		dropdownFrame.Visible = false
		dropdownFrame.AutomaticSize = Enum.AutomaticSize.Y

		local dropdownFrameUIPadding = Instance.new("UIPadding")
		dropdownFrameUIPadding.Name = "DropdownFrameUIPadding"
		dropdownFrameUIPadding.PaddingBottom = UDim.new(0, 8)
		dropdownFrameUIPadding.PaddingTop = UDim.new(0, 38)
		dropdownFrameUIPadding.Parent = dropdownFrame

		local dropdownFrameUIListLayout = Instance.new("UIListLayout")
		dropdownFrameUIListLayout.Name = "DropdownFrameUIListLayout"
		dropdownFrameUIListLayout.Padding = UDim.new(0, 5)
		dropdownFrameUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		dropdownFrameUIListLayout.Parent = dropdownFrame

		local function ResetName()
			if #Selected > 0 then
				dropdownName.Text = tostring(Settings.Name) .. " • " .. table.concat(Selected, ", ")
			else
				dropdownName.Text = tostring(Settings.Name)
			end
		end

		local function UpdateDropdown()
			for _, xz in pairs(dropdownFrame:GetChildren()) do
				if xz:IsA("TextButton") or xz:IsA("GuiObject") then
					xz:Destroy()
				end
			end
			OptionObjs = {}

			local search = Instance.new("Frame")
			search.Name = "Search"
			search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			search.BackgroundTransparency = 0.95
			search.BorderColor3 = Color3.fromRGB(0, 0, 0)
			search.BorderSizePixel = 0
			search.LayoutOrder = -1
			search.Size = UDim2.new(1, 0, 0, 27)
			search.Parent = dropdownFrame
			search.Visible = Settings.Search or true

			local sectionUICorner = Instance.new("UICorner")
			sectionUICorner.Name = "SectionUICorner"
			sectionUICorner.Parent = search

			local searchIcon = Instance.new("ImageLabel")
			searchIcon.Name = "SearchIcon"
			searchIcon.Image = "rbxassetid://86737463322606"
			searchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
			searchIcon.AnchorPoint = Vector2.new(0, 0.5)
			searchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			searchIcon.BackgroundTransparency = 1
			searchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			searchIcon.BorderSizePixel = 0
			searchIcon.Position = UDim2.fromScale(0, 0.5)
			searchIcon.Size = UDim2.fromOffset(12, 12)
			searchIcon.Parent = search

			local uIPadding = Instance.new("UIPadding")
			uIPadding.Name = "UIPadding"
			uIPadding.PaddingLeft = UDim.new(0, 15)
			uIPadding.Parent = search

			local searchBox = Instance.new("TextBox")
			searchBox.Name = "SearchBox"
			searchBox.CursorPosition = -1
			searchBox.FontFace = Font.new(
				"rbxassetid://12187365364",
				Enum.FontWeight.Medium,
				Enum.FontStyle.Normal
			)
			searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
			searchBox.PlaceholderText = "Search..."
			searchBox.Text = ""
			searchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
			searchBox.TextSize = 14
			searchBox.TextXAlignment = Enum.TextXAlignment.Left
			searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			searchBox.BackgroundTransparency = 1
			searchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			searchBox.BorderSizePixel = 0
			searchBox.Size = UDim2.fromScale(1, 1)

			local function findOption()
				local searchTerm = searchBox.Text:lower()

				for _, v in pairs(OptionObjs) do
					local optionText = v.NameLabel.Text:lower()
					local isVisible = string.find(optionText, searchTerm) ~= nil

					if v.Button.Visible ~= isVisible then
						v.Button.Visible = isVisible
					end
				end
			end

			searchBox:GetPropertyChangedSignal("Text"):Connect(findOption)


			local uIPadding1 = Instance.new("UIPadding")
			uIPadding1.Name = "UIPadding"
			uIPadding1.PaddingLeft = UDim.new(0, 23)
			uIPadding1.Parent = searchBox

			searchBox.Parent = search

			local tweensettings = {
				duration = 0.2,
				easingStyle = Enum.EasingStyle.Quint,
				transparencyIn = 0.2,
				transparencyOut = 0.5,
				checkSizeIncrease = 12,
				checkSizeDecrease = -13,
				waitTime = 1
			}

			local function Toggle(optionName, State)
				local option = OptionObjs[optionName]

				if not option then return end

				local checkmark = option.Checkmark
				local optionNameLabel = option.NameLabel

				if State then
					if Settings.Multi then
						if not table.find(Selected, optionName) then
							table.insert(Selected, optionName)
						end
					else
						for name, opt in pairs(OptionObjs) do
							if name ~= optionName then
								opt.Checkmark.Size = UDim2.new(opt.Checkmark.Size.X.Scale, tweensettings.checkSizeDecrease, opt.Checkmark.Size.Y.Scale, opt.Checkmark.Size.Y.Offset)
								opt.NameLabel.TextTransparency = tweensettings.transparencyOut
								opt.Checkmark.TextTransparency = 1
							end
						end
						Selected = {optionName}
					end
					checkmark.Size = UDim2.new(checkmark.Size.X.Scale, tweensettings.checkSizeIncrease, checkmark.Size.Y.Scale, checkmark.Size.Y.Offset)
					optionNameLabel.TextTransparency = tweensettings.transparencyIn
					checkmark.TextTransparency = 0
				else
					if Settings.Multi then
						local idx = table.find(Selected, optionName)
						if idx then
							table.remove(Selected, idx)
						end
					else
						Selected = {}
					end

					checkmark.Size = UDim2.new(checkmark.Size.X.Scale, tweensettings.checkSizeDecrease, checkmark.Size.Y.Scale, checkmark.Size.Y.Offset)
					optionNameLabel.TextTransparency = tweensettings.transparencyOut

					checkmark.TextTransparency = 1
				end

				if Settings.Required and #Selected == 0 and not State then
					return
				end

				ResetName()
			end

			for i, v in pairs(Settings.Options) do
				local option = Instance.new("TextButton")
				option.Name = "Option"
				option.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				option.Text = ""
				option.TextColor3 = Color3.fromRGB(0, 0, 0)
				option.TextSize = 14
				option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				option.BackgroundTransparency = 1
				option.BorderColor3 = Color3.fromRGB(0, 0, 0)
				option.BorderSizePixel = 0
				option.Size = UDim2.new(1, 0, 0, 30)
				if v == "" then
					option.Visible = false
				end

				local optionUIPadding = Instance.new("UIPadding")
				optionUIPadding.Name = "OptionUIPadding"
				optionUIPadding.PaddingLeft = UDim.new(0, 15)
				optionUIPadding.Parent = option

				local optionName = Instance.new("TextLabel")
				optionName.Name = "OptionName"
				optionName.FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.Medium,
					Enum.FontStyle.Normal
				)
				optionName.Text = tostring(v)
				optionName.RichText = true
				optionName.TextColor3 = Color3.fromRGB(255, 255, 255)
				optionName.TextSize = 13
				optionName.TextTransparency = 0.5
				optionName.TextTruncate = Enum.TextTruncate.AtEnd
				optionName.TextXAlignment = Enum.TextXAlignment.Left
				optionName.TextYAlignment = Enum.TextYAlignment.Top
				optionName.AnchorPoint = Vector2.new(0, 0.5)
				optionName.AutomaticSize = Enum.AutomaticSize.XY
				optionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				optionName.BackgroundTransparency = 1
				optionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
				optionName.BorderSizePixel = 0
				optionName.Position = UDim2.fromScale(1.3e-07, 0.5)
				optionName.Parent = option

				local optionUIListLayout = Instance.new("UIListLayout")
				optionUIListLayout.Name = "OptionUIListLayout"
				optionUIListLayout.Padding = UDim.new(0, 10)
				optionUIListLayout.FillDirection = Enum.FillDirection.Horizontal
				optionUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				optionUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				optionUIListLayout.Parent = option

				local checkmark = Instance.new("TextLabel")
				checkmark.Name = "Checkmark"
				checkmark.FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.Medium,
					Enum.FontStyle.Normal
				)
				checkmark.Text = "✓"
				checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
				checkmark.TextSize = 13
				checkmark.TextTransparency = 1
				checkmark.TextXAlignment = Enum.TextXAlignment.Left
				checkmark.TextYAlignment = Enum.TextYAlignment.Top
				checkmark.AnchorPoint = Vector2.new(0, 0.5)
				checkmark.AutomaticSize = Enum.AutomaticSize.Y
				checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				checkmark.BackgroundTransparency = 1
				checkmark.BorderColor3 = Color3.fromRGB(0, 0, 0)
				checkmark.BorderSizePixel = 0
				checkmark.LayoutOrder = -1
				checkmark.Position = UDim2.fromScale(1.3e-07, 0.5)
				checkmark.Size = UDim2.fromOffset(-13, 0)
				checkmark.Parent = option

				option.Parent = dropdownFrame

				dropdownFrame.Parent = dropdown
				OptionObjs[v] = {
					Index = i,
					Button = option,
					NameLabel = optionName,
					Checkmark = checkmark
				}

				local dropdownUIPadding = Instance.new("UIPadding")
				dropdownUIPadding.Name = "DropdownUIPadding"
				dropdownUIPadding.PaddingLeft = UDim.new(0, 15)
				dropdownUIPadding.PaddingRight = UDim.new(0, 15)
				dropdownUIPadding.Parent = dropdown

				local tweensettings = {
					duration = 0.2,
					easingStyle = Enum.EasingStyle.Quint,
					transparencyIn = 0.2,
					transparencyOut = 0.5,
					checkSizeIncrease = 12,
					checkSizeDecrease = -optionUIListLayout.Padding.Offset,
					waitTime = 1
				}

				local isSelected = false
				if Settings.Default then
					if Settings.Multi then
						isSelected = (table.find(Settings.Default, v) or Settings.Default[v] == true) and true or false
					else
						isSelected = (Settings.Default == i or Settings.Default == v) and true or false
					end
				end
				local option = OptionObjs[v].Button

				local function tog_gle()
					local isSelecteds = table.find(Selected, v) and true or false;

					local newSelected = not isSelecteds

					if Settings.Required and not newSelected and #Selected <= 1 then
						return
					end

					Toggle(v, newSelected)

					task.spawn(function()
						if Settings.Multi then
							local Return = {}
							for _, opt in ipairs(Selected) do
								Return[opt] = true
							end
							_dropdown_callback(Return)
							--Settings.Callback(Return)
						else
							if newSelected then
								_dropdown_callback(Selected[1] or "")
							else
								_dropdown_callback("")
								--Settings.Callback(Selected[1] or nil)
							end
						end
					end)
				end

				OptionObjs[v].Toggle = function()
					task.spawn(tog_gle)
				end

				if isSelected then
					Toggle(v, isSelected)
				end

				option.MouseButton1Click:Connect(tog_gle)

				ResetName()
			end
		end


		local function CalculateDropdownSize()
			local count = 0
			for _,v in pairs(dropdownFrame:GetChildren()) do
				if v:IsA("GuiObject") and v.Visible then count += 1 end
			end
			if count == 0 then
				count = 1
			end
			local calculationVals = {
				[1] = dropdown.AbsoluteSize.Y,
				[2] = dropdownFrameUIPadding.PaddingTop.Offset - dropdownFrameUIPadding.PaddingBottom.Offset,
				[3] = 34 * count
			}
			return calculationVals[1] + calculationVals[2] + calculationVals[3]
		end

		local dropped = false
		local function ToggleDropdown()
			local defaultDropdownSize = 38
			local isDropdownOpen = not dropped
			local isAddon = self.addons ~= nil
			local targetSize = isDropdownOpen and UDim2.new(isAddon and 0 or 1, isAddon and 250 or 0, 0, CalculateDropdownSize()) or UDim2.new(isAddon and 0 or 1, isAddon and 250 or 0, 0, defaultDropdownSize)

			dropdown.Size = targetSize

			if isDropdownOpen then
				dropdownFrame.Visible = true
			else
				dropdownFrame.Visible = false
			end

			dropped = isDropdownOpen
		end

		interact.MouseButton1Click:Connect(ToggleDropdown)

		function DropdownFunctions:UpdateName(New)
			dropdownName.Text = tostring(New)
		end

		function DropdownFunctions:SetVisibility(State)
			dropdown.Visible = State
		end

		function DropdownFunctions:SetCallback(Callback_Func)
			if typeof(Callback_Func) == "function" then
				_dropdown_callback = Callback_Func
			end
		end

		function DropdownFunctions:SetDropdown(Selection)
			Settings.Options = Selection
			local newSelected = {}
			for i,v in pairs(Selected) do
				if table.find(Settings.Options, v) then				
					table.insert(newSelected, v)
				end
			end
			Selected = newSelected
			if Settings.Multi then
				Settings.Default = newSelected
			else
				Settings.Default = Selected[1]
			end
			UpdateDropdown()
		end

        function DropdownFunctions:Set(Value)
            if Settings.Multi then
                if typeof(Value) == "table" then
                    if #Value == 0 then
                        for optionName, optionObj in pairs(OptionObjs) do
                            if table.find(Selected, optionName) then
                                Toggle(optionName, false)
                            end
                        end
                    else
                        for xz, zx in pairs(Value) do
                            if not table.find(Selected, zx) then
                                if OptionObjs[zx] then
                                    OptionObjs[zx].Toggle()
                                end
                            end
                        end
                    end
                end
            else
                if not table.find(Selected, Value) then
                    if #Selected >= 1 then
                        for xz, zx in pairs(OptionObjs) do
                            if xz ~= Value then
                                zx.Toggle()
                            end
                        end
                    end
                    if OptionObjs[Value] then
                        OptionObjs[Value].Toggle()
                    end
                end
            end
        end

		UpdateDropdown()
		ResetName()

		return DropdownFunctions
	end

	function Funcs:Header(Settings)
		Settings = Defaults({
			Name = "Test Header"
		}, Settings)
		local HeaderFunctions = {}

		local section = self.addons or self.section

		local header = Instance.new("Frame")
		header.Name = "Header"
		header.AutomaticSize = Enum.AutomaticSize.XY
		header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		header.BackgroundTransparency = 1
		header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		header.BorderSizePixel = 0
		header.LayoutOrder = 0
		header.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.fromScale(1, 0)
		header.Parent = section

		local uIPadding = Instance.new("UIPadding")
		uIPadding.Name = "UIPadding"
		uIPadding.PaddingBottom = UDim.new(0, 5)
		uIPadding.Parent = header

		local headerText = Instance.new("TextLabel")
		headerText.Name = "HeaderText"
		headerText.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.SemiBold,
			Enum.FontStyle.Normal
		)
		headerText.RichText = true
		headerText.Text = tostring(Settings.Name)
		headerText.TextColor3 = Color3.fromRGB(255, 255, 255)
		headerText.TextSize = 16
		headerText.TextTransparency = 0.4
		headerText.TextWrapped = true
		headerText.TextXAlignment = Enum.TextXAlignment.Left
		headerText.AutomaticSize = Enum.AutomaticSize.Y
		headerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		headerText.BackgroundTransparency = 1
		headerText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		headerText.BorderSizePixel = 0
		headerText.Size = UDim2.fromScale(1, 0)
		headerText.Parent = header

		function HeaderFunctions:UpdateName(New)
			headerText.Text = tostring(New)
		end

		return HeaderFunctions
	end

	function Funcs:Label(Settings)
		Settings = Defaults({
			Name = "Test Label"
		}, Settings)

		local LabelFunctions = {}

		local section = self.addons or self.section

		local label = Instance.new("Frame")
		label.Name = "Label"
		label.AutomaticSize = Enum.AutomaticSize.XY
		label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		label.BackgroundTransparency = 1
		label.BorderColor3 = Color3.fromRGB(0, 0, 0)
		label.BorderSizePixel = 0
		label.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		label.Parent = section

		local labelText = Instance.new("TextLabel")
		labelText.Name = "LabelText"
		labelText.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		labelText.RichText = true
		labelText.Text = tostring(Settings.Name)
		labelText.TextColor3 = Color3.fromRGB(255, 255, 255)
		labelText.TextSize = 13
		labelText.TextTransparency = 0.5
		labelText.TextWrapped = true
		labelText.TextXAlignment = Enum.TextXAlignment.Left
		labelText.AutomaticSize = Enum.AutomaticSize.Y
		labelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		labelText.BackgroundTransparency = 1
		labelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		labelText.BorderSizePixel = 0
		labelText.Size = UDim2.fromScale(1, 1)
		labelText.Parent = label

		function LabelFunctions:UpdateName(New)
			labelText.Text = tostring(New)
		end

		return LabelFunctions
	end

	function Funcs:Paragraph(Settings)
		Settings = Defaults({
			Body = "Test Paragraph"
		}, Settings)

		local ParagraphFunctions = {}

		local section = self.addons or self.section

		local paragraph = Instance.new("Frame")
		paragraph.Name = "Paragraph"
		paragraph.AutomaticSize = Enum.AutomaticSize.Y
		paragraph.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		paragraph.BackgroundTransparency = 1
		paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
		paragraph.BorderSizePixel = 0
		paragraph.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		paragraph.Parent = section

		local uIPadding = Instance.new("UIPadding")
		uIPadding.Name = "UIPadding"
		uIPadding.PaddingBottom = UDim.new(0, 8)
		uIPadding.PaddingTop = UDim.new(0, 8)
		uIPadding.Parent = paragraph

		local paragraphHeader = Instance.new("TextLabel")
		paragraphHeader.Name = "ParagraphHeader"
		paragraphHeader.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		paragraphHeader.RichText = true
		paragraphHeader.Text = tostring(Settings.Header)
		paragraphHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
		paragraphHeader.TextSize = 16
		paragraphHeader.TextTransparency = 0.4
		paragraphHeader.TextWrapped = true
		paragraphHeader.TextXAlignment = Enum.TextXAlignment.Left
		paragraphHeader.AutomaticSize = Enum.AutomaticSize.Y
		paragraphHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		paragraphHeader.BackgroundTransparency = 1
		paragraphHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
		paragraphHeader.BorderSizePixel = 0
		paragraphHeader.Size = UDim2.fromScale(1, 0)
		paragraphHeader.Parent = paragraph

		local uIListLayout = Instance.new("UIListLayout")
		uIListLayout.Name = "UIListLayout"
		uIListLayout.Padding = UDim.new(0, 5)
		uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout.Parent = paragraph

		local paragraphBody = Instance.new("TextLabel")
		paragraphBody.Name = "ParagraphBody"
		paragraphBody.FontFace = Font.new("rbxassetid://12187365364")
		paragraphBody.RichText = true
		paragraphBody.Text = tostring(Settings.Body)
		paragraphBody.TextColor3 = Color3.fromRGB(255, 255, 255)
		paragraphBody.TextSize = 13
		paragraphBody.TextTransparency = 0.5
		paragraphBody.TextWrapped = true
		paragraphBody.TextXAlignment = Enum.TextXAlignment.Left
		paragraphBody.AutomaticSize = Enum.AutomaticSize.Y
		paragraphBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		paragraphBody.BackgroundTransparency = 1
		paragraphBody.BorderColor3 = Color3.fromRGB(0, 0, 0)
		paragraphBody.BorderSizePixel = 0
		paragraphBody.LayoutOrder = 1
		paragraphBody.Size = UDim2.fromScale(1, 0)
		paragraphBody.Parent = paragraph

		function ParagraphFunctions:UpdateHeader(New)
			paragraphHeader.Text = tostring(New)
		end
		function ParagraphFunctions:UpdateBody(New)
			paragraphBody.Text = tostring(New)
		end

		return ParagraphFunctions

	end

	function Funcs:Divider()
		local DividerFunctions = {}

		local section = self.addons or self.section

		local divider = Instance.new("Frame")
		divider.Name = "Divider"
		divider.AnchorPoint = Vector2.new(0, 1)
		divider.AutomaticSize = Enum.AutomaticSize.Y
		divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		divider.BackgroundTransparency = 1
		divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		divider.BorderSizePixel = 0
		divider.Position = UDim2.fromScale(0, 1)
		divider.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 1)
		divider.Parent = section

		local uIPadding = Instance.new("UIPadding")
		uIPadding.Name = "UIPadding"
		uIPadding.PaddingBottom = UDim.new(0, 8)
		uIPadding.PaddingTop = UDim.new(0, 8)
		uIPadding.Parent = divider

		local uIListLayout = Instance.new("UIListLayout")
		uIListLayout.Name = "UIListLayout"
		uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout.Parent = divider

		local line = Instance.new("Frame")
		line.Name = "Line"
		line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		line.BackgroundTransparency = 0.9
		line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		line.BorderSizePixel = 0
		line.Size = UDim2.new(1, 0, 0, 1)
		line.Parent = divider

		function DividerFunctions:Remove()
			divider:Destroy()
		end

		return DividerFunctions
	end

	function Funcs:Spacer()
		local SpacerFunctions = {}

		local section = self.addons or self.section

		local spacer = Instance.new("Frame")
		spacer.Name = "Spacer"
		spacer.AnchorPoint = Vector2.new(0, 1)
		spacer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		spacer.BackgroundTransparency = 1
		spacer.BorderColor3 = Color3.fromRGB(0, 0, 0)
		spacer.BorderSizePixel = 0
		spacer.Position = UDim2.fromScale(0, 1)
		spacer.Parent = section

		function SpacerFunctions:Remove()
			spacer:Destroy()
		end

		return SpacerFunctions
	end

	function Funcs:SubLabel(Settings)
		Settings = Defaults({
			Text = "Test SubLabel"
		}, Settings)

		local SubLabelFunctions = {}
		local section = self.addons or self.section

		local subLabel = Instance.new("Frame")
		subLabel.Name = "SubLabel"
		subLabel.AutomaticSize = Enum.AutomaticSize.Y
		subLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		subLabel.BackgroundTransparency = 1
		subLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subLabel.BorderSizePixel = 0
		subLabel.Size = UDim2.new(1, 0, 0, 0)
		subLabel.Parent = section

		local subLabelText = Instance.new("TextLabel")
		subLabelText.Name = "SubLabelText"
		subLabelText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		subLabelText.RichText = true
		subLabelText.Text = tostring(Settings.Text) or tostring(Settings.Name) -- Settings.Name Deprecated
		subLabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
		subLabelText.TextSize = 11
		subLabelText.TextTransparency = 0.7
		subLabelText.TextWrapped = true
		subLabelText.TextXAlignment = Enum.TextXAlignment.Left
		subLabelText.AutomaticSize = Enum.AutomaticSize.Y
		subLabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		subLabelText.BackgroundTransparency = 1
		subLabelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subLabelText.BorderSizePixel = 0
		subLabelText.Size = UDim2.fromScale(1, 1)
		subLabelText.Parent = subLabel

		function SubLabelFunctions:UpdateName(New)
			subLabelText.Text = tostring(New)
		end
		function SubLabelFunctions:SetVisibility(State)
			subLabel.Visible = State
		end

		return SubLabelFunctions
	end

	function Funcs:Colorpicker(Settings)
		Settings = Defaults({

		}, Settings)

		local ColorpickerFunctions = {}

		local section = self.addons or self.section

		local isAlpha = Settings.Alpha and true or false
		ColorpickerFunctions.Color = Settings.Default
		ColorpickerFunctions.Alpha = isAlpha and Settings.Alpha

		local colorpicker = Instance.new("Frame")
		colorpicker.Name = "Colorpicker"
		colorpicker.AutomaticSize = Enum.AutomaticSize.Y
		colorpicker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		colorpicker.BackgroundTransparency = 1
		colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorpicker.BorderSizePixel = 0
		colorpicker.Size = self.addons and UDim2.new(0, 250, 0, 38) or UDim2.new(1, 0, 0, 38)
		colorpicker.Parent = section
		colorpicker.ZIndex = 10
		colorpicker.Active = true

		local colorpickerName = Instance.new("TextLabel")
		colorpickerName.Name = "KeybindName"
		colorpickerName.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		colorpickerName.Text = tostring(Settings.Name)
		colorpickerName.TextColor3 = Color3.fromRGB(255, 255, 255)
		colorpickerName.TextSize = 13
		colorpickerName.TextTransparency = 0.5
		colorpickerName.RichText = true
		colorpickerName.TextTruncate = Enum.TextTruncate.AtEnd
		colorpickerName.TextXAlignment = Enum.TextXAlignment.Left
		colorpickerName.TextYAlignment = Enum.TextYAlignment.Top
		colorpickerName.AnchorPoint = Vector2.new(0, 0.5)
		colorpickerName.AutomaticSize = Enum.AutomaticSize.XY
		colorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorpickerName.BackgroundTransparency = 1
		colorpickerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorpickerName.BorderSizePixel = 0
		colorpickerName.Position = UDim2.fromScale(0, 0.5)
		colorpickerName.Parent = colorpicker
		colorpickerName.ZIndex = 11

		local colorCbg = Instance.new("ImageLabel")
		colorCbg.Name = "NewColor"
		colorCbg.Image = "rbxassetid://121484455191370"
		colorCbg.ScaleType = Enum.ScaleType.Tile
		colorCbg.TileSize = UDim2.fromOffset(500, 500)
		colorCbg.AnchorPoint = Vector2.new(1, 0.5)
		colorCbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorCbg.BackgroundTransparency = 1
		colorCbg.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorCbg.BorderSizePixel = 0
		colorCbg.Position = UDim2.fromScale(1, 0.5)
		colorCbg.Size = UDim2.fromOffset(21, 21)
		colorCbg.ZIndex = 11

		local colorC = Instance.new("Frame")
		colorC.Name = "Color"
		colorC.AnchorPoint = Vector2.new(0.5, 0.5)
		colorC.BackgroundColor3 = ColorpickerFunctions.Color
		colorC.BorderSizePixel = 0
		colorC.Position = UDim2.fromScale(0.5, 0.5)
		colorC.Size = UDim2.fromScale(1, 1)
		colorC.BackgroundTransparency = ColorpickerFunctions.Alpha or 0
		colorC.ZIndex = 11

		local uICorner = Instance.new("UICorner")
		uICorner.Name = "UICorner"
		uICorner.CornerRadius = UDim.new(0, 6)
		uICorner.Parent = colorC

		local interact = Instance.new("TextButton")
		interact.Name = "Interact"
		interact.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		interact.Text = ""
		interact.TextColor3 = Color3.fromRGB(0, 0, 0)
		interact.TextSize = 14
		interact.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		interact.BackgroundTransparency = 1
		interact.BorderColor3 = Color3.fromRGB(0, 0, 0)
		interact.BorderSizePixel = 0
		interact.Size = UDim2.fromScale(1, 1)
		interact.Parent = colorC
		interact.ZIndex = 11

		colorC.Parent = colorCbg

		local uICorner1 = Instance.new("UICorner")
		uICorner1.Name = "UICorner"
		uICorner1.CornerRadius = UDim.new(0, 8)
		uICorner1.Parent = colorCbg

		colorCbg.Parent = colorpicker

		local colorPicker = Instance.new("Frame")
		colorPicker.Name = "ColorPicker"
		colorPicker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		colorPicker.BackgroundTransparency = 0.5
		colorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorPicker.BorderSizePixel = 0
		colorPicker.Size = UDim2.fromScale(1, 1)
		colorPicker.Visible = false
		colorPicker.ZIndex = 11

		local baseUICorner = Instance.new("UICorner")
		baseUICorner.Name = "BaseUICorner"
		baseUICorner.CornerRadius = UDim.new(0, 10)
		baseUICorner.Parent = colorPicker

		local prompt = Instance.new("Frame")
		prompt.Name = "Prompt"
		prompt.AnchorPoint = Vector2.new(0.5, 0.5)
		prompt.AutomaticSize = Enum.AutomaticSize.Y
		prompt.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		prompt.BorderColor3 = Color3.fromRGB(0, 0, 0)
		prompt.BorderSizePixel = 0
		prompt.Position = UDim2.fromScale(0.5, 0.5)
		prompt.Size = UDim2.fromOffset(420, 0)
		prompt.ZIndex = 11

		local globalSettingsUIStroke = Instance.new("UIStroke")
		globalSettingsUIStroke.Name = "GlobalSettingsUIStroke"
		globalSettingsUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		globalSettingsUIStroke.Color = Color3.fromRGB(255, 255, 255)
		globalSettingsUIStroke.Transparency = 0.9
		globalSettingsUIStroke.Parent = prompt

		local globalSettingsUICorner = Instance.new("UICorner")
		globalSettingsUICorner.Name = "GlobalSettingsUICorner"
		globalSettingsUICorner.CornerRadius = UDim.new(0, 10)
		globalSettingsUICorner.Parent = prompt

		local uIListLayout = Instance.new("UIListLayout")
		uIListLayout.Name = "UIListLayout"
		uIListLayout.Padding = UDim.new(0, 10)
		uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout.Parent = prompt

		local colorOptions = Instance.new("Frame")
		colorOptions.Name = "ColorOptions"
		colorOptions.AutomaticSize = Enum.AutomaticSize.XY
		colorOptions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorOptions.BackgroundTransparency = 1
		colorOptions.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorOptions.BorderSizePixel = 0
		colorOptions.LayoutOrder = 1
		colorOptions.Size = UDim2.fromScale(1, 0)
		colorOptions.ZIndex = 11

		local value = Instance.new("TextButton")
		value.Name = "Value"
		value.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		value.Text = ""
		value.TextColor3 = Color3.fromRGB(0, 0, 0)
		value.TextSize = 14
		value.AutoButtonColor = false
		value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		value.BorderColor3 = Color3.fromRGB(0, 0, 0)
		value.BorderSizePixel = 0
		value.LayoutOrder = 1
		value.Position = UDim2.fromScale(0.092, 0.886)
		value.Size = UDim2.new(1, 0, 0, 15)
		value.ZIndex = 11

		local uIGradient = Instance.new("UIGradient")
		uIGradient.Name = "UIGradient"
		uIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
		})
		uIGradient.Parent = value

		local slide = Instance.new("Frame")
		slide.Name = "Slide"
		slide.AnchorPoint = Vector2.new(0, 0.5)
		slide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		slide.BorderColor3 = Color3.fromRGB(27, 42, 53)
		slide.BorderSizePixel = 0
		slide.Position = UDim2.fromScale(0, 0.5)
		slide.Size = UDim2.new(0, 13, 1, 8)
		slide.ZIndex = 11

		local uICorner = Instance.new("UICorner")
		uICorner.Name = "UICorner"
		uICorner.CornerRadius = UDim.new(1, 0)
		uICorner.Parent = slide

		local uIStroke = Instance.new("UIStroke")
		uIStroke.Name = "UIStroke"
		uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uIStroke.Transparency = 0.5
		uIStroke.Parent = slide

		slide.Parent = value

		local uICorner1 = Instance.new("UICorner")
		uICorner1.Name = "UICorner"
		uICorner1.CornerRadius = UDim.new(0, 6)
		uICorner1.Parent = value

		local uIStroke1 = Instance.new("UIStroke")
		uIStroke1.Name = "UIStroke"
		uIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uIStroke1.Color = Color3.fromRGB(255, 255, 255)
		uIStroke1.Transparency = 0.9

		local uIGradient1 = Instance.new("UIGradient")
		uIGradient1.Name = "UIGradient"
		uIGradient1.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
		})
		uIGradient1.Rotation = 180
		uIGradient1.Parent = uIStroke1

		uIStroke1.Parent = value

		value.Parent = colorOptions

		local uIListLayout1 = Instance.new("UIListLayout")
		uIListLayout1.Name = "UIListLayout"
		uIListLayout1.Padding = UDim.new(0, 25)
		uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout1.Parent = colorOptions

		local wheel = Instance.new("Frame")
		wheel.Name = "Wheel"
		wheel.AutomaticSize = Enum.AutomaticSize.Y
		wheel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		wheel.BackgroundTransparency = 1
		wheel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		wheel.BorderSizePixel = 0
		wheel.Size = UDim2.new(1, 0, 0, 100)
		wheel.ZIndex = 11

		local wheel1 = Instance.new("ImageButton")
		wheel1.Name = "Wheel"
		wheel1.Image = "rbxassetid://2849458409"
		wheel1.AutoButtonColor = false
		wheel1.Active = false
		wheel1.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
		wheel1.BackgroundTransparency = 1
		wheel1.BorderColor3 = Color3.fromRGB(27, 42, 53)
		wheel1.Selectable = false
		wheel1.Size = UDim2.fromOffset(220, 220)
		wheel1.SizeConstraint = Enum.SizeConstraint.RelativeYY
		wheel1.ZIndex = 11

		local target = Instance.new("ImageLabel")
		target.Name = "Target"
		target.Image = "rbxassetid://73265255323268"
		target.ImageColor3 = Color3.fromRGB(0, 0, 0)
		target.AnchorPoint = Vector2.new(0.5, 0.5)
		target.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		target.BackgroundTransparency = 1
		target.BorderColor3 = Color3.fromRGB(27, 42, 53)
		target.Position = UDim2.fromScale(0.5, 0.5)
		target.Size = UDim2.fromOffset(22, 22)
		target.SizeConstraint = Enum.SizeConstraint.RelativeYY
		target.Parent = wheel1
		target.ZIndex = 11

		wheel1.Parent = wheel

		local inputs = Instance.new("Frame")
		inputs.Name = "Inputs"
		inputs.AnchorPoint = Vector2.new(1, 0.5)
		inputs.AutomaticSize = Enum.AutomaticSize.XY
		inputs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputs.BackgroundTransparency = 1
		inputs.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputs.BorderSizePixel = 0
		inputs.LayoutOrder = 1
		inputs.Position = UDim2.fromScale(1, 0.5)
		inputs.ZIndex = 11

		local uIListLayout2 = Instance.new("UIListLayout")
		uIListLayout2.Name = "UIListLayout"
		uIListLayout2.Padding = UDim.new(0, 5)
		uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout2.Parent = inputs

		local red = Instance.new("Frame")
		red.Name = "Red"
		red.AutomaticSize = Enum.AutomaticSize.XY
		red.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		red.BackgroundTransparency = 1
		red.BorderColor3 = Color3.fromRGB(0, 0, 0)
		red.BorderSizePixel = 0
		red.LayoutOrder = 1
		red.Size = UDim2.fromOffset(0, 38)
		red.ZIndex = 11

		local inputName = Instance.new("TextLabel")
		inputName.Name = "InputName"
		inputName.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputName.Text = "Red"
		inputName.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName.TextSize = 13
		inputName.TextTransparency = 0.5
		inputName.TextTruncate = Enum.TextTruncate.AtEnd
		inputName.TextXAlignment = Enum.TextXAlignment.Left
		inputName.TextYAlignment = Enum.TextYAlignment.Top
		inputName.AnchorPoint = Vector2.new(0, 0.5)
		inputName.AutomaticSize = Enum.AutomaticSize.XY
		inputName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName.BackgroundTransparency = 1
		inputName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName.BorderSizePixel = 0
		inputName.LayoutOrder = 2
		inputName.Position = UDim2.fromScale(0, 0.5)
		inputName.Parent = red
		inputName.ZIndex = 11

		local uIListLayout3 = Instance.new("UIListLayout")
		uIListLayout3.Name = "UIListLayout"
		uIListLayout3.Padding = UDim.new(0, 15)
		uIListLayout3.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout3.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout3.Parent = red

		local inputBox = Instance.new("TextBox")
		inputBox.Name = "InputBox"
		inputBox.ClearTextOnFocus = false
		inputBox.CursorPosition = -1
		inputBox.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputBox.Text = "255"
		inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox.TextSize = 12
		inputBox.TextTransparency = 0.4
		inputBox.TextXAlignment = Enum.TextXAlignment.Left
		inputBox.AnchorPoint = Vector2.new(1, 0.5)
		inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox.BackgroundTransparency = 0.95
		inputBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox.BorderSizePixel = 0
		inputBox.ClipsDescendants = true
		inputBox.LayoutOrder = 1
		inputBox.Position = UDim2.fromScale(1, 0.5)
		inputBox.Size = UDim2.fromOffset(75, 25)
		inputBox.ZIndex = 11

		local inputBoxUICorner = Instance.new("UICorner")
		inputBoxUICorner.Name = "InputBoxUICorner"
		inputBoxUICorner.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner.Parent = inputBox

		local inputBoxUIStroke = Instance.new("UIStroke")
		inputBoxUIStroke.Name = "InputBoxUIStroke"
		inputBoxUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke.Transparency = 0.9
		inputBoxUIStroke.Parent = inputBox

		local inputBoxUISizeConstraint = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint.Parent = inputBox

		local inputBoxUIPadding = Instance.new("UIPadding")
		inputBoxUIPadding.Name = "InputBoxUIPadding"
		inputBoxUIPadding.PaddingLeft = UDim.new(0, 8)
		inputBoxUIPadding.PaddingRight = UDim.new(0, 10)
		inputBoxUIPadding.Parent = inputBox

		inputBox.Parent = red

		red.Parent = inputs

		local green = Instance.new("Frame")
		green.Name = "Green"
		green.AutomaticSize = Enum.AutomaticSize.XY
		green.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		green.BackgroundTransparency = 1
		green.BorderColor3 = Color3.fromRGB(0, 0, 0)
		green.BorderSizePixel = 0
		green.LayoutOrder = 2
		green.Size = UDim2.fromOffset(0, 38)
		green.ZIndex = 11

		local inputName1 = Instance.new("TextLabel")
		inputName1.Name = "InputName"
		inputName1.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputName1.Text = "Green"
		inputName1.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName1.TextSize = 13
		inputName1.TextTransparency = 0.5
		inputName1.TextTruncate = Enum.TextTruncate.AtEnd
		inputName1.TextXAlignment = Enum.TextXAlignment.Left
		inputName1.TextYAlignment = Enum.TextYAlignment.Top
		inputName1.AnchorPoint = Vector2.new(0, 0.5)
		inputName1.AutomaticSize = Enum.AutomaticSize.XY
		inputName1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName1.BackgroundTransparency = 1
		inputName1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName1.BorderSizePixel = 0
		inputName1.LayoutOrder = 2
		inputName1.Position = UDim2.fromScale(0, 0.5)
		inputName1.Parent = green
		inputName1.ZIndex = 11

		local uIListLayout4 = Instance.new("UIListLayout")
		uIListLayout4.Name = "UIListLayout"
		uIListLayout4.Padding = UDim.new(0, 15)
		uIListLayout4.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout4.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout4.Parent = green

		local inputBox1 = Instance.new("TextBox")
		inputBox1.Name = "InputBox"
		inputBox1.ClearTextOnFocus = false
		inputBox1.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputBox1.Text = "255"
		inputBox1.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox1.TextSize = 12
		inputBox1.TextTransparency = 0.4
		inputBox1.TextXAlignment = Enum.TextXAlignment.Left
		inputBox1.AnchorPoint = Vector2.new(1, 0.5)
		inputBox1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox1.BackgroundTransparency = 0.95
		inputBox1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox1.BorderSizePixel = 0
		inputBox1.ClipsDescendants = true
		inputBox1.LayoutOrder = 1
		inputBox1.Position = UDim2.fromScale(1, 0.5)
		inputBox1.Size = UDim2.fromOffset(75, 25)
		inputBox1.ZIndex = 11

		local inputBoxUICorner1 = Instance.new("UICorner")
		inputBoxUICorner1.Name = "InputBoxUICorner"
		inputBoxUICorner1.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner1.Parent = inputBox1

		local inputBoxUIStroke1 = Instance.new("UIStroke")
		inputBoxUIStroke1.Name = "InputBoxUIStroke"
		inputBoxUIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke1.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke1.Transparency = 0.9
		inputBoxUIStroke1.Parent = inputBox1

		local inputBoxUISizeConstraint1 = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint1.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint1.Parent = inputBox1

		local inputBoxUIPadding1 = Instance.new("UIPadding")
		inputBoxUIPadding1.Name = "InputBoxUIPadding"
		inputBoxUIPadding1.PaddingLeft = UDim.new(0, 8)
		inputBoxUIPadding1.PaddingRight = UDim.new(0, 10)
		inputBoxUIPadding1.Parent = inputBox1

		inputBox1.Parent = green

		green.Parent = inputs

		local blue = Instance.new("Frame")
		blue.Name = "Blue"
		blue.AutomaticSize = Enum.AutomaticSize.XY
		blue.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		blue.BackgroundTransparency = 1
		blue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		blue.BorderSizePixel = 0
		blue.LayoutOrder = 3
		blue.Size = UDim2.fromOffset(0, 38)
		blue.ZIndex = 11

		local inputName2 = Instance.new("TextLabel")
		inputName2.Name = "InputName"
		inputName2.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputName2.Text = "Blue"
		inputName2.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName2.TextSize = 13
		inputName2.TextTransparency = 0.5
		inputName2.TextTruncate = Enum.TextTruncate.AtEnd
		inputName2.TextXAlignment = Enum.TextXAlignment.Left
		inputName2.TextYAlignment = Enum.TextYAlignment.Top
		inputName2.AnchorPoint = Vector2.new(0, 0.5)
		inputName2.AutomaticSize = Enum.AutomaticSize.XY
		inputName2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName2.BackgroundTransparency = 1
		inputName2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName2.BorderSizePixel = 0
		inputName2.LayoutOrder = 2
		inputName2.Position = UDim2.fromScale(0, 0.5)
		inputName2.Parent = blue
		inputName2.ZIndex = 11

		local uIListLayout5 = Instance.new("UIListLayout")
		uIListLayout5.Name = "UIListLayout"
		uIListLayout5.Padding = UDim.new(0, 15)
		uIListLayout5.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout5.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout5.Parent = blue

		local inputBox2 = Instance.new("TextBox")
		inputBox2.Name = "InputBox"
		inputBox2.ClearTextOnFocus = false
		inputBox2.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputBox2.Text = "255"
		inputBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox2.TextSize = 12
		inputBox2.TextTransparency = 0.4
		inputBox2.TextXAlignment = Enum.TextXAlignment.Left
		inputBox2.AnchorPoint = Vector2.new(1, 0.5)
		inputBox2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox2.BackgroundTransparency = 0.95
		inputBox2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox2.BorderSizePixel = 0
		inputBox2.ClipsDescendants = true
		inputBox2.LayoutOrder = 1
		inputBox2.Position = UDim2.fromScale(1, 0.5)
		inputBox2.Size = UDim2.fromOffset(75, 25)
		inputBox2.ZIndex = 11

		local inputBoxUICorner2 = Instance.new("UICorner")
		inputBoxUICorner2.Name = "InputBoxUICorner"
		inputBoxUICorner2.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner2.Parent = inputBox2

		local inputBoxUIStroke2 = Instance.new("UIStroke")
		inputBoxUIStroke2.Name = "InputBoxUIStroke"
		inputBoxUIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke2.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke2.Transparency = 0.9
		inputBoxUIStroke2.Parent = inputBox2

		local inputBoxUISizeConstraint2 = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint2.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint2.Parent = inputBox2

		local inputBoxUIPadding2 = Instance.new("UIPadding")
		inputBoxUIPadding2.Name = "InputBoxUIPadding"
		inputBoxUIPadding2.PaddingLeft = UDim.new(0, 8)
		inputBoxUIPadding2.PaddingRight = UDim.new(0, 10)
		inputBoxUIPadding2.Parent = inputBox2

		inputBox2.Parent = blue

		blue.Parent = inputs

		local alpha = Instance.new("Frame")
		alpha.Name = "Alpha"
		alpha.AutomaticSize = Enum.AutomaticSize.XY
		alpha.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		alpha.BackgroundTransparency = 1
		alpha.BorderColor3 = Color3.fromRGB(0, 0, 0)
		alpha.BorderSizePixel = 0
		alpha.LayoutOrder = 4
		alpha.Size = UDim2.fromOffset(0, 38)
		alpha.Visible = isAlpha
		alpha.ZIndex = 11

		local inputName3 = Instance.new("TextLabel")
		inputName3.Name = "InputName"
		inputName3.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputName3.Text = "Alpha"
		inputName3.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName3.TextSize = 13
		inputName3.TextTransparency = 0.5
		inputName3.TextTruncate = Enum.TextTruncate.AtEnd
		inputName3.TextXAlignment = Enum.TextXAlignment.Left
		inputName3.TextYAlignment = Enum.TextYAlignment.Top
		inputName3.AnchorPoint = Vector2.new(0, 0.5)
		inputName3.AutomaticSize = Enum.AutomaticSize.XY
		inputName3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName3.BackgroundTransparency = 1
		inputName3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName3.BorderSizePixel = 0
		inputName3.LayoutOrder = 2
		inputName3.Position = UDim2.fromScale(0, 0.5)
		inputName3.Parent = alpha
		inputName3.ZIndex = 11

		local uIListLayout6 = Instance.new("UIListLayout")
		uIListLayout6.Name = "UIListLayout"
		uIListLayout6.Padding = UDim.new(0, 15)
		uIListLayout6.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout6.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout6.Parent = alpha

		local inputBox3 = Instance.new("TextBox")
		inputBox3.Name = "InputBox"
		inputBox3.ClearTextOnFocus = false
		inputBox3.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputBox3.Text = "0"
		inputBox3.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox3.TextSize = 12
		inputBox3.TextTransparency = 0.4
		inputBox3.TextXAlignment = Enum.TextXAlignment.Left
		inputBox3.AnchorPoint = Vector2.new(1, 0.5)
		inputBox3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox3.BackgroundTransparency = 0.95
		inputBox3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox3.BorderSizePixel = 0
		inputBox3.ClipsDescendants = true
		inputBox3.LayoutOrder = 1
		inputBox3.Position = UDim2.fromScale(1, 0.5)
		inputBox3.Size = UDim2.fromOffset(75, 25)
		inputBox3.ZIndex = 11

		local inputBoxUICorner3 = Instance.new("UICorner")
		inputBoxUICorner3.Name = "InputBoxUICorner"
		inputBoxUICorner3.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner3.Parent = inputBox3

		local inputBoxUIStroke3 = Instance.new("UIStroke")
		inputBoxUIStroke3.Name = "InputBoxUIStroke"
		inputBoxUIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke3.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke3.Transparency = 0.9
		inputBoxUIStroke3.Parent = inputBox3

		local inputBoxUISizeConstraint3 = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint3.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint3.Parent = inputBox3

		local inputBoxUIPadding3 = Instance.new("UIPadding")
		inputBoxUIPadding3.Name = "InputBoxUIPadding"
		inputBoxUIPadding3.PaddingLeft = UDim.new(0, 8)
		inputBoxUIPadding3.PaddingRight = UDim.new(0, 10)
		inputBoxUIPadding3.Parent = inputBox3

		inputBox3.Parent = alpha

		alpha.Parent = inputs

		local hex = Instance.new("Frame")
		hex.Name = "Hex"
		hex.AutomaticSize = Enum.AutomaticSize.XY
		hex.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		hex.BackgroundTransparency = 1
		hex.BorderColor3 = Color3.fromRGB(0, 0, 0)
		hex.BorderSizePixel = 0
		hex.Size = UDim2.fromOffset(0, 38)
		hex.ZIndex = 11

		local inputName4 = Instance.new("TextLabel")
		inputName4.Name = "InputName"
		inputName4.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputName4.Text = "Hex"
		inputName4.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputName4.TextSize = 13
		inputName4.TextTransparency = 0.5
		inputName4.TextTruncate = Enum.TextTruncate.AtEnd
		inputName4.TextXAlignment = Enum.TextXAlignment.Left
		inputName4.TextYAlignment = Enum.TextYAlignment.Top
		inputName4.AnchorPoint = Vector2.new(0, 0.5)
		inputName4.AutomaticSize = Enum.AutomaticSize.XY
		inputName4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputName4.BackgroundTransparency = 1
		inputName4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputName4.BorderSizePixel = 0
		inputName4.LayoutOrder = 2
		inputName4.Position = UDim2.fromScale(0, 0.5)
		inputName4.Parent = hex
		inputName4.ZIndex = 11

		local uIListLayout7 = Instance.new("UIListLayout")
		uIListLayout7.Name = "UIListLayout"
		uIListLayout7.Padding = UDim.new(0, 15)
		uIListLayout7.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout7.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout7.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout7.Parent = hex

		local inputBox4 = Instance.new("TextBox")
		inputBox4.Name = "InputBox"
		inputBox4.ClearTextOnFocus = false
		inputBox4.CursorPosition = -1
		inputBox4.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Medium,
			Enum.FontStyle.Normal
		)
		inputBox4.Text = "255"
		inputBox4.TextColor3 = Color3.fromRGB(255, 255, 255)
		inputBox4.TextSize = 12
		inputBox4.TextTransparency = 0.4
		inputBox4.TextXAlignment = Enum.TextXAlignment.Left
		inputBox4.AnchorPoint = Vector2.new(1, 0.5)
		inputBox4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		inputBox4.BackgroundTransparency = 0.95
		inputBox4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		inputBox4.BorderSizePixel = 0
		inputBox4.ClipsDescendants = true
		inputBox4.LayoutOrder = 1
		inputBox4.Position = UDim2.fromScale(1, 0.5)
		inputBox4.Size = UDim2.fromOffset(75, 25)
		inputBox4.ZIndex = 11

		local inputBoxUICorner4 = Instance.new("UICorner")
		inputBoxUICorner4.Name = "InputBoxUICorner"
		inputBoxUICorner4.CornerRadius = UDim.new(0, 4)
		inputBoxUICorner4.Parent = inputBox4

		local inputBoxUIStroke4 = Instance.new("UIStroke")
		inputBoxUIStroke4.Name = "InputBoxUIStroke"
		inputBoxUIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		inputBoxUIStroke4.Color = Color3.fromRGB(255, 255, 255)
		inputBoxUIStroke4.Transparency = 0.9
		inputBoxUIStroke4.Parent = inputBox4

		local inputBoxUISizeConstraint4 = Instance.new("UISizeConstraint")
		inputBoxUISizeConstraint4.Name = "InputBoxUISizeConstraint"
		inputBoxUISizeConstraint4.Parent = inputBox4

		local inputBoxUIPadding4 = Instance.new("UIPadding")
		inputBoxUIPadding4.Name = "InputBoxUIPadding"
		inputBoxUIPadding4.PaddingLeft = UDim.new(0, 8)
		inputBoxUIPadding4.PaddingRight = UDim.new(0, 10)
		inputBoxUIPadding4.Parent = inputBox4

		inputBox4.Parent = hex

		hex.Parent = inputs

		inputs.Parent = wheel

		local uIPadding = Instance.new("UIPadding")
		uIPadding.Name = "UIPadding"
		uIPadding.PaddingRight = UDim.new(0, 5)
		uIPadding.Parent = wheel

		wheel.Parent = colorOptions

		local colorWells = Instance.new("Frame")
		colorWells.Name = "ColorWells"
		colorWells.AutomaticSize = Enum.AutomaticSize.Y
		colorWells.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorWells.BackgroundTransparency = 1
		colorWells.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorWells.BorderSizePixel = 0
		colorWells.LayoutOrder = 2
		colorWells.Size = UDim2.fromScale(1, 0)
		colorWells.ZIndex = 11

		local uIGridLayout = Instance.new("UIGridLayout")
		uIGridLayout.Name = "UIGridLayout"
		uIGridLayout.CellPadding = UDim2.fromOffset(10, 0)
		uIGridLayout.CellSize = UDim2.new(0.5, -5, 0, 30)
		uIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIGridLayout.Parent = colorWells

		local newColor = Instance.new("ImageLabel")
		newColor.Name = "NewColor"
		newColor.Image = "rbxassetid://121484455191370"
		newColor.ScaleType = Enum.ScaleType.Tile
		newColor.TileSize = UDim2.fromOffset(500, 500)
		newColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		newColor.BackgroundTransparency = 1
		newColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
		newColor.BorderSizePixel = 0
		newColor.Size = UDim2.fromOffset(100, 100)
		newColor.ZIndex = 11

		local uICorner2 = Instance.new("UICorner")
		uICorner2.Name = "UICorner"
		uICorner2.Parent = newColor

		local color = Instance.new("Frame")
		color.Name = "Color"
		color.AnchorPoint = Vector2.new(0.5, 0.5)
		color.BorderColor3 = Color3.fromRGB(27, 42, 53)
		color.BorderSizePixel = 0
		color.Position = UDim2.fromScale(0.5, 0.5)
		color.Size = UDim2.new(1, 1, 1, 1)
		color.ZIndex = 11

		local uICorner3 = Instance.new("UICorner")
		uICorner3.Name = "UICorner"
		uICorner3.Parent = color

		color.Parent = newColor

		newColor.Parent = colorWells

		local oldColor = Instance.new("ImageLabel")
		oldColor.Name = "OldColor"
		oldColor.Image = "rbxassetid://121484455191370"
		oldColor.ScaleType = Enum.ScaleType.Tile
		oldColor.TileSize = UDim2.fromOffset(500, 500)
		oldColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		oldColor.BackgroundTransparency = 1
		oldColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
		oldColor.BorderSizePixel = 0
		oldColor.LayoutOrder = 1
		oldColor.Size = UDim2.fromOffset(100, 100)
		oldColor.ZIndex = 11

		local uICorner4 = Instance.new("UICorner")
		uICorner4.Name = "UICorner"
		uICorner4.Parent = oldColor

		local color1 = Instance.new("Frame")
		color1.Name = "Color"
		color1.AnchorPoint = Vector2.new(0.5, 0.5)
		color1.BorderColor3 = Color3.fromRGB(27, 42, 53)
		color1.BorderSizePixel = 0
		color1.Position = UDim2.fromScale(0.5, 0.5)
		color1.Size = UDim2.new(1, 1, 1, 1)
		color1.ZIndex = 11

		local uICorner5 = Instance.new("UICorner")
		uICorner5.Name = "UICorner"
		uICorner5.Parent = color1

		color1.Parent = oldColor

		oldColor.Parent = colorWells

		colorWells.Parent = colorOptions

		colorOptions.Parent = prompt

		local interactions = Instance.new("Frame")
		interactions.Name = "Interactions"
		interactions.AutomaticSize = Enum.AutomaticSize.Y
		interactions.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		interactions.BackgroundTransparency = 1
		interactions.BorderColor3 = Color3.fromRGB(0, 0, 0)
		interactions.BorderSizePixel = 0
		interactions.LayoutOrder = 2
		interactions.Size = UDim2.fromScale(1, 0)
		interactions.ZIndex = 11

		local uIListLayout8 = Instance.new("UIListLayout")
		uIListLayout8.Name = "UIListLayout"
		uIListLayout8.Padding = UDim.new(0, 10)
		uIListLayout8.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout8.Parent = interactions

		local confirm = Instance.new("TextButton")
		confirm.Name = "Confirm"
		confirm.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.SemiBold,
			Enum.FontStyle.Normal
		)
		confirm.Text = "Confirm"
		confirm.TextColor3 = Color3.fromRGB(255, 255, 255)
		confirm.TextSize = 15
		confirm.TextTransparency = 0.5
		confirm.TextTruncate = Enum.TextTruncate.AtEnd
		confirm.AutoButtonColor = false
		confirm.AutomaticSize = Enum.AutomaticSize.Y
		confirm.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		confirm.BorderColor3 = Color3.fromRGB(0, 0, 0)
		confirm.BorderSizePixel = 0
		confirm.Size = UDim2.fromScale(1, 0)
		confirm.ZIndex = 11

		local uIPadding1 = Instance.new("UIPadding")
		uIPadding1.Name = "UIPadding"
		uIPadding1.PaddingBottom = UDim.new(0, 9)
		uIPadding1.PaddingLeft = UDim.new(0, 10)
		uIPadding1.PaddingRight = UDim.new(0, 10)
		uIPadding1.PaddingTop = UDim.new(0, 9)
		uIPadding1.Parent = confirm

		local baseUICorner = Instance.new("UICorner")
		baseUICorner.Name = "BaseUICorner"
		baseUICorner.CornerRadius = UDim.new(0, 10)
		baseUICorner.Parent = confirm

		confirm.Parent = interactions

		local cancel = Instance.new("TextButton")
		cancel.Name = "Cancel"
		cancel.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.SemiBold,
			Enum.FontStyle.Normal
		)
		cancel.Text = "Cancel"
		cancel.TextColor3 = Color3.fromRGB(255, 255, 255)
		cancel.TextSize = 15
		cancel.TextTransparency = 0.5
		cancel.TextTruncate = Enum.TextTruncate.AtEnd
		cancel.AutoButtonColor = false
		cancel.AutomaticSize = Enum.AutomaticSize.Y
		cancel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		cancel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		cancel.BorderSizePixel = 0
		cancel.Size = UDim2.fromScale(1, 0)
		cancel.ZIndex = 11

		local baseUICorner1 = Instance.new("UICorner")
		baseUICorner1.Name = "BaseUICorner"
		baseUICorner1.CornerRadius = UDim.new(0, 10)
		baseUICorner1.Parent = cancel

		local uIPadding2 = Instance.new("UIPadding")
		uIPadding2.Name = "UIPadding"
		uIPadding2.PaddingBottom = UDim.new(0, 9)
		uIPadding2.PaddingLeft = UDim.new(0, 10)
		uIPadding2.PaddingRight = UDim.new(0, 10)
		uIPadding2.PaddingTop = UDim.new(0, 9)
		uIPadding2.Parent = cancel

		cancel.Parent = interactions

		local uIPadding3 = Instance.new("UIPadding")
		uIPadding3.Name = "UIPadding"
		uIPadding3.PaddingTop = UDim.new(0, 10)
		uIPadding3.Parent = interactions

		interactions.Parent = prompt

		local globalSettingsUIPadding = Instance.new("UIPadding")
		globalSettingsUIPadding.Name = "GlobalSettingsUIPadding"
		globalSettingsUIPadding.PaddingBottom = UDim.new(0, 20)
		globalSettingsUIPadding.PaddingLeft = UDim.new(0, 20)
		globalSettingsUIPadding.PaddingRight = UDim.new(0, 20)
		globalSettingsUIPadding.PaddingTop = UDim.new(0, 20)
		globalSettingsUIPadding.Parent = prompt

		local paragraph = Instance.new("Frame")
		paragraph.Name = "Paragraph"
		paragraph.AutomaticSize = Enum.AutomaticSize.Y
		paragraph.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		paragraph.BackgroundTransparency = 1
		paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
		paragraph.BorderSizePixel = 0
		paragraph.Size = UDim2.fromScale(1, 0)
		paragraph.ZIndex = 11

		local paragraphHeader = Instance.new("TextLabel")
		paragraphHeader.Name = "ParagraphHeader"
		paragraphHeader.FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.SemiBold,
			Enum.FontStyle.Normal
		)
		paragraphHeader.RichText = true
		paragraphHeader.Text = tostring(Settings.Name)
		paragraphHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
		paragraphHeader.TextSize = 18
		paragraphHeader.TextTransparency = 0.4
		paragraphHeader.TextWrapped = true
		paragraphHeader.TextYAlignment = Enum.TextYAlignment.Top
		paragraphHeader.AutomaticSize = Enum.AutomaticSize.XY
		paragraphHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		paragraphHeader.BackgroundTransparency = 1
		paragraphHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
		paragraphHeader.BorderSizePixel = 0
		paragraphHeader.Size = UDim2.fromScale(1, 0)
		paragraphHeader.Parent = paragraph
		paragraphHeader.ZIndex = 11

		local uIListLayout9 = Instance.new("UIListLayout")
		uIListLayout9.Name = "UIListLayout"
		uIListLayout9.Padding = UDim.new(0, 15)
		uIListLayout9.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uIListLayout9.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout9.Parent = paragraph

		local uIPadding4 = Instance.new("UIPadding")
		uIPadding4.Name = "UIPadding"
		uIPadding4.PaddingBottom = UDim.new(0, 15)
		uIPadding4.Parent = paragraph

		local line = Instance.new("Frame")
		line.Name = "Line"
		line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		line.BackgroundTransparency = 0.9
		line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		line.BorderSizePixel = 0
		line.LayoutOrder = 1
		line.Size = UDim2.new(1, 0, 0, 1)
		line.Parent = paragraph
		line.ZIndex = 11

		paragraph.Parent = prompt

		prompt.Parent = colorPicker

		colorPicker.Parent = MacLib.base

		local fromHSV, fromRGB, v2, udim2 = Color3.fromHSV, Color3.fromRGB, Vector2.new, UDim2.new

		local wheel = wheel1
		local ring = target
		local slider = value
		local colour = color

		local modifierInputs = {
			Hex = hex.InputBox,
			Red = red.InputBox,
			Green = green.InputBox,
			Blue = blue.InputBox,
			Alpha = alpha.InputBox
		}

		local Mouse = LocalPlayer:GetMouse()

		local WheelDown, SlideDown = false, false
		local hue, saturation, value = 0, 0, 1

		local function toPolar(v)
			return math.atan2(v.y, v.x), v.magnitude
		end

		local function radToDeg(x)
			return ((x + math.pi) / (2 * math.pi)) * 360
		end

		local function degToRad(degrees)
			return degrees * (math.pi / 180)
		end

		local function hexToRGB(hex)
			hex = hex:gsub("#","")
			if #hex ~= 6 then return 0, 0, 0 end
			local r = tonumber(hex:sub(1, 2), 16) or 0
			local g = tonumber(hex:sub(3, 4), 16) or 0
			local b = tonumber(hex:sub(5, 6), 16) or 0
			return r, g, b
		end

		local function clampInput(value, min, max)
			local num = tonumber(value)
			if num then
				return math.clamp(num, min, max)
			end
			return min
		end

		local function update()
			local c = fromHSV(hue, saturation, value)
			colour.BackgroundColor3 = c
			colour.BackgroundTransparency = clampInput(modifierInputs.Alpha.Text, 0, 1)

			modifierInputs.Red.Text = tostring(math.floor(c.r * 255 + 0.5))
			modifierInputs.Green.Text = tostring(math.floor(c.g * 255 + 0.5))
			modifierInputs.Blue.Text = tostring(math.floor(c.b * 255 + 0.5))
			modifierInputs.Alpha.Text = clampInput(modifierInputs.Alpha.Text, 0, 1)

			local hexColor = string.format("#%02X%02X%02X", 
				math.floor(c.r * 255 + 0.5),
				math.floor(c.g * 255 + 0.5),
				math.floor(c.b * 255 + 0.5))
			modifierInputs.Hex.Text = hexColor
		end

		local function UpdateSlide(iX)
			local rY = iX - slider.AbsolutePosition.X
			local cY = math.clamp(rY, 0, slider.AbsoluteSize.X - slide.AbsoluteSize.X)
			slide.Position = udim2(0, cY, 0.5, 0)
			value = 1 - (cY / (slider.AbsoluteSize.X - slide.AbsoluteSize.X))
			update()
		end

		local function UpdateRing(iX, iY)
			local r = wheel.AbsoluteSize.x / 2
			local d = v2(iX, iY) - wheel.AbsolutePosition - wheel.AbsoluteSize / 2

			if d:Dot(d) > r * r then
				d = d.unit * r
			end

			ring.Position = udim2(0.5, d.x, 0.5, d.y)
			local phi, len = toPolar(d * v2(1, -1))
			hue, saturation = radToDeg(phi) / 360, math.clamp(len / r, 0, 1)
			slider.BackgroundColor3 = fromHSV(hue, saturation, 1)
			update()
		end

		local function UpdateSlideFromValue(value)
			local cY = (1 - value) * (slider.AbsoluteSize.X - slide.AbsoluteSize.X)
			slide.Position = UDim2.new(0, cY, 0.5, 0)
		end

		local function UpdateRingFromHSV(hue, saturation)
			local r = wheel.AbsoluteSize.X / 2
			local phi = degToRad(hue * 360)
			local len = saturation * r
			local x = len * math.cos(phi)
			local y = len * math.sin(phi)

			ring.Position = UDim2.new(0.5, -x, 0.5, y)
			slider.BackgroundColor3 = fromHSV(hue, saturation, 1)
		end

		local function updateFromRGB()
			local r = clampInput(modifierInputs.Red.Text, 0, 255)
			local g = clampInput(modifierInputs.Green.Text, 0, 255)
			local b = clampInput(modifierInputs.Blue.Text, 0, 255)
			modifierInputs.Red.Text = r
			modifierInputs.Green.Text = g
			modifierInputs.Blue.Text = b

			hue, saturation, value = Color3.fromRGB(r, g, b):ToHSV()

			UpdateSlideFromValue(value)
			UpdateRingFromHSV(hue, saturation)
			update()
		end

		local function updateFromHex()
			local hex = modifierInputs.Hex.Text
			local r, g, b = hexToRGB(hex)

			r = clampInput(r, 0, 255)
			g = clampInput(g, 0, 255)
			b = clampInput(b, 0, 255)

			modifierInputs.Red.Text = r
			modifierInputs.Green.Text = g
			modifierInputs.Blue.Text = b

			hue, saturation, value = Color3.fromRGB(r, g, b):ToHSV()
			UpdateSlideFromValue(value)
			UpdateRingFromHSV(hue, saturation)
			update()
		end

		local function updateFromSettings()
			local r = math.floor(ColorpickerFunctions.Color.R * 255 + 0.5)
			local g = math.floor(ColorpickerFunctions.Color.G * 255 + 0.5)
			local b = math.floor(ColorpickerFunctions.Color.B * 255 + 0.5)
			modifierInputs.Red.Text = r
			modifierInputs.Green.Text = g
			modifierInputs.Blue.Text = b
			modifierInputs.Alpha.Text = isAlpha and ColorpickerFunctions.Alpha or 0

			local hexColor = string.format("#%02X%02X%02X", r,g,b)
			modifierInputs.Hex.Text = hexColor

			hue, saturation, value = Color3.fromRGB(r, g, b):ToHSV()

			color1.BackgroundColor3 = ColorpickerFunctions.Color
			color1.BackgroundTransparency = isAlpha and ColorpickerFunctions.Alpha or 0

			colour.BackgroundColor3 = Color3.fromRGB(r,g,b)
			colour.BackgroundTransparency = isAlpha and ColorpickerFunctions.Alpha or 0

			UpdateSlideFromValue(value)
			UpdateRingFromHSV(hue, saturation)
		end

		wheel.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				WheelDown = true
				UpdateRing(Mouse.X, Mouse.Y)

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						WheelDown = false
					end
				end)
			end
		end)

		slider.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				SlideDown = true
				UpdateSlide(Mouse.X)

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						SlideDown = false
					end
				end)
			end
		end)

		--[[UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if SlideDown then
					UpdateSlide(Mouse.X)
				elseif WheelDown then
					UpdateRing(Mouse.X, Mouse.Y)
				end
			end
		end)]]

		RunService.RenderStepped:Connect(function()
			if WheelDown then
				UpdateRing(Mouse.X, Mouse.Y)
			elseif SlideDown then
				UpdateSlide(Mouse.X)
			end
		end)

		local function onFocusEnter(instance)
			local placeholder = tostring(instance.Text)
			instance.Text = ""
			instance.PlaceholderText = placeholder
		end

		modifierInputs.Hex.FocusLost:Connect(updateFromHex)
		modifierInputs.Red.FocusLost:Connect(updateFromRGB)
		modifierInputs.Green.FocusLost:Connect(updateFromRGB)
		modifierInputs.Blue.FocusLost:Connect(updateFromRGB)
		modifierInputs.Alpha.FocusLost:Connect(update)

		modifierInputs.Hex.Focused:Connect(function()
			onFocusEnter(modifierInputs.Hex)
		end)
		modifierInputs.Red.Focused:Connect(function()
			onFocusEnter(modifierInputs.Red)
		end)
		modifierInputs.Green.Focused:Connect(function()
			onFocusEnter(modifierInputs.Green)
		end)
		modifierInputs.Blue.Focused:Connect(function()
			onFocusEnter(modifierInputs.Blue)
		end)
		modifierInputs.Alpha.Focused:Connect(function()
			onFocusEnter(modifierInputs.Alpha)
		end)

		local function makeCanvas()
			local ColorPickerCanvas = Instance.new("CanvasGroup")
			ColorPickerCanvas.Name = "ColorPickerCanvas"
			ColorPickerCanvas.BackgroundTransparency = 1
			ColorPickerCanvas.BorderSizePixel = 0
			ColorPickerCanvas.Size = UDim2.fromScale(1, 1)
			ColorPickerCanvas.ZIndex = 16
			ColorPickerCanvas.GroupTransparency = 1
			ColorPickerCanvas.Parent = MacLib.base
			ColorPickerCanvas.Visible = false
			return ColorPickerCanvas
		end

		local function transition(isIn)
			local canvas = makeCanvas()
			local tweenTransparency = isIn and 0 or 1
			local stateTransparency = isIn and 1 or 0
			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine)

			colorPicker.Visible = true
			colorPicker.Parent = canvas
			canvas.Visible = true
			canvas.GroupTransparency = tweenTransparency

			if not isIn then
				colorPicker.Visible = false
				canvas.Visible = false
			end

			colorPicker.Parent = MacLib.base
			canvas:Destroy()
		end

		local function colorpickerIn()
			transition(true)
		end

		local function colorpickerOut()
			transition(false)
		end

		interact.MouseButton1Click:Connect(colorpickerIn)

		cancel.MouseButton1Click:Connect(colorpickerOut)
		confirm.MouseButton1Click:Connect(function()
			colorpickerOut()
			local c = fromHSV(hue, saturation, value)
			ColorpickerFunctions.Color = Color3.fromRGB(c.r * 255, c.g * 255, c.b * 255)
			ColorpickerFunctions.Alpha = isAlpha and clampInput(modifierInputs.Alpha.Text, 0, 1)

			color1.BackgroundColor3 = ColorpickerFunctions.Color
			color1.BackgroundTransparency = isAlpha and ColorpickerFunctions.Alpha or 0

			colorC.BackgroundColor3 = ColorpickerFunctions.Color
			colorC.BackgroundTransparency = isAlpha and ColorpickerFunctions.Alpha or 0

			if Settings.Callback then
				task.spawn(function()
					Settings.Callback(ColorpickerFunctions.Color, isAlpha and ColorpickerFunctions.Alpha)
				end)
			end
		end)

		updateFromSettings()

		function ColorpickerFunctions:UpdateName(New)
			colorpickerName.Text = tostring(New)
		end
		function ColorpickerFunctions:SetVisibility(State)
			colorpicker.Visible = State
		end

		function ColorpickerFunctions:SetColor(color3)
			ColorpickerFunctions.Color = color3
			colorC.BackgroundColor3 = color3

			local r = math.floor(ColorpickerFunctions.Color.R * 255 + 0.5)
			local g = math.floor(ColorpickerFunctions.Color.G * 255 + 0.5)
			local b = math.floor(ColorpickerFunctions.Color.B * 255 + 0.5)
			modifierInputs.Red.Text = r
			modifierInputs.Green.Text = g
			modifierInputs.Blue.Text = b

			local hexColor = string.format("#%02X%02X%02X", r,g,b)
			modifierInputs.Hex.Text = hexColor

			hue, saturation, value = Color3.fromRGB(r, g, b):ToHSV()

			color1.BackgroundColor3 = ColorpickerFunctions.Color
			colour.BackgroundColor3 = Color3.fromRGB(r,g,b)

			UpdateSlideFromValue(value)
			UpdateRingFromHSV(hue, saturation)
		end

		function ColorpickerFunctions:SetAlpha(alpha)
			ColorpickerFunctions.Alpha = alpha
			colorC.Transparency = alpha
			updateFromSettings()
		end

		for _,v in pairs(colorpicker:GetDescendants()) do
			if v:IsA("GuiObject") then
				v.Active = true
			end
		end

		return ColorpickerFunctions
	end

	SectionFunctions.__index = Funcs
	SectionFunctions.__namecall = function(table, key, ...)
		return Funcs[key](...)
	end
end

local TabFunctions = {}

do
	local Funcs = {}

	function Funcs:Tab(Settings)
		Settings = Defaults({
			Name = "Test Tab",
			Image = ""
		}, Settings)
		local TabFuncs = {}

		local Container = self.sectionTabSwitchers
		local content = MacLib.content
		local currentTab = MacLib.currentTab

		local tabSwitcher = Instance.new("TextButton")
		tabSwitcher.Name = "TabSwitcher"
		tabSwitcher.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		tabSwitcher.Text = ""
		tabSwitcher.TextColor3 = Color3.fromRGB(0, 0, 0)
		tabSwitcher.TextSize = 14
		tabSwitcher.AutoButtonColor = false
		tabSwitcher.Modal = true
		tabSwitcher.AnchorPoint = Vector2.new(0.5, 0)
		tabSwitcher.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabSwitcher.BackgroundTransparency = 1
		tabSwitcher.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabSwitcher.BorderSizePixel = 0
		tabSwitcher.Position = UDim2.fromScale(0.5, 0)
		tabSwitcher.Size = UDim2.new(1, -21, 0, 34)

		tabIndex += 1
		tabSwitcher.LayoutOrder = tabIndex

		local tabSwitcherUICorner = Instance.new("UICorner")
		tabSwitcherUICorner.Name = "TabSwitcherUICorner"
		tabSwitcherUICorner.Parent = tabSwitcher

		local tabSwitcherUIStroke = Instance.new("UIStroke")
		tabSwitcherUIStroke.Name = "TabSwitcherUIStroke"
		tabSwitcherUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		tabSwitcherUIStroke.Color = Color3.fromRGB(255, 255, 255)
		tabSwitcherUIStroke.Transparency = 1
		tabSwitcherUIStroke.Parent = tabSwitcher

		local tabSwitcherUIListLayout = Instance.new("UIListLayout")
		tabSwitcherUIListLayout.Name = "TabSwitcherUIListLayout"
		tabSwitcherUIListLayout.Padding = UDim.new(0, 9)
		tabSwitcherUIListLayout.FillDirection = Enum.FillDirection.Horizontal
		tabSwitcherUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabSwitcherUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		tabSwitcherUIListLayout.Parent = tabSwitcher

		local tabImage = Instance.new("ImageLabel")
		tabImage.Name = "TabImage"
		tabImage.Image = Settings.Image or ""
		tabImage.ImageTransparency = 0.4
		tabImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabImage.BackgroundTransparency = 1
		tabImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabImage.BorderSizePixel = 0
		tabImage.Size = UDim2.fromOffset(16, 16)
		tabImage.Parent = tabSwitcher

		local tabSwitcherName = Instance.new("TextLabel")
		tabSwitcherName.Name = "TabSwitcherName"
		tabSwitcherName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold,Enum.FontStyle.Normal)
		tabSwitcherName.Text = tostring(Settings.Name)
		tabSwitcherName.TextColor3 = Color3.fromRGB(255, 255, 255)
		tabSwitcherName.TextSize = 16
		tabSwitcherName.TextTransparency = 0.4
		tabSwitcherName.TextTruncate = Enum.TextTruncate.SplitWord
		tabSwitcherName.TextXAlignment = Enum.TextXAlignment.Left
		tabSwitcherName.TextYAlignment = Enum.TextYAlignment.Top
		tabSwitcherName.AutomaticSize = Enum.AutomaticSize.Y
		tabSwitcherName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabSwitcherName.BackgroundTransparency = 1
		tabSwitcherName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabSwitcherName.BorderSizePixel = 0
		tabSwitcherName.Size = UDim2.fromScale(1, 0)
		tabSwitcherName.Parent = tabSwitcher

		local tabSwitcherUIPadding = Instance.new("UIPadding")
		tabSwitcherUIPadding.Name = "TabSwitcherUIPadding"
		tabSwitcherUIPadding.PaddingLeft = UDim.new(0, 24)
		tabSwitcherUIPadding.PaddingRight = UDim.new(0, 35)
		tabSwitcherUIPadding.PaddingTop = UDim.new(0, 1)
		tabSwitcherUIPadding.Parent = tabSwitcher

		tabSwitcher.Parent = Container

		local elements1 = Instance.new("Frame")
		elements1.Name = "Elements"
		elements1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		elements1.BackgroundTransparency = 1
		elements1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		elements1.BorderSizePixel = 0
		elements1.Position = UDim2.fromOffset(0, 63)
		elements1.Size = UDim2.new(1, 0, 1, -63)

		local elementsUIPadding = Instance.new("UIPadding")
		elementsUIPadding.Name = "ElementsUIPadding"
		elementsUIPadding.PaddingRight = UDim.new(0, 5)
		elementsUIPadding.PaddingTop = UDim.new(0, 10)
		elementsUIPadding.Parent = elements1

		local elementsScrolling = Instance.new("ScrollingFrame")
		elementsScrolling.Name = "ElementsScrolling"
		elementsScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
		elementsScrolling.BottomImage = ""
		elementsScrolling.CanvasSize = UDim2.new()
		elementsScrolling.ScrollBarImageTransparency = 0.5
		elementsScrolling.ScrollBarThickness = 1
		elementsScrolling.TopImage = ""
		elementsScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		elementsScrolling.BackgroundTransparency = 1
		elementsScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
		elementsScrolling.BorderSizePixel = 0
		elementsScrolling.Size = UDim2.fromScale(1, 1)

		local elementsScrollingUIPadding = Instance.new("UIPadding")
		elementsScrollingUIPadding.Name = "ElementsScrollingUIPadding"
		elementsScrollingUIPadding.PaddingBottom = UDim.new(0, 15)
		elementsScrollingUIPadding.PaddingLeft = UDim.new(0, 11)
		elementsScrollingUIPadding.PaddingRight = UDim.new(0, 3)
		elementsScrollingUIPadding.PaddingTop = UDim.new(0, 5)
		elementsScrollingUIPadding.Parent = elementsScrolling

		local elementsScrollingUIListLayout = Instance.new("UIListLayout")
		elementsScrollingUIListLayout.Name = "ElementsScrollingUIListLayout"
		elementsScrollingUIListLayout.Padding = UDim.new(0, 15)
		elementsScrollingUIListLayout.FillDirection = Enum.FillDirection.Horizontal
		elementsScrollingUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		elementsScrollingUIListLayout.Parent = elementsScrolling

		local left = Instance.new("Frame")
		left.Name = "Left"
		left.AutomaticSize = Enum.AutomaticSize.Y
		left.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		left.BackgroundTransparency = 1
		left.BorderColor3 = Color3.fromRGB(0, 0, 0)
		left.BorderSizePixel = 0
		left.Position = UDim2.fromScale(0.512, 0)
		left.Size = UDim2.new(0.5, -10, 0, 0)

		local leftUIListLayout = Instance.new("UIListLayout")
		leftUIListLayout.Name = "LeftUIListLayout"
		leftUIListLayout.Padding = UDim.new(0, 15)
		leftUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		leftUIListLayout.Parent = left

		left.Parent = elementsScrolling

		local right = Instance.new("Frame")
		right.Name = "Right"
		right.AutomaticSize = Enum.AutomaticSize.Y
		right.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		right.BackgroundTransparency = 1
		right.BorderColor3 = Color3.fromRGB(0, 0, 0)
		right.BorderSizePixel = 0
		right.LayoutOrder = 1
		right.Position = UDim2.fromScale(0.512, 0)
		right.Size = UDim2.new(0.5, -10, 0, 0)

		local rightUIListLayout = Instance.new("UIListLayout")
		rightUIListLayout.Name = "RightUIListLayout"
		rightUIListLayout.Padding = UDim.new(0, 15)
		rightUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		rightUIListLayout.Parent = right

		right.Parent = elementsScrolling

		elementsScrolling.Parent = elements1

		local function SelectCurrentTab()
			local easetime = 0.15

			if currentTabInstance then
				currentTabInstance.Parent = nil
			end

			for _, v in pairs(MacLib.tabSwitchersScrollingFrame:GetDescendants()) do
				if v.Name == "TabSwitcher" then
					v.BackgroundTransparency = 1
					v:FindFirstChild("TabSwitcherUIStroke").Transparency = 1
				end
			end

			tabs[tabSwitcher].Parent = content
			currentTabInstance = tabs[tabSwitcher]
			currentTab.Text = tostring(Settings.Name)

			tabSwitcher.BackgroundTransparency = 0.98
			tabSwitcherUIStroke.Transparency = 0.95

		end

		tabSwitcher.MouseButton1Click:Connect(function()
			SelectCurrentTab()
		end)

		function TabFuncs:Select()
			SelectCurrentTab()
		end


		function TabFuncs:Section(Settings)
			Settings = Defaults({
				Side = "Left"
			}, Settings)
			local SectionFuncs = {}
			local section = Instance.new("Frame")
			section.Name = "Section"
			section.AutomaticSize = Enum.AutomaticSize.Y
			section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			section.BackgroundTransparency = 0.98
			section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			section.BorderSizePixel = 0
			section.Position = UDim2.fromScale(0, 6.78e-08)
			section.Size = UDim2.fromScale(1, 0)
			section.Parent = Settings.Side == "Left" and left or right

			SectionFuncs.section = section

			local sectionUICorner = Instance.new("UICorner")
			sectionUICorner.Name = "SectionUICorner"
			sectionUICorner.Parent = section

			local sectionUIStroke = Instance.new("UIStroke")
			sectionUIStroke.Name = "SectionUIStroke"
			sectionUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			sectionUIStroke.Color = Color3.fromRGB(255, 255, 255)
			sectionUIStroke.Transparency = 0.95
			sectionUIStroke.Parent = section

			local sectionUIListLayout = Instance.new("UIListLayout")
			sectionUIListLayout.Name = "SectionUIListLayout"
			sectionUIListLayout.Padding = UDim.new(0, 10)
			sectionUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sectionUIListLayout.Parent = section

			local sectionUIPadding = Instance.new("UIPadding")
			sectionUIPadding.Name = "SectionUIPadding"
			sectionUIPadding.PaddingBottom = UDim.new(0, 20)
			sectionUIPadding.PaddingLeft = UDim.new(0, 20)
			sectionUIPadding.PaddingRight = UDim.new(0, 18)
			sectionUIPadding.PaddingTop = UDim.new(0, 22)
			sectionUIPadding.Parent = section

			setmetatable(SectionFuncs, SectionFunctions)

			if Settings.Title then
				SectionFuncs:Header({
					Name = Settings.Title
				})
			end

			return SectionFuncs
		end

		tabs[tabSwitcher] = elements1

		return TabFuncs
	end

	TabFunctions.__index = Funcs
	TabFunctions.__namecall = function(table, key, ...)
		return Funcs[key](...)
	end
end

local TabGroupFunctions = {}

do
	local Funcs = {}

	function Funcs:TabGroup()
		local Container = self.tabSwitchersScrollingFrame
		local SectionFunction = {}

		local tabGroup = Instance.new("Frame")
		tabGroup.Name = "Section"
		tabGroup.AutomaticSize = Enum.AutomaticSize.Y
		tabGroup.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabGroup.BackgroundTransparency = 1
		tabGroup.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabGroup.BorderSizePixel = 0
		tabGroup.Size = UDim2.fromScale(1, 0)

		local divider3 = Instance.new("Frame")
		divider3.Name = "Divider"
		divider3.AnchorPoint = Vector2.new(0.5, 1)
		divider3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		divider3.BackgroundTransparency = 0.9
		divider3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		divider3.BorderSizePixel = 0
		divider3.Position = UDim2.fromScale(0.5, 1)
		divider3.Size = UDim2.new(1, -21, 0, 1)
		divider3.Parent = tabGroup

		local sectionTabSwitchers = Instance.new("Frame")
		sectionTabSwitchers.Name = "SectionTabSwitchers"
		sectionTabSwitchers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sectionTabSwitchers.BackgroundTransparency = 1
		sectionTabSwitchers.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sectionTabSwitchers.BorderSizePixel = 0
		sectionTabSwitchers.Size = UDim2.fromScale(1, 1)

		local uIListLayout1 = Instance.new("UIListLayout")
		uIListLayout1.Name = "UIListLayout"
		uIListLayout1.Padding = UDim.new(0, 15)
		uIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout1.Parent = sectionTabSwitchers

		local uIPadding1 = Instance.new("UIPadding")
		uIPadding1.Name = "UIPadding"
		uIPadding1.PaddingBottom = UDim.new(0, 15)
		uIPadding1.Parent = sectionTabSwitchers

		sectionTabSwitchers.Parent = tabGroup
		tabGroup.Parent = Container

		SectionFunction.sectionTabSwitchers = sectionTabSwitchers

		setmetatable(SectionFunction, TabFunctions)

		return SectionFunction
	end

	TabGroupFunctions.__index = Funcs
	TabGroupFunctions.__namecall = function(table, key, ...)
		return Funcs[key](...)
	end
end

function MacLib:FindIcon(name)
	local icon_holder = icons.assets
	return icon_holder[name] or ""
end

function MacLib:Window(Settings)
	Settings = Defaults({
		Title = "Goomba Hub",
		Subtitle = "",
		Size = UDim2.fromOffset(868, 650),
		Scale = 1,
		AcrylicBlur = false,
		Keybind = Enum.KeyCode.RightControl,
		ShowUserInfo = false
	}, Settings)

	local WindowFunctions = {}

	if Settings.AcrylicBlur ~= nil then
		acrylicBlur = Settings.AcrylicBlur
	else
		acrylicBlur = true
	end

	local macLib = Instance.new("ScreenGui")
	macLib.Name = "MacLib"
	macLib.DisplayOrder = 100
	macLib.IgnoreGuiInset = true
	macLib.ScreenInsets = Enum.ScreenInsets.None
	macLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	macLib.Parent = (isStudio and LocalPlayer.PlayerGui) or game.CoreGui

	MacLib.macLib = macLib

	local notifications = Instance.new("Frame")
	notifications.Name = "Notifications"
	notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	notifications.BackgroundTransparency = 1
	notifications.BorderColor3 = Color3.fromRGB(0, 0, 0)
	notifications.BorderSizePixel = 0
	notifications.Size = UDim2.fromScale(1, 1)
	notifications.Parent = macLib
	notifications.ZIndex = 2

	local notificationsUIListLayout = Instance.new("UIListLayout")
	notificationsUIListLayout.Name = "NotificationsUIListLayout"
	notificationsUIListLayout.Padding = UDim.new(0, 10)
	notificationsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	notificationsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	notificationsUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	notificationsUIListLayout.Parent = notifications

	local notificationsUIPadding = Instance.new("UIPadding")
	notificationsUIPadding.Name = "NotificationsUIPadding"
	notificationsUIPadding.PaddingBottom = UDim.new(0, 10)
	notificationsUIPadding.PaddingLeft = UDim.new(0, 10)
	notificationsUIPadding.PaddingRight = UDim.new(0, 10)
	notificationsUIPadding.PaddingTop = UDim.new(0, 10)
	notificationsUIPadding.Parent = notifications

	local base = Instance.new("Frame")
	base.Name = "Base"
	base.AnchorPoint = Vector2.new(0.5, 0.5)
	base.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	base.BackgroundTransparency = Settings.AcrylicBlur and 0.1 or 0
	base.BorderColor3 = Color3.fromRGB(0, 0, 0)
	base.BorderSizePixel = 0
	base.Position = UDim2.fromScale(0.5, 0.5)
	base.Size = Settings.Size or UDim2.fromOffset(868, 650)
	base.Active = true

	MacLib.base = base

	local baseUIScale = Instance.new("UIScale")
	baseUIScale.Name = "BaseUIScale"
	baseUIScale.Parent = base
	baseUIScale.Scale = 1
	MacLib.scale = baseUIScale

	if Settings.Scale ~= nil and tonumber(Settings.Scale) then
		baseUIScale.Scale = tonumber(Settings.Scale)
	end

	local baseUICorner = Instance.new("UICorner")
	baseUICorner.Name = "BaseUICorner"
	baseUICorner.CornerRadius = UDim.new(0, 10)
	baseUICorner.Parent = base

	local baseUIStroke = Instance.new("UIStroke")
	baseUIStroke.Name = "BaseUIStroke"
	baseUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	baseUIStroke.Color = Color3.fromRGB(255, 255, 255)
	baseUIStroke.Transparency = 0.9
	baseUIStroke.Parent = base

	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sidebar.BackgroundTransparency = 1
	sidebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	sidebar.BorderSizePixel = 0
	sidebar.Position = UDim2.fromScale(-3.52e-08, 4.69e-08)
	sidebar.Size = UDim2.fromScale(0.325, 1)

	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.AnchorPoint = Vector2.new(1, 0)
	divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider.BackgroundTransparency = 0.9
	divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider.BorderSizePixel = 0
	divider.Position = UDim2.fromScale(1, 0)
	divider.Size = UDim2.new(0, 1, 1, 0)
	divider.Parent = sidebar

	local windowControls = Instance.new("Frame")
	windowControls.Name = "WindowControls"
	windowControls.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	windowControls.BackgroundTransparency = 1
	windowControls.BorderColor3 = Color3.fromRGB(0, 0, 0)
	windowControls.BorderSizePixel = 0
	windowControls.Size = UDim2.new(1, 0, 0, 31)

	local controls = Instance.new("Frame")
	controls.Name = "Controls"
	controls.BackgroundColor3 = Color3.fromRGB(119, 174, 94)
	controls.BackgroundTransparency = 1
	controls.BorderColor3 = Color3.fromRGB(0, 0, 0)
	controls.BorderSizePixel = 0
	controls.Size = UDim2.fromScale(1, 1)

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 5)
	uIListLayout.FillDirection = Enum.FillDirection.Horizontal
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	uIListLayout.Parent = controls

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingLeft = UDim.new(0, 11)
	uIPadding.Parent = controls

	local minimize = Instance.new("TextButton")
	minimize.Name = "Minimize"
	minimize.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	minimize.Text = ""
	minimize.TextColor3 = Color3.fromRGB(0, 0, 0)
	minimize.TextSize = 14
	minimize.AutoButtonColor = false
	minimize.BackgroundColor3 = Color3.fromRGB(252, 190, 57)
	minimize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	minimize.BorderSizePixel = 0
	minimize.LayoutOrder = 1
	minimize.Size = UDim2.fromOffset(8, 8)

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.CornerRadius = UDim.new(1, 0)
	uICorner1.Parent = minimize

	minimize.Parent = controls

	local maximize = Instance.new("TextButton")
	maximize.Name = "Maximize"
	maximize.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	maximize.Text = ""
	maximize.TextColor3 = Color3.fromRGB(0, 0, 0)
	maximize.TextSize = 14
	maximize.AutoButtonColor = false
	maximize.BackgroundTransparency = 1
	maximize.Active = false
	maximize.BackgroundColor3 = Color3.fromRGB(119, 174, 94)
	maximize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	maximize.BorderSizePixel = 0
	maximize.LayoutOrder = 1
	maximize.Size = UDim2.fromOffset(7, 7)

	local uICorner2 = Instance.new("UICorner")
	uICorner2.Name = "UICorner"
	uICorner2.CornerRadius = UDim.new(1, 0)
	uICorner2.Parent = maximize

	local baseUIStroke1 = Instance.new("UIStroke")
	baseUIStroke1.Name = "BaseUIStroke"
	baseUIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	baseUIStroke1.Color = Color3.fromRGB(255, 255, 255)
	baseUIStroke1.Transparency = 0.9
	baseUIStroke1.Parent = maximize

	maximize.Parent = controls

	controls.Parent = windowControls

	local divider1 = Instance.new("Frame")
	divider1.Name = "Divider"
	divider1.AnchorPoint = Vector2.new(0, 1)
	divider1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider1.BackgroundTransparency = 0.9
	divider1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider1.BorderSizePixel = 0
	divider1.Position = UDim2.fromScale(0, 1)
	divider1.Size = UDim2.new(1, 0, 0, 1)
	divider1.Parent = windowControls

	windowControls.Parent = sidebar

	local information = Instance.new("Frame")
	information.Name = "Information"
	information.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	information.BackgroundTransparency = 1
	information.BorderColor3 = Color3.fromRGB(0, 0, 0)
	information.BorderSizePixel = 0
	information.Position = UDim2.fromOffset(0, 31)
	information.Size = UDim2.new(1, 0, 0, 60)

	local divider2 = Instance.new("Frame")
	divider2.Name = "Divider"
	divider2.AnchorPoint = Vector2.new(0, 1)
	divider2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider2.BackgroundTransparency = 0.9
	divider2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider2.BorderSizePixel = 0
	divider2.Position = UDim2.fromScale(0, 1)
	divider2.Size = UDim2.new(1, 0, 0, 1)
	divider2.Parent = information

	local informationHolder = Instance.new("Frame")
	informationHolder.Name = "InformationHolder"
	informationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	informationHolder.BackgroundTransparency = 1
	informationHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	informationHolder.BorderSizePixel = 0
	informationHolder.Size = UDim2.fromScale(1, 1)

	local informationHolderUIPadding = Instance.new("UIPadding")
	informationHolderUIPadding.Name = "InformationHolderUIPadding"
	informationHolderUIPadding.PaddingBottom = UDim.new(0, 10)
	informationHolderUIPadding.PaddingLeft = UDim.new(0, 23)
	informationHolderUIPadding.PaddingRight = UDim.new(0, 22)
	informationHolderUIPadding.PaddingTop = UDim.new(0, 10)
	informationHolderUIPadding.Parent = informationHolder

	local globalSettingsButton = Instance.new("ImageButton")
	globalSettingsButton.Name = "GlobalSettingsButton"
	globalSettingsButton.Image = "rbxassetid://18767849817"
	globalSettingsButton.ImageTransparency = 0.4
	globalSettingsButton.AnchorPoint = Vector2.new(1, 0.5)
	globalSettingsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	globalSettingsButton.BackgroundTransparency = 1
	globalSettingsButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	globalSettingsButton.BorderSizePixel = 0
	globalSettingsButton.Position = UDim2.fromScale(1, 0.5)
	globalSettingsButton.Size = UDim2.fromOffset(15, 15)
	globalSettingsButton.Parent = informationHolder

	local function ChangeGlobalSettingsButtonState(State)
		if State == "Default" then
			globalSettingsButton.ImageTransparency = 0.4
		elseif State == "Hover" then
			globalSettingsButton.ImageTransparency = 0.2
		end
	end

	globalSettingsButton.MouseEnter:Connect(function()
		ChangeGlobalSettingsButtonState("Hover")
	end)
	globalSettingsButton.MouseLeave:Connect(function()
		ChangeGlobalSettingsButtonState("Default")
	end)

	local titleFrame = Instance.new("Frame")
	titleFrame.Name = "TitleFrame"
	titleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	titleFrame.BackgroundTransparency = 1
	titleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	titleFrame.BorderSizePixel = 0
	titleFrame.Size = UDim2.fromScale(1, 1)

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold,Enum.FontStyle.Normal)
	title.Text = tostring(Settings.Title)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 20
	title.TextTransparency = 0.2
	title.TextTruncate = Enum.TextTruncate.SplitWord
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextYAlignment = Enum.TextYAlignment.Top
	title.AutomaticSize = Enum.AutomaticSize.Y
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	title.BorderSizePixel = 0
	title.Size = UDim2.new(1, -20, 0, 0)
	title.Parent = titleFrame

	local subtitle = Instance.new("TextLabel")
	subtitle.Name = "Subtitle"
	subtitle.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
	subtitle.RichText = true
	subtitle.Text = tostring(Settings.Subtitle) or ''
	subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	subtitle.TextSize = 12
	subtitle.TextTransparency = 0.8
	subtitle.TextTruncate = Enum.TextTruncate.SplitWord
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.TextYAlignment = Enum.TextYAlignment.Top
	subtitle.AutomaticSize = Enum.AutomaticSize.Y
	subtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	subtitle.BackgroundTransparency = 1
	subtitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	subtitle.BorderSizePixel = 0
	subtitle.LayoutOrder = 1
	subtitle.Size = UDim2.new(1, -20, 0, 0)
	subtitle.Parent = titleFrame

	local titleFrameUIListLayout = Instance.new("UIListLayout")
	titleFrameUIListLayout.Name = "TitleFrameUIListLayout"
	titleFrameUIListLayout.Padding = UDim.new(0, 3)
	titleFrameUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	titleFrameUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	titleFrameUIListLayout.Parent = titleFrame

	titleFrame.Parent = informationHolder

	informationHolder.Parent = information

	information.Parent = sidebar

	local sidebarGroup = Instance.new("Frame")
	sidebarGroup.Name = "SidebarGroup"
	sidebarGroup.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sidebarGroup.BackgroundTransparency = 1
	sidebarGroup.BorderColor3 = Color3.fromRGB(0, 0, 0)
	sidebarGroup.BorderSizePixel = 0
	sidebarGroup.Position = UDim2.fromOffset(0, 91)
	sidebarGroup.Size = UDim2.new(1, 0, 1, -91)

	local sidebarGroupUIPadding = Instance.new("UIPadding")
	sidebarGroupUIPadding.Name = "SidebarGroupUIPadding"
	sidebarGroupUIPadding.PaddingLeft = UDim.new(0, 10)
	sidebarGroupUIPadding.PaddingRight = UDim.new(0, 10)
	sidebarGroupUIPadding.PaddingTop = UDim.new(0, 15)
	sidebarGroupUIPadding.Parent = sidebarGroup

	local tabSwitchers = Instance.new("Frame")
	tabSwitchers.Name = "TabSwitchers"
	tabSwitchers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabSwitchers.BackgroundTransparency = 1
	tabSwitchers.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabSwitchers.BorderSizePixel = 0
	tabSwitchers.Size = UDim2.new(1, 0, 1, -10)

	local tabSwitchersScrollingFrame = Instance.new("ScrollingFrame")
	tabSwitchersScrollingFrame.Name = "TabSwitchersScrollingFrame"
	tabSwitchersScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabSwitchersScrollingFrame.BottomImage = ""
	tabSwitchersScrollingFrame.CanvasSize = UDim2.new()
	tabSwitchersScrollingFrame.ScrollBarImageTransparency = 0.8
	tabSwitchersScrollingFrame.ScrollBarThickness = 1
	tabSwitchersScrollingFrame.TopImage = ""
	tabSwitchersScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabSwitchersScrollingFrame.BackgroundTransparency = 1
	tabSwitchersScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabSwitchersScrollingFrame.BorderSizePixel = 0
	tabSwitchersScrollingFrame.Size = UDim2.fromScale(1, 1)

	MacLib.tabSwitchersScrollingFrame = tabSwitchersScrollingFrame

	local tabSwitchersScrollingFrameUIListLayout = Instance.new("UIListLayout")
	tabSwitchersScrollingFrameUIListLayout.Name = "TabSwitchersScrollingFrameUIListLayout"
	tabSwitchersScrollingFrameUIListLayout.Padding = UDim.new(0, 17)
	tabSwitchersScrollingFrameUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabSwitchersScrollingFrameUIListLayout.Parent = tabSwitchersScrollingFrame

	local tabSwitchersScrollingFrameUIPadding = Instance.new("UIPadding")
	tabSwitchersScrollingFrameUIPadding.Name = "TabSwitchersScrollingFrameUIPadding"
	tabSwitchersScrollingFrameUIPadding.PaddingTop = UDim.new(0, 2)
	tabSwitchersScrollingFrameUIPadding.Parent = tabSwitchersScrollingFrame

	tabSwitchersScrollingFrame.Parent = tabSwitchers
	WindowFunctions.tabSwitchersScrollingFrame = tabSwitchersScrollingFrame

	tabSwitchers.Parent = sidebarGroup

	sidebarGroup.Parent = sidebar

	sidebar.Parent = base

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.AnchorPoint = Vector2.new(1, 0)
	content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	content.BackgroundTransparency = 1
	content.BorderColor3 = Color3.fromRGB(0, 0, 0)
	content.BorderSizePixel = 0
	content.Position = UDim2.fromScale(1, 4.69e-08)
	content.Size = UDim2.fromScale(0.675, 1)

	MacLib.content = content

	local topbar = Instance.new("Frame")
	topbar.Name = "Topbar"
	topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	topbar.BackgroundTransparency = 1
	topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	topbar.BorderSizePixel = 0
	topbar.Size = UDim2.new(1, 0, 0, 63)

	local divider4 = Instance.new("Frame")
	divider4.Name = "Divider"
	divider4.AnchorPoint = Vector2.new(0, 1)
	divider4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider4.BackgroundTransparency = 0.9
	divider4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	divider4.BorderSizePixel = 0
	divider4.Position = UDim2.fromScale(0, 1)
	divider4.Size = UDim2.new(1, 0, 0, 1)
	divider4.Parent = topbar

	local elements = Instance.new("Frame")
	elements.Name = "Elements"
	elements.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	elements.BackgroundTransparency = 1
	elements.BorderColor3 = Color3.fromRGB(0, 0, 0)
	elements.BorderSizePixel = 0
	elements.Size = UDim2.fromScale(1, 1)

	local uIPadding2 = Instance.new("UIPadding")
	uIPadding2.Name = "UIPadding"
	uIPadding2.PaddingLeft = UDim.new(0, 20)
	uIPadding2.PaddingRight = UDim.new(0, 20)
	uIPadding2.Parent = elements

	local dragging_ = false
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		base.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	local function onDragStart(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging_ = true
			dragStart = input.Position
			startPos = base.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging_ = false
				end
			end)
		end
	end

	local function onDragUpdate(input)
		if dragging_ and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input
		end
	end

	base.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			onDragStart(input)
		end
	end)

	base.InputChanged:Connect(onDragUpdate)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging_ then
			update(input)
		end
	end)


	local currentTab = Instance.new("TextLabel")
	currentTab.Name = "CurrentTab"
	currentTab.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.SemiBold,Enum.FontStyle.Normal)
	currentTab.RichText = true
	currentTab.Text = "Tab"
	currentTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	currentTab.TextSize = 15
	currentTab.TextTransparency = 0.5
	currentTab.TextTruncate = Enum.TextTruncate.SplitWord
	currentTab.TextXAlignment = Enum.TextXAlignment.Left
	currentTab.TextYAlignment = Enum.TextYAlignment.Top
	currentTab.AnchorPoint = Vector2.new(0, 0.5)
	currentTab.AutomaticSize = Enum.AutomaticSize.Y
	currentTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	currentTab.BackgroundTransparency = 1
	currentTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	currentTab.BorderSizePixel = 0
	currentTab.Position = UDim2.fromScale(0, 0.5)
	currentTab.Size = UDim2.fromScale(0.9, 0)
	currentTab.Parent = elements

	MacLib.currentTab = currentTab

	elements.Parent = topbar

	topbar.Parent = content

	content.Parent = base

	local globalSettings = Instance.new("Frame")
	globalSettings.Name = "GlobalSettings"
	globalSettings.AutomaticSize = Enum.AutomaticSize.XY
	globalSettings.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	globalSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
	globalSettings.BorderSizePixel = 0
	globalSettings.Position = UDim2.fromScale(0.298, 0.104)
	globalSettings.BackgroundTransparency = Settings.AcrylicBlur and 0.2 or 0.7

	local globalSettingsUIStroke = Instance.new("UIStroke")
	globalSettingsUIStroke.Name = "GlobalSettingsUIStroke"
	globalSettingsUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	globalSettingsUIStroke.Color = Color3.fromRGB(255, 255, 255)
	globalSettingsUIStroke.Transparency = 0.9
	globalSettingsUIStroke.Parent = globalSettings

	local globalSettingsUICorner = Instance.new("UICorner")
	globalSettingsUICorner.Name = "GlobalSettingsUICorner"
	globalSettingsUICorner.CornerRadius = UDim.new(0, 10)
	globalSettingsUICorner.Parent = globalSettings

	local globalSettingsUIPadding = Instance.new("UIPadding")
	globalSettingsUIPadding.Name = "GlobalSettingsUIPadding"
	globalSettingsUIPadding.PaddingBottom = UDim.new(0, 10)
	globalSettingsUIPadding.PaddingTop = UDim.new(0, 10)
	globalSettingsUIPadding.Parent = globalSettings

	local globalSettingsUIListLayout = Instance.new("UIListLayout")
	globalSettingsUIListLayout.Name = "GlobalSettingsUIListLayout"
	globalSettingsUIListLayout.Padding = UDim.new(0, 5)
	globalSettingsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	globalSettingsUIListLayout.Parent = globalSettings

	local globalSettingsUIScale = Instance.new("UIScale")
	globalSettingsUIScale.Name = "GlobalSettingsUIScale"
	globalSettingsUIScale.Scale = 1e-07
	globalSettingsUIScale.Parent = globalSettings
	globalSettings.Parent = base
	base.Parent = macLib

	function WindowFunctions:SetScale(Size)
		if tonumber(Size) then
			baseUIScale.Scale = tonumber(Size)
		end
	end

	function WindowFunctions:UpdateTitle(NewTitle)
		title.Text = tostring(NewTitle)
	end

	function WindowFunctions:UpdateSubtitle(NewSubtitle)
		subtitle.Text = tostring(NewSubtitle)
	end

	local hovering
	local function toggle()
		globalSettingsUIScale.Scale = globalSettingsUIScale.Scale == 1 and 1e-07 or 1
	end
	globalSettingsButton.MouseButton1Click:Connect(function()
		if not hasGlobalSetting then return end
		toggle()
	end)
	globalSettings.MouseEnter:Connect(function()
		hovering = true
	end)
	globalSettings.MouseLeave:Connect(function()
		hovering = false
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 and globalSettingsUIScale.Scale == 1 and not hovering then
			toggle()
		end
	end)

	function WindowFunctions:GlobalSetting(Settings)
		hasGlobalSetting = true
		local GlobalSettingFunctions = {}
		local globalSetting = Instance.new("TextButton")
		globalSetting.Name = "GlobalSetting"
		globalSetting.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		globalSetting.Text = ""
		globalSetting.TextColor3 = Color3.fromRGB(0, 0, 0)
		globalSetting.TextSize = 14
		globalSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		globalSetting.BackgroundTransparency = 1
		globalSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
		globalSetting.BorderSizePixel = 0
		globalSetting.Size = UDim2.fromOffset(200, 30)

		local globalSettingToggleUIPadding = Instance.new("UIPadding")
		globalSettingToggleUIPadding.Name = "GlobalSettingToggleUIPadding"
		globalSettingToggleUIPadding.PaddingLeft = UDim.new(0, 15)
		globalSettingToggleUIPadding.Parent = globalSetting

		local settingName = Instance.new("TextLabel")
		settingName.Name = "SettingName"
		settingName.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		settingName.Text = tostring(Settings.Name)
		settingName.TextColor3 = Color3.fromRGB(255, 255, 255)
		settingName.TextSize = 13
		settingName.TextTransparency = 0.5
		settingName.TextTruncate = Enum.TextTruncate.SplitWord
		settingName.TextXAlignment = Enum.TextXAlignment.Left
		settingName.TextYAlignment = Enum.TextYAlignment.Top
		settingName.AnchorPoint = Vector2.new(0, 0.5)
		settingName.AutomaticSize = Enum.AutomaticSize.Y
		settingName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		settingName.BackgroundTransparency = 1
		settingName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		settingName.BorderSizePixel = 0
		settingName.Position = UDim2.fromScale(1.3e-07, 0.5)
		settingName.Size = UDim2.new(1,-40,0,0)
		settingName.Parent = globalSetting

		local globalSettingToggleUIListLayout = Instance.new("UIListLayout")
		globalSettingToggleUIListLayout.Name = "GlobalSettingToggleUIListLayout"
		globalSettingToggleUIListLayout.Padding = UDim.new(0, 10)
		globalSettingToggleUIListLayout.FillDirection = Enum.FillDirection.Horizontal
		globalSettingToggleUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		globalSettingToggleUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		globalSettingToggleUIListLayout.Parent = globalSetting

		local checkmark = Instance.new("TextLabel")
		checkmark.Name = "Checkmark"
		checkmark.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Medium,Enum.FontStyle.Normal)
		checkmark.Text = "✓"
		checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
		checkmark.TextSize = 13
		checkmark.TextTransparency = 1
		checkmark.TextXAlignment = Enum.TextXAlignment.Left
		checkmark.TextYAlignment = Enum.TextYAlignment.Top
		checkmark.AnchorPoint = Vector2.new(0, 0.5)
		checkmark.AutomaticSize = Enum.AutomaticSize.Y
		checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		checkmark.BackgroundTransparency = 1
		checkmark.BorderColor3 = Color3.fromRGB(0, 0, 0)
		checkmark.BorderSizePixel = 0
		checkmark.LayoutOrder = -1
		checkmark.Position = UDim2.fromScale(1.3e-07, 0.5)
		checkmark.Size = UDim2.fromOffset(-10, 0)
		checkmark.Parent = globalSetting

		globalSetting.Parent = globalSettings

		local tweensettings = {
			duration = 0.2,
			easingStyle = Enum.EasingStyle.Quint,
			transparencyIn = 0.2,
			transparencyOut = 0.5,
			checkSizeIncrease = 12,
			checkSizeDecrease = -globalSettingToggleUIListLayout.Padding.Offset,
			waitTime = 1
		}

		local function Toggle(State)
			if not State then
				checkmark.Size = UDim2.new(checkmark.Size.X.Scale, -globalSettingToggleUIListLayout.Padding.Offset, checkmark.Size.Y.Scale, checkmark.Size.Y.Offset)
				settingName.TextTransparency = 0.5
				checkmark:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					if checkmark.AbsoluteSize.X <= 0 then
						checkmark.TextTransparency = 1
					end
				end)
			else
				checkmark.Size = UDim2.new(checkmark.Size.X.Scale, 12, checkmark.Size.Y.Scale, checkmark.Size.Y.Offset)
				settingName.TextTransparency = 0.2
				checkmark:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					if checkmark.AbsoluteSize.X > 0 then
						checkmark.TextTransparency = 0
					end
				end)
			end
		end

		local toggled = Settings.Default
		Toggle(toggled)

		globalSetting.MouseButton1Click:Connect(function()
			toggled = not toggled
			Toggle(toggled)

			if Settings.Callback then
				task.spawn(Settings.Callback)
			end
		end)

		function GlobalSettingFunctions:UpdateName(NewName)
			settingName.Text = tostring(NewName)
		end

		function GlobalSettingFunctions:UpdateState(NewState)
			Toggle(NewState)
			toggled = NewState
			if Settings.Callback then
				task.spawn(Settings.Callback)
			end
		end

		return GlobalSettingFunctions
	end

	function WindowFunctions:Notify(Settings)
		task.spawn(function()
			local NotificationFunctions = {}

			local notification = Instance.new("Frame")
			notification.Name = "Notification"
			notification.AnchorPoint = Vector2.new(0.5, 0.5)
			notification.AutomaticSize = Enum.AutomaticSize.Y
			notification.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notification.BorderSizePixel = 0
			notification.Position = UDim2.fromScale(0.5, 0.5)
			notification.Size = UDim2.fromOffset(250, 0)

			notification.Parent = notifications

			local notificationUIStroke = Instance.new("UIStroke")
			notificationUIStroke.Name = "NotificationUIStroke"
			notificationUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			notificationUIStroke.Color = Color3.fromRGB(255, 255, 255)
			notificationUIStroke.Transparency = 0.9
			notificationUIStroke.Parent = notification

			local notificationUICorner = Instance.new("UICorner")
			notificationUICorner.Name = "NotificationUICorner"
			notificationUICorner.CornerRadius = UDim.new(0, 10)
			notificationUICorner.Parent = notification

			local notificationUIScale = Instance.new("UIScale")
			notificationUIScale.Name = "NotificationUIScale"
			notificationUIScale.Parent = notification
			notificationUIScale.Scale = 0

			local notificationInformation = Instance.new("Frame")
			notificationInformation.Name = "NotificationInformation"
			notificationInformation.AutomaticSize = Enum.AutomaticSize.Y
			notificationInformation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			notificationInformation.BackgroundTransparency = 1
			notificationInformation.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notificationInformation.BorderSizePixel = 0
			notificationInformation.Size = UDim2.fromScale(1, 1)

			local notificationTitle = Instance.new("TextLabel")
			notificationTitle.Name = "NotificationTitle"
			notificationTitle.FontFace = Font.new(
				"rbxassetid://12187365364",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			)
			notificationTitle.RichText = true
			notificationTitle.Text = tostring(Settings.Title)
			notificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			notificationTitle.TextSize = 13
			notificationTitle.TextTransparency = 0.2
			notificationTitle.TextTruncate = Enum.TextTruncate.SplitWord
			notificationTitle.TextXAlignment = Enum.TextXAlignment.Left
			notificationTitle.TextYAlignment = Enum.TextYAlignment.Top
			notificationTitle.AutomaticSize = Enum.AutomaticSize.XY
			notificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			notificationTitle.BackgroundTransparency = 1
			notificationTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notificationTitle.BorderSizePixel = 0
			notificationTitle.Size = UDim2.new(1, -12, 0, 0)

			local notificationTitleUIPadding = Instance.new("UIPadding")
			notificationTitleUIPadding.Name = "NotificationTitleUIPadding"
			notificationTitleUIPadding.PaddingRight = UDim.new(0, 25)
			notificationTitleUIPadding.Parent = notificationTitle

			notificationTitle.Parent = notificationInformation

			local notificationDescription = Instance.new("TextLabel")
			notificationDescription.Name = "NotificationDescription"
			notificationDescription.FontFace = Font.new(
				"rbxassetid://12187365364",
				Enum.FontWeight.Medium,
				Enum.FontStyle.Normal
			)
			notificationDescription.Text = tostring(Settings.Description) or ""
			notificationDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
			notificationDescription.TextSize = 11
			notificationDescription.TextTransparency = 0.5
			notificationDescription.TextWrapped = true
			notificationDescription.RichText = true
			notificationDescription.TextXAlignment = Enum.TextXAlignment.Left
			notificationDescription.TextYAlignment = Enum.TextYAlignment.Top
			notificationDescription.AutomaticSize = Enum.AutomaticSize.XY
			notificationDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			notificationDescription.BackgroundTransparency = 1
			notificationDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notificationDescription.BorderSizePixel = 0
			notificationDescription.Size = UDim2.new(1, -12, 0, 0)

			local notificationDescriptionUIPadding = Instance.new("UIPadding")
			notificationDescriptionUIPadding.Name = "NotificationDescriptionUIPadding"
			notificationDescriptionUIPadding.PaddingRight = UDim.new(0, 25)
			notificationDescriptionUIPadding.PaddingTop = UDim.new(0, 17)
			notificationDescriptionUIPadding.Parent = notificationDescription

			notificationDescription.Parent = notificationInformation

			local notificationUIPadding = Instance.new("UIPadding")
			notificationUIPadding.Name = "NotificationUIPadding"
			notificationUIPadding.PaddingBottom = UDim.new(0, 12)
			notificationUIPadding.PaddingLeft = UDim.new(0, 10)
			notificationUIPadding.PaddingRight = UDim.new(0, 10)
			notificationUIPadding.PaddingTop = UDim.new(0, 10)
			notificationUIPadding.Parent = notificationInformation

			notificationInformation.Parent = notification

			local notificationControls = Instance.new("Frame")
			notificationControls.Name = "NotificationControls"
			notificationControls.AutomaticSize = Enum.AutomaticSize.Y
			notificationControls.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			notificationControls.BackgroundTransparency = 1
			notificationControls.BorderColor3 = Color3.fromRGB(0, 0, 0)
			notificationControls.BorderSizePixel = 0
			notificationControls.Size = UDim2.fromScale(1, 1)

			local interactable = Instance.new("TextButton")
			interactable.Name = "Interactable"
			interactable.FontFace = Font.new("rbxassetid://12187365364")
			interactable.Text = "✓"
			interactable.TextColor3 = Color3.fromRGB(255, 255, 255)
			interactable.TextSize = 17
			interactable.TextTransparency = 0.2
			interactable.AnchorPoint = Vector2.new(1, 0.5)
			interactable.AutomaticSize = Enum.AutomaticSize.XY
			interactable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			interactable.BackgroundTransparency = 1
			interactable.BorderColor3 = Color3.fromRGB(0, 0, 0)
			interactable.BorderSizePixel = 0
			interactable.LayoutOrder = 1
			interactable.Position = UDim2.fromScale(1, 0.5)
			interactable.Parent = notificationControls

			local uIPadding = Instance.new("UIPadding")
			uIPadding.Name = "UIPadding"
			uIPadding.PaddingBottom = UDim.new(0, 6)
			uIPadding.PaddingRight = UDim.new(0, 13)
			uIPadding.PaddingTop = UDim.new(0, 6)
			uIPadding.Parent = notificationControls

			notificationControls.Parent = notification

			local styles = {
				None = function() interactable:Destroy() end,
				Confirm = function() interactable.Text = "✓" end,
				Cancel = function() interactable.Text = "✗" end
			}

			local style = styles[Settings.Style] or function() interactable:Destroy() end
			style()

			if interactable then
				interactable.MouseButton1Click:Connect(function()
					NotificationFunctions:Cancel()
					task.spawn(function()
						Settings.Callback()
					end)
				end)
			end

			local AnimateNotification = task.spawn(function()

				notificationUIScale.Scale = 1

				Settings.Lifetime = Settings.Lifetime or 3

				if Settings.Lifetime ~= 0 then
					task.wait(Settings.Lifetime)
					notification:Destroy()
				end
			end)

			function NotificationFunctions:UpdateTitle(New)
				notificationTitle.Text = tostring(New)
			end

			function NotificationFunctions:UpdateDescription(New)
				notificationDescription.Text = tostring(New)
			end

			function NotificationFunctions:Cancel()
				task.cancel(AnimateNotification)
				notification:Destroy()
			end

			return NotificationFunctions
		end)
	end

	function WindowFunctions:Dialog(Settings)
		local DialogFunctions = {}

		task.spawn(function()
			local dialogCanvas = Instance.new("CanvasGroup")
			dialogCanvas.Name = "DialogCanvas"
			dialogCanvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dialogCanvas.BackgroundTransparency = 1
			dialogCanvas.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dialogCanvas.BorderSizePixel = 0
			dialogCanvas.Size = UDim2.fromScale(1, 1)
			dialogCanvas.GroupTransparency = 1
			dialogCanvas.Parent = base
			dialogCanvas.ZIndex = 999
			dialogCanvas.Active = true

			local dialog = Instance.new("Frame")
			dialog.Name = "Dialog"
			dialog.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			dialog.BackgroundTransparency = 0.5
			dialog.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dialog.BorderSizePixel = 0
			dialog.Size = UDim2.fromScale(1, 1)
			dialog.ZIndex = 999
			dialog.Active = true

			local baseUICorner = Instance.new("UICorner")
			baseUICorner.Name = "BaseUICorner"
			baseUICorner.CornerRadius = UDim.new(0, 10)
			baseUICorner.Parent = dialog

			local prompt = Instance.new("Frame")
			prompt.Name = "Prompt"
			prompt.AnchorPoint = Vector2.new(0.5, 0.5)
			prompt.AutomaticSize = Enum.AutomaticSize.Y
			prompt.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			prompt.BorderColor3 = Color3.fromRGB(0, 0, 0)
			prompt.BorderSizePixel = 0
			prompt.Position = UDim2.fromScale(0.5, 0.5)
			prompt.Size = UDim2.fromOffset(280, 0)
			prompt.ZIndex = 999
			prompt.Active = true

			local globalSettingsUIStroke = Instance.new("UIStroke")
			globalSettingsUIStroke.Name = "GlobalSettingsUIStroke"
			globalSettingsUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			globalSettingsUIStroke.Color = Color3.fromRGB(255, 255, 255)
			globalSettingsUIStroke.Transparency = 0.9
			globalSettingsUIStroke.Parent = prompt

			local globalSettingsUICorner = Instance.new("UICorner")
			globalSettingsUICorner.Name = "GlobalSettingsUICorner"
			globalSettingsUICorner.CornerRadius = UDim.new(0, 10)
			globalSettingsUICorner.Parent = prompt

			local globalSettingsUIPadding = Instance.new("UIPadding")
			globalSettingsUIPadding.Name = "GlobalSettingsUIPadding"
			globalSettingsUIPadding.PaddingBottom = UDim.new(0, 20)
			globalSettingsUIPadding.PaddingLeft = UDim.new(0, 20)
			globalSettingsUIPadding.PaddingRight = UDim.new(0, 20)
			globalSettingsUIPadding.PaddingTop = UDim.new(0, 20)
			globalSettingsUIPadding.Parent = prompt

			local paragraph = Instance.new("Frame")
			paragraph.Name = "Paragraph"
			paragraph.AutomaticSize = Enum.AutomaticSize.Y
			paragraph.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			paragraph.BackgroundTransparency = 1
			paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
			paragraph.BorderSizePixel = 0
			paragraph.Size = UDim2.new(1, 0, 0, 38)
			paragraph.ZIndex = 999
			paragraph.Active = true

			local paragraphHeader = Instance.new("TextLabel")
			paragraphHeader.Name = "ParagraphHeader"
			paragraphHeader.FontFace = Font.new(
				"rbxassetid://12187365364",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			)
			paragraphHeader.RichText = true
			paragraphHeader.Text = tostring(Settings.Title)
			paragraphHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
			paragraphHeader.TextSize = 18
			paragraphHeader.TextTransparency = 0.4
			paragraphHeader.TextWrapped = true
			paragraphHeader.AutomaticSize = Enum.AutomaticSize.Y
			paragraphHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			paragraphHeader.BackgroundTransparency = 1
			paragraphHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
			paragraphHeader.BorderSizePixel = 0
			paragraphHeader.Size = UDim2.fromScale(1, 0)
			paragraphHeader.Parent = paragraph
			paragraphHeader.ZIndex = 999
			paragraphHeader.Active = true

			local uIListLayout = Instance.new("UIListLayout")
			uIListLayout.Name = "UIListLayout"
			uIListLayout.Padding = UDim.new(0, 15)
			uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			uIListLayout.Parent = paragraph

			local paragraphBody = Instance.new("TextLabel")
			paragraphBody.Name = "ParagraphBody"
			paragraphBody.FontFace = Font.new(
				"rbxassetid://12187365364",
				Enum.FontWeight.Medium,
				Enum.FontStyle.Normal
			)
			paragraphBody.RichText = true
			paragraphBody.Text = tostring(Settings.Description)
			paragraphBody.TextColor3 = Color3.fromRGB(255, 255, 255)
			paragraphBody.TextSize = 14
			paragraphBody.TextTransparency = 0.5
			paragraphBody.TextWrapped = true
			paragraphBody.AutomaticSize = Enum.AutomaticSize.Y
			paragraphBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			paragraphBody.BackgroundTransparency = 1
			paragraphBody.BorderColor3 = Color3.fromRGB(0, 0, 0)
			paragraphBody.BorderSizePixel = 0
			paragraphBody.LayoutOrder = 1
			paragraphBody.Size = UDim2.fromScale(1, 0)
			paragraphBody.Parent = paragraph
			paragraphBody.ZIndex = 999
			paragraphBody.Active = true

			paragraph.Parent = prompt

			local interactions = Instance.new("Frame")
			interactions.Name = "Interactions"
			interactions.AutomaticSize = Enum.AutomaticSize.Y
			interactions.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			interactions.BackgroundTransparency = 1
			interactions.BorderColor3 = Color3.fromRGB(0, 0, 0)
			interactions.BorderSizePixel = 0
			interactions.LayoutOrder = 1
			interactions.Size = UDim2.fromScale(1, 0)
			interactions.ZIndex = 1000
			interactions.Active = true

			local uIListLayout1 = Instance.new("UIListLayout")
			uIListLayout1.Name = "UIListLayout"
			uIListLayout1.Padding = UDim.new(0, 10)
			uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			uIListLayout1.Parent = interactions

			local uIPadding = Instance.new("UIPadding")
			uIPadding.Name = "UIPadding"
			uIPadding.PaddingTop = UDim.new(0, 20)
			uIPadding.Parent = interactions

			interactions.Parent = prompt

			local uIListLayout2 = Instance.new("UIListLayout")
			uIListLayout2.Name = "UIListLayout"
			uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
			uIListLayout2.Parent = prompt

			prompt.Parent = dialog

			dialog.Parent = dialogCanvas

			local function dialogIn()
				dialogCanvas.GroupTransparency = 0
				dialog.Parent = base
			end

			local function dialogOut()
				dialog.Parent = dialogCanvas
				dialogCanvas.GroupTransparency = 1
				dialogCanvas:Destroy()
			end

			for _, v in pairs(Settings.Buttons) do
				local button = Instance.new("TextButton")
				button.Name = "Button"
				button.FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.SemiBold,
					Enum.FontStyle.Normal
				)
				button.Text = tostring(v.Name)
				button.TextColor3 = Color3.fromRGB(255, 255, 255)
				button.TextSize = 15
				button.TextTransparency = 0.5
				button.TextTruncate = Enum.TextTruncate.AtEnd
				button.AutoButtonColor = false
				button.AutomaticSize = Enum.AutomaticSize.Y
				button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				button.BorderSizePixel = 0
				button.Size = UDim2.fromScale(1, 0)
				button.ZIndex = 1001
				button.Active = true

				local uIPadding1 = Instance.new("UIPadding")
				uIPadding1.Name = "UIPadding"
				uIPadding1.PaddingBottom = UDim.new(0, 9)
				uIPadding1.PaddingLeft = UDim.new(0, 10)
				uIPadding1.PaddingRight = UDim.new(0, 10)
				uIPadding1.PaddingTop = UDim.new(0, 9)
				uIPadding1.Parent = button

				local baseUICorner1 = Instance.new("UICorner")
				baseUICorner1.Name = "BaseUICorner"
				baseUICorner1.CornerRadius = UDim.new(0, 10)
				baseUICorner1.Parent = button

				button.Parent = interactions

				local TweenSettings = {
					DefaultTransparency = 0,
					DefaultTransparency2 = 0.5,
					HoverTransparency = 0.3,
					HoverTransparency2 = 0.6,

					EasingStyle = Enum.EasingStyle.Sine
				}

				local function ChangeState(State)
					if State == "Idle" then
						button.BackgroundTransparency = TweenSettings.DefaultTransparency
						button.TextTransparency = TweenSettings.DefaultTransparency2

					elseif State == "Hover" then
						button.BackgroundTransparency = TweenSettings.HoverTransparency
						button.TextTransparency = TweenSettings.HoverTransparency2

					end
				end

				button.MouseButton1Click:Connect(function()
					if dialogCanvas.GroupTransparency ~= 0 then return end
					if v.Callback then
						v.Callback()
					end

					dialog.Parent = dialogCanvas

					dialogOut()
				end)

				button.MouseEnter:Connect(function()
					ChangeState("Hover")
				end)
				button.MouseLeave:Connect(function()
					ChangeState("Idle")
				end)
			end

			dialogIn()

			function DialogFunctions:UpdateTitle(New)
				paragraphHeader.Text = tostring(New)
			end
			function DialogFunctions:UpdateDescription(New)
				paragraphBody.Text = tostring(New)
			end

			function DialogFunctions:Cancel()
				dialogOut()
			end
		end)

		return DialogFunctions
	end

	function WindowFunctions:SetNotificationsState(State)
		notifications.Visible = State
	end

	function WindowFunctions:GetNotificationsState(State)
		return notifications.Visible
	end

	function WindowFunctions:SetState(State)
		windowState = State
		base.Visible = State
		acrylicBlur = State
	end

	local MenuKeybind = Settings.Keybind or Enum.KeyCode.RightControl
	local function ToggleMenu()
		local state = not WindowFunctions:GetState()
		WindowFunctions:SetState(state)
		WindowFunctions:Notify({
			Title = Settings.Title,
			Description = (state and "Maximized " or "Minimized ") .. "the menu. Use " .. tostring(MenuKeybind.Name) .. " to toggle it.",
			Lifetime = 5
		})
	end
	UserInputService.InputEnded:Connect(function(inp, gpe)
		if gpe then return end
		if inp.KeyCode == MenuKeybind then
			ToggleMenu()
		end
	end)
	minimize.MouseButton1Click:Connect(ToggleMenu)

	function WindowFunctions:GetState()
		return windowState
	end

	function WindowFunctions:SetKeybind(Keycode)
		MenuKeybind = Keycode
	end

	function WindowFunctions:SetAcrylicBlurState(State)
		acrylicBlur = State
		base.BackgroundTransparency = State and 0.05 or 0
	end

	function WindowFunctions:GetAcrylicBlurState()
		return acrylicBlur
	end

	function WindowFunctions:SetSize(Size)
		base.Size = Size
	end
	function WindowFunctions:GetSize(Size)
		return base.Size
	end

	windowState = true

	macLib.Enabled = false
	macLib.Enabled = true

	local uiButton;

	local createUIButton = function()
		if uiButton == nil then
			local mainGui = Instance.new('ScreenGui', game:GetService('CoreGui'));
			mainGui.DisplayOrder = 1;
			uiButton = mainGui;

			local button = Instance.new('TextButton', mainGui);
			button.AnchorPoint = Vector2.new(1, 0.5);
			button.Position = UDim2.new(1, 0, 0.5, 0);
			button.Size = UDim2.new(0.08, 0, 0.087, 0);
			button.SizeConstraint = Enum.SizeConstraint.RelativeYY
			button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.Text = ''
			button.ZIndex = 9998

			local gradient = Instance.new('UIGradient', button);
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(10/255, 22/255, 22/255)),
				ColorSequenceKeypoint.new(1, Color3.new(15/255, 68/255, 64/255))
			})
			gradient.Enabled = true
			gradient.Rotation = -120

			local stroke = Instance.new('UIStroke', button);
			stroke.LineJoinMode = 0
			stroke.Thickness = 4
			stroke.Enabled = true
			stroke.ApplyStrokeMode = 1
			stroke.Color = Color3.new(1, 1, 1)
			local gradient2 = Instance.new('UIGradient', stroke);
			gradient2.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.new(120/255, 90/255, 40/255)),
				ColorSequenceKeypoint.new(1, Color3.new(214/255, 159/255, 64/255))
			}


			local label = Instance.new('TextLabel', button);
			label.AnchorPoint = Vector2.new(0.5, 0.5)
			label.Position = UDim2.new(0.5, 0, 0.5, 0)
			label.Size = UDim2.new(0.882, 0, 0.823, 0)
			label.TextColor3 = Color3.fromRGB(255, 5, 5)
			label.BackgroundTransparency = 1
			label.Text = 'Goomba Hub'
			label.TextScaled = true
			label.ZIndex = 9999

			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")

			local frame = button

			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart

				-- Convert scale to offset for Y position
				local parentHeight = frame.Parent.AbsoluteSize.Y
				local startOffsetY = startPos.Y.Scale * parentHeight + startPos.Y.Offset
				local newPosY = math.clamp(startOffsetY + delta.Y, 0, parentHeight - frame.AbsoluteSize.Y)

				-- Lock X position to the right edge and allow only vertical movement
				frame.Position = UDim2.new(1, 0, 0, newPosY)
			end

			frame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = frame.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			frame.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			RunService.RenderStepped:Connect(function()
				if dragging and dragInput then
					update(dragInput)
				end
			end)
			button.MouseButton1Click:Connect(function()
				WindowFunctions:SetState( not windowState )
			end)
		end
	end
	task.delay(0.05, createUIButton)

	setmetatable(WindowFunctions, TabGroupFunctions)

	return WindowFunctions

end

function MacLib:Demo()
	local Window = MacLib:Window({
		Title = "MacLib Demo",
		Subtitle = "This is a subtitle.",
		Size = UDim2.fromOffset(868, 650),
		ShowUserInfo = true,
		Keybind = Enum.KeyCode.RightControl,
		AcrylicBlur = true
	})

	local globalSettings = {
		NotificationToggler = Window:GlobalSetting({
			Name = "Notifications",
			Default = Window:GetNotificationsState(),
			Callback = function(bool)
				Window:SetNotificationsState(bool)
				Window:Notify({
					Title = "MacLib Demo",
					Description = (bool and "Enabled" or "Disabled") .. " Notifications",
					Lifetime = 5
				})
			end,
		})
	}

	local tabGroups = {
		TabGroup1 = Window:TabGroup()
	}

	local tabs = {
		Main = tabGroups.TabGroup1:Tab({ Name = "Demo", Image = "rbxassetid://18821914323" })
	}

	local sections = {
		MainSection1 = tabs.Main:Section({ Side = "Left" }),
		MainSection2 = tabs.Main:Section({ Side = "Right" })
	}

	sections.MainSection1:Header({
		Name = "Header #1"
	})

	sections.MainSection1:Button({
		Name = "Button",
		Callback = function()
			Window:Dialog({
				Title = "MacLib Demo",
				Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Eros vestibulum aliquet mattis, ex platea nunc.",
				Buttons = {
					{
						Name = "Confirm",
						Callback = function()
							print("Confirmed!")
						end,
					},
					{
						Name = "Cancel"
					}
				}
			})
		end,
	})

	sections.MainSection1:Input({
		Name = "Input",
		Placeholder = "Input",
		AcceptedCharacters = "All",
		Callback = function(input)
			Window:Notify({
				Title = "MacLib Demo",
				Description = "Successfully set input to " .. input
			})
		end
	})

	sections.MainSection1:Slider({
		Name = "Slider",
		Default = 50,
		Minimum = 0,
		Maximum = 100,
		DisplayMethod = "Percent",
		Callback = function(Value)
			print("Changed to ".. Value)
		end,
	})

	sections.MainSection1:Slider({
		Name = "UI Scale",
		Default = 1,
		Minimum = 0.5,
		Maximum = 2,
		DisplayMethod = "Tenths",
		Callback = function(Val)
			Window:SetScale(Val)
		end,
	})

	sections.MainSection1:Toggle({
		Name = "Toggle",
		Default = false,
		Callback = function(value)
			Window:Notify({
				Title = "MacLib Demo",
				Description = (value and "Enabled " or "Disabled ") .. "Toggle"
			})
		end,
	})

	sections.MainSection1:Keybind({
		Name = "Keybind",
		Callback = function(binded)
			Window:Notify({
				Title = "Demo Window",
				Description = "Pressed keybind - "..tostring(binded.Name),
				Lifetime = 3
			})
		end
	})

	sections.MainSection1:Colorpicker({
		Name = "Colorpicker",
		Default = Color3.fromRGB(0, 255, 255),
		Callback = function(color)
			print("Color: ", color)
		end,
	})

	local alphaColorPicker = sections.MainSection1:Colorpicker({
		Name = "Transparency Colorpicker",
		Default = Color3.fromRGB(255,0,0),
		Alpha = 0,
		Callback = function(color, alpha)
			print("Color: ", color, " Alpha: ", alpha)
		end,
	})

	local rainbowActive
	local rainbowConnection
	local hue = 0

	local rainb = sections.MainSection1:Toggle({
		Name = "Rainbow",
		Default = false,
		Callback = function(value)
			rainbowActive = value
			if rainbowActive then
				rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
					hue = (hue + deltaTime * 0.1) % 1
					local newColor = Color3.fromHSV(hue, 1, 1)
					alphaColorPicker:SetColor(newColor)
				end)
			else
				if rainbowConnection then
					rainbowConnection:Disconnect()
					rainbowConnection = nil
				end
			end
		end,
		Addon = true
	})

	local rainbowAddons = rainb:CreateAddon()

	rainbowAddons:Button({
		Name = "Test",
		Callback = function()
			print("testing")
		end,
	})
	
	rainbowAddons:Slider({
		name = "Test"
	})
	
	rainbowAddons:Dropdown({
		Name = "Test"
	})
	
	rainbowAddons:Input({
		Name = "Test"
	})
	
	rainbowAddons:Toggle({
		Name = "Test"
	})
	
	rainbowAddons:Keybind({
		Name = "Test"
	})
	
	rainbowAddons:Colorpicker({
		Name = "Colorpicker",
		Default = Color3.fromRGB(0, 255, 255),
		Callback = function(color)
			print("Color: ", color)
		end,
	})

	local optionTable = {}

	for i = 1,10 do
		local formatted = "Option ".. tostring(i)
		table.insert(optionTable, formatted)
	end

	local Dropdown = sections.MainSection1:Dropdown({
		Name = "Dropdown",
		Multi = false,
		Required = true,
		Options = optionTable,
		Default = 1,
		Callback = function(Value)
			print("Dropdown changed: ".. Value)
		end,
	})

	local MultiDropdown = sections.MainSection1:Dropdown({
		Name = "Multi Dropdown",
		Search = true,
		Multi = true,
		Required = false,
		Options = optionTable,
		Default = {"Option 1", "Option 3"},
		Callback = function(Value)
			local Values = {}
			for Value, State in next, Value do
				table.insert(Values, Value)
			end
			print("Mutlidropdown changed:", table.concat(Values, ", "))
		end,
	})

	sections.MainSection1:Button({
		Name = "Update Selection",
		Callback = function()
			Dropdown:Set(4)
			MultiDropdown:SetDropdown({"Option 2", "Option 5"})
		end,
	})

	sections.MainSection1:Divider()

	sections.MainSection1:Header({
		Text = "Header #2"
	})

	sections.MainSection1:Paragraph({
		Header = "Paragraph",
		Body = "Paragraph body. Lorem ipsum odor amet, consectetuer adipiscing elit. Morbi tempus netus aliquet per velit est gravida."
	})

	sections.MainSection1:Label({
		Text = "Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
	})

	sections.MainSection1:SubLabel({
		Text = "Sub-Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
	})

	sections.MainSection2:Header({
		Name = "Header #1"
	})

	sections.MainSection2:Button({
		Name = "Button",
		Callback = function()
			Window:Dialog({
				Title = "MacLib Demo",
				Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Eros vestibulum aliquet mattis, ex platea nunc.",
				Buttons = {
					{
						Name = "Confirm",
						Callback = function()
							print("Confirmed!")
						end,
					},
					{
						Name = "Cancel"
					}
				}
			})
		end,
	})

	sections.MainSection2:Input({
		Name = "Input",
		Placeholder = "Input",
		AcceptedCharacters = "All",
		Callback = function(input)
			Window:Notify({
				Title = "MacLib Demo",
				Description = "Successfully set input to " .. input
			})
		end
	})

	sections.MainSection2:Slider({
		Name = "Slider",
		Default = 50,
		Minimum = 0,
		Maximum = 100,
		DisplayMethod = "Percent",
		Callback = function(Value)
			print("Changed to ".. Value)
		end,
	})

	sections.MainSection2:Slider({
		Name = "UI Scale",
		Default = 1,
		Minimum = 0.5,
		Maximum = 2,
		DisplayMethod = "Tenths",
		Callback = function(Val)
			Window:SetScale(Val)
		end,
	})

	sections.MainSection2:Toggle({
		Name = "Toggle",
		Default = false,
		Callback = function(value)
			Window:Notify({
				Title = "MacLib Demo",
				Description = (value and "Enabled " or "Disabled ") .. "Toggle"
			})
		end,
	})

	sections.MainSection2:Keybind({
		Name = "Keybind",
		Callback = function(binded)
			Window:Notify({
				Title = "Demo Window",
				Description = "Pressed keybind - "..tostring(binded.Name),
				Lifetime = 3
			})
		end
	})

	sections.MainSection2:Colorpicker({
		Name = "Colorpicker",
		Default = Color3.fromRGB(0, 255, 255),
		Callback = function(color)
			print("Color: ", color)
		end,
	})

	local alphaColorPicker = sections.MainSection2:Colorpicker({
		Name = "Transparency Colorpicker",
		Default = Color3.fromRGB(255,0,0),
		Alpha = 0,
		Callback = function(color, alpha)
			print("Color: ", color, " Alpha: ", alpha)
		end,
	})

	local rainbowActive
	local rainbowConnection
	local hue = 0

	local rainb2 = sections.MainSection2:Toggle({
		Name = "Rainbow",
		Default = false,
		Callback = function(value)
			rainbowActive = value
			if rainbowActive then
				rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
					hue = (hue + deltaTime * 0.1) % 1
					local newColor = Color3.fromHSV(hue, 1, 1)
					alphaColorPicker:SetColor(newColor)
				end)
			else
				if rainbowConnection then
					rainbowConnection:Disconnect()
					rainbowConnection = nil
				end
			end
		end,
		Addon = true
	})

	local rainbowAddons2 = rainb2:CreateAddon()

	rainbowAddons2:Button({
		Name = "Test",
		Callback = function()
			print("testing")
		end,
	})

	rainbowAddons2:Slider({
		name = "Test"
	})

	rainbowAddons2:Dropdown({
		Name = "Test"
	})

	rainbowAddons2:Input({
		Name = "Test"
	})

	rainbowAddons2:Toggle({
		Name = "Test"
	})

	rainbowAddons2:Keybind({
		Name = "Test"
	})

	rainbowAddons2:Colorpicker({
		Name = "Colorpicker",
		Default = Color3.fromRGB(0, 255, 255),
		Callback = function(color)
			print("Color: ", color)
		end,
	})

	local optionTable = {}

	for i = 1,10 do
		local formatted = "Option ".. tostring(i)
		table.insert(optionTable, formatted)
	end

	local Dropdown = sections.MainSection2:Dropdown({
		Name = "Dropdown",
		Multi = false,
		Required = true,
		Options = optionTable,
		Default = 1,
		Callback = function(Value)
			print("Dropdown changed: ".. Value)
		end,
	})

	local MultiDropdown = sections.MainSection2:Dropdown({
		Name = "Multi Dropdown",
		Search = true,
		Multi = true,
		Required = false,
		Options = optionTable,
		Default = {"Option 1", "Option 3"},
		Callback = function(Value)
			local Values = {}
			for Value, State in next, Value do
				table.insert(Values, Value)
			end
			print("Mutlidropdown changed:", table.concat(Values, ", "))
		end,
	})

	sections.MainSection2:Button({
		Name = "Update Selection",
		Callback = function()
			Dropdown:Set(4)
			MultiDropdown:SetDropdown({"Option 2", "Option 5"})
		end,
	})

	sections.MainSection2:Divider()

	sections.MainSection2:Header({
		Text = "Header #2"
	})

	sections.MainSection2:Paragraph({
		Header = "Paragraph",
		Body = "Paragraph body. Lorem ipsum odor amet, consectetuer adipiscing elit. Morbi tempus netus aliquet per velit est gravida."
	})

	sections.MainSection2:Label({
		Text = "Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
	})

	sections.MainSection2:SubLabel({
		Text = "Sub-Label. Lorem ipsum odor amet, consectetuer adipiscing elit."
	})


	tabs.Main:Select()
end

return MacLib;
