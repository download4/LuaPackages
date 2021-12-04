return function()
	local SocialLibraries = script:FindFirstAncestor("social-libraries")
	local dependencies = require(SocialLibraries.dependencies)
	local Roact = dependencies.Roact

	local getWith = require(script.Parent.getWith)

	beforeAll(function(context)
		expect.extend(context.Mock.Matchers)
	end)

	it("SHOULD allow function to pass renderFunc with a single argument", function(c)
		local context = Roact.createContext("contextObject")

		local capturedContext = nil

		local component = function(props)
			capturedContext = props.contextValue
			return nil
		end

		local with = getWith(context)
		local connectedComponent = function()
			return with(function(value)
				return Roact.createElement(component, {
					contextValue = value,
				})
			end)
		end

		local tree = Roact.createElement(connectedComponent)
		Roact.mount(tree)

		expect(capturedContext).to.equal("contextObject")
	end)
end
