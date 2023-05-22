local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface('vRP')

local rebornServer = Tunnel.getInterface(GetCurrentResourceName())

local rebornClient = {}
Tunnel.bindInterface(GetCurrentResourceName(),rebornClient)




local Config

local orgName
local configName
local inArsenal = false

CreateThread(function()
    Config = rebornServer.getConfigs()
    Wait(1000)

    -- MENU PRINCIPAL
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local sleep = 1000
            if not inArsenal then
                for k,v in pairs(Config["locationsArsenal"]) do
                    if distanceCalculate(v["cds"]) < Config["arsenalConfig"][k]["blipConfig"]["distanceViewer"] then
                        local x,y,z = table.unpack(v["cds"])
                        local blipColor = Config["arsenalConfig"][k]["blipConfig"]["blipColour"]
                        
                        sleep = 4
                        DrawMarker(Config["arsenalConfig"][k]["blipConfig"]["blip"], x,y,z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8,0.8, 0.8, blipColor[1],blipColor[2],blipColor[3],blipColor[4], false, false, 2, true)
                        if distanceCalculate(v["cds"]) < 1.5 then
                            if IsControlJustPressed(0, 38) and rebornServer.checkPermission(Config["arsenalConfig"][k]["roleConfig"]) then
                                inArsenal = true
                                configName = k
                                orgName = Config["arsenalConfig"][k]["orgName"]
                                SetNuiFocus(true,true)
                                SendNUIMessage({action = "openMenu", configWeapons = Config["arsenalConfig"][k]["weaponsList"], configSecondary = Config["arsenalConfig"][k]["secondaryItens"], myWeapons = vRP.getWeapons(), bank = rebornServer.getBank(orgName),weaponsDatabase = rebornServer.weaponsDatabase(orgName)})
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)

    -- MENU DE DEPOSITO
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local sleep = 1000
            if not inArsenal then
                for k,v in pairs(Config["locationsArsenal"]) do
                    if distanceCalculate(v["depositCds"]) < Config["arsenalConfig"][k]["blipConfig"]["distanceViewer"] then
                        local x,y,z = table.unpack(v["depositCds"])
                        local blipColor = Config["arsenalConfig"][k]["blipConfig"]["blipColour"]
                        sleep = 4
                        DrawMarker(Config["arsenalConfig"][k]["blipConfig"]["depositBlip"], x,y,z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8,0.8, 0.8, blipColor[1],blipColor[2],blipColor[3],blipColor[4], false, false, 2, true)
                        if distanceCalculate(v["depositCds"]) < 1.5 then
                            if IsControlJustPressed(0, 38) and rebornServer.checkPermission(Config["arsenalConfig"][k]["roleConfig"]) then
                                rebornServer.tryDeposit(Config["arsenalConfig"][k]["orgName"],k)
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end)


distanceCalculate = function(pos)
    local ped = PlayerPedId()
    return #(GetEntityCoords(ped) - pos)
end

rebornClient.removeWeapon = function(weapon)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
    RemoveWeaponFromPed(PlayerPedId(),weapon)
    SetPedAmmo(PlayerPedId(),weapon,0)
    return true
end


-- CALLBACKS 

RegisterNUICallback("giveBack", function(data,cb)
    if data["weapon"] then
        SetNuiFocus(false,false)
        if rebornServer.giveBack(orgName,data["weapon"],configName) then
            cb({myWeapons = vRP.getWeapons()})
            SetNuiFocus(true,true)
        else
            SetNuiFocus(true,true)
            cb({})
        end
    end
end)
RegisterNUICallback("buyAmmo", function(data,cb)
    if data["weapon"] then
        SetNuiFocus(false,false)
        if rebornServer.buyAmmo(orgName,data["weapon"],configName,GetAmmoInPedWeapon(PlayerPedId(),GetHashKey(data["weapon"]))) then
            cb({myWeapons = vRP.getWeapons()})
            SetNuiFocus(true,true)
        else
            SetNuiFocus(true,true)
            cb({})
        end
    end
end)

RegisterNUICallback("getWeapon", function(data,cb)
    if data["weapon"] then
        SetNuiFocus(false,false)
        if rebornServer.getWeapon(orgName,data["weapon"],configName) then
            cb({myWeapons = vRP.getWeapons()})
            SetNuiFocus(true,true)
        else
            SetNuiFocus(true,true)
            cb({})
        end
    end
end)
RegisterNUICallback("updateStock", function(data,cb)
   cb({weaponsList = Config["arsenalConfig"][configName]["weaponsList"], weaponsDatabase = rebornServer.weaponsDatabase(orgName),bank = rebornServer.getBank(orgName)})
end)

RegisterNUICallback("buyWeapon", function(data,cb)
    if data["weapon"] then
        SetNuiFocus(false,false)
        if rebornServer.checkPermission(Config["arsenalConfig"][configName]["roleBuy"]) then
            if rebornServer.buyStock(orgName,data["weapon"],configName) then
                cb({})
                SetNuiFocus(true,true)
            else
                SetNuiFocus(true,true)
                cb({})
            end
        else
            TriggerEvent("Notify","negado","Você não tem permissão para comprar estoque")
            SetNuiFocus(true,true)
            cb({})
        end
    end
end)

RegisterNUICallback("buyItem", function(data,cb)
    if data["item"] then
        SetNuiFocus(false,false)
        if rebornServer.buyItem(orgName,data["item"],configName) then
            cb({})
            SetNuiFocus(true,true)
        else
            SetNuiFocus(true,true)
            cb({})
        end
    end
end)

RegisterNUICallback("checkStock", function(data,cb)
    if data["weapon"] then
        cb({weapon = rebornServer.checkStock(orgName,data["weapon"])})
    end
end)

RegisterNUICallback("closeArsenal", function()
    inArsenal = false
    ClearPedTasksImmediately(PlayerPedId())
    SetNuiFocus(0,0)
end)
