--[[
	Top-level reducer for the Profile feature
]]
local Packages = script:FindFirstAncestor("RoduxProfile").Parent
local Rodux = require(Packages.Rodux)
local Assets = require(script.Parent.Assets)
local CurrentlyWearing = require(script.Parent.CurrentlyWearing)
local ProfilePageDataStatus = require(script.Parent.ProfilePageDataStatus)
local NextDataExpirationTime = require(script.Parent.NextDataExpirationTime)
local ProfilePeekView = require(script.Parent.ProfilePeekView)
local AdditionalUserFields = require(script.Parent.AdditionalUserFields)
local PremiumMembershipStatus = require(script.Parent.PremiumMembershipStatus)
local FriendshipStatus = require(script.Parent.FriendshipStatus)
local FriendsCount = require(script.Parent.FriendsCount)
local FollowersCount = require(script.Parent.FollowersCount)
local FollowingsCount = require(script.Parent.FollowingsCount)

type UserIdList = { [number]: string }

export type State = {
	Assets: Assets.State,
	CurrentlyWearing: CurrentlyWearing.State,
	NetworkStatus: { [string]: string },
	ProfilePageDataStatus: ProfilePageDataStatus.State,
	NextDataExpirationTime: NextDataExpirationTime.State,
	ProfilePeekView: ProfilePeekView.State,
	Users: { byUsername: string, byUserId: { id: string, username: string, displayName: string } },
	Presence: {
		byUserId: { [string]: {
			userId: string,
			lastOnline: string,
			lastLocation: string,
			universeId: string?,
			rootPlaceId: string?,
			placeId: string?,
			gameId: string?,
		} },
		byGameId: { [string]: UserIdList },
		byGameInstanceId: { [string]: UserIdList },
		byPlaceId: { [string]: UserIdList },
	 },
	AdditionalUserFields: AdditionalUserFields.State,
	PremiumMembershipStatus: PremiumMembershipStatus.State,
	FriendshipStatus: FriendshipStatus.State,
	FriendsCount: { [string]: number },
	FollowersCount: FollowersCount.State,
	FollowingsCount: FollowingsCount.State,
}

--[[
	Function to configure and return the Profile reducer

	@param options - Configuration options for the reducer
				.roduxNetworking - The RoduxNetworking instance
				.networkingProfile - The Profile networking instance
				.roduxUsers - the Rodux-Users instance
				.roduxPresence - the Rodux-Presence instance
]]
return function(options)
	local roduxNetworking = options.roduxNetworking
	local roduxUsers = options.roduxUsers
	local roduxPresence = options.roduxPresence

	return Rodux.combineReducers({
		Assets = Assets(options),
		CurrentlyWearing = CurrentlyWearing(options),
		NetworkStatus = roduxNetworking.installReducer(),
		ProfilePageDataStatus = ProfilePageDataStatus,
		NextDataExpirationTime = NextDataExpirationTime,
		ProfilePeekView = ProfilePeekView,
		Users = roduxUsers.installReducer(),
		Presence = roduxPresence.installReducer(),
		AdditionalUserFields = AdditionalUserFields(options),
		PremiumMembershipStatus = PremiumMembershipStatus(options),
		FriendshipStatus = FriendshipStatus(options),
		FriendsCount = FriendsCount(options),
		FollowersCount = FollowersCount(options),
		FollowingsCount = FollowingsCount(options),
	})
end
