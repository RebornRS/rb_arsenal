Config = {}

Config["arsenalConfig"] = {

    ["PM"] = {

        ["orgName"] = "PM", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"policia.permissao","mecanico.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "mecanico.permissao",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 150000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 300000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

      },

      ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
          ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
          ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
       -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
      },
    },
    ["ROTA"] = {

        ["orgName"] = "ROTA", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 3.5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"policia.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "policia.permissao",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 150000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 300000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

        },

        ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
            ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
            ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
         -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
         -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
         -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
        },

    },
    ["BAEP"] = {

        ["orgName"] = "BAEP", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 3.5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"baep.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "coronel.baep",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 150000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 300000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

      },

      ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
          ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
          ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
       -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
      },

    },
    ["PRF"] = {

        ["orgName"] = "PRF", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 3.5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"prf.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "inspector.permissao",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 150000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 300000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

      },

        ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
          ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
          ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
       -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
      },
      
    },
      ["PRF2"] = {

        ["orgName"] = "PRF2", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 3.5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"prf.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "inspector.permissao",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 150000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 300000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

      },

      ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
          ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
          ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
       -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
      },

    },
    ["CIVIL"] = {

        ["orgName"] = "CIVIL", -- NOME DA ORGANIZAÇÃO

        ["blipConfig"] = { -- CONFIG DOS BLIPS
           ["blip"] = 31, -- ID DOS BLIPS
           ["depositBlip"] = 29, -- ID DOS BLIPS
           ["distanceViewer"] = 3.5, -- DISTANCIA PARA VER O BLIP
           ["blipColour"] = {255, 255, 255, 255},
        },

        ["itemBuy"] = { -- CONFIGURAÇÃO DE COMPRA (CONFIGURAR SE SERÁ COMPRADO COM ITEM OU NÃO E QUAL ITEM)
            ["buyWithBank"] = true, -- FALSE = COMPRAR COM DINHEIRO LIMPO
            ["itemName"] = "dinheirosujo" -- NOME DO ITEM QUE SERÁ USADO PARA COMPRAR O ARMAMENTO
        },
        
        ["roleConfig"] = {"pcivil.permissao"}, -- LISTA DE PERMISSÕES QUE PODEM ACESSAR O ARSENAL

        ["roleBuy"] = "delegado.permissao",

        ["weaponsList"] = { -- AQUI FICA A LISTA DE ITENS,VALOR DOS MESMOS E INGREDIENTES.

          --["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 40000, ["ammoPrice"] = 300, ["perm"] = "admin.permissao",},
          ["WEAPON_COMBATPISTOL"] = {["titleWeapon"] = "GLOCK", ["weaponPrice"] = 30000, ["ammoPrice"] = 100 },
          ["WEAPON_PUMPSHOTGUN_MK2"] = {["titleWeapon"] = "Remington 870 MK II", ["weaponPrice"] = 250000, ["ammoPrice"] = 500 },
          ["WEAPON_SMG"] = {["titleWeapon"] = "MP5", ["weaponPrice"] = 110000, ["ammoPrice"] = 100 },
          ["WEAPON_COMBATPDW"] = {["titleWeapon"] = "Sig Sauer MPX", ["weaponPrice"] = 100000, ["ammoPrice"] = 100 },
          ["WEAPON_CARBINERIFLE"] = {["titleWeapon"] = "IMBEL IA2", ["weaponPrice"] = 250000, ["ammoPrice"] = 180 }, 
          ["WEAPON_SPECIALCARBINE"] = {["titleWeapon"] = "SCAR-H", ["weaponPrice"] = 180000, ["ammoPrice"] = 180 },
          ["WEAPON_CARBINERIFLE_MK2"] = {["titleWeapon"] = "PARAFAL", ["weaponPrice"] = 200000, ["ammoPrice"] = 300 },
          ["WEAPON_STUNGUN"] = {["titleWeapon"] = "Taser", ["weaponPrice"] = 50000, ["ammoPrice"] = 100 },
          ["WEAPON_NIGHTSTICK"] = {["titleWeapon"] = "Cassetete", ["weaponPrice"] = 3000, ["ammoPrice"] = 100 },

      },

      ["secondaryItens"] = { -- ITENS SECUNDÁRIOS DO ARSENAL
          ["radio"] = {["index"] = "radio", ["price"] = 2000, ["buyWithBank"] = true, ["qtd"] = 1},
          ["colete"] = {["index"] = "colete", ["price"] = 10000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["shield"] = {["index"] = "shield", ["price"] = 50000, ["buyWithBank"] = true, ["qtd"] = 1},
       -- ["marmita"] = {["index"] = {[1] = "agua",[2] = "hotdog"}, ["price"] = 3000, ["qtd"] = 4},
       -- ["attatchs"] = {["index"] = "attatchs", ["price"] = 3000, ["buyWithBank"] = true, ["qtd"] = 1, ["perm"] = "rock.permissão"},
      },

    },

}

Config["locationsArsenal"] = {
    ["PM"] = {["cds"] = vector3(-1217.0, -2278.89, 14.31), ["depositCds"] = vector3(-1198.09, -2231.31, 14.31), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
    ["ROTA"] = {["cds"] = vector3(-1139.24, -2333.96, 14.61), ["depositCds"] = vector3(-1059.11, -2310.48, 21.14), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
    ["BAEP"] = {["cds"] = vector3(111.27, 6548.85, 32.5), ["depositCds"] = vector3(36.53, 6524.05, 32.5), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
    ["PRF"] = {["cds"] = vector3(2605.92, 5343.01, 47.61), ["depositCds"] = vector3(2634.64,5289.19,47.5), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
    ["CIVIL"] = {["cds"] = vector3(-928.02, -2037.94, 13.38), ["depositCds"] = vector3(-921.6, -2047.25, 13.38), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
    ["PRF2"] = {["cds"] = vector3(-2837.41, -1.35, 16.51), ["depositCds"] = vector3(-2840.07, -1.14, 16.49), ["webhook"] = ""}, -- LOCAL DO BLIP DO ARSENAL / DEPOSITAR DINHEIRO SUJO
}

return Config