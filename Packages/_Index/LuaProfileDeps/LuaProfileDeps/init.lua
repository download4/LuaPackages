--[[
	The LuaProfileDeps package API.
]]
local Packages = script.Parent

return {
	DebugUtils = require(Packages.DebugUtils),
	NetworkingProfile = require(Packages.NetworkingProfile),
	NetworkingUserInfo = require(Packages.NetworkingUserInfo),
	RoduxProfile = require(Packages.RoduxProfile),
	UnitTestHelpers = require(Packages.UnitTestHelpers),

	Dash = require(Packages.Dash),
	HttpRequest = require(Packages.HttpRequest),
	Promise = require(Packages.Promise),
	RoduxNetworking = require(Packages.RoduxNetworking),
	NetworkingUsers = require(Packages.NetworkingUsers),
	NetworkingFriends = require(Packages.NetworkingFriends),
	NetworkingPresence = require(Packages.NetworkingPresence),
	RoduxPresence = require(Packages.RoduxPresence),
}
