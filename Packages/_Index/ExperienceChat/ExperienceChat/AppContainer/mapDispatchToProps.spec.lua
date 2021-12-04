local CoreGui = game:GetService("CoreGui")
local ExperienceChat = CoreGui:FindFirstChild("ExperienceChat", true)
local globals = require(ExperienceChat.Dev.Jest).Globals
local expect = globals.expect

return function()
	beforeAll(function(c)
		c.mapDispatchToProps = require(script.Parent.mapDispatchToProps)
	end)

	it("SHOULD return a function", function(c)
		expect(type(c.mapDispatchToProps)).toEqual("function")
	end)

	describe("WHEN called", function()
		beforeAll(function(c)
			c.returnValue = c.mapDispatchToProps(function() end)
		end)

		it("SHOULD return a table", function(c)
			expect(type(c.returnValue)).toEqual("table")
		end)

		it("SHOULD have the expected fields", function(c)
			expect(c.returnValue.chatTopBarButtonActivated).never.toBeNil()
			expect(c.returnValue.textChatServiceChatWindowPropertyChanged).never.toBeNil()
		end)
	end)
end
