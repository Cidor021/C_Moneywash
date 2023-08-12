ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    for k,v in pairs(Config.Ped) do
        ped(k,v)
    end
end)

function ped(k, data)
    RequestModel(data.pedModel)
    while not HasModelLoaded(data.pedModel) do
        Wait(1)
    end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
    end
    ped =  CreatePed(4, data.pedModel,vector3(data.location.x, data.location.y, data.location.z -1), 3374176, false, true)
    SetEntityHeading(ped, data.heading)
    FreezeEntityPosition(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    exports.qtarget:AddBoxZone(k, vector3(data.location.x, data.location.y, data.location.z -1), 0.45, 0.35, {
        name=k,
        heading=data.heading,
        debugPoly=false,
        minZ=data.location.z -1,
        maxZ=data.location.z + 2,
    }, {
        options = {
            {
                event = "qrp_duty:goOnDuty",
                action = function()
                    lib.registerContext({
                        id = 'cidor_menu',
                        title = 'PRANJE NOVCA',
                        options = {
                            {
                                id = 1,
                                title = 'Operi Prljave Pare',
                                onSelect = function()
                                    local input = lib.inputDialog('Unesi Kolicinu Novca?', {
                                        {type = 'number'},
                                    })
                                    if not input then return end
                                    TriggerServerEvent("cidor:pranje", input[1])
                                end,
                                icon = 'fas fa-dollar-sign'
                            },
                        }
                    })
                    lib.showContext('cidor_menu')
                end,
                icon = 'fas fa-dollar-sign',
                label = "Operi pare",
            },
        },
        distance = 3.5
    })
end
