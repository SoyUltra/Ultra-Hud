

window.addEventListener("message", function(event) {
    var v = event.data 
    var vida = new ldBar("#vidaiconB")
    var armor = new ldBar("#vestB")
    var stamina = new ldBar("#runB")
    var comida = new ldBar("#burgerB")
    var agua = new ldBar("#waterB")
    var co2 = new ldBar("#oxyB")
    var gaso = new ldBar("#carhudjs")

    switch (v.action) {

        // Show Car Hud
        case "showCarhud":
            gaso.set(v.gasolina, true)
            $('.callejs').html(v.street)
            if (v.cinturon == true) {
                $('.beltjs').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940141783168483378/belt2.png')
            } else if(v.cinturon == false) {
                $('.beltjs').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940141782774190130/belt.png')
            }

            if (v.bateria == true) {
                $('.motorON').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940141782203760650/motor2.png')
            } else if(v.bateria == false) {
                $('.motorON').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940141781742395432/motor.png')
            }
            $('.speedjs').html(Math.round(v.vel.toFixed(2)))
            if (v.gasolina < 20) {
                $('.gasjs').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940144134205874196/gasolina2.png')
                $('#carhudjs path.mainline').css({'stroke':'#fa0000'})
            } else {
                $('.gasjs').attr('src', 'https://cdn.discordapp.com/attachments/932530461970956310/940143954853265488/gasolina.png')
                $('#carhudjs path.mainline').css({'stroke':'#00ADFA'})
            }
            $('.gasolinajs').html(Math.round(v.gasolina)+'%')
            if (v.vel >= 10 && v.vel <=100 ) {
                $('.hideHUD').show()
                $('.hideHUD').html('0'+Math.round(v.vel.toFixed(2)))
            } else if (v.vel >= 100) {
                $('.hideHUD').html(Math.round(v.vel.toFixed(2)))
                $('.hideHUD').hide()
            } else {
                $('.hideHUD').show()
                $('.hideHUD').html('00')
            }
            $('.motorjs').html(Math.round(v.vidav)+'%')
            $('.mapa').fadeIn(100)
            $('.carHUD').fadeIn(100)
            $('.calle').fadeIn(100)
            $('.CarIMG').fadeIn(100)
        break;

        // Hide Car Hud

        case "hideCarhud":
            $('.mapa').fadeOut(100)
            $('.carHUD').fadeOut(100)
            $('.calle').fadeOut(100)
            $('.CarIMG').fadeOut(100)
        break;

        // Status
        case "updateStatus":
            $('.UltraHud').show()
            $('.logoprueba').attr('src', v.logo)
            $('.pedOline').html(' '+v.pall+'/'+v.maxPlayers+'');
            $('.pedID').html(' ID: '+v.pid)
            vida.set(v.health, true)
            $('.vidajs').html(v.health+'%')
            armor.set(v.armor, true)
            $('.vestjs').html(v.armor+'%')
            stamina.set(v.stamina, true)
            $('.runjs').html(Math.round(v.stamina)+'%')
            comida.set(v.hunger, true)
            $('.burgerjs').html(Math.round(v.hunger)+'%')
            agua.set(v.thirst, true)
            $('.waterjs').html(Math.round(v.thirst)+'%')
            co2.set(v.oxigen, true)
            $('.oxyjs').html(Math.round(v.oxigen)+'%')
        break;

        case "ShowAllHud":
            $('.UltraHud').show(300)
        break;
        
        case "hideAllHud":
            $('.UltraHud').hide(300)
        break;

        case  "updateAmmo":
            $('.ammo').show()
            $('.ammojs').html('Ammo <span style="color: #00abe4;">'+v.ammohand+'/'+v.ammo+'</span>')
        break;

        // Hide ammo
        case "hideAmmo":
            $('.ammo').hide()
        break;
        
    }
        if (event.data.talking == true) 
         {
            $('.voicejs').attr("src","https://cdn.discordapp.com/attachments/932530461970956310/940126045795930192/Micro2.png")
         }
         else if (event.data.talking == false)
         {
            $('.voicejs').attr("src","https://cdn.discordapp.com/attachments/932530461970956310/940126046404100127/Micro1.png")
         }
    
});

 
    