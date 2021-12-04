--[[
	The RoduxProfile package API.

	It must be configured before use with required options:

		{
			roduxNetworking - The RoduxNetworking instance to use. The reducer it provides for network
				status will be installed under the "NetworkStatus" key within the Profile reducer
		}
]]
local Packages = script.Parent :: any
local Dash = require(Packages.Dash)
local NetworkingProfile = require(Packages.NetworkingProfile)
local RoduxNetworking = require(Packages.RoduxNetworking)
local Profile = require(script.Reducers.Profile)
local UsersReducer = require(Packages.RoduxUsers)
local PresenceReducer = require(Packages.RoduxPresence)
local NetworkingUsers = require(Packages.NetworkingUsers)
local NetworkingUserInfo = require(Packages.NetworkingUserInfo)
local NetworkingFriends = require(Packages.NetworkingFriends)
local NetworkingPresence = require(Packages.NetworkingPresence)

return {
	config = function(options)
		options = Dash.join(options, {
			networkingProfile = NetworkingProfile.config({
				-- Networking instance is used only to match action names
				roduxNetworking = RoduxNetworking.mock(),
			}),
			roduxUsers = UsersReducer.config({
				keyPath = "Profile.Users",
			}),
			roduxPresence = PresenceReducer.config({
				keyPath = "Profile.Presence"
			}),
			networkingUsers = NetworkingUsers.config({
				roduxNetworking = RoduxNetworking.mock(),
			}),
			networkingUserInfo = NetworkingUserInfo.config({
				roduxNetworking = RoduxNetworking.mock(),
			}),
			networkingFriends = NetworkingFriends.config({
				roduxNetworking = RoduxNetworking.mock(),
			}),
			networkingPresence = NetworkingPresence.config({
				roduxNetworking = RoduxNetworking.mock(),
			}),
		})

		return {
			installReducer = function()
				return Profile(options)
			end,
			Actions = {
				SetNextDataExpirationTime = require(script.Actions.SetNextDataExpirationTime),
				SetProfilePageDataStatus = require(script.Actions.SetProfilePageDataStatus),
				SetProfilePeekViewState = require(script.Actions.SetProfilePeekViewState),
			},
			Models = {
				AssetInfo = require(script.Models.AssetInfo),
			},
		}
	end,
}
