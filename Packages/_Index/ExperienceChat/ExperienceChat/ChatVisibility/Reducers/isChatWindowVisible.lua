local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Rodux = require(ProjectRoot.Rodux)

return Rodux.createReducer(true, {
	ChatTopBarButtonActivated = function(state, _)
		return not state
	end,
	TextChatServiceChatWindowPropertyChanged = function(_, action)
		return action.isVisible
	end,
})
