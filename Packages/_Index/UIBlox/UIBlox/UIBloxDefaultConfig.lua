return {
	-- tempFixGridViewLayoutWithSpawn: A temp/hacky fix to a problem with GridView layout.
	-- Somehow GridView doesn't get created until we do some kind of a read, and furthermore
	-- this read can't happen right after component is mounted.
	-- Temp fix: add a spawn in didMount around the hack 'read'.
	-- Long term fix: C++ changes to UI code, and/or refactor of GridView code.
	tempFixGridViewLayoutWithSpawn = false,

	-- tempFixEmptyGridView: This is a temp/hacky fix to a problem in UI layout code.  Real/better
	-- fix is coming on C++ side, this is a stopgap measure to fix the problem ASAP in prod.
	tempFixEmptyGridView = false,

	-- styleRefactorConfig: DEPRECATED: this is a no-op, but is left in so that it's easier to upgrade consumers of
	-- UIBlox that try to assign a value to it (the config layer will throw if assigning to a value that's not in the
	-- default config)
	styleRefactorConfig = false,

	--useNewUICornerRoundedCorners: Uses the new roblox CornerUI Instance instead of mask-based UI corners
	useNewUICornerRoundedCorners = false,

	-- genericSliderFilterOldTouchInputs: Filters inputObjects that trigger inputBegan with a
	-- non Enum.UserInputState.Begin UserInputState in the GenericSlider component
	genericSliderFilterOldTouchInputs = false,

	-- useAnimatedXboxCursors: Uses the new animated selection cursors when selecting UI elements in xbox
	useAnimatedXboxCursors = false,

	--allowSystemBarToAcceptString: Allows you to pass a string as the value for 'badgeValue'. Passing a
	--string will show the badge even if the string is empty.
	allowSystemBarToAcceptString = false,

	-- emptyStateControllerSupport: Enables controller support for the EmptyState component.
	emptyStateControllerSupport = false,

	-- useTileThumbnailV2: Controls the usage of TileThumbnailV2
	useTileThumbnailV2 = false,

	-- useUpdatedCheckbox: Enables FitFrame for InputButton and gives Checkbox a gamepad
	-- selection cursor.
	useUpdatedCheckbox = false,

	-- fixDropdownMenuListPositionAndSize: Uses the bottom inset for positioning the dropdown menu list for
	-- mobile view, allows sizing relative to parent container size, and limits dropdown width for wide view.
	fixDropdownMenuListPositionAndSize = false,

	-- enableSubtitleOnTile: Enables a subtitle label positioned below the title
	-- that can be passed in as a prop.
	enableSubtitleOnTile = false,

	-- Warning for deprecated components.
	-- This is not a flag but a temporary config to show a warning for using deprecated components.
	-- current deprecated components are,
	-- src\App\Loading\Enum\LoadingState.lua
	-- src\App\Loading\Enum\ReloadingStyle.lua
	devHasDeprecationWarning = false,

	-- addIsEmptyToBadge: A smaller badge with no contents will show when the value for badge is BadgeStates.isEmpty
	-- applies to NavBar items too.
	addIsEmptyToBadge = false,

	-- modalMarginSize: Allow modals to take in a margin size
	modalMarginSize = false,

	-- useNewGenericTextLabelProps: when false, GenericTextLabel component supports AutomaticSize, TextSize, and Size
	-- props from a traditional TextLabel
	useNewGenericTextLabelProps = false,

	-- genericButtonInputChanges: Allows delayed input + input icon on buttons
	genericButtonInputChanges = false,

	-- genericButtonSupportsMultiline: Allows for GenericButton to support multiline
	-- text.
	genericButtonSupportsMultiline = false,

	-- enableGamepadKeyCodeSupportForKeyLabel: Allows KeyLabel to accept a gamepad
	-- KeyCode and displays the appropriate gamepad button image
	enableGamepadKeyCodeSupportForKeyLabel = false,

	-- enableAnimatedCursorForNonRoactGamepadComponent: enable animated selection cursor for contextual menu
	-- without using RoactGamepad component in IGM
	enableAnimatedCursorForNonRoactGamepadComponent = false,

	-- includeIconInTileTextSize: Includes the inline icon when measuring title text
	-- size to match how ImageTextLabel lays out the text.
	includeIconInTileTextSize = false,

	-- updateDescriptionTextSize: `DescroptionText` in `ExpandableTextArea` to adjust size based on
	-- expanded or collasped state
	updateDescriptionTextSize = false,
}
