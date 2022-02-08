-- ________   ______   __    __ 
-- /        | /      \ /  |  /  |
-- $$$$$$$$/ /$$$$$$  |$$ |  $$ |
-- $$ |__    $$ \__$$/ $$  \/$$/ 
-- $$    |   $$      \  $$  $$<  
-- $$$$$/     $$$$$$  |  $$$$  \ 
-- $$ |_____ /  \__$$ | $$ /$$  |
-- $$       |$$    $$/ $$ |  $$ |
-- $$$$$$$$/  $$$$$$/  $$/   $$/ 

ESX                     = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

    AddEventHandler('playerSpawned', function()   
        Citizen.CreateThread(function ()
            while true do 
                if not IsPauseMenuActive() then 
                    ped = PlayerPedId()
                    health = GetEntityHealth(ped)
                    armor = GetPedArmour(ped)
                    pid = GetPlayerServerId(PlayerId())
                    SendNUIMessage({
                        action = 'updateStatus',
                        health = health - 100,
                        armor = armor,
                        pid = pid,
                        voice = NetworkIsPlayerTalking(PlayerId()),
                        stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                        oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())*10,
                        hunger = food,
                        thirst = water,
                        pall = playersCount,
                        stress = stress
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
                else
                    SendNUIMessage({
                        action = 'hideAllHud',
                    })
                end
                Wait(500)
            end
        end)
        
    
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Config.StatusUpdateInterval)
                GetStatus(function(data)
                        food = data[1]
                        water = data[2]
                        stress = data[3]
                end)
            end
        end)
    end)

         
    
--   ______    ______   ________  ______  __     __  ________        _______   __         ______   __      __  ________  _______  
--  /      \  /      \ /        |/      |/  |   /  |/        |      /       \ /  |       /      \ /  \    /  |/        |/       \ 
-- /$$$$$$  |/$$$$$$  |$$$$$$$$/ $$$$$$/ $$ |   $$ |$$$$$$$$/       $$$$$$$  |$$ |      /$$$$$$  |$$  \  /$$/ $$$$$$$$/ $$$$$$$  |
-- $$ |__$$ |$$ |  $$/    $$ |     $$ |  $$ |   $$ |$$ |__          $$ |__$$ |$$ |      $$ |__$$ | $$  \/$$/  $$ |__    $$ |__$$ |
-- $$    $$ |$$ |         $$ |     $$ |  $$  \ /$$/ $$    |         $$    $$/ $$ |      $$    $$ |  $$  $$/   $$    |   $$    $$< 
-- $$$$$$$$ |$$ |   __    $$ |     $$ |   $$  /$$/  $$$$$/          $$$$$$$/  $$ |      $$$$$$$$ |   $$$$/    $$$$$/    $$$$$$$  |
-- $$ |  $$ |$$ \__/  |   $$ |    _$$ |_   $$ $$/   $$ |_____       $$ |      $$ |_____ $$ |  $$ |    $$ |    $$ |_____ $$ |  $$ |
-- $$ |  $$ |$$    $$/    $$ |   / $$   |   $$$/    $$       |      $$ |      $$       |$$ |  $$ |    $$ |    $$       |$$ |  $$ |
-- $$/   $$/  $$$$$$/     $$/    $$$$$$/     $/     $$$$$$$$/       $$/       $$$$$$$$/ $$/   $$/     $$/     $$$$$$$$/ $$/   $$/ 
                                                                                                                               
                                                                                                                               
RegisterNetEvent('Ultra-Hud:GetActivePlayers')
AddEventHandler('Ultra-Hud:GetActivePlayers', function(players)
    playersCount = players
end)

-- __     __  ________  __    __  ______   ______   __        ________ 
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

RegisterCommand('offmotor', function ()
    EngineControl()
end)

RegisterCommand('belt', function ()
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
end)


RegisterKeyMapping('belt', 'Car Belt', 'keyboard', Config.BeltKey)
RegisterKeyMapping('offmotor', 'Turn ON/OFF the car', 'keyboard', Config.ONandOFFMotorKey)



