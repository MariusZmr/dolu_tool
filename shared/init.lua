RESOURCE_NAME = GetCurrentResourceName()
lib.locale()

Shared = {}

if not GetResourceState('ox_lib'):find('start') then
    print('^1ox_lib should be started before this resource^0', 2)
end

if GetResourceState('ox_inventory'):find('start') then
    Shared.ox_inventory = true
end
    
CreateThread(function()
    if IsDuplicityVersion() then
        Server = {}
    else
        Client = {
            noClip = false,
            isMenuOpen = false,
            currentTab = 'home',
            lastLocation = json.decode(GetResourceKvpString('dmt_lastLocation')),
            portalPoly = false,
            portalLines = false,
            portalCorners = false,
            portalInfos = false,
            interiorId = GetInteriorFromEntity(cache.ped),
            spawnedEntities = {},
            freezeTime = false,
            freezeWeather = false
        }

        lib.callback('dmt:getLocations', false, function(locations)
            Client.locations = locations
        end)

        lib.callback('dmt:getPedList', false, function(pedLists)
            Client.pedLists = pedLists
        end)

        lib.callback('dmt:getVehicleList', false, function(vehicleLists)
            Client.vehicleLists = vehicleLists
        end)

        lib.callback('dmt:getWeaponList', false, function(weaponLists)
            Client.weaponLists = weaponLists
        end)

        CreateThread(function()
            FUNC.setMenuPlayerCoords()

            while true do
                Wait(100)
                Client.interiorId = GetInteriorFromEntity(cache.ped)
            end
        end)
    end
end)

