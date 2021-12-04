local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)

local DEFAULT_FONT = Enum.Font.GothamSemibold
local DEFAULT_TEXT_COLOR = BrickColor.new(255, 255, 255)
local DEFAULT_TEXT_SIZE = 14

local TextMessageLabel = Roact.Component:extend("TextMessageLabel")
TextMessageLabel.defaultProps = {}

function TextMessageLabel:render()
	local text = self.props.textChatMessage.Text or ""
	local prefixText = self.props.textChatMessage.PrefixText or ""

	return Roact.createElement("TextLabel", {
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		Font = DEFAULT_FONT,
		RichText = true,
		Size = UDim2.new(1, 0, 0, 0),
		Text = prefixText .. ": " .. text,
		TextColor = DEFAULT_TEXT_COLOR,
		TextSize = DEFAULT_TEXT_SIZE,
		TextStrokeTransparency = 0.5,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = self.props.LayoutOrder,
	})
end

return TextMessageLabel
