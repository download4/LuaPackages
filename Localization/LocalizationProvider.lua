local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Roact)
local LocalizationKey = require(CorePackages.Localization.LocalizationKey)
local LocalizationRoactContext = require(CorePackages.Localization.LocalizationRoactContext)

local GetFFlagLuaAppFixLocalizationContext = require(script.Parent.GetFFlagLuaAppFixLocalizationContext)

if GetFFlagLuaAppFixLocalizationContext() then
	local function LocalizationProvider(props)
		return Roact.createElement(LocalizationRoactContext.Provider, {
			value = props.localization
		}, props[Roact.Children])
	end

	return LocalizationProvider
end

local LocalizationProvider = Roact.Component:extend("LocalizationProvider")

function LocalizationProvider:init(props)
	local localization = props.localization
	self._context[LocalizationKey] = {
		localization = localization
	}
end

function LocalizationProvider:render()
	return Roact.oneChild(self.props[Roact.Children])
end

return LocalizationProvider
