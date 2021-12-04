local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)

local UI = script.UI
local ChatInputBar = require(UI.ChatInputBar)

local ChatInputBarApp = Roact.Component:extend("ChatInputBarApp")
ChatInputBarApp.defaultProps = {
	addTopPadding = true,
	LayoutOrder = 1,
	targetChannelDisplayName = nil,
	onTargetChannelChanged = function() end,
}

function ChatInputBarApp:render()
	return Roact.createElement(ChatInputBar, {
		addTopPadding = self.props.addTopPadding,
		LayoutOrder = self.props.LayoutOrder,
		placeholderText = 'To chat click here or press "/" key',
		size = UDim2.fromScale(1, 0),
		targetChannelDisplayName = self.props.targetChannelDisplayName,
		onTargetChannelChanged = self.props.onTargetChannelChanged,
	})
end

-- TODO: Rodux connection
return ChatInputBarApp
