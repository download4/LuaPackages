local Packages = script.Parent
local Roact17UpgradeFlag = require(Packages.Roact17UpgradeFlag)
local GetFFlagLegacyRoactUpgradeFlag = require(Packages.GetFFlagLegacyRoactUpgradeFlag)

if Roact17UpgradeFlag.getRolloutForId() then
	return require(Packages.Roact17)
else
	if GetFFlagLegacyRoactUpgradeFlag() then
		return require(Packages.UpgradedLegacyRoact)
	else
		return require(Packages.LegacyRoact)
	end
end
