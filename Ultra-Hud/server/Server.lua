----------------------------------------------------------
--Number of active players
--Numero de Player activos
----------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- in MS
		TriggerClientEvent('Ultra-Hud:GetActivePlayers', -1, GetNumPlayerIndices())
    end
end)
