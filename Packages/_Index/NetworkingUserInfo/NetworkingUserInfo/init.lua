--[[
	The RoduxProfile package API.
]]

local networkRequests = script.networkRequests
local createGetUserPremiumMembershipStatus = require(
	networkRequests.createGetUserPremiumMembershipStatus
)
local createGetFollowersCount = require(networkRequests.createGetFollowersCount)
local createGetFollowingsCount = require(networkRequests.createGetFollowingsCount)
local createGetFriendshipStatus = require(networkRequests.createGetFriendshipStatus)

local function createRequestThunks(config)
	return {
		GetUserPremiumMembershipStatus = createGetUserPremiumMembershipStatus(config),
		GetFollowingsCount = createGetFollowingsCount(config),
		GetFollowersCount = createGetFollowersCount(config),
		GetFriendshipStatus = createGetFriendshipStatus(config),
	}
end

return {
	config = createRequestThunks,
}
