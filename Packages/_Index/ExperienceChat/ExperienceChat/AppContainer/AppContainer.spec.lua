local CoreGui = game:GetService("CoreGui")
local ExperienceChat = CoreGui:FindFirstChild("ExperienceChat", true)
local globals = require(ExperienceChat.Dev.Jest).Globals
local expect = globals.expect
local ChatVisibility = ExperienceChat.ExperienceChat.ChatVisibility
local Actions = ChatVisibility.Actions
local ChatTopBarButtonActivated = require(Actions.ChatTopBarButtonActivated)
local TextChatServiceChatWindowPropertyChanged = require(Actions.TextChatServiceChatWindowPropertyChanged)

return function()
	beforeAll(function(rootContext)
		local storyDefinition = require(script.Parent:FindFirstChild("AppContainer.story"))
		local installReducer = require(script.Parent.Parent.installReducer)
		rootContext.mount = function(initialState, context)
			local Roact = context.Roact
			local RoactRodux = context.RoactRodux
			local storyMiddleware = context.storyMiddleware
			local instance = Instance.new("ScreenGui")
			instance.Parent = game:GetService("CoreGui")

			local middlewares = {
				context.Rodux.thunkMiddleware,
			}
			local store = context.Rodux.Store.new(installReducer(), initialState, middlewares)

			local tree = Roact.createElement(RoactRodux.StoreProvider, {
				store = store,
			}, {
				container = Roact.createElement(storyMiddleware(storyDefinition.story)),
			})
			local roactInstance = Roact.mount(tree, instance)
			return {
				instance = instance,
				unmount = function()
					Roact.unmount(roactInstance)
					instance:Destroy()
				end,
				store = store,
			}
		end

		rootContext.createInitialState = function(isChatWindowVisible, isChatInputBarVisible)
			return {
				ChatVisibility = {
					isChatWindowVisible = isChatWindowVisible,
					isChatInputBarVisible = isChatInputBarVisible,
				},
			}
		end
	end)

	it("SHOULD mount AppContainer properly", function(c)
		local mountResult = c.mount({}, c)
		expect(mountResult.instance).never.toBeNil()
		mountResult.unmount()
	end)

	describe("WHEN mounted", function()
		it("SHOULD render Chat Window and Chat Input Bar on default", function(c)
			local mountResult = c.mount({}, c)
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()
			mountResult.unmount()
		end)

		it("SHOULD render Chat Window and Chat Input Bar depending on initial state", function(c)
			-- When state = { ChatVisibility = { isChatWindowVisible = false, isChatInputBarVisible = false} },
			-- then chatWindow and chatInputBar should not be rendered

			local initialState = c.createInitialState(false, false)
			local mountResult = c.mount(initialState, c)
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).toBeNil()

			-- When state = { ChatVisibility = { isChatWindowVisible = true, isChatInputBarVisible = false} },
			-- then chatWindow should and chatInputBar should not be rendered
			initialState = c.createInitialState(true, false)
			mountResult = c.mount(initialState, c)
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).toBeNil()

			-- When state = { ChatVisibility = { isChatWindowVisible = false, isChatInputBarVisible = true} },
			-- then chatWindow should not and chatInputBar should be rendered
			initialState = c.createInitialState(false, true)
			mountResult = c.mount(initialState, c)
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()
			mountResult.unmount()
		end)
	end)

	it(
		"SHOULD toggle ChatVibility and rendering of chatWindow and chatInputBar when ChatTopBarButtonActivated action is dispatched",
		function(c)
			local mountResult = c.mount({}, c)
			local store = mountResult.store
			expect(store:getState()).toEqual({
				ChatVisibility = {
					isChatWindowVisible = true,
					isChatInputBarVisible = true,
				},
			})
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()

			store:dispatch(ChatTopBarButtonActivated())
			expect(store:getState()).toEqual({
				ChatVisibility = {
					isChatWindowVisible = false,
					isChatInputBarVisible = false,
				},
			})
			wait()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).toBeNil()

			store:dispatch(ChatTopBarButtonActivated())
			expect(store:getState()).toEqual({
				ChatVisibility = {
					isChatWindowVisible = true,
					isChatInputBarVisible = true,
				},
			})
			wait()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
			expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()
		end
	)

	it("SHOULD render chatWindow and chatInputBar based on TextChatServiceChatWindowPropertyChanged action", function(c)
		local mountResult = c.mount({}, c)
		local store = mountResult.store
		expect(store:getState()).toEqual({
			ChatVisibility = {
				isChatWindowVisible = true,
				isChatInputBarVisible = true,
			},
		})
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()

		store:dispatch(TextChatServiceChatWindowPropertyChanged(false))
		expect(store:getState()).toEqual({
			ChatVisibility = {
				isChatWindowVisible = false,
				isChatInputBarVisible = false,
			},
		})
		wait()
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).toBeNil()
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).toBeNil()

		store:dispatch(TextChatServiceChatWindowPropertyChanged(true))
		expect(store:getState()).toEqual({
			ChatVisibility = {
				isChatWindowVisible = true,
				isChatInputBarVisible = true,
			},
		})
		wait()
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatWindow" })).never.toBeNil()
		expect(c.findFirstInstance(mountResult.instance, { Name = "chatInputBar" })).never.toBeNil()
	end)
end
