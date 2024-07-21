RegisterNetEvent('playSoundInRadius')
AddEventHandler('playSoundInRadius', function(x, y, z, radius, soundFile)
    -- Diffuse l'événement à tous les clients dans le radius
    TriggerClientEvent('playSoundForClients', -1, x, y, z, radius, soundFile)
end)
