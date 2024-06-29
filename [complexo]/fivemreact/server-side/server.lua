local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP", "fivemreact")

-- Exemplo de função no servidor
AddEventHandler("vRP:playerJoin", function(user_id, source)
    vRP.userIds[source] = user_id
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    vRP.userIds[source] = nil
end)

function vRP.getUserId(source)
    return vRP.userIds[tonumber(source)]
end
