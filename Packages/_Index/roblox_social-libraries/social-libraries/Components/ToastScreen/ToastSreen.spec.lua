return function()
	local SocialLibraries = script:FindFirstAncestor("social-libraries")
	local dependencies = require(SocialLibraries.dependencies)
	local Roact = dependencies.Roact
	local RoactNavigation = dependencies.RoactNavigation

	local ToastScreen = require(script.Parent)

	beforeAll(function(context)
		expect.extend(context.Mock.Matchers)
	end)

	describe("WHEN mounted as screen of StackNavigator", function()
		it("SHOULD mount and unmount without issue", function(context)
			local TestNavigator = RoactNavigation.createRobloxStackNavigator({
				{
					["TestScreen"] = {
						screen = ToastScreen,
					},
				},
			})

			local navigationAppContainer = RoactNavigation.createAppContainer(TestNavigator)
			local _, cleanup = context.UnitTestHelpers.mountFrame(Roact.createElement(navigationAppContainer))

			cleanup()
		end)
	end)

	describe("WHEN mounted with mock navigation", function()
		it("SHOULD call correct props after duration", function(context)
			local goBackSpy, goBack = context.Mock.Spy.new(function()end)
			local onAppearedSpy, onAppeared = context.Mock.Spy.new(function()end)
			local onDismissedSpy, onDismissed = context.Mock.Spy.new(function()end)

			local _, cleanup = context.UnitTestHelpers.mountFrame(Roact.createElement(ToastScreen, {
				navigation = {
					getParam = function()
						return {
							toastContent = {
								onAppeared = onAppeared,
								onDismissed = onDismissed,
							},
							duration = 1,
						}
					end,
					goBack = goBack,
				}
			}))

			wait(1)
			expect(onAppearedSpy).toHaveBeenCalled(1)

			wait(2)
			expect(goBackSpy).toHaveBeenCalled(1)
			expect(onDismissedSpy).toHaveBeenCalled(1)

			cleanup()
		end)
	end)
end
