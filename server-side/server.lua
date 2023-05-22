local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local rebornClient = Tunnel.getInterface(GetCurrentResourceName())

local rebornServer = {}
Tunnel.bindInterface(GetCurrentResourceName(),rebornServer)

Config = module(GetCurrentResourceName(),"config")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

rebornServer.getConfigs = function()
    return Config
end

vRP.prepare("rb_arsenal/addOrg","INSERT INTO rb_arsenal (org,bank) VALUES(@org,0) ")
vRP.prepare("rb_arsenal/checkOrg","SELECT * FROM rb_arsenal WHERE org = @org")
vRP.prepare("rb_arsenal/updateMoney","UPDATE rb_arsenal SET bank = @bank WHERE org = @org")

vRP.prepare("rb_arsenal/createTables", [[	
	CREATE TABLE IF NOT EXISTS rb_arsenal (
	id int(11) NOT NULL AUTO_INCREMENT,
	org longtext,
	bank int(11) DEFAULT 0,
	PRIMARY KEY (id))
]])


vRP.prepare("rb_arsenal/consultTables","SHOW TABLES LIKE 'rb_arsenal'")
CreateThread(function()
    if vRP.query("rb_arsenal/consultTables")[1] == nil then
        vRP.execute("rb_arsenal/createTables")
        print('[+] ^rb_arsenal^0 - BANCO DE DADOS INSTALADO COM SUCESSO!')
    else
        print('[+] ^rb_arsenal^0 - O BANCO DE DADOS ESTA CONFIGURADO!')
    end
end)


rebornServer.tryDeposit = function(org,configName)
    local source = source
    local user_id = vRP.getUserId(source)


    if not vRP.query("rb_arsenal/checkOrg", { org = org})[1] then
        vRP.execute("rb_arsenal/addOrg",{org = org})
        print('[+] ^rb_arsenal^0 - NOVO REGISTRO ADICIONADO NO SISTEMA [ORG: '..org..']')
        Wait(500)
    end

    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
    if orgQuery[1] then
        local configArsenal = Config["arsenalConfig"][configName]

        local value = parseInt(vRP.prompt(source,"Valor de deposito:",""))
        if value == "" or parseInt(value) < 1 then
            TriggerClientEvent("Notify",source,"negado","Você deve inserir um valor acima de 0")
            return
        end

        if parseInt(value) > 0 then
            if vRP.request(source,"Você tem certeza que quer depositar $"..parseInt(value).." de dinheiro ilegal ? ",30) then
                if vRP.tryGetInventoryItem(user_id,configArsenal["itemBuy"]["itemName"],parseInt(value)) then
                    vRP.execute("rb_arsenal/updateMoney",{bank = parseInt(orgQuery[1]["bank"] + parseInt(value)), org = org})
                    SendWebhookMessage(Config["locationsArsenal"][configName]["webhook"],"```prolog\n[PASSAPORTE]: "..user_id.." \n[DEPOSITOU]: "..value.."\r```",org)

                    TriggerClientEvent("Notify",source,"sucesso","Valor depositado com sucesso!")
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem o valor informado")
                    return
                end
            end
        else
            return
        end
    else
        TriggerClientEvent("Notify",source,"negado","Não encontramos a organização "..org)
    end
end

rebornServer.getWeapon = function(org,weapon,configName)
    local source = source
    local user_id = vRP.getUserId(source)

    local configArsenal = Config["arsenalConfig"][configName]

    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
    if orgQuery[1] then

        if not orgQuery[1][weapon] then
            vRP.prepare("rb_arsenal/alterTable"..weapon, "ALTER TABLE rb_arsenal ADD "..weapon.." int(8) DEFAULT(0)")
            vRP.execute("rb_arsenal/alterTable"..weapon)
            print('[+] ^rb_arsenal^0 - NOVA TABELA ADICIONADA NO SISTEMA [WEAPON:'..weapon..']')
            Wait(500)
        end

        if configArsenal["weaponsList"][weapon]["perm"] then
            if not vRP.hasPermission(user_id,configArsenal["weaponsList"][weapon]["perm"]) then
                TriggerClientEvent("Notify",source,"negado","Você não tem permissão para pegar este equipamento")
                return false
            end
        end

        if not vRPclient.getWeapons(source)[weapon] then

            if parseInt(orgQuery[1][weapon]) > 0 then            
                vRP.prepare("rb_arsenal/removeStock"..weapon,"UPDATE rb_arsenal SET "..weapon.." = "..weapon.." - 1 WHERE org = @org")
                vRP.execute("rb_arsenal/removeStock"..weapon, {org = org})
                vRPclient.giveWeapons(source,{[weapon] = {ammo = 0}})
                SendWebhookMessage(Config["locationsArsenal"][configName]["webhook"],"```prolog\n[PASSAPORTE]: "..user_id.." \n[PEGOU A ARMA]: "..weapon.."\r```",org)

                TriggerClientEvent("Notify",source,"sucesso","Você pegou a sua arma, devolva no fim do expediente")
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Não tem estoque desta arma, você deve comprar mais")
                Wait(200)
                return false
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você já tem essa arma equipada")
            return false
        end
    end
end

rebornServer.weaponsDatabase = function(org)
    local source = source
    local user_id = vRP.getUserId(source)

    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
    if orgQuery[1] then
        return orgQuery[1]
    else
        return {}
    end
end


rebornServer.getBank = function(org)
    local source = source
    local user_id = vRP.getUserId(source)

    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
    if orgQuery[1] then
        return orgQuery[1].bank
    else
        return 0
    end

end


