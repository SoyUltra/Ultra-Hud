if Config.Framework == "ESX" then

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10000) -- in MS
            TriggerClientEvent('Ultra-Hud:GetActivePlayers', -1, GetNumPlayerIndices())
        end
    end)

end