local playedZones = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Réduire la charge CPU en vérifiant toutes les 0,5 seconde

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, zone in ipairs(Config.Zones) do
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, zone.x, zone.y, zone.z)

            if distance < zone.radius and not playedZones[i] then
                -- Envoyer une requête au serveur pour jouer le son
                TriggerServerEvent('playSoundInRadius', zone.x, zone.y, zone.z, zone.radius, zone.sound)
                print('Demande de jouer le son : ' .. zone.sound .. ' dans la zone ' .. i)

                -- Marquer la zone comme jouée
                playedZones[i] = true

                -- Après un court délai, permettre au son d'être rejoué
                Citizen.SetTimeout(1000, function()
                    playedZones[i] = false
                end)
            end

            -- Ajouter un marker rond rouge
            if distance < zone.radius then
                DrawMarker(1, zone.x, zone.y, zone.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zone.radius * 2.0, zone.radius * 2.0, 1.0, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
            end
        end
    end
end)

RegisterNetEvent('playSoundForClients')
AddEventHandler('playSoundForClients', function(x, y, z, radius, soundFile)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, x, y, z) < radius then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = soundFile
        })
        print('Son joué pour le client : ' .. soundFile)
    end
end)
