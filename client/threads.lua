CreateThread(function()
    Wait(500)
    GetInteriorData(Client.interiorId)
end)

-- Send interior data to NUI
CreateThread(function()
    while true do
        if Client.isMenuOpen and Client.interiorId > 0 then
            GetInteriorData(Client.interiorId, true)
        else
            Wait(500)
        end
        Wait(0)
    end
end)

CreateThread(function()
    while true do
        if Client.interiorId > 0 then
            if Client.portalPoly or Client.portalLines or Client.portalCorners or Client.portalInfos then
                DrawPortalInfos(Client.interiorId)
            end
        else
            Wait(500)
        end
        Wait(0)
    end
end)

-- Send current coords to NUI
CreateThread(function()
    local oldCoords = vec3(0, 0, 0)

    while true do
        if Client.isMenuOpen then
            local coords = GetEntityCoords(cache.ped)

            if #(coords - oldCoords) > 0.5 then
                oldCoords = coords
                local formatedCoords = FUNC.round(coords.x, 3) .. ", " .. FUNC.round(coords.y, 3) .. ", " .. FUNC.round(coords.z, 3)

                SendNUIMessage({
                    action = 'playerCoords',
                    data = {
                        coords = formatedCoords,
                        heading = tostring(FUNC.round(GetEntityHeading(cache.ped), 3))
                    }
                })
            end
        else
            Wait(200)
        end
        Wait(50)
    end
end)