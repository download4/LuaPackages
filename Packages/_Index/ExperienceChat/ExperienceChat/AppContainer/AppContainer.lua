local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local RoactRodux = require(ProjectRoot.RoactRodux)

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local AppLayout = require(script.Parent.Parent.AppLayout)

local AppContainer = Roact.Component:extend("AppContainer")
AppContainer.defaultProps = {
	targetChannelDisplayName = nil,
	isChatInputBarVisible = true,
	isChatWindowVisible = true,
	messageHistory = nil,
}

function AppContainer:render()
	return Roact.createElement(AppLayout, {
		targetChannelDisplayName = self.props.targetChannelDisplayName,
		isChatInputBarVisible = self.props.isChatInputBarVisible,
		isChatWindowVisible = self.props.isChatWindowVisible,
		messageHistory = self.props.messageHistory,
	})
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(AppContainer)
