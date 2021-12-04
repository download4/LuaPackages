return function()
	local Events = require(script.Parent.Parent.Events)

	describe("Events token tests", function()
		it("should return same object for each token for multiple calls", function()
			expect(Events.WillFocus).to.equal(Events.WillFocus)
			expect(Events.DidFocus).to.equal(Events.DidFocus)
			expect(Events.WillBlur).to.equal(Events.WillBlur)
			expect(Events.DidBlur).to.equal(Events.DidBlur)
			expect(Events.Action).to.equal(Events.Action)
			expect(Events.Refocus).to.equal(Events.Refocus)
		end)

		it("should return matching string names for symbols", function()
			expect(tostring(Events.WillFocus)).to.equal("WILL_FOCUS")
			expect(tostring(Events.DidFocus)).to.equal("DID_FOCUS")
			expect(tostring(Events.WillBlur)).to.equal("WILL_BLUR")
			expect(tostring(Events.DidBlur)).to.equal("DID_BLUR")
			expect(tostring(Events.Action)).to.equal("ACTION")
			expect(tostring(Events.Refocus)).to.equal("REFOCUS")
		end)
	end)
end
