local ProjectRoot = script:FindFirstAncestor("ExperienceChat").Parent
local Roact = require(ProjectRoot.Roact)
local List = require(ProjectRoot.llama).List

local AppLayout = require(script.Parent)

local story = Roact.Component:extend("story")

function story:init()
	self.textChatMessages = {
		{
			PrefixText = [[<font color="#D7C59A">Alice</font>]],
			Text = "Hello world!",
		},
		{
			PrefixText = [[<font color="#E8BAC8">Bob</font>]],
			Text = string.rep("Hello world! ", 10),
		},
		{
			PrefixText = [[<font color="#01A2FF">Charlie</font>]],
			Text = string.rep("AAAA! ", 10),
		},
		{
			PrefixText = [[<font color="#FD2943"><font color="#FFA500">[VIP]</font> Darla</font>]],
			Text = string.rep("lol! ", 2),
		},
	}
	local count = 0
	self.getTextChatMessage = function()
		count = (count + 1) % (#self.textChatMessages + 1)
		return self.textChatMessages[count]
	end

	self.state.messageHistory = { self.getTextChatMessage() }
end

function story:render()
	return Roact.createElement("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = "rbxassetid://751751000",
		ScaleType = Enum.ScaleType.Crop,
	}, {
		appLayout = Roact.createElement(AppLayout, {
			isChatWindowVisible = self.props.controls.isChatWindowVisible,
			isChatInputBarVisible = self.props.controls.isChatInputBarVisible,
			targetChannelDisplayName = self.props.controls.targetChannelDisplayName,
			onTargetChannelChanged = self.props.onTargetChannelChanged,
			messageHistory = self.state.messageHistory,
		}),
	})
end

function story:didMount()
	local timeElapsed = 0
	self.connection = self.props.timeSignal:connect(function(dt)
		timeElapsed += dt

		local frequency = self.props.controls.sentMessageHz
		if timeElapsed >= frequency then
			timeElapsed -= frequency

			self:setState({
				messageHistory = List.append(self.state.messageHistory, self.getTextChatMessage()),
			})
		end
	end)
end

function story:willUnmount()
	if self.connection then
		self.connection:disconnect()
	end
end

return {
	summary = "A full picture of the ExperienceChat application.",
	story = story,
	controls = {
		isChatWindowVisible = true,
		isChatInputBarVisible = true,
		sentMessageHz = 2,
		targetChannelDisplayName = nil,
	},
	props = {
		timeSignal = game:GetService("RunService").Heartbeat,
	},
}
