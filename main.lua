printc("`2Multibot & executor by `#BotHax YT") -- print text like gt, but some color doesnt work
-- SetLogin("name", "pass") -- if you want login using growID


function RandomEmail()
RET = "RANDEMAIL.N" .. math.random(1000, 10000) .. ".N" .. math.random(1000, 10000)
RET = RET .. "@gmail"
RET = RET .. ".com"
return RET
end

function AppendSTR(path, str)
content = ""

file = io.open(path,"r") -- Read
if file then
content = file:read("*a") -- Store
file:close()
end

f = io.open(path, "w")
f:write(content .. str .. "\n") -- Write
f:close()
end

-- edit this
ACC = {
	name = "testcreater",
	startnum = 40,
	endnum = 90,
	pass = "bothaxyt000!!!",
	email = RandomEmail()
}



dialogManager = function(content)
if content:find("add_label_with_icon|big|`wGet a GrowID``|left|206|") then

if ACC.startnum > ACC.startnum then
print("huh?? you should exit manually")
Disconnect(true)
return
end

SendPacket(2, string.format([[
action|dialog_return
dialog_name|growid_apply
logon|%s%d
password|%s
password_verify|%s
email|%s
]], ACC.name, ACC.startnum, ACC.pass, ACC.pass, ACC.email))
printc("`2Creating acc for `c" .. ACC.name .. ACC.startnum)
ACC.startnum = ACC.startnum + 1
ACC.email = RandomEmail()
elseif content:find("add_label_with_icon|big|`wGrowID GET!``|left|206|") then
content = content:sub(content:find("log on of `w") + 12, string.len(content))
content = content:sub(1, content:find("`` created.") - 1)
printc("`2Account created: `c" .. content)
AppendSTR("acc.txt", string.format([[
Id: %s
Pass: %s
]], content, ACC.pass))
if (ACC.startnum > ACC.endnum) then
print("DONE")
os.exit()
else
Reconnect()
end
else
print("Something went wrong.")
end
end

hookVar = function(var)
if var[0] == 'OnDialogRequest' then
dialogManager(var[1])
elseif var[0] == 'OnConsoleMessage' then
-- printc(var[1])
elseif var[0]:find("Compass") then
SendPacket(2, "action|growid")
end
end

hookMsg = function(msg)
printc(msg)
if msg:find("Too many accounts created from this IP address.") then
printc("`4IP limited!")
os.exit()
end
end

AddHook('onvariant', hookVar)
AddHook('gameMessage', hookMsg)

