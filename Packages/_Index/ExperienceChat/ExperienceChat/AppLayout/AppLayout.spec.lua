local CoreGui = game:GetService("CoreGui")
local ExperienceChat = CoreGui:FindFirstChild("ExperienceChat", true)
local globals = require(ExperienceChat.Dev.Jest).Globals
local expect = globals.expect

return function()
	beforeAll(function(rootContext)
		local storyDefinition = require(script.Parent:FindFirstChild("AppLayout.story"))
		rootContext.mount = rootContext.createMount(storyDefinition.story, function(c)
			return {
				controls = {
					isChatWindowVisible = c.isChatWindowVisible,
					isChatInputBarVisible = c.isChatInputBarVisible,
					targetChannelDisplayName = c.targetChannelDisplayName,
				},
				timeSignal = c.timeBindableEvent.Event,
			}
		end)
	end)

	describe("GIVEN timeSignal", function()
		beforeAll(function(c)
			c.timeBindableEvent = Instance.new("BindableEvent")
		end)

		describe("WHEN isChatWindowVisible is true", function()
			beforeAll(function(c)
				c.isChatWindowVisible = true
			end)

			it("SHOULD mount ChatWindow", function(c)
				local result = c:mount()
				local chatWindow = c.findFirstInstance(result.instance, { Name = "chatWindow" })
				expect(chatWindow).never.toBeNil()
			end)
		end)

		describe("WHEN isChatWindowVisible is false", function()
			beforeAll(function(c)
				c.isChatWindowVisible = false
			end)

			it("SHOULD NEVER mount ChatWindow", function(c)
				local result = c:mount()
				local chatWindow = c.findFirstInstance(result.instance, { Name = "chatWindow" })
				expect(chatWindow).toBeNil()
			end)
		end)

		describe("WHEN isChatInputBarVisible is true", function()
			beforeAll(function(c)
				c.isChatInputBarVisible = true
			end)

			it("SHOULD mount ChatInputBar", function(c)
				local result = c:mount()
				local chatInputBar = c.findFirstInstance(result.instance, { Name = "chatInputBar" })
				expect(chatInputBar).never.toBeNil()
			end)
		end)

		describe("WHEN isChatInputBarVisible is false", function()
			beforeAll(function(c)
				c.isChatInputBarVisible = false
			end)

			it("SHOULD NEVER mount ChatInputBar", function(c)
				local result = c:mount()
				local chatInputBar = c.findFirstInstance(result.instance, { Name = "chatInputBar" })
				expect(chatInputBar).toBeNil()
			end)
		end)

		describe("WHEN given targetChannelDisplayName and backspace is pressed", function()
			beforeAll(function(c)
				c.isChatInputBarVisible = true
				c.targetChannelDisplayName = "[Team]"
			end)

			beforeEach(function(c)
				c.mountResult = c:mount()
				c.chatInputBar = c.findFirstInstance(c.mountResult.instance, { Name = "chatInputBar" })
				c.targetChannelLabel = c.findFirstInstance(c.mountResult.instance, { Name = "TargetChannel" })
				c.textBox = c.findFirstInstance(c.mountResult.instance, { ClassName = "TextBox" })

				expect(c.targetChannelLabel).never.toBeNil()
				expect(c.targetChannelLabel.Text).toEqual("[Team]")

				c.textBoxElement = c.Rhodium.Element.new(c.textBox)
				c.textBoxElement:click()
			end)

			afterEach(function(c)
				c.mountResult.unmount()
			end)

			it("SHOULD delete target channel when message is empty", function(c)
				expect(c.targetChannelLabel).toHaveProperty("Visible", true)
				c.textBoxElement:sendKey(Enum.KeyCode.Backspace)
				wait()
				expect(c.targetChannelLabel).toHaveProperty("Visible", false)
			end)

			it("SHOULD properly handle target channel when message is a single character", function(c)
				-- Type some tex† into the textbox
				c.textBoxElement:sendText("a")
				wait()

				expect(c.textBox).toHaveProperty("Text", "a")
				expect(c.targetChannelLabel).toHaveProperty("Visible", true)

				-- Press backspace once
				c.textBoxElement:sendKey(Enum.KeyCode.Backspace)
				wait()

				expect(c.textBox).toHaveProperty("Text", "")
				expect(c.targetChannelLabel).toHaveProperty("Visible", true)

				-- Press backspace again on an empty message
				c.textBoxElement:sendKey(Enum.KeyCode.Backspace)
				wait()

				expect(c.textBox).toHaveProperty("Text", "")
				expect(c.targetChannelLabel).toHaveProperty("Visible", false)
			end)

			it("SHOULD properly handle target channel when message is a long string", function(c)
				-- Type some tex† into the textbox
				c.textBoxElement:sendText("Hello I'm a message")
				wait()

				expect(c.textBox).toHaveProperty("Text", "Hello I'm a message")
				expect(c.targetChannelLabel).toHaveProperty("Visible", true)

				-- Delete the entire message
				for _ = 1, #c.textBox.Text do
					c.textBoxElement:sendKey(Enum.KeyCode.Backspace)
					wait()
					expect(c.targetChannelLabel).toHaveProperty("Visible", true)
				end

				-- Press backspace on the empty message
				c.textBoxElement:sendKey(Enum.KeyCode.Backspace)
				wait()

				expect(c.textBox).toHaveProperty("Text", "")
				expect(c.targetChannelLabel).toHaveProperty("Visible", false)
			end)
		end)
	end)
end
