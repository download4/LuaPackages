local Packages = script:FindFirstAncestor("NetworkingProfile").Parent
local buildApiSiteUrl = require(Packages.buildApiSiteUrl)

return buildApiSiteUrl("catalog")
