-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("facs")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS DE INÍCIO
-----------------------------------------------------------------------------------------------------------------------------------------

local Coordenadas = {
	-- GUETOS
	{ 224.55,-1760.99,25.24 }, -- Families
	{ 112.49,-1995.69,14.88 }, -- Ballas
	{ 421.27,-2048.39,18.74 }, -- Vagos

	-- FAVELAS
	{ 1397.58,-183.36,161.51 }, -- Favela1
	{ 2248.67,67.39,248.47 }, -- Favela3
	{ 2994.66,3036.49,105.73 }, -- Favela4
	{ 1697.23,387.87,245.48 }, -- Favela2

	-- ARMAS
	{ 1400.02,1139.74,114.33 }, -- Weapons
	{ 986.93,-93.0,74.85 }, -- Weapons2

}

-----------------------------------------------------------------------------------------------------------------------------------------
-- INÍCIO | FIM
-----------------------------------------------------------------------------------------------------------------------------------------

local inicio = 0
local fim = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 435.53, ['y'] = 214.84, ['z'] = 103.17 },--- 435.53,214.84,103.17,
	[2] = { ['x'] = -830.38, ['y'] = 115.05, ['z'] = 56.04 }, -- -830.38,115.05,56.04,271.52
	[3] = { ['x'] = -1143.33, ['y'] = -325.79, ['z'] = 37.83 }, -- -1143.33,-325.79,37.83,82 
	[4] = { ['x'] = -1083.22, ['y'] = -1262.13, ['z'] = 5.6 }, --  -1083.22,-1262.13,5.6,
	[5] = { ['x'] = -169.11, ['y'] = -1352.35, ['z'] = 29.99 }, --  -169.11,-1352.35,29.99
	[6] = { ['x'] = 250.1, ['y'] = -1730.76, ['z'] = 29.67 }, ---  250.1,-1730.76,29.67
	[7] = { ['x'] = 801.14, ['y'] = -2117.16, ['z'] = 29.35 }, --  801.14,-2117.16,29.35
	[8] = { ['x'] = 1384.32, ['y'] = -2079.7, ['z'] = 52.22 }, -- 1384.32,-2079.7,52.22
	[9] = { ['x'] = 1336.78, ['y'] = -1578.82, ['z'] = 54.45 }, -- 1336.78,-1578.82,54.45,
	[10] = { ['x'] = 1924.41, ['y'] = -973.1, ['z'] = 78.64 }, --  1924.54,-973.1,78.64
	[11] = { ['x'] = 2558.87, ['y'] = 288.76, ['z'] = 108.61 }, -- 2558.87,288.76,108.61,
	[12] = { ['x'] = 2137.1, ['y'] = 1936.29, ['z'] = 93.78 }, -- 2137.1,1936.29,93.78,
	[13] = { ['x'] = 2314.04, ['y'] = 2549.84, ['z'] = 47.71 }, --- 2314.04,2549.84,47.71,40.97
	[14] = { ['x'] = 2569.25, ['y'] = 2720.35, ['z'] = 42.97 }, -- - 2569.25,2720.35,42.97,31.18
	[15] = { ['x'] = 2662.58, ['y'] = 3265.46, ['z'] = 55.25 }, -- 2662.58,3265.46,55.25,341.25
	[16] = { ['x'] = 2675.52, ['y'] = 3499.34, ['z'] = 53.31 }, -- 2675.52,3499.34,53.31,164.99
	[17] = { ['x'] = 2713.03, ['y'] = 4324.38, ['z'] = 45.86 }, --- 2713.03,4324.38,45.86,40.07
	[18] = { ['x'] = 2335.22, ['y'] = 4859.9, ['z'] = 41.81 },-- 2335.22,4859.9,41.81,50.08
	[19] = { ['x'] = 1723.31, ['y'] = 6417.81, ['z'] = 35.01 }, -- 1723.31,6417.81,35.01,247.57
	[20] = { ['x'] = 1417.08, ['y'] = 6339.26, ['z'] = 24.4 },-- 1417.08,6339.26,24.4,197.06
	[21] = { ['x'] = 136.52, ['y'] = 6643.27, ['z'] = 31.81 },--  136.52,6643.27,31.81,45.75
	[22] = { ['x'] = -270.04, ['y'] = 6283.81, ['z'] = 31.5 },-- -270.04,6283.81,31.5,45.45
	[23] = { ['x'] = -768.86, ['y'] = 5597.09, ['z'] = 33.61 },-- -768.86,5597.09,33.61,356.29
	[24] = { ['x'] = -2193.35, ['y'] = 4289.89, ['z'] = 49.18 },-- -2193.35,4289.89,49.18,240.18
	[25] = { ['x'] = -2304.64, ['y'] = 3427.34, ['z'] = 31.06 },-- -2304.64,3427.34,31.06,228.16
	[26] = { ['x'] = -2544.25, ['y'] = 2316.02, ['z'] = 33.22 }, 
	[27] = { ['x'] = -1502.3, ['y'] = 1527.56, ['z'] = 115.25 },-- -1502.3,1527.56,115.25,165.72
	[28] = { ['x'] = -1829.25, ['y'] = 800.97, ['z'] = 138.52 },-- -1829.25,800.97,138.52,230.92
	[29] = { ['x'] = -1737.46, ['y'] = 219.09, ['z'] = 64.45 },-- -1737.46,219.09,64.45,305.43
	[30] = { ['x'] = -1561.62, ['y'] = -210.61, ['z'] = 55.54 },-- -1561.62,-210.61,55.54,181.87 
	[31] = { ['x'] = -1146.5, ['y'] = 545.89, ['z'] = 101.91 },-- -1146.5,545.89,101.91,187.09
	[32] = { ['x'] = -620.37, ['y'] = -283.46, ['z'] = 39.42 },-- -620.37,-283.46,39.42,119.12
	[33] = { ['x'] = -383.78, ['y'] = 152.68, ['z'] = 65.54 },-- -383.78,152.68,65.54,274.97

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL DE INÍCIO DA ROTA
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local RusherOtimizar = 1000
		if not servico then
			for _,mark in pairs(Coordenadas) do
				local x,y,z = table.unpack(mark)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
				if distance <= 30.0 then
					RusherOtimizar = 5
					DrawMarker(21,x,y,z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
					if distance <= 1.2 then
						RusherOtimizar = 1
						drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR COLETA",4,0.5,0.93,0.50,255,255,255,180)	
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),224.55,-1760.99,25.24,true) <= 1.2 then -- Families
								servico = true	
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),112.49,-1995.69,14.88,true) <= 1.2 then -- Ballas
								servico = true						
								inicio = 1
								fim = 33						
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000) 
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),421.27,-2048.39,18.74,true) <= 1.2 then -- Vagos
								servico = true						
								inicio = 1
								fim = 33						
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000) 
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1397.58,-183.36,161.51,true) <= 1.2 then -- Favela1
								servico = true						
								inicio = 1
								fim = 33						
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)  
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2248.67,67.39,248.47,true) <= 1.2 then -- Favela3
								servico = true							
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2994.66,3036.49,105.73,true) <= 1.2 then -- Favela4
								servico = true							
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1697.23,387.87,245.48,true) <= 1.2 then -- Favela2
								servico = true							
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)		
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1400.02,1139.74,114.33,true) <= 1.2 then -- Weapons
								servico = true							
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)				
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),986.93,-93.0,74.85,true) <= 1.2 then -- Weapons
								servico = true							
								inicio = 1
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","verde","Você iniciou o serviço.",5000)	
							end
						end
					end
				end
			end
		end
		Citizen.Wait(RusherOtimizar)
	end
end)

-- COLETA DE COMPONENTES

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
            
            
            if distance <= 100.0 then
                timeDistance = 5
                DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
                if distance <= 1.6 then
                    timeDistance = 4
                    drawTxt("PRESSIONE ~p~E~w~  PARA COLETAR",4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                        if emP.checkPayment() then
                            TriggerEvent('progress',1000,'PEGANDO')
							TriggerEvent('cancelando',true)
							vRP._playAnim(false,{{"pickup_object","pickup_low"}},true)
							Citizen.Wait(1000)
							vRP._stopAnim(false)
							TriggerEvent('cancelando',false)
							RemoveBlip(blips)
							selecionado = selecionado + 1
							if selecionado > fim then
								selecionado = inicio
							end
                            CriandoBlip(locs,selecionado)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)

-- CANCELAR

Citizen.CreateThread(function()
	while true do
		local nome = 1000
		if servico then
			nome = 5
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","amarelo","Você largou o serviço.",5000)
			end
		end
		Citizen.Wait(nome)
	end
end)

-- FUNÇÕES

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,12)
	SetBlipColour(blips,2)
	SetBlipScale(blips,0.9)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componentes")
	EndTextCommandSetBlipName(blips)
end


