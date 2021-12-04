local ExperienceChat = script:FindFirstAncestor("ExperienceChat")
local Actions = ExperienceChat.ChatVisibility.Actions
local ChatTopBarButtonActivated = require(Actions.ChatTopBarButtonActivated)
local TextChatServiceChatWindowPropertyChanged = require(Actions.TextChatServiceChatWindowPropertyChanged)

return function(dispatch)
	return {
		chatTopBarButtonActivated = function()
			dispatch(ChatTopBarButtonActivated)
		end,

		textChatServiceChatWindowPropertyChanged = function()
			dispatch(TextChatServiceChatWindowPropertyChanged)
		end,
	}
end
