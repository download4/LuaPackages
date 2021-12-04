-- Return an empty table to test with all flags off i.e. the UIBloxDefaultConfig
-- return {}

return {
	--useNewUICornerRoundedCorners: Uses the new roblox CornerUI Instance instead of mask-based UI corners
	useNewUICornerRoundedCorners = true,

	-- emptyStateControllerSupport: Enables controller support for the EmptyState component.
	emptyStateControllerSupport = true,

	-- useAnimatedXboxCursors: Uses the new animated selection cursors when selecting UI elements in xbox
	useAnimatedXboxCursors = true,

	-- useUpdatedCheckbox: Enables FitFrame for InputButton and gives Checkbox a gamepad
	-- selection cursor.
	useUpdatedCheckbox = true,

	-- fixDropdownMenuListPositionAndSize: Uses the bottom inset for positioning the dropdown menu list for
	-- mobile view, allows sizing relative to parent container size, and limits dropdown width for wide view.
	fixDropdownMenuListPositionAndSize = true,

	--allowSystemBarToAcceptString: Allows you to pass a string as the value for 'badgeValue'. Passing a
	--string will show the badge even if the string is empty.
	allowSystemBarToAcceptString = true,

	-- addIsEmptyToBadge: A smaller badge with no contents will show when the value for badge is BadgeStates.isEmpty
	-- applies to NavBar items too.
	addIsEmptyToBadge = true,

	-- modalMarginSize: Allow modals to take in a margin size
	modalMarginSize = true,

	-- genericButtonInputChanges: Allows delayed input + input icon on buttons
	genericButtonInputChanges = true,

	-- genericButtonSupportsMultiline: Allows for GenericButton to support multiline
	-- text.
	genericButtonSupportsMultiline = true,

	-- useNewGenericTextLabelProps: when off, GenericTextLabel component supports AutomaticSize, TextSize, and Size
	-- props from a traditional TextLabel
	useNewGenericTextLabelProps = false,

	-- enableGamepadKeyCodeSupportForKeyLabel: Allows KeyLabel to accept a gamepad
	-- KeyCode and displays the appropriate gamepad button image
	enableGamepadKeyCodeSupportForKeyLabel = true,

	-- updateDescriptionTextSize: `DescroptionText` in `ExpandableTextArea` to adjust size based on
	-- expanded or collasped state
	updateDescriptionTextSize = true,
}
