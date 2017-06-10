--Author by chaoL

module("luci.controller.NetKeeper", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/netkeeper") then
		return
	end

	local page

	page = entry({"admin", "network", "NetKeeper"}, cbi("netkeeper"), _("NetKeeper Tool"))
	page.dependent = true
end