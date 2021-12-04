local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)

local ChatWindow = require(script.Parent)

return {
	summary = "ChatWindow concept with ScrollingView and TextMessageLabel. Currently children are static"
		.. " but in the future ChatWindow will parse text chat messages and convert into children.",
	story = function(props)
		return Roact.createElement(ChatWindow, {
			size = props.size,
			messageHistory = props.messageHistory,
		})
	end,
	controls = {},
	props = {
		size = UDim2.fromOffset(350, 100),
		messageHistory = {
			{
				PrefixText = "Player1",
				Text = "Hello world!",
			},
			{
				PrefixText = "<font color='#AA55AA'>Player2</font>",
				Text = "Nice work.",
			},
		},
	},
}
