return function(state, _)
	return {
		isChatInputBarVisible = state.ChatVisibility.isChatInputBarVisible,
		isChatWindowVisible = state.ChatVisibility.isChatWindowVisible,
	}
end
