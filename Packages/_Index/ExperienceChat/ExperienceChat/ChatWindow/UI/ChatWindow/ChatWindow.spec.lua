local CoreGui = game:GetService("CoreGui")
local ExperienceChat = CoreGui:FindFirstChild("ExperienceChat", true)
local globals = require(ExperienceChat.Dev.Jest).Globals
local expect = globals.expect

return function()
	beforeAll(function(rootContext)
		local storyDefinition = require(script.Parent:FindFirstChild("ChatWindow.story"))
		rootContext.mount = rootContext.createMount(storyDefinition.story, function(c)
			return {
				messageHistory = c.messageHistory,
			}
		end)
	end)

	describe("GIVEN a short messageHistory", function()
		beforeAll(function(c)
			c.messageHistory = {
				{ PrefixText = "First", Text = "First" },
				{ PrefixText = "Second", Text = "Second" },
				{ PrefixText = "Third", Text = "Third" },
			}
		end)

		it("SHOULD mount the messageHistory in descending order", function(c)
			local instance = c:mount().instance

			local firstMessage = c.findFirstInstance(instance, { Text = "First: First" })
			local secondMessage = c.findFirstInstance(instance, { Text = "Second: Second" })
			local thirdMessage = c.findFirstInstance(instance, { Text = "Third: Third" })
			expect(firstMessage).never.toBeNil()
			expect(secondMessage).never.toBeNil()
			expect(thirdMessage).never.toBeNil()

			expect(firstMessage).toBeAbove(secondMessage)
			expect(secondMessage).toBeAbove(thirdMessage)
		end)
	end)
end
