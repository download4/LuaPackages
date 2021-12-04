local Packages = script.Parent.Parent
local UserInputService = game:GetService("UserInputService")
local UIBlox = require(Packages.UIBlox)

return {
	Roact = require(Packages.Roact),
	-- TODO add ability to pass in UIBlox config on setup (currently assumes UIBlox is initialized by consuming project)
	UIBlox = UIBlox,
	RoactFitComponents = require(Packages.RoactFitComponents),
	GenericPagination = require(Packages.GenericPagination),
	Cryo = require(Packages.Cryo),
	RoactNavigation = require(Packages.RoactNavigation),
	Rodux = require(Packages.Rodux),
	Lumberyak = require(Packages.Lumberyak),
	tutils = require(Packages.tutils),
	t = require(Packages.t),
	Promise = require(Packages.Promise),
	Symbol = require(Packages.Symbol),
	Otter = require(Packages.Otter),
	llama = require(Packages.llama),

	-- TODO remove this when keyboard covering screen is automatically tracked on android
	UserInputService = UserInputService,

	-- TODO find ways to remove
	Text = require(script.Parent.temp.Text),
	UserModel = require(script.Parent.temp.User),
}
