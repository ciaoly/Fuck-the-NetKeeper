require("luci.sys")
require("uci")

local conf  = require "luci.config"
local ntm = require "luci.model.network".init()
local x, m, s, pass, ifname

x = uci.cursor()
m = Map("netkeeper", translate("NetKeeper"), translate("Here you can configurate the pppoe client for NetKeeper Tool, before using the tool, you should choose a valid interface with PPPoE protocol and config the password of the interface. Then pressing the save&commit and dialing up with the computer. "))
s = m:section(TypedSection, "setting", translate("NetKeeper module config"))
s.addremove = false
s.anonymous = true
ifname = s:option(ListValue, "interface", translate("Interfaces"))
pass = s:option(Value, "password", translate("Password"))
pass.password = true
x:foreach("network", "interface", function(s)
	local interface = s[".name"]
	if(x:get("network", interface, "proto") == 'pppoe') then 
		ifname:value(interface)
	end
end)

--for k, v in ipairs(luci.sys.net.devices()) do
--	if v ~= "lo" then
--		ifname:value(v)
--	end
--end

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/nk4 restart")
end

return m