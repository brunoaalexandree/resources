-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permList = {}
local selfReturn = {}
permList["Taxi"] = {}
permList["Police"] = {}
permList["Emergency"] = {}
permList["Foods"] = {}
permList["Runners"] = {}
permList["Mechanic"] = {}
permList["Paramedic"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {
	["Admin"] = {
		["Admin"] = true
	},
	["Moderator"] = {
		["Admin"] = true,
		["Moderator"] = true
	},
	["masterPolice"] = {
		["masterPolice"] = true
	},
	["Police"] = {
		["Police"] = true,
		["State"] = true,
		["Ranger"] = true,
		["Sheriff"] = true,
		["Corrections"] = true
	},
	["Ranger"] = {
		["Ranger"] = true
	},
	["State"] = {
		["State"] = true
	},
	["Corrections"] = {
		["Corrections"] = true
	},
	["Police"] = {
		["Police"] = true
	},
	["Sheriff"] = {
		["Sheriff"] = true
	},
	["masterParamedic"] = {
		["masterParamedic"] = true
	},
	["Paramedic"] = {
		["Paramedic"] = true
	},
	["Emergency"] = {
		["Police"] = true,
		["State"] = true,
		["Ranger"] = true,
		["Sheriff"] = true,
		["Paramedic"] = true,
		["Corrections"] = true
	},
	["Mechanic"] = {
		["Mechanic"] = true
	},
	["Ballas"] = {
		["Ballas"] = true
	},
	["EastSide"] = {
		["EastSide"] = true
	},
	["Vagos"] = {
		["Vagos"] = true
	},
	["Families"] = {
		["Families"] = true
	},
	["Aztecas"] = {
		["Aztecas"] = true
	},
	["Bloods"] = {
		["Bloods"] = true
	},
	["TheLost"] = {
		["TheLost"] = true
	},
	["Vinhedo"] = {
		["Vinhedo"] = true
	},
	["Vanilla"] = {
		["Vanilla"] = true
	},
	["Triads"] = {
		["Triads"] = true
	},
	["Razors"] = {
		["Razors"] = true
	},
	["Runners"] = {
		["Runners"] = true
	},
	["BurgerShot"] = {
		["BurgerShot"] = true
	},
	["PizzaThis"] = {
		["PizzaThis"] = true
	},
	["Arcade"] = {
		["Arcade"] = true
	},
	["Desserts"] = {
		["Desserts"] = true
	},
	["Playboy"] = {
		["Playboy"] = true
	},
	["Callisto"] = {
		["Callisto"] = true
	},
	["Salieris"] = {
		["Salieris"] = true
	},
	["Uwucafe"] = {
		["Uwucafe"] = true
	},
	["Favela1"] = {
		["Favela1"] = true
	},
	["Favela2"] = {
		["Favela2"] = true
	},
	["Favela3"] = {
		["Favela3"] = true
	},
	["Favela4"] = {
		["Favela4"] = true
	},
	["Foods"] = {
		["Desserts"] = true,
		["BurgerShot"] = true,
		["PizzaThis"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Groups()
    return Groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATAGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(Permission)
    return vRP.GetSrvData("Permissions:" ..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserType(Passport, Type)
    for k, v in pairs(Groups) do
        local Datatable = vRP.GetSrvData("Permissions:" .. k)
        if Groups[k].Type and Groups[k].Type == Type and Datatable[tostring(Passport)] then
            return k
        end
    end
    return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] == nil then
			dataTable["perm"][perm] = true
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] == nil then
				userTables["perm"][perm] = true
			end

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			dataTable["perm"] = {}
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
				vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				dataTable["perm"][perm] = nil
			end
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				if userTables["perm"][perm] then
					userTables["perm"][perm] = nil
					vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id,perm,new)
	local new = tostring(new)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] then
			dataTable["perm"][perm] = nil
		end

		dataTable["perm"][new] = true
	else
		local userTables = vRP.userData(user_id,"Datatable")
		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] then
				userTables["perm"][perm] = nil
			end

			userTables["perm"][new] = true

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	selfReturn[user_id] = false

	if dataTable then
		if dataTable["perm"] then
			for k,v in pairs(dataTable["perm"]) do
				if permissions[perm][k] then
					selfReturn[user_id] = true
					break
				end
			end
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local tableList = {}

	for k,v in pairs(permList[perm]) do
		table.insert(tableList,v)
	end

	return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source,user_id,perm)
	if permList[perm] then
		permList[perm][user_id] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id,perm)
	if permList[perm][user_id] then
		permList[perm][user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSBYPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id,source)
	if permList["Police"][user_id] then
		permList["Police"][user_id] = nil
	end

	if permList["Paramedic"][user_id] then
		permList["Paramedic"][user_id] = nil
	end

	if permList["Taxi"][user_id] then
		permList["Taxi"][user_id] = nil
	end

	if permList["Mechanic"][user_id] then
		permList["Mechanic"][user_id] = nil
	end

	if permList["Runners"][user_id] then
		permList["Runners"][user_id] = nil
	end

	if selfReturn[user_id] then
		selfReturn[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	if vRP.hasPermission(user_id,"Corrections") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Corrections",true)
		TriggerClientEvent("service:Label",source,"Corrections","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Ranger") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Ranger",true)
		TriggerClientEvent("service:Label",source,"Ranger","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"State") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"State",true)
		TriggerClientEvent("service:Label",source,"State","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Police") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Police",true)
		TriggerClientEvent("service:Label",source,"Police","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Sheriff") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Sheriff",true)
		TriggerClientEvent("service:Label",source,"Sheriff-1","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Sheriff-2","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Paramedic") then
		permList["Paramedic"][user_id] = source
		TriggerClientEvent("vRP:ParamedicService",source,true)
		TriggerEvent("blipsystem:Enter",source,"Paramedic",true)
		TriggerClientEvent("service:Label",source,"Paramedic-1","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-2","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-3","Sair de Serviço",5000)
	end

	if vRP.hasGroup(user_id,"Mechanic") then
		permList["Mechanic"][user_id] = source
		TriggerClientEvent("service:Label",source,"Mechanic","Sair de Serviço",5000)
	end

	if vRP.hasGroup(user_id,"Runners") then
		permList["Runners"][user_id] = source
	end

	if vRP.hasGroup(user_id,"Ballas") then
		TriggerClientEvent("player:Relationship",source,"Ballas")
	end

	if vRP.hasGroup(user_id,"Families") then
		TriggerClientEvent("player:Relationship",source,"Families")
	end

	if vRP.hasGroup(user_id,"Vagos") then
		TriggerClientEvent("player:Relationship",source,"Vagos")
	end

	if vRP.hasGroup(user_id,"TheLost") then
		TriggerClientEvent("player:Relationship",source,"TheLost")
	end
end)

function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end