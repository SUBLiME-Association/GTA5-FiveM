_Admin.Data = {}
_Admin.ItemsList = {}


function KI(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(1.0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end




function _Admin.GetRankNameFromGrade(grade)
    for _, v in pairs(_Admin.Ranks) do
        if v.grade == grade then 
            return v.name
        end
    end
end




RegisterNetEvent(_Admin.Prefix.."reviveTargetPlayer")
AddEventHandler(_Admin.Prefix.."reviveTargetPlayer", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do Citizen.Wait(50) end
        local formattedCoords = {
            x = ESX.Math.Round(coords.x, 1),
            y = ESX.Math.Round(coords.y, 1),
            z = ESX.Math.Round(coords.z, 1)
        }
        RespawnPed(playerPed, formattedCoords, 0.0)
        StopScreenEffect('DeathFailOut')
        DoScreenFadeIn(800)
    end)
end)




function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end




local tableBlip = {}
function ToggleGPS(Coords, Player)
    local TGPS = AddBlipForCoord(Coords)     
    SetBlipSprite(TGPS, 480)       
    SetBlipShrink(TGPS, true)
    SetBlipScale(TGPS, 0.8)
    SetBlipColour(TGPS,29)
    SetBlipPriority(TGPS, 5)
    SetBlipRoute(TGPS, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("PLAYER : "..Player.."")
    SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
    EndTextCommandSetBlipName(TGPS)
    table.insert(tableBlip, TGPS)
end




function DeleteGPS()
    for k, v in pairs(tableBlip) do RemoveBlip(v) end tableBlip = {}
end




function _Admin.Print(msg)
    if _Admin.Config.EnablePrints then
        TriggerServerEvent(_Admin.Prefix.."SendPrint2Server", msg)
    end
end




HealMyPed = function(Index, rank)
    local playerPed = PlayerPedId()
    if Index == "HP" then
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    elseif Index == "Shield" then
        SetPedArmour(playerPed, 100)
    elseif Index == "Faim" then
        TriggerEvent('esx_status:set', 'hunger', 1000000)
    elseif Index == "Soif" then
        TriggerEvent('esx_status:set', 'thirst', 1000000)
    end
    _Admin.Print("[^1"..rank.." ^7- ^2"..GetPlayerName(PlayerId()).."^7] ^3"..Index.."^7")
end




_Admin.DrawText = function(x,y,scale,font,text,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end




_Admin.DrawRect = function(x, y, width, height, r, g, b, a)
    DrawRect((x/1920), (y/1080), (width/1920), (height/1080), r, g, b, a)
end




function _Admin.RefreshSublimeData()
    TriggerServerEvent(_Admin.Prefix.."RefreshData")
end




function _Admin.RefreshBans()
    TriggerServerEvent(_Admin.Prefix.."RefreshBans")
end




function _Admin.RefreshStaff()
    TriggerServerEvent(_Admin.Prefix.."RefreshStaff")
end



function _Admin.SendServerLogs(msg)
    TriggerServerEvent(_Admin.Prefix.."SendServerLogs", msg)
end



RegisterNetEvent(_Admin.Prefix.."SendData")
AddEventHandler(_Admin.Prefix.."SendData", function(data)
    _Admin.Data = data
end)




RegisterNetEvent(_Admin.Prefix.."SendBans")
AddEventHandler(_Admin.Prefix.."SendBans", function(bans)
    _Admin.Bans = bans
end)




RegisterNetEvent(_Admin.Prefix.."SendStaff")
AddEventHandler(_Admin.Prefix.."SendStaff", function(staff)
    _Admin.Staff = staff
end)




function _Admin.RefreshAllItems()
    TriggerServerEvent(_Admin.Prefix.."GetListOfAllItems")
end




RegisterNetEvent(_Admin.Prefix.."LoadListOfAllItems")
AddEventHandler(_Admin.Prefix.."LoadListOfAllItems", function(listItems)
    _Admin.ItemsList = listItems
end)


_Admin.allJobs, _Admin.allFactions = {}, {}

if _Admin.Config.DoubleJob == true then
    CreateThread(function()
        while true do
            Wait(3500)
            print("VEUILLEZ REMETTRE Config.DoubleJob SUR FALSE ou 'fbase' SI VOUS UTILISEZ ESX-LEGACY DE FELLOW, ACTUELLEMENT NON DISPONIBLE SUR TRUE")
        end
    end)
elseif _Admin.Config.DoubleJob == 'fbase' or _Admin.Config.DoubleJob == false then
    function _Admin.GetAllJobsFactions()
        ESX.TriggerServerCallback(_Admin.Prefix.."GetAllJobsGrades", function(result)
            _Admin.allJobs = result
        end)
    end  
end

_Admin.dataPlayers = {}
_Admin.adminName = nil
_Admin.TargetInventory, _Admin.TargetWeight, _Admin.TargetMaxWeight = {}, 0, 0

function _Admin.GetAllPlayersOnline()
    ESX.TriggerServerCallback(_Admin.Prefix.."GetAllPlayersOnline", function(result)
        _Admin.dataPlayers = result
    end)
    ESX.TriggerServerCallback(_Admin.Prefix.."GetAdminName", function(result)
        _Admin.adminName = result
    end)
end

function _Admin.GetTargetInventory(target)
    ESX.TriggerServerCallback(_Admin.Prefix.."GetInventoryTargetPlayers", function(data)
        _Admin.TargetInventory = data.inventory
        _Admin.TargetWeight = data.weight
        _Admin.TargetMaxWeight = data.maxWeight
        _Admin.TargetJob = data.job
        --_Admin.TargetMoney = data.money
    end, target)
end

_Admin.TargetJobLabel, _Admin.TargetGradeLabel = '', ''

function _Admin.GetTargetJob(target)
    ESX.TriggerServerCallback(_Admin.Prefix.."GetJobTargetPlayers", function(data)
        _Admin.TargetJobLabel = data.job
        _Admin.TargetGradeLabel = data.grade
    end, target)
end

_Admin.TargetAccounts = {}

function _Admin.GetTargetAccounts(target)
    ESX.TriggerServerCallback(_Admin.Prefix.."GetAccountsTargetPlayers", function(data)
        _Admin.TargetAccounts = data
    end, target)
end


-- Vehicle

_Admin.GetVehicleSQL = {}
RegisterNetEvent(_Admin.Prefix.."Receive:GetAllVehicleSQL")
AddEventHandler(_Admin.Prefix.."Receive:GetAllVehicleSQL", function(data)
    _Admin.GetVehicleSQL = data
end)

_Admin.playersVehicleData = {}
function _Admin.GetVehicleAllPlayers(xtarget)
    
    ESX.TriggerServerCallback(_Admin.Prefix..'GetAllPlayersVehicle', function(result)
        _Admin.playersVehicleData = result
    end, xtarget)
end

function _Admin.GetOwnerVehiclePedIsInPlate(vehicle, plate)
    if string.match(vehicle, plate) then -- not (string.sub(vehicle, string.find(vehicle, plate))) == nil 
        return true
    else
        return false
    end
end