--------------------------------------------------------QBCORE--------------------------------------

if Config.Framework == "QBCORE" then

    QBCore = exports["qb-core"]:GetCoreObject()

    local PlayerData = QBCore.Functions.GetPlayerData()
    local hunger = nil
    local thirst = nil
    local ped, health, armor, pid, Player, playerId , playersCount, stamina

    RegisterNetEvent('hud:client:UpdateNeeds')
    AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
        hunger = newHunger
        thirst = newThirst
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
        PlayerData = {}
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
    AddEventHandler("QBCore:Client:OnPlayerLoaded", function ()
        Wait(100)
        SendNUIMessage({ action = 'ShowAllHud' })
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
        Wait(100)
            SendNUIMessage({ action = 'ShowAllHud' })
        end
    end)

    Citizen.CreateThread(function ()
        while true do 
            Wait(500)
            if LocalPlayer.state.isLoggedIn then 

                QBCore.Functions.GetPlayerData(function(PlayerData)
                    ped = PlayerPedId()
                    health = GetEntityHealth(ped)
                    armor = GetPedArmour(ped)
                    Player = QBCore.Functions.GetPlayerData()
                    playerId = PlayerId() 
                    pid = GetPlayerServerId(PlayerId())
                    playersCount = 1
                    stamina = 100 - GetPlayerSprintStaminaRemaining(playerId)
                    
                    SendNUIMessage({
                        action = 'updateStatus',
                        pid = pid,
                        health = health - 100,
                        armor = armor,
                        hunger = hunger,
                        thirst = thirst,
                        stamina = stamina,
                        logo = Config.Logo,
                        pall = playersCount,
                        maxPlayers = Config.MaxPlayers,
                        oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())*10
                    })

                    if IsPedArmed(ped, 7) then
                        local weapon = GetSelectedPedWeapon(ped)
                        local ammoTotal = GetAmmoInPedWeapon(ped,weapon)
                        local bool,ammoClip = GetAmmoInClip(ped,weapon)
                        local ammoRemaining = math.floor(ammoTotal - ammoClip)
                        SendNUIMessage({
                            action = 'updateAmmo',
                            ammo = ammoClip,
                            ammohand = ammoRemaining
                        })
                    else
                        SendNUIMessage({
                            action = 'hideAmmo',
                        })
                    end
                    
                end)
            else
                SendNUIMessage({action = 'hideAllHud'})
            end
            Wait(1000)
        end
    end)

end
--------------------------------------------------------END QBCORE----------------------------------
--------------------------------------------------------ESX-----------------------------------------

if Config.Framework == "ESX" then

    ESX = nil

    local PlayerData = nil
    local playersCount = 1

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(4000)
        end
    end)

    AddEventHandler('playerSpawned', function()
        Wait(100)
        SendNUIMessage({ action = 'ShowAllHud' })
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
        Wait(100)
            SendNUIMessage({ action = 'ShowAllHud' })
        end
    end)

    Citizen.CreateThread(function()
        while true do
        Wait(4000)
            TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
                TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                    food = hunger.getPercent()
                    water = thirst.getPercent()
                end)
            end)
        end
    end)

    Citizen.CreateThread(function() 
    
        ESX.PlayerData = ESX.GetPlayerData()
            while true do
            
                local ped = PlayerPedId()
                local health = GetEntityHealth(ped)
                local armor = GetPedArmour(ped)
                local pid = GetPlayerServerId(PlayerId())
                local player = PlayerId()
                local armor = GetPedArmour(ped)
                local stamina = 100 - GetPlayerSprintStaminaRemaining(player)
                
                SendNUIMessage({
                    action = 'updateStatus',
                    health = health - 100,
                    armor = armor,
                    pid = pid,
                    hunger = food,
                    thirst = water,
                    stamina = stamina,
                    oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())*10,
                    logo = Config.Logo,
                    maxPlayers = Config.MaxPlayers,
                    pall = playersCount,
                })
                
                if IsPedArmed(ped, 7) then
                    local weapon = GetSelectedPedWeapon(ped)
                    local ammoTotal = GetAmmoInPedWeapon(ped,weapon)
                    local bool,ammoClip = GetAmmoInClip(ped,weapon)
                    local ammoRemaining = math.floor(ammoTotal - ammoClip)
                    SendNUIMessage({
                        action = 'updateAmmo',
                        ammo = ammoClip,
                        ammohand = ammoRemaining
                    })
                else
                    SendNUIMessage({
                        action = 'hideAmmo',
                    })
                end
                Wait(1000)
                if IsEntityDead(ped) then
                    health = 0
                else
                    health = GetEntityHealth(ped) - 100
                end
            end
        end)
                                                                                                                                                                                                                                           
    RegisterNetEvent('Ultra-Hud:GetActivePlayers')
    AddEventHandler('Ultra-Hud:GetActivePlayers', function(players)
        playersCount = players
    end)

