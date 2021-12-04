--[[
	GetFriendshipStatus API

	Query path: /v1/users/{userId}/friends/statuses
]]
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)

return function(config)
	local roduxNetworking = config.roduxNetworking

	return roduxNetworking.GET(
		{ Name = "GetFriendshipStatus" },
		function(requestBuilder, targetUserId)
			return requestBuilder(FRIENDS_URL)
				:path("v1")
				:path("users")
				:id(targetUserId)
				:path("friends")
				:path("statuses")
		end
	)
end