rebornServer.checkStock = function(org,weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
    if orgQuery[1] then
        if orgQuery[1][weapon] then
            return true
        else
            return false
        end
    end
end

rebornServer.buyAmmo = function(org,weapon,configName,ammo)
    local source = source
    local user_id = vRP.getUserId(source)

    local configArsenal = Config["arsenalConfig"][configName]
    local qtd = 1
    local value = parseInt(vRP.prompt(source,"Quantas deseja comprar ?:",""))
    if value == "" or parseInt(value) < 1 then
        qtd = 1
        TriggerClientEvent("Notify",source,"negado","Você deve inserir um valor acima de 0")
        return false
    else
        qtd = value
    end


    if (ammo + qtd) > 250 then
        TriggerClientEvent("Notify",source,"negado","Essa quantidade ultrapassa o que a arma suporta!")
        return
    end

    if Config["arsenalConfig"][configName]["itemBuy"]["buyWithBank"] then
        local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})

        if vRP.request(source,"Você deseja que sua corporação pague $"..parseInt(((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1)).." por isso ? ",30) then
            if orgQuery[1] and orgQuery[1]["bank"] >= ((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1) then
                vRP.execute("rb_arsenal/updateMoney",{bank = parseInt(orgQuery[1]["bank"] - ((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1)), org = org})
                vRPclient.giveWeapons(source,{[weapon] = {ammo = parseInt(qtd)}})
                SendWebhookMessage(Config["locationsArsenal"][configName]["webhook"],"```prolog\n[PASSAPORTE]: "..user_id.." \n[COMPROU A MUNIÇÃO DA ARMA]: "..weapon.."\n [QUANTIDADE]: "..qtd.."\r```",org)
                
                TriggerClientEvent("Notify",source,"sucesso","Você comprou mais "..(qtd or 1).."x de munição para você")
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Sua corporção não tem o valor necessário para comprar estoque")
                return false
            end
        else
            return false
        end
    else
        if vRP.request(source,"Você deseja que sua corporação pague $"..parseInt(((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1)).." por isso ? ",30) then
            if vRP.tryFullPayment(user_id,((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1)) then
                vRPclient.giveWeapons(source,{[weapon] = {ammo = parseInt(qtd)}})
                SendWebhookMessage(Config["locationsArsenal"][configName]["webhook"],"```prolog\n[PASSAPORTE]: "..user_id.." \n[COMPROU A MUNIÇÃO DA ARMA]: "..weapon.."\n [QUANTIDADE]: "..qtd.."\r```",org)
                TriggerClientEvent("Notify",source,"sucesso","Você comprou mais "..(qtd or 1).."x de munição para você")
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem o valor para comprar mais estoque, o valor necessário é $"..((configArsenal["weaponsList"][weapon]["ammoPrice"]) * qtd or 1))
                return false
            end
        else
            return false
        end
    end
end

rebornServer.giveBack = function(org,weapon,configName)
    local source = source
    local user_id = vRP.getUserId(source)

    local configArsenal = Config["arsenalConfig"][configName]

    local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})

    if vRPclient.getWeapons(source)[weapon] then
        if rebornClient.removeWeapon(source,GetHashKey(weapon)) then
            vRP.prepare("rb_arsenal/addStock"..weapon,"UPDATE rb_arsenal SET "..weapon.." = "..weapon.." + 1 WHERE org = @org")
            vRP.execute("rb_arsenal/addStock"..weapon, {org = org})
            SendWebhookMessage(Config["locationsArsenal"][configName]["webhook"],"```prolog\n[PASSAPORTE]: "..user_id.." \n[GUARDOU A ARMA]: "..weapon.."\r```",org)
            TriggerClientEvent("Notify",source,"sucesso","Você guardou a arma no estoque da arma da corporação")
            return true
        else
            return false
        end
    end

end

rebornServer.buyStock = function(org,weapon,configName,qtd)
    local source = source
    local user_id = vRP.getUserId(source)

    local configArsenal = Config["arsenalConfig"][configName]

    local value = parseInt(vRP.prompt(source,"Quantas deseja comprar ?:",""))
    if value == "" or parseInt(value) < 1 then
        qtd = 1
        TriggerClientEvent("Notify",source,"negado","Você deve inserir um valor acima de 0")
        return false
    else
        qtd = value
    end


    if Config["arsenalConfig"][configName]["itemBuy"]["buyWithBank"] then
        local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})

        if configArsenal["roleBuy"] then
            if not vRP.hasPermission(user_id,configArsenal["roleBuy"]) then
                TriggerClientEvent("Notify",source,"negado","Você não tem permissão para comprar armamento")
                return false
            end
        end


        if vRP.request(source,"Você deseja que sua corporação pague $"..parseInt(((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1)).." por isso ? ",30) then
            if orgQuery[1] and orgQuery[1]["bank"] >= ((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1) then
                vRP.execute("rb_arsenal/updateMoney",{bank = parseInt(orgQuery[1]["bank"] - ((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1)), org = org})
                vRP.prepare("rb_arsenal/addStock"..weapon,"UPDATE rb_arsenal SET "..weapon.." = "..weapon.." + "..(qtd or 1).." WHERE org = @org")
                vRP.execute("rb_arsenal/addStock"..weapon, {org = org})
                TriggerClientEvent("Notify",source,"sucesso","Você comprou mais "..(qtd or 1).."x estoque da arma para a corporação")
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Sua corporção não tem o valor necessário para comprar estoque")
                return false
            end
        else
            return false
        end
    else
        if vRP.request(source,"Você deseja que sua corporação pague $"..parseInt(((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1)).." por isso ? ",30) then
            if vRP.tryFullPayment(user_id,((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1)) then
                local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
                vRP.prepare("rb_arsenal/addStock"..weapon,"UPDATE rb_arsenal SET "..weapon.." = "..weapon.." + "..(qtd or 1).." WHERE org = @org")
                vRP.execute("rb_arsenal/addStock"..weapon, {org = org})
                TriggerClientEvent("Notify",source,"sucesso","Você comprou mais "..(qtd or 1).."x estoque da arma para a corporação")
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Você não tem o valor para comprar mais estoque, o valor necessário é $"..((configArsenal["weaponsList"][weapon]["weaponPrice"]) * qtd or 1))
                return false
            end
        else
            return false
        end
    end
end

rebornServer.buyItem = function(org,Type,configName)
    local source = source
    local user_id = vRP.getUserId(source)

    local configArsenal = Config["arsenalConfig"][configName]

    if configArsenal["secondaryItens"][Type] then
        if configArsenal["secondaryItens"][Type]["buyWithBank"] then

            if configArsenal["secondaryItens"][Type]["perm"] then
                if not vRP.hasPermission(user_id,configArsenal["secondaryItens"][Type]["perm"]) then
                    TriggerClientEvent("Notify",source,"negado","Você não tem permissão para pegar este item")
                    return false
                end
            end
    
            local orgQuery = vRP.query("rb_arsenal/checkOrg", { org = org})
            if vRP.request(source,"Você deseja que sua corporação pague $"..parseInt(configArsenal["secondaryItens"][Type]["price"]).." por isso ? ",30) then
            
                if orgQuery[1] and orgQuery[1]["bank"] >= (configArsenal["secondaryItens"][Type]["price"]) then
                    vRP.execute("rb_arsenal/updateMoney",{bank = parseInt(orgQuery[1]["bank"] - (configArsenal["secondaryItens"][Type]["price"])), org = org})
                    
                    if type(configArsenal["secondaryItens"][Type]["index"]) == "table" then
                        for k,v in pairs(configArsenal["secondaryItens"][Type]["index"]) do
                            vRP.giveInventoryItem(user_id,v,configArsenal["secondaryItens"][Type]["qtd"])
                        end
                    else
                        vRP.giveInventoryItem(user_id,configArsenal["secondaryItens"][Type]["index"],configArsenal["secondaryItens"][Type]["qtd"])
                    end

                    TriggerClientEvent("Notify",source,"sucesso","Você compro "..configArsenal["secondaryItens"][Type]["qtd"].."x de "..Type.."")
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Sua corporção não tem o valor necessário para comprar estoque")
                    return false
                end
            else
               
                return false
            end
        else
            if vRP.request(source,"Você deseja pagar "..parseInt(configArsenal["secondaryItens"][Type]["price"]).." por isso ? ",30) then

                if vRP.tryFullPayment(user_id,configArsenal["secondaryItens"][Type]["price"]) then
                    if type(configArsenal["secondaryItens"][Type]["index"]) == "table" then
                        for k,v in pairs(configArsenal["secondaryItens"][Type]["index"]) do
                            vRP.giveInventoryItem(user_id,v,configArsenal["secondaryItens"][Type]["qtd"])
                        end
                    else
                        vRP.giveInventoryItem(user_id,configArsenal["secondaryItens"][Type]["index"],configArsenal["secondaryItens"][Type]["qtd"])
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem o valor para comprar este item, o valor necessário é $"..configArsenal["secondaryItens"][Type]["price"])
                end
            else
                return
            end
        end
    end

end


rebornServer.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if type(perm) == "table" then
        for k,v in pairs(perm) do
            if vRP.hasPermission(user_id,v) then
                return true
            end
        end
    else
        return vRP.hasPermission(user_id,perm)
    end
    return false
end


-- [FUNÇÃO PARA ENVIAR WEBHOOK]
function SendWebhookMessage(webhook,message,title)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
            avatar_url = "http://site.rebornresources.net/images/reborn_logo_3-1.png",
            username = "Reborn Resources",
            embeds = {
                {     ------------------------------------------------------------
                  title = "ARSENAL\n⠀",
                  thumbnail = {
                    url = "http://site.rebornresources.net/images/reborn_logo_3-1.png"
                  }, 
                  fields = {
                    { 
                      name = ""..title.."\n",
                      value = message
                    }
                  }, 
                  footer = { 
                    text = "Data e hora: " ..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://www.autoriafacil.com/wp-content/uploads/2019/01/icone-data-hora.png"
                  },
                  color = 13991687
                }
              }
            }), 
        {['Content-Type'] = 'application/json' })
	end
end