local ExperienceChat = script:FindFirstAncestor("ExperienceChat")
local ProjectRoot = ExperienceChat.Parent
local Roact = require(ProjectRoot.Roact)

local ChatInputBar = require(ExperienceChat.ChatInput)
local ChatWindow = require(ExperienceChat.ChatWindow)

local AppLayout = Roact.Component:extend("AppLayout")
AppLayout.defaultProps = {
	targetChannelDisplayName = nil,
	isChatInputBarVisible = true,
	isChatWindowVisible = true,
	messageHistory = nil,
	addTopPadding = true,
	LayoutOrder = 1,
}

function AppLayout:init()
	self.state = {
		targetChannelDisplayName = self.props.targetChannelDisplayName,
	}

	self.onTargetChannelChanged = function(newChannelName)
		self:setState({
			targetChannelDisplayName = newChannelName or Roact.None,
		})
	end
end

function AppLayout:render()
	return Roact.createElement("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 4),
		Size = UDim2.fromScale(0.4, 0.25),
	}, {
		layout = Roact.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		topBorder = Roact.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/TopRoundedRect8px.png",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.3,
			LayoutOrder = 1,
			ScaleType = Enum.ScaleType.Slice,
			Size = UDim2.new(1, 0, 0, 8),
			SliceCenter = Rect.new(8, 8, 24, 32),
			Visible = self.props.isChatWindowVisible or self.props.isChatInputBarVisible,
		}),
		chatWindow = self.props.isChatWindowVisible and Roact.createElement(ChatWindow, {
			LayoutOrder = 2,
			messageHistory = self.props.messageHistory,
			size = UDim2.fromScale(1, 1),
		}),
		chatInputBar = self.props.isChatInputBarVisible and Roact.createElement(ChatInputBar, {
			LayoutOrder = 3,
			addTopPadding = self.props.isChatWindowVisible,
			targetChannelDisplayName = self.state.targetChannelDisplayName,
			onTargetChannelChanged = self.onTargetChannelChanged,
		}),
		bottomBorder = Roact.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/BottomRoundedRect8px.png",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.3,
			LayoutOrder = 4,
			ScaleType = Enum.ScaleType.Slice,
			Size = UDim2.new(1, 0, 0, 8),
			SliceCenter = Rect.new(8, 0, 24, 16),
			Visible = self.props.isChatWindowVisible or self.props.isChatInputBarVisible,
		}),
	})
end

return AppLayout
