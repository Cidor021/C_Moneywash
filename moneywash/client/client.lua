ESX = exports['es_extended']:getSharedObject()


local operi = {
    'csb_agent'
}

exports['qtarget']:AddTargetModel(operi, {
    options = {
        {
            event = 'operiprljavkes',
            label = 'Pranje Novca',
            icon = 'fas fa-money',

        }
    },
    distance = 1.5
})

RegisterNetEvent('operiprljavkes', function()
    lib.registerContext({
        id = 'cidor_menu',
        title = '💰 | PRANJE NOVCA',
        options = {
            {
                id = 1,
                title = '💰 | Operi Prljave Pare',
                event = 'cidor:moneywash',
            },
        }
    })
    lib.showContext('cidor_menu') 
end)


RegisterNetEvent('cidor:moneywash', function()
    local input = lib.inputDialog('Unesi Kolicinu Novca?', {
        {type = 'number'},
      })
    if not input then return end
    TriggerServerEvent("cidor:pranje", input[1])
end)

CreateThread(function()
    RequestModel(Config.Ped.pedModel)
    while not HasModelLoaded(Config.Ped.pedModel) do
        Wait(1)
    end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, Config.Ped.pedModel,Config.Ped.location, 3374176, false, true)
    SetEntityHeading(ped, Config.Ped.heading)
    FreezeEntityPosition(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end)