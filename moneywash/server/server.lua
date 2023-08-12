ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('cidor:pranje')
AddEventHandler('cidor:pranje', function(kolicina)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount('black_money').money

    if kolicina > blackMoney then
        TriggerClientEvent('esx:showNotification', source, 'Nemate dovoljno prljavog novca.')
        return
    end

    local cistaKolicina = math.floor(kolicina * 0.7) 
    xPlayer.removeAccountMoney('black_money', kolicina)
    xPlayer.addMoney(cistaKolicina)

    TriggerClientEvent('esx:showNotification', source, 'Oprali ste ' .. kolicina .. ' prljavog novca i dobili ' .. cistaKolicina .. ' čistog novca.')
    pranjekurca('Igrač: ' .. GetPlayerName(source) .. ' je oprao ' .. kolicina .. ' novca i dobio ' .. cistaKolicina .. ' čistog novca.', source) 
end)
local DISCORD_WEBHOOK = ""
local DISCORD_NAME = "Cidor Moneywash"
local DISCORD_IMAGE = ""

function pranjekurca(message)
    local connect = {
          {
              ["color"] = 10914,
              ["title"] = 'Cidor Moneywash',
              ["description"] = message,
              ["footer"] = {
                  ["text"] = 'Cidor',
              },
          }
      }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end 
                                       