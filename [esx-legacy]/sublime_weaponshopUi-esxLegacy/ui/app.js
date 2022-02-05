////////////////////////////////////////////////////////////////////////////////
///////////////////////////////   AFFICHAGE    /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

$(function () {
    // FERMETURE DU MENU
    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            $.post('http://sublime_weaponshopUi-esxLegacy/close', JSON.stringify({}));
        }
    });
    // AFFICHAGE DU MENU
    $(document).ready(function () {
        window.addEventListener('message', function (event) {
            var item = event.data;
            if (item.display == true) {
                if (item.licence) {
                    $('.container').css('display', 'block');
                    $('.ammunation-licence').css('display', 'none');
                } else {
                    $('.container').css('display', 'block');
                    $('.ammunation-licence').css('display', 'block');
                }

            } else if (item.display == false) {
                $('.container').css('display', 'none');
            }
        });
    });
});


////////////////////////////////////////////////////////////////////////////////
////////////////////////////   CONFIGURATION    ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// PRIX LICENCE
let licencePrice = 25000;

// LISTE DES ARMES
var weapon_list = {
    pistol: {
        item: 'pistol',
        label: 'Pistolet',
        price: 15000,
        count: 1,
        restricted: true,
        picture: 'img/pistol.png',
    },

    dagger: {
        item: 'dagger',
        label: 'Dague',
        price: 5000,
        count: 1,
        restricted: false,
        picture: 'img/dagger.png',
    },

    knife: {
        item: 'knife',
        label: 'Couteau',
        price: 4500,
        count: 1,
        restricted: false,
        picture: 'img/knife.png',
    },

    hammer: {
        item: 'hammer',
        label: 'Marteau',
        price: 3000,
        count: 1,
        restricted: false,
        picture: 'img/hammer.png',
    },

    bat: {
        item: 'bat',
        label: 'Batte de baseball',
        price: 3500,
        count: 1,
        restricted: false,
        picture: 'img/bat.png',
    },

    knuckle: {
        item: 'knuckle',
        label: 'Poing Américain',
        price: 4500,
        count: 1,
        restricted: false,
        picture: 'img/knuckle.png',
    },

    fireextinguisher: {
        item: 'fireextinguisher',
        label: 'Extincteur',
        price: 1000,
        count: 1,
        restricted: false,
        picture: 'img/fireextinguisher.png',
    },

    snspistol: {
        item: 'snspistol',
        label: 'Pistolet SNS',
        price: 13500,
        count: 1,
        restricted: true,
        picture: 'img/snspistol.png',
    },

    // skin: {
    //     item: 'skin',
    //     label: 'Camouflage',
    //     price: 2000,
    //     count: 1,
    //     restricted: false,
    //     picture: 'img/skin.png',
    // },

    // kevlar: {
    //     item: 'kevlar',
    //     label: 'Kevlar',
    //     price: 7000,
    //     count: 1,
    //     restricted: false,
    //     picture: 'img/kevlar.png',
    // },

    flashlight: {
        item: 'flashlight',
        label: 'Torche',
        price: 1000,
        count: 1,
        restricted: false,
        picture: 'img/flashlight.png',
    },

    pistol_ammo: {
        item: 'pistol_ammo',
        label: '30 Balles',
        price: 500,
        count: 30,
        restricted: false,
        picture: 'img/bullet.png',
    },
}


////////////////////////////////////////////////////////////////////////////////
///////////////////////   AFFICHER TOUTES LES ARMES    /////////////////////////
////////////////////////////////////////////////////////////////////////////////

function show_weapon_list() {
    $('#weapon_list').empty();
    $.each(weapon_list, function (key, value) {
        $('#weapon_list').append(
            '<div class="item" id="' + value.item + '">' +
            '<img src="' + value.picture + '" class="weapon_picture">' +
            '<div class="weapon_label">' + value.label + '</div>' +
            '<div class="weapon_price">' + value.price + '$</div>' +
            '</div>'
        );
    });
}

show_weapon_list();


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////   BUY WEAPON    //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
function buy_weapon(weapon) {
    $.post('http://sublime_weaponshopUi-esxLegacy/sublime_weaponshopUi-esxLegacy:buy', JSON.stringify(weapon));
}

// ACHAT D'UNE ARME PAR LE CLIQUE SUR LE BOUTON
$(document).on('click', '.item', function () {
    buy_weapon(weapon_list[$(this).attr('id')]);
});


////////////////////////////////////////////////////////////////////////////////
//////////////////////////   BUY LICENCE    ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

function buy_licence(licencePrice) {
    $.post('http://sublime_weaponshopUi-esxLegacy/sublime_weaponshopUi-esxLegacy:buyLicence', JSON.stringify({ licencePrice: licencePrice }));
}

// ACHAT D'UNE LICENCE PAR LE CLIQUE SUR LE BOUTON
$(document).on('click', '.btn-licence', function () {
    buy_licence(licencePrice);
    $('.ammunation-licence').css('display', 'none');
});


// Copyright (c) 2022 Sublime //