end
-------------------------------------------------------- END ESX-----------------------------------------

    -- /  |   /  |/        |/  |  /  |/      | /      \ /  |      /        |
    -- $$ |   $$ |$$$$$$$$/ $$ |  $$ |$$$$$$/ /$$$$$$  |$$ |      $$$$$$$$/ 
    -- $$ |   $$ |$$ |__    $$ |__$$ |  $$ |  $$ |  $$/ $$ |      $$ |__    
    -- $$  \ /$$/ $$    |   $$    $$ |  $$ |  $$ |      $$ |      $$    |   
    --  $$  /$$/  $$$$$/    $$$$$$$$ |  $$ |  $$ |   __ $$ |      $$$$$/    
    --   $$ $$/   $$ |_____ $$ |  $$ | _$$ |_ $$ \__/  |$$ |_____ $$ |_____ 
    --    $$$/    $$       |$$ |  $$ |/ $$   |$$    $$/ $$       |$$       |
    --     $/     $$$$$$$$/ $$/   $$/ $$$$$$/  $$$$$$/  $$$$$$$$/ $$$$$$$$/ 
                                                                        
                                                    
local cinturon = false 
local bateria = true

function Cinturon(ped)
    while true do 
        if cinturon then 
            DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
            DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
    while true do 
        ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            _sleep = 200
            local vehiculo = GetVehiclePedIsUsing(ped)
            local velo = (GetEntitySpeed(vehiculo)* 3.6)
            local gaso = GetVehicleFuelLevel(vehiculo)
            local position = GetEntityCoords(ped)
            local carhealth = GetVehicleBodyHealth(vehiculo)/10
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            if Config.MinimapJustInCar then 
                DisplayRadar(true)
            end
            SendNUIMessage({
                action = 'showCarhud';
                vel = velo; 
                gasolina = gaso;
                street = streetName;
                cinturon = cinturon;
                bateria = bateria;
                vidav  = carhealth;
                map = true
            })
        else
            if Config.MinimapJustInCar then 
                DisplayRadar(false)
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud';
                    map = false
                })
            else
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud'
                })
            end
        end
        Wait(_sleep)
    end
end)


function EngineControl()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil and veh ~= 0 and GetPedInVehicleSeat(veh, 0) then
       if GetIsVehicleEngineRunning(veh) then
            SetVehicleEngineOn(veh, false, false, true)
            bateria = false
            -- Here you can put a notification (example, you turned off the engine) / Aqui puedes poner una notificacion ( ejemplo, apagaste el motor)
       else
            SetVehicleEngineOn(veh, true, false, true)
            bateria = true
            -- Here you can put a notification (example, you started the engine) / Aqui puedes poner una notificacion ( ejemplo, prendiste el motor)
       end
    end
end

function BeltControl()
    local jugador = PlayerPedId()
    if IsPedInAnyVehicle(jugador) then
        if cinturon then 
            -- Here you can put a notification of the belt (example, I removed the belt) / Aqui puedes poner una notificacion del cinturon (ejemplo , me removu el cinturon)
            cinturon = false
            Cinturon(jugador)
        else
            -- Here you can put a notification of the belt (example, I put on the belt) / Aqui puedes poner una notificacion del cinturon (ejemplo , me puse el cinturon)
            cinturon = true
            Cinturon(jugador)
        end
    end
end

RegisterCommand(Config.CommandHideAllHUD, function()
    SendNUIMessage({action = 'hideAllHud'})
end)

RegisterCommand(Config.CommandShowAllHUD, function()
    SendNUIMessage({ action = 'ShowAllHud' })
end)

RegisterCommand('offmotor', function ()
    EngineControl()
end)

RegisterCommand('belt', function ()
    BeltControl()
end)

RegisterKeyMapping('belt', 'Car Belt', 'keyboard', Config.BeltKey)
RegisterKeyMapping('offmotor', 'Turn ON/OFF the car', 'keyboard', Config.ONandOFFMotorKey)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local player = PlayerId()
            if IsPauseMenuActive() and not isPaused then
                isPaused = true
                SendNUIMessage({action = 'hideAllHud'})
            elseif not IsPauseMenuActive() and isPaused then
                isPaused = false
                SendNUIMessage({action = 'ShowAllHud'})
            end
        Wait(500)
    end
end)

-- MIC

Citizen.CreateThread(function() 
    
    local talking = false
    local playerId = PlayerId()

    while true do
        Wait(300)
            if NetworkIsPlayerTalking(PlayerId()) then
                SendNUIMessage({talking = true})
                else 
                SendNUIMessage({talking = false})
            end	
    end
end)

RegisterNetEvent('Ultra-Hud:Hideall')
AddEventHandler('Ultra:Hideall', function(players)
	SendNUIMessage({action = 'hideAllHud'})
end)

RegisterNetEvent('Ultra:showhudall')
AddEventHandler('Ultra:showhudall', function(players)
	SendNUIMessage({ action = 'ShowAllHud' })
end)
