local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)

local AppContainer = require(script.Parent)

return {
	story = function(props)
		return Roact.createElement(AppContainer, {
			messageHistory = props.messageHistory,
			isChatInputBarVisible = props.isChatInputBarVisible,
			isChatWindowVisible = props.isChatWindowVisible,
			targetChannelDisplayName = props.targetChannelDisplayName,
		})
	end,
	controls = {},
	props = {
		messageHistory = {},
		isChatInputBarVisible = false,
		isChatWindowVisible = false,
		targetChannelDisplayName = "",
	},
}
