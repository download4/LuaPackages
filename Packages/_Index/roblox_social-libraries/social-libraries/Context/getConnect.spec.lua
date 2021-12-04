return function()
	local SocialLibraries = script:FindFirstAncestor("social-libraries")
	local dependencies = require(SocialLibraries.dependencies)
	local Roact = dependencies.Roact

	local getConnect = require(script.Parent.getConnect)

	beforeAll(function(context)
		expect.extend(context.Mock.Matchers)
	end)

	it("SHOULD allow mapper to inject prop into lower component", function(c)
		local context = Roact.createContext("contextObject")

		local capturedContext = nil
		local capturedProps = nil

		local component = function(props)
			capturedContext = props.contextText
			capturedProps = props.propsText
			return nil
		end

		local connect = getConnect(context)
		local connectedComponent = connect(function(value)
			return { contextText = value }
		end)(component)

		local tree = Roact.createElement(connectedComponent, {
			propsText = "propsObject"
		})
		Roact.mount(tree)

		expect(capturedContext).to.equal("contextObject")
		expect(capturedProps).to.equal("propsObject")
	end)
end
