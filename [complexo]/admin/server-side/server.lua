-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("admin",cRP)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")

local webaddcar = "https://discord.com/api/webhooks/1043982090624057435/8CWdmisK0LfNlcyuMWOv6tA3ixNFRPQPv36mJ8BIiBiXLbbhko9Vw1Xc6WsJguABuXz6"
local webgroup = "https://discord.com/api/webhooks/1043982090624057435/8CWdmisK0LfNlcyuMWOv6tA3ixNFRPQPv36mJ8BIiBiXLbbhko9Vw1Xc6WsJguABuXz6"
local webhookgive = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterNetEvent("hup:phoneObject")
AddEventHandler("hup:phoneObject",function ()
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport) 
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)
	
	local Service = vRP.NumPermission("Police")
	for Passport,Sources in pairs(Service) do
		
		if vRP.HasService(Sources,"Police") then
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = "31", name = Identity["name"].." "..Identity["name2"].."  "..vRP.Identity(Passport).phone,phone = vRP.Identity(Passport).phone, title = "SOS TELEFONES", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "EMERGENCIA", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
			end)
		end
	end
end)

RegisterCommand("ugroups",function(source,Message)
	local user_id = vRP.getUserId(source)
	if user_id then
		local OtherUser_id = tostring(user_id)
		local Messages = ""
		
		if Message[1] and vRP.hasGroup(user_id,"Admin") then
			OtherUser_id = Message[1]
			Messages = "<b>Passaporte:</b> "..Message[1].."<br>"
			
			if parseInt(OtherUser_id) <= 0 then
				return
			end
		end
		
		local Groups = vRP.Groups()
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherUser_id] then
				Messages = Messages..Permission.."<br>"
			end
		end
		
		if Messages ~= "" then
			TriggerClientEvent("Notify",source,"verde",Messages,10000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local ID = parseInt(args[1])
			local Amount = parseInt(args[2])
			local identity = vRP.userIdentity(ID)
			if identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.execute("accounts/infosUpdategems",{ steam = identity["steam"], gems = Amount })
				TriggerEvent("discordLogs","Gemstones","**Passaporte:** "..ID.."\n**Recebeu:** "..Amount.." Gemas\n**Horário:** "..os.date("%H:%M:%S"),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vRPC.blipsAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] then
				local nuser_id = parseInt(args[1])
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vRP.upgradeThirst(nuser_id,100)
					vRP.upgradeHunger(nuser_id,100)
					vRP.downgradeStress(nuser_id,100)
					vRPC.revivePlayer(otherPlayer,200)
				end
			else
				vRP.setArmour(source,100)
				vRPC.revivePlayer(source,200)
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.removeObjects(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] and args[2] and itemBody(args[1]) ~= nil then
				vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] and args[2] and args[3] and itemBody(args[1]) ~= nil then
				vRP.generateItem(args[3],args[1],parseInt(args[2]),true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("priority",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id and parseInt(args[1]) > 0 then
		if vRP.hasGroup(user_id,"Admin") then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"verde","Prioridade adicionada.",5000)
				vRP.execute("accounts/setPriority",{ steam = identity["steam"], priority = 99 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasGroup(user_id,"Moderator") then
			local nuser_id = parseInt(args[1])
			vRP.execute("characters/removeCharacters",{ id = nuser_id })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..nuser_id.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vRPC.noClip(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = false
RegisterCommand("spectate",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if Spectate then
				Spectate = false
				TriggerClientEvent("admin:resetSpectate",source)
				TriggerClientEvent("Notify",source,"amarelo","Desativado.",5000)
			else
				Spectate = true
				TriggerClientEvent("admin:initSpectate",source)
				TriggerClientEvent("Notify",source,"verde","Ativado.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
			vRP.kick(args[1],"Expulso da cidade.")
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

RegisterCommand("pd",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			vRP.kick(parseInt(args[1]),"A historia do seu personagem chegou ao fim...")
				TriggerClientEvent("Notify",source,"amarelo","PD aplicado com sucesso ID: "..args[1] ,5000)
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[TOMOU PD]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local time = parseInt(args[2])
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.kick(nuser_id,"Banido.")
				vRP.execute("banneds/insertBanned",{ steam = identity["steam"], time = time })
				vRP.execute("accounts/setwl",{ steam = tostring(args[1]), whitelist = 0 })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> banido por <b>"..time.." dias.",5000)
				SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.execute("banneds/removeBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..nuser_id.."</b> desbanido.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Moderator") then
			local Keyboard = vKEYBOARD.keySingle(source,"Cordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
		end
       	end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local Ped = GetPlayerPed(source)
			local coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.keyCopy(source,"Cordenadas:",mathLegth(coords["x"])..","..mathLegth(coords["y"])..","..mathLegth(coords["z"])..","..mathLegth(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or user_id == 1 and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[SETOU]: "..args[1].."g"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			vRP.setPermission(args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.remPermission(args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				vRP.teleport(otherPlayer,coords["x"],coords["y"],coords["z"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(otherPlayer)
				local coords = GetEntityCoords(ped)
				vRP.teleport(source,coords["x"],coords["y"],coords["z"])
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vCLIENT.teleportWay(source)
			SendWebhookMessage(webhookostpway, "```prolog\n[TPWAY]\n[ID:] "..user_id.."\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				print(vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("admin:vehicleTuning",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if vehicle then
				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("inventory:repairAdmin",v,vehNet,vehPlate)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			local Players = vRPC.Players(source)
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("syncarea",v,coords["x"],coords["y"],coords["z"],100)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.updateTxt(user_id..".txt",mathLegth(coords.x)..","..mathLegth(coords.y)..","..mathLegth(coords.z)..","..mathLegth(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and args[1] then
			TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source == 0 then
		local playerList = vRP.userList()
		for k,v in pairs(playerList) do
			vRP.kick(k,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end

		TriggerEvent("admin:KickAll")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local playerList = vRP.userList()
			for k,v in pairs(playerList) do
				async(function()
					vRP.generateItem(k,tostring(args[1]),parseInt(args[2]),true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local checkPoints = 0
function cRP.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		checkPoints = checkPoints + 1

		vRP.updateTxt("races.txt","["..checkPoints.."] = {")

		vRP.updateTxt("races.txt","{ "..mathLegth(vehCoords["x"])..","..mathLegth(vehCoords["y"])..","..mathLegth(vehCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(leftCoords["x"])..","..mathLegth(leftCoords["y"])..","..mathLegth(leftCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(rightCoords["x"])..","..mathLegth(rightCoords["y"])..","..mathLegth(rightCoords["z"]).." }")

		vRP.updateTxt("races.txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spectate",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if Spectate[user_id] then
				TriggerClientEvent("Notify",source,"verde","Desativado.",5000)

				local Ped = GetPlayerPed(Spectate[user_id])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[user_id] = nil
			else
				TriggerClientEvent("Notify",source,"verde","Ativado.",5000)

				local nsource = vRP.userSource(args[1])
				if nsource then
					local Ped = GetPlayerPed(nsource)
					if DoesEntityExist(Ped) then
						SetEntityDistanceCullingRadius(Ped,999999999.0)
						Wait(1000)
						TriggerClientEvent("admin:initSpectate",source,nsource)
						Spectate[user_id] = nsource
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if Spectate[user_id] then
		Spectate[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUGESTÃO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sugestao",function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		local Keyboard = vKEYBOARD.keyArea(source,"Sugestão:")
		if Keyboard then
			TriggerClientEvent("Notify",source,"verde","Sugestão enviada.",5000)
			TriggerEvent("discordLogs","Sugestões","**Passaporte:** "..parseFormat(user_id).."\n**Sugestão:** "..Keyboard[1],3092790)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBACK - 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addback",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and args[1] then
        if vRP.hasGroup(user_id,"Moderator") then
            local nuser_id = parseInt(args[1])
            local amountWeight = parseInt(args[2])
            vRP.setWeight(nuser_id,amountWeight)
            TriggerClientEvent("Notify",source,"verde","Mochila adicionado para <b>"..nuser_id.."</b> em "..amountWeight.."KG.",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMBACK - 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remback",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and args[1] then
        if vRP.hasGroup(user_id,"Moderator") then
            local nuser_id = parseInt(args[1])
            local amountWeight = parseInt(args[2])
            vRP.remWeight(nuser_id,amountWeight)
            TriggerClientEvent("Notify",source,"verde","Mochila removida de <b>"..nuser_id.."</b> em "..amountWeight.."KG.",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
			vRP.execute("vehicles/addVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(false) })
		--	vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"verde","Recebido o veículo <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"verde","Adicionado o veiculo <b>"..args[2].."</b> na garagem de ID <b>"..args[1].."</b>.",10000)
			SendWebhookMessage(webaddcar,"```prolog\n[ID]: "..user_id.." \n[Para Id:]: "..args[1].."\n[Carro:]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
			local nuser_id = parseInt(args[1])
			vRP.execute("vehicles/removeVehicles",{ user_id = parseInt(args[1]), vehicle = args[2]})
		--	vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",nuser_id,"verde","Removido o veículo <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"verde","Removido o veiculo <b>"..args[2].."</b> na garagem de ID <b>"..args[1].."</b>.",10000)
			SendWebhookMessage(webaddcar,"```prolog\n[ID]: "..user_id.." \n[Para Id:]: "..args[1].."\n[Carro Removido:]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderator") then
			vRP.execute("accounts/setwl",{ steam = tostring(args[1]), whitelist = 1 })
			TriggerClientEvent("Notify",source,"verde","Você aprovou a Hex "..args[1]..".",5000)
			SendWebhookMessage(webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PON/IDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pon",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		local users = vRP.getPlayesOn()

		local players = ""
		local quantidade = 0
		for k,v in pairs(users) do
			if k ~= #users then
				players = players..", "
			end
			players = players..k
			quantidade = quantidade + 1
		end
		TriggerClientEvent("chatMessage",source,"Total onlines",{1, 136, 0},quantidade)
		TriggerClientEvent("chatMessage",source,"IDs onlines",{1, 136, 0},players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISOMED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisomed",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Admin") then
            local message = vKEYBOARD.keyArea(source,"Mensagem:","")
            if message == "" then
                return
            end
			
            TriggerClientEvent("Notify",-1,"blood",message,15000,"<br><b>Mensagem enviada pela Prefeitura</b>")
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISOMEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mec",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Mechanic") or vRP.hasPermission(user_id,"Admin") then
            local message = vKEYBOARD.keyArea(source,"Mensagem:","")
            if message == "" then
                return
            end
			
            TriggerClientEvent("Notify",-1,"azul",message,15000,"<br><b>Mensagem enviada pela Prefeitura</b>")
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PREFEITURA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciar",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
            local message = vKEYBOARD.keyArea(source,"Mensagem:","")
            if message == "" then
                return
            end
			
            TriggerClientEvent("Notify",-1,"vermelho",message,15000,"<br><b>Mensagem enviada por: Gorvenador</b>")
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avisopm",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Admin") then
            local message = vKEYBOARD.keyArea(source,"Mensagem:","")
            if message == "" then
                return
            end
            
            TriggerClientEvent("Notify",-1,"azul",message,15000)
            TriggerClientEvent("sounds:source",-1,"notification",0.5)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local messagetype = vKEYBOARD.keyArea(source,"Tipo da mensagem: (default, azul, amarelo, verde, vermelho)","")
			if messagetype == "" then
				return
			end
			
			
			local message = vKEYBOARD.keyArea(source,"Mensagem:","")
			if message == "" then
				return
			end
			
			
			local timer = vKEYBOARD.keyArea(source,"Duração da mensagem:","")
			if timer == "" then
				return
			end
			
			TriggerClientEvent("Notify",-1,messagetype,message,timer)
			TriggerClientEvent("sounds:source",-1,"notification",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("admindebug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local user_id = vRP.user_id(source)
		if not vRP.hasGroup(user_id,"Admin") then
			return
		end
	end

	TriggerEvent("admin:KickAll")
end)
