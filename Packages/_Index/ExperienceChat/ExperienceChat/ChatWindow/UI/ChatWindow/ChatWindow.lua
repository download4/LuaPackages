local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local llama = require(ProjectRoot.llama)
local Dictionary = llama.Dictionary

local UI = script:FindFirstAncestor("UI")
local ScrollingView = require(UI.ScrollingView)
local TextMessageLabel = require(UI.TextMessageLabel)

local ChatWindow = Roact.Component:extend("ChatWindow")
ChatWindow.defaultProps = {
	LayoutOrder = 1,
	size = UDim2.fromScale(1, 1),
	messageHistory = {},
}

function ChatWindow:init()
	self.createChildren = function(history)
		local result = Dictionary.join(
			{
				layout = Roact.createElement("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			},
			Dictionary.map(history, function(textChatMessage, index)
				local child = Roact.createElement(TextMessageLabel, {
					textChatMessage = textChatMessage,
					LayoutOrder = index,
				})

				return child, "message" .. index
			end)
		)

		return result
	end
end

function ChatWindow:render()
	return Roact.createElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		LayoutOrder = self.props.LayoutOrder,
		Size = self.props.size,
	}, {
		scrollingView = Roact.createElement(ScrollingView, {
			size = self.props.size,
		}, self.createChildren(
			self.props.messageHistory
		)),
	})
end

return ChatWindow
