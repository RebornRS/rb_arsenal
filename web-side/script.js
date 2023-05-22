var myWeapons
let boxShow 
$(document).ready(function(){

    window.addEventListener("message",function(event){
        let data = event.data
        switch (data.action) {
            case 'openMenu':
                arsenal.open(data.configWeapons,data.configSecondary,data.myWeapons,data.bank,data.weaponsDatabase)
            break
        }
    })

    window.addEventListener("keydown", function(event) {
        if(event.code == "Escape"){
            arsenal.close()
        }
     })
}) 

const arsenal = {

    open : (weaponsList,secondarylist,weapons,bank,weaponsDatabase) =>{

        $(".painel-central").fadeIn(500)
        $(".painel-central .firt-menu .weapons-list").empty()
        $(".painel-central .final-menu .center-box").empty()
        myWeapons = weapons
        for([k,v] of Object.entries(weaponsList)){
            $(".painel-central .firt-menu .weapons-list").append(`
                <div class="box" data-weapon="${k}" data-bank="${bank}" onclick="arsenal.selectWeapon(this)">
                    <div class="title-box">
                        <span>${v.titleWeapon}</span>
                        <small>ESTOQUE:${weaponsDatabase[k]||0}</small>
                    </div>

                    <div class="weapon-image">
                        <img src="https://guarulhosinfinity.hadeslab.com.br/itens/${k}.png" alt="">
                    </div>

                    <div class="price-weapon">${v.weaponPrice}</div>
                </div>
            `)
        }

        for([k,v] of Object.entries(secondarylist)){
            $(".painel-central .final-menu .center-box").append(`
                <div class="buttons" data-item="${k}" onclick="arsenal.selectItem(this)">
                    <img src="assets/images/${k}.png" alt="">
                    <span style="text-transform:uppercase;">${k}</span>
                </div>
            `)
        }

    },

    selectWeapon: (data) =>{
        arsenal.showInfos(data.dataset.weapon,data.dataset.bank)
    },

    showInfos: (weapon,bank) =>{
        boxShow = ""
        $(".center-menu").empty()
        $(".center-menu").show()
        $(".center-menu").html(`
            <div class="title-menu">ARSENAL</div>
            <img src="https://guarulhosinfinity.hadeslab.com.br/itens/${weapon}.png" alt="">
            <div class="footer">SALDO EM BANCO DA CORPORAÇÃO: $${bank},00</div>
        `)

        $.post("https://rb_arsenal/checkStock",JSON.stringify({weapon:weapon}), (data) => {

            if(myWeapons && myWeapons[weapon]){

                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.giveBack(this)" id="buttonYellow">
                        <img src="assets/images/download.png" alt="">
                        <span>DEVOLVER</span>
                    </div>

                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyAmmo(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>MUNIÇÃO</span>
                    </div>

                `

            }else{
                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.getWeapon(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>RESGATAR</span>
                    </div>
                `
            }

            $(".final-menu .final-box").html(`
                ${boxShow}

                <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyWeapon(this)" id="buttonGreen">
                    <img src="assets/images/buy.png" alt="">
                    <span>COMPRAR</span>
                </div>
            `)
            $(".final-menu .final-box").fadeIn(500)


        })

    },


    buyAmmo: (data) => {

        let weapon = data.dataset.weapon
        $(".painel-central").fadeOut(500)

        $.post("https://rb_arsenal/buyAmmo",JSON.stringify({weapon:weapon}),(data) =>{

            if(data.myWeapons && data.myWeapons[weapon]){

                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.giveBack(this)" id="buttonYellow">
                        <img src="assets/images/download.png" alt="">
                        <span>DEVOLVER</span>
                    </div>

                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyAmmo(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>MUNIÇÃO</span>
                    </div>
                `

            }else{
                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.getWeapon(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>RESGATAR</span>
                    </div>
                `
            }

            $(".final-menu .final-box").html(`
                ${boxShow}

                <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyWeapon(this)" id="buttonGreen">
                    <img src="assets/images/buy.png" alt="">
                    <span>COMPRAR</span>
                </div>
            `)

            $(".painel-central").fadeIn(500)

        })


    },


    getWeapon:(data) =>{
        let weapon = data.dataset.weapon
        $(".painel-central").fadeOut(500)

        $.post("https://rb_arsenal/getWeapon",JSON.stringify({weapon:weapon}),(data) =>{

            if(data.myWeapons && data.myWeapons[weapon]){

                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.giveBack(this)" id="buttonYellow">
                        <img src="assets/images/download.png" alt="">
                        <span>DEVOLVER</span>
                    </div>

                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyAmmo(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>MUNIÇÃO</span>
                    </div>
                `

            }else{
                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.getWeapon(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>RESGATAR</span>
                    </div>
                `
            }

            $(".final-menu .final-box").html(`
                ${boxShow}

                <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyWeapon(this)" id="buttonGreen">
                    <img src="assets/images/buy.png" alt="">
                    <span>COMPRAR</span>
                </div>
            `)
            arsenal.updateStock()
            $(".painel-central").fadeIn(500)

        })

    },

    giveBack:(data) =>{
        let weapon = data.dataset.weapon
        $(".painel-central").fadeOut(500)

        $.post("https://rb_arsenal/giveBack",JSON.stringify({weapon:weapon}),(data) =>{

            if(data.myWeapons && data.myWeapons[weapon]){

                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.giveBack(this)" id="buttonYellow">
                        <img src="assets/images/download.png" alt="">
                        <span>DEVOLVER</span>
                    </div>

                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyAmmo(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>MUNIÇÃO</span>
                    </div>
                `

            }else{
                boxShow = `
                    <div class="buttons" data-weapon="${weapon}" onclick="arsenal.getWeapon(this)" id="buttonGreen">
                        <img src="assets/images/download.png" alt="">
                        <span>RESGATAR</span>
                    </div>
                `
            }

            $(".final-menu .final-box").html(`
                ${boxShow}

                <div class="buttons" data-weapon="${weapon}" onclick="arsenal.buyWeapon(this)" id="buttonGreen">
                    <img src="assets/images/buy.png" alt="">
                    <span>COMPRAR</span>
                </div>
            `)
            arsenal.updateStock()
            $(".painel-central").fadeIn(500)

        })

    },

    buyWeapon:(data) =>{

        let weapon = data.dataset.weapon
        $(".painel-central").fadeOut(500)
        $.post("https://rb_arsenal/buyWeapon",JSON.stringify({weapon:weapon}), (data) =>{
            arsenal.updateStock()
            $(".painel-central").fadeIn(500)
        })

    },

    updateStock: () => {
        $.post("https://rb_arsenal/updateStock",JSON.stringify({}), (data) => {

            $(".center-menu .footer").attr(`SALDO EM BANCO DA CORPORAÇÃO: $${data.bank},00`)

            $(".painel-central .firt-menu .weapons-list").empty()
            for([k,v] of Object.entries(data.weaponsList)){
                $(".painel-central .firt-menu .weapons-list").append(`
                    <div class="box" data-weapon="${k}" data-bank="${data.bank}" onclick="arsenal.selectWeapon(this)">
                        <div class="title-box">
                            <span>${v.titleWeapon}</span>
                            <small>ESTOQUE:${data.weaponsDatabase[k]||0}</small>
                        </div>
    
                        <div class="weapon-image">
                            <img src="https://guarulhosinfinity.hadeslab.com.br/itens/${k}.png" alt="">
                        </div>
    
                        <div class="price-weapon">${v.weaponPrice}</div>
                    </div>
                `)
            }
        })
    },


    selectItem: (data) => {

        let item = data.dataset.item
        $(".painel-central").fadeOut(500)
        $.post("https://rb_arsenal/buyItem",JSON.stringify({item:item}), (data) =>{
            $(".painel-central").fadeIn(500)
        })
    },

    showTales: () =>{


    },

    close: () =>{
        $(".painel-central").fadeOut(500)
        $(".final-menu .final-box").empty(500)
        $(".center-menu").fadeOut(500)
        $.post("https://rb_arsenal/closeArsenal",JSON.stringify())
    }
    
}