local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local RoactRodux = require(ProjectRoot.RoactRodux)

local AppContainer = require(script.Parent.AppContainer)
local createStore = require(script.Parent.createStore)

local App = Roact.Component:extend("App")

local store = createStore()
App.DispatchBindableEvent = require(script.Parent.createDispatchBindableEvent)(store)

App.defaultProps = {
	messageHistory = {},
	targetChannelDisplayName = nil,
	store = store,
}

function App:render()
	return self.props.isDefaultChatEnabled
		and Roact.createElement(RoactRodux.StoreProvider, {
			store = self.props.store,
		}, {
			container = Roact.createElement(AppContainer, {
				messageHistory = self.props.messageHistory,
				isChatInputBarVisible = self.props.isChatInputBarVisible,
				isChatWindowVisible = self.props.isChatWindowVisible,
				targetChannelDisplayName = self.props.targetChannelDisplayName,
			}),
		})
end

return App
