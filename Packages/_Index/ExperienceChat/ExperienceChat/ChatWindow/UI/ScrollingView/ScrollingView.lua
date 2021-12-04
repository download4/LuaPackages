local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local UIBlox = require(ProjectRoot.UIBlox)

local VerticalScrollView = UIBlox.App.Container.VerticalScrollView

local ScrollingView = Roact.Component:extend("ScrollingView")
ScrollingView.defaultProps = {}

function ScrollingView:render()
	return Roact.createElement("ImageButton", {
		BackgroundTransparency = 1,
		Size = self.props.size,
	}, {
		verticalScrollView = Roact.createElement(VerticalScrollView, {
			useAutomaticCanvasSize = true,
			size = UDim2.fromScale(1, 1),
			canvasSizeY = UDim.new(0, 0),
			paddingHorizontal = 8,
		}, self.props[Roact.Children]),
	})
end

return ScrollingView
