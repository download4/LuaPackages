local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Rodux = require(ProjectRoot.Rodux)

return function()
	return Rodux.combineReducers({
		ChatVisibility = require(script.Parent.ChatVisibility.Reducers),
	})
end
