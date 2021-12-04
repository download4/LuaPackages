local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local UIBlox = require(ProjectRoot.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.Label

local DEFAULT_FONT = Enum.Font.GothamSemibold
local DEFAULT_TEXT_SIZE = 14

local TOGGLE_CHAT_ACTION_NAME = "ToggleDefaultChat"

local ChatInputBar = Roact.Component:extend("ChatInputBar")
ChatInputBar.defaultProps = {
	userInputService = game:GetService("UserInputService"),
	contextActionService = game:GetService("ContextActionService"),
	LayoutOrder = 1,
	sendButtonContainerWidth = 30,
	targetChannelDisplayName = nil,
	onTargetChannelChanged = function() end,
}

function ChatInputBar:init()
	self.isMounted = false
	self.emptyInputText = true
	self.state = {
		inputText = "",
		isFocused = false,
	}

	self.targetChannelWidth, self.updateTargetChannelWidth = Roact.createBinding(0)
	self.textBoxRef = Roact.createRef()

	self.onFocused = function()
		self:setState({
			isFocused = true,
		})
	end

	self.onFocusLost = function(enterPressed)
		if enterPressed then
			self.onSendActivated()
		end

		if self.isMounted then
			self:setState({
				isFocused = false,
			})
		end
	end

	self.onTextChanged = function(rbx)
		local newText = rbx.Text

		self:setState({
			inputText = newText,
		})

		self.emptyInputText = #newText == 0 and self.emptyInputText
	end

	self.onSendActivated = function()
		if not self.isMounted then
			return
		end

		local text = string.gsub(self.state.inputText, "%p", {
			["<"] = "&lt;",
			[">"] = "&gt;",
			["&"] = "&amp;",
		})

		-- * In the future, this is where we would call some bridge to SendAsync
		if self.props.onSendChat then
			self.props.onSendChat(text)
		end

		self.textBoxRef:getValue().Text = ""
		self.textBoxRef:getValue():ReleaseFocus()

		self:setState({
			inputText = "",
		})
	end

	self.onBackspacePressedConnection = self.props.userInputService.InputEnded:connect(function(inputObj, _)
		if
			self.textBoxRef:getValue():IsFocused()
			and inputObj.KeyCode == Enum.KeyCode.Backspace
			and self.state.inputText == ""
		then
			if not self.emptyInputText then
				self.emptyInputText = true
			else
				self.props.onTargetChannelChanged(Roact.None)
				self.updateTargetChannelWidth(0)
			end
		end
	end)
end
function ChatInputBar:render()
	local hasEmptyInputText = self.state.inputText == ""
	local showPlaceholderText = hasEmptyInputText and not self.state.isFocused

	return Roact.createElement("Frame", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = UIBlox.App.Style.Colors.Black,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		LayoutOrder = self.props.LayoutOrder,
		Size = self.props.size,
	}, {
		UIPadding = Roact.createElement("UIPadding", {
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8),
			PaddingTop = self.props.addTopPadding and UDim.new(0, 8) or UDim.new(0, 0),
		}),
		Background = Roact.createElement("Frame", {
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = UIBlox.App.Style.Colors.Obsidian,
			BackgroundTransparency = 0.2,
			Size = UDim2.new(1, 0, 0, 0),
		}, {
			Border = Roact.createElement("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = UIBlox.App.Style.Colors.White,
				Transparency = 0.8,
			}),
			Corner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 3),
			}),
			Container = Roact.createElement("Frame", {
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.fromScale(1, 0),
				BackgroundColor3 = UIBlox.App.Style.Colors.White,
				BackgroundTransparency = 1,
			}, {
				TextContainer = Roact.createElement("Frame", {
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -self.props.sendButtonContainerWidth, 0, 0),
				}, {
					TargetChannel = Roact.createElement("TextLabel", {
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Font = DEFAULT_FONT,
						TextSize = DEFAULT_TEXT_SIZE,
						Text = self.props.targetChannelDisplayName,
						TextWrapped = true,
						TextTransparency = 0,
						TextColor3 = UIBlox.App.Style.Colors.White,
						Size = UDim2.fromScale(0, 1),
						Visible = self.props.targetChannelDisplayName ~= nil,

						[Roact.Change.AbsoluteSize] = function(rbx)
							self.updateTargetChannelWidth(rbx.AbsoluteSize.X)
						end,
					}, {
						textPadding = Roact.createElement("UIPadding", {
							PaddingRight = UDim.new(0, 4),
						}),
					}),
					TextBox = Roact.createElement("TextBox", {
						AnchorPoint = Vector2.new(1, 0),
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						ClearTextOnFocus = false,
						Font = DEFAULT_FONT,
						PlaceholderText = showPlaceholderText and self.props.placeholderText or "",
						Position = UDim2.fromScale(1, 0),
						Size = self.targetChannelWidth:map(function(width)
							return UDim2.new(1, -width, 0, 0)
						end),
						Text = "",
						TextColor3 = showPlaceholderText and UIBlox.App.Style.Colors.Pumice
							or UIBlox.App.Style.Colors.White,
						TextSize = DEFAULT_TEXT_SIZE,
						TextTransparency = showPlaceholderText and 0.5 or 0,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,

						[Roact.Event.Focused] = self.onFocused,
						[Roact.Event.FocusLost] = self.onFocusLost,
						[Roact.Change.Text] = self.onTextChanged,
						[Roact.Ref] = self.textBoxRef,
					}),
					UIPadding = Roact.createElement("UIPadding", {
						PaddingBottom = UDim.new(0, 10),
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 10),
						PaddingTop = UDim.new(0, 10),
					}),
				}),
				SendButton = Roact.createElement("TextButton", {
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					LayoutOrder = 2,
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.new(0, self.props.sendButtonContainerWidth, 1, 0),
					Text = "",

					[Roact.Event.Activated] = self.onSendActivated,
				}, {
					Layout = Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),
					SendIcon = Roact.createElement(ImageSetLabel, {
						BackgroundTransparency = 1,
						ImageColor3 = hasEmptyInputText and UIBlox.App.Style.Colors.Pumice
							or UIBlox.App.Style.Colors.White,
						ImageTransparency = hasEmptyInputText and 0.5 or 0,
						Image = Images["icons/actions/send"],
						Size = UDim2.new(0, 30, 0, 30),
					}),
				}),
			}),
		}),
	})
end

function ChatInputBar:didMount()
	self.isMounted = true

	local function handleAction(_, inputState)
		if inputState == Enum.UserInputState.End and not self.textBoxRef:getValue():IsFocused() then
			self.textBoxRef:getValue():CaptureFocus()
		end
	end
	self.props.contextActionService:BindAction(TOGGLE_CHAT_ACTION_NAME, handleAction, false, Enum.KeyCode.Slash)
end

function ChatInputBar:willUnmount()
	self.isMounted = false

	self.props.contextActionService:UnbindAction(TOGGLE_CHAT_ACTION_NAME)

	self.onBackspacePressedConnection:Disconnect()
	self.onBackspacePressedConnection = nil
end

return ChatInputBar
