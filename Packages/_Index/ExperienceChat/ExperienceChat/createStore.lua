local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Rodux = require(ProjectRoot.Rodux)

local installReducer = require(script.Parent.installReducer)

local function createStore()
	local middlewares = {
		Rodux.thunkMiddleware,
	}
	return Rodux.Store.new(installReducer(), nil, middlewares)
end

return createStore
