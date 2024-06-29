local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "fivemreact")

print('Script cliente carregado')

function getUserData(user_id)
    local source = source
	local user_id = vRP.getUserId(source)
    print('Função getUserData chamada com user_id:', user_id)
    local allChars = vRP.query("characters/allChars")
    print('allChars:')
    print(allChars)
    local characterResult = vRP.query("characters/getUsers", { id = 1 })
    local bankResult = vRP.query("bank/getInfos", { user_id = user_id, mode = "Private" }) 

    print('Resultados da consulta:')
    print('characterResult:')
    print(characterResult)
    print('bankResult:')
    print(bankResult)

    if #characterResult > 0 and #bankResult > 0 then
        local characterData = characterResult[1]
        local bankData = bankResult[1]
        
        local combinedData = {
            name = characterData.name,
            phone = characterData.phone,
            serial = characterData.serial,
            locate = characterData.locate,
            bank = bankData.value -- Supondo que 'value' contém o saldo bancário
        }
        return combinedData
    else
        return nil
    end
end

local function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('show-nui', function()
    local source = source
    local user_id = 1
    local data = getUserData(user_id)
    
    if user_id then
        local data = getUserData(user_id)
        if data then
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = 'ui',
                display = true,
                data = data
            })
        else
            print("Dados do jogador não encontrados.")
        end
    else
        print("Usuário não encontrado.")
    end
end, false)

RegisterNUICallback('hideFrame', function(_, cb)
    toggleNuiFrame(false)
    debugPrint('Hide NUI frame')
    cb({})
end)
