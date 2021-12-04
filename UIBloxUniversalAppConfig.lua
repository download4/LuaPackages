-- See https://confluence.rbx.com/display/MOBAPP/UIBlox+Flagging
-- for more info on how to add values here
local CorePackages = game:GetService("CorePackages")

local GetFFlagLuaAppUseNewUIBloxRoundedCorners = require(
	CorePackages.UIBloxFlags.GetFFlagLuaAppUseNewUIBloxRoundedCorners
)
local FFlagUIBloxUseTileThumbnailV2 = require(CorePackages.UIBloxFlags.FFlagUIBloxUseTileThumbnailV2)
local FFlagTempFixEmptyGridView = require(CorePackages.UIBloxFlags.FFlagTempFixEmptyGridView)
local FFlagTempFixGridViewLayoutWithSpawn = require(CorePackages.UIBloxFlags.FFlagTempFixGridViewLayoutWithSpawn)
local GetFFlagUIBloxFixDropdownMenuListPositionAndSize = require(
	CorePackages.UIBloxFlags.GetFFlagUIBloxFixDropdownMenuListPositionAndSize
)
local GetFFlagUIBloxEnableSubtitleOnTile = require(CorePackages.UIBloxFlags.GetFFlagUIBloxEnableSubtitleOnTile)
local GetFFlagUIBloxModalMarginSize = require(CorePackages.UIBloxFlags.GetFFlagUIBloxModalMarginSize)
local GetFFlagUIBloxUpdateDescriptionTextSize = require(
	CorePackages.UIBloxFlags.GetFFlagUIBloxUpdateDescriptionTextSize
)
local GetFFlagUIBloxEnableGamepadKeyCodeSupportForKeyLabel = require(
	CorePackages.UIBloxFlags.GetFFlagUIBloxEnableGamepadKeyCodeSupportForKeyLabel
)
local GetFFlagUIBloxUseNewGenericTextLabelProps = require(
	CorePackages.UIBloxFlags.GetFFlagUIBloxUseNewGenericTextLabelProps
)
local FFlagSupportMultilineButtons = require(CorePackages.UIBloxFlags.FFlagSupportMultilineButtons)
local FFlagUIBloxIncludeIconInTileTextSize = require(CorePackages.UIBloxFlags.FFlagUIBloxIncludeIconInTileTextSize)

return {
	genericButtonSupportsMultiline = FFlagSupportMultilineButtons,
	tempFixEmptyGridView = FFlagTempFixEmptyGridView,
	tempFixGridViewLayoutWithSpawn = FFlagTempFixGridViewLayoutWithSpawn,
	useNewUICornerRoundedCorners = GetFFlagLuaAppUseNewUIBloxRoundedCorners(),
	genericSliderFilterOldTouchInputs = true,
	allowSystemBarToAcceptString = game:DefineFastFlag("UIBloxAllowSystemBarToAcceptString", false),
	emptyStateControllerSupport = true,
	useTileThumbnailV2 = FFlagUIBloxUseTileThumbnailV2,
	useAnimatedXboxCursors = game:DefineFastFlag("GamepadAnimatedCursor", false),
	useUpdatedCheckbox = true,
	fixDropdownMenuListPositionAndSize = GetFFlagUIBloxFixDropdownMenuListPositionAndSize(),
	enableSubtitleOnTile = GetFFlagUIBloxEnableSubtitleOnTile(),
	addIsEmptyToBadge = game:DefineFastFlag("UIBloxEnableAddIsEmptyToBadge", false),
	modalMarginSize = GetFFlagUIBloxModalMarginSize(),
	enableGamepadKeyCodeSupportForKeyLabel = GetFFlagUIBloxEnableGamepadKeyCodeSupportForKeyLabel(),
	useNewGenericTextLabelProps = GetFFlagUIBloxUseNewGenericTextLabelProps(),
	includeIconInTileTextSize = FFlagUIBloxIncludeIconInTileTextSize,
	updateDescriptionTextSize = GetFFlagUIBloxUpdateDescriptionTextSize(),
}
