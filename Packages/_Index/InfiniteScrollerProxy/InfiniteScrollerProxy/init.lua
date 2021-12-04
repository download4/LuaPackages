local Packages = script.Parent
local Roact17UpgradeFlag = require(Packages.Roact17UpgradeFlag)
local InfiniteScrollerUpgradeFlag = game:DefineFastFlag("InfiniteScrollerUpgradeFlag", false)

if Roact17UpgradeFlag.getRolloutForId() then
	if InfiniteScrollerUpgradeFlag then
		return require(Packages.InfiniteScroller0_9_4)
	else
		return require(Packages.InfiniteScroller0_9_0)
	end
else
	return require(Packages.InfiniteScroller0_8_0)
end
