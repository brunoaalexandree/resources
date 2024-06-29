-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
emP = {}
Tunnel.bindInterface("facs",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Vagos") or vRP.hasPermission(user_id,"Ballas") or vRP.hasPermission(user_id,"Families") or vRP.hasPermission(user_id,"Weapons") or vRP.hasPermission(user_id,"Favela4") or vRP.hasPermission(user_id,"Favela1") or vRP.hasPermission(user_id,"Favela2") or vRP.hasPermission(user_id,"Favela3") or vRP.hasPermission(user_id,"Weapons2") or vRP.hasPermission(user_id,"Ammos") or vRP.hasPermission(user_id,"Ammos2") then 
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem acesso.", 5000)
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

-----------------------------------------------------------------------------------------------------------------------------------------
-- Weapons Arma
-----------------------------------------------------------------------------------------------------------------------------------------
if vRP.hasPermission(user_id,"Weapons") then
	local itens = math.random(100)
	local quantidade = math.random(1,2)
	if itens <= 100 then
			quantidade = math.random(1,2)
			quantidade2 = math.random(1,2)
			quantidade3 = math.random(1,2)
			quantidade4 = math.random(1,2)
			quantidade5 = math.random(1,2)
			vRP.giveInventoryItem( user_id,"rubber",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			vRP.giveInventoryItem( user_id,"plastic",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Borrachas",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Garrafa de vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade4.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade5.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Weapons2 Arma
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Weapons2") then
	local itens = math.random(100)
	local quantidade = math.random(1,2)
	if itens <= 100 then
			quantidade = math.random(1,2)
			quantidade2 = math.random(1,2)
			quantidade3 = math.random(1,2)
			quantidade4 = math.random(1,2)
			quantidade5 = math.random(1,2)
			vRP.giveInventoryItem( user_id,"rubber",quantidade)
			vRP.giveInventoryItem( user_id,"glass",quantidade2)
			vRP.giveInventoryItem( user_id,"plastic",quantidade3)
			vRP.giveInventoryItem( user_id,"copper",quantidade4)
			vRP.giveInventoryItem( user_id,"aluminum",quantidade5)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Borrachas",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Garrafa de vidro",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade3.."x Plastico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade4.."x Cobre",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade5.."x Aluminio",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VAGOS
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Vagos") then
	local itens = math.random(100)
	local quantidade = math.random(1,2)
	if itens <= 100 then
			quantidade = math.random(1,2)
			quantidade2 = math.random(1,2)
			vRP.giveInventoryItem( user_id,"saline",quantidade)
			vRP.giveInventoryItem( user_id,"acetone",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Soro Fisiológico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Acetona",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Ballas
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Ballas") then
	local itens = math.random(100)
	local quantidade = math.random(1,2)
	if itens <= 100 then
			quantidade = math.random(1,2)
			quantidade2 = math.random(1,2)
			vRP.giveInventoryItem( user_id,"sulfuric",quantidade)
			vRP.giveInventoryItem( user_id,"cokeleaf",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Ácido Sulfurico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folha de Coca",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Families
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Families") then
    local itens = math.random(100)
	local quantidade = math.random(1,2)
	if itens <= 100 then
			quantidade = math.random(1,2)
			quantidade2 = math.random(1,2)
			vRP.giveInventoryItem( user_id,"silk",quantidade)
			vRP.giveInventoryItem( user_id,"weedleaf",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Seda",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folha de Maconha",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Favela4 - Lean
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Favela4") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"codeine",quantidade)
			vRP.giveInventoryItem( user_id,"emptybottle",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Seda",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folha de Maconha",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Favela1 - Meta
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Favela1") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"saline",quantidade)
			vRP.giveInventoryItem( user_id,"acetone",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Soro Fisiológico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Acetona",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Favela2 - Coca 
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Favela2") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"sulfuric",quantidade)
			vRP.giveInventoryItem( user_id,"cokeleaf",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Ácido Sulfurico",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folha de Coca",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Barragem P3 - Maconha
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Favela3") then
	local itens = math.random(100)
	local quantidade = math.random(1,3)
	if itens <= 100 then
			quantidade = math.random(1,3)
			quantidade2 = math.random(1,3)
			vRP.giveInventoryItem( user_id,"silk",quantidade)
			vRP.giveInventoryItem( user_id,"weedleaf",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Seda.",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Folhas de Maconha.",5000)
	else
		TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRAIA (X)
-----------------------------------------------------------------------------------------------------------------------------------------
elseif vRP.hasPermission(user_id,"Vermelhos") then
	local itens = math.random(100)
	local quantidade = math.random(2,5)
	if itens <= 100 then
			quantidade = math.random(2,5)
			quantidade2 = math.random(2,5)
			vRP.giveInventoryItem( user_id,"weedleaf",quantidade)
			vRP.giveInventoryItem( user_id,"silk",quantidade2)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade.."x Folha de Maconha",5000)
			TriggerClientEvent("Notify",source,"verde","Você coletou <b>"..quantidade2.."x Sedas",5000)
		else
			TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
		end	
	end
	return true
end
end