local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)

local UI = script.UI
local ChatWindow = require(UI.ChatWindow)

local ChatWindowApp = Roact.Component:extend("ChatWindowApp")
ChatWindowApp.defaultProps = {
	LayoutOrder = 1,
	messageHistory = {},
	size = UDim2.fromScale(1, 1),
}

function ChatWindowApp:render()
	return Roact.createElement(ChatWindow, {
		LayoutOrder = self.props.LayoutOrder,
		messageHistory = self.props.messageHistory,
		size = self.props.size,
	})
end

-- TODO: Rodux connection
return ChatWindowApp
