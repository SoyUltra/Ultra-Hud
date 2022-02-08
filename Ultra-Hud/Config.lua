Config = {}
-----------------------------------------------------------
--  This is for thirst and hunger of ESX.
--  Esto es para la sed y el hambre de ESX.
-----------------------------------------------------------
Config.BeltKey = 'B'
Config.ONandOFFMotorKey = 'Y'
Config.StatusUpdateInterval = 4000 -- Time it takes for status to update (lowering this value adds ms) / Tiempo que tarda el estado en actualizarse (reducir este valor agrega ms)
Config.MinimapJustInCar = true

function GetStatus(cb)

    TriggerEvent("esx_status:getStatus", "hunger", function(h)
        TriggerEvent("esx_status:getStatus", "thirst", function(t)
            local hunger = h.getPercent()
            local thirst = t.getPercent()
            local stress = 10  -- You can trigger your stress. / puede desencadenar su estrés.
            cb({hunger, thirst, stress})
        end)
    end)

end