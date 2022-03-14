




_Admin.ApparenceList = {
    -- type 1 = GetNumberOfPedDrawableVariations
    -- type 2 = GetNumberOfPedTextureVariations
    -- type 3 = GetNumHeadOverlayValues
    -- type 4 = GetNumberOfPedPropDrawableVariations
    -- type 5 = GetNumHairColors
    -- type 6 = qty maxData
    -- type 7 = GetNumberOfPedPropTextureVariations

    {label = "Cheveux 1", model = "hair_1", index = 1, remove = 1, type = 1, componentId = 2}; --1
    {label = "Cheveux 2", model = "hair_2", index = 1, remove = 1, type = 2, componentId = 2, drawableId = 1};--2 
    {label = "Couleur cheveux 1", model = "hair_color_1", index = 1, remove = 1, type = 5, componentId = nil};--3
    {label = "Couleur cheveux 2", model = "hair_color_2", index = 1, remove = 1, type = 5, componentId = nil};--4

    {label = "Type barbe", model = "beard_1", index = 1, remove = 1, type = 3, componentId = 1}; --5
    {label = "Opacité barbe", model = "beard_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --6
    {label = "Couleur barbe 1", model = "beard_3", index = 1, remove = 1, type = 5, componentId = nil}; --7
    {label = "Couleur barbe 2", model = "beard_4", index = 1, remove = 1, type = 5, componentId = nil}; --8

    {label = "Opacité maquillage", model = "makeup_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --9
    {label = "Type maquillage", model = "makeup_1", index = 1, remove = 1, type = 3, componentId = 4}; --10
    {label = "Couleur maquillage 1", model = "makeup_3", index = 1, remove = 1, type = 5, componentId = nil}; --11
    {label = "Couleur maquillage 2", model = "makeup_4", index = 1, remove = 1, type = 5, componentId = nil}; --12

    {label = "Opacité rousseur", model = "moles_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --13
    {label = "Taches de rousseur", model = "moles_1", index = 1, remove = 1, type = 3, componentId = 9}; --14

    {label = "Opacité rougeur", model = "blush_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --15
    {label = "Type Rougeur", model = "blush_1", index = 1, remove = 1, type = 3, componentId = 5}; --16
    {label = "Couleur rougeur", model = "blush_3", index = 1, remove = 1, type = 5, componentId = nil}; --17

    {label = "Épaisseur rides", model = "age_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --18
    {label = "Type rides", model = "age_1", index = 1, remove = 1, type = 3, componentId = 3}; --19

    {label = "Épaisseur rouge a lèvres", model = "lipstick_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --20
    {label = "Type rouge à lèvres", model = "lipstick_1", index = 1, remove = 1, type = 3, componentId = 8}; --21
    {label = "Couleur rouge a lèvres 1", model = "lipstick_3", index = 1, remove = 1, type = 5, componentId = nil}; --22
    {label = "Couleur rouge a lèvres 2", model = "lipstick_4", index = 1, remove = 1, type = 5, componentId = nil}; --23

    {label = "Opacité sourcils", model = "eyebrows_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --24
    {label = "Type sourcils", model = "eyebrows_1", index = 1, remove = 1, type = 3, componentId = 2}; --25
    {label = "Couleur sourcils 1", model = "eyebrows_3", index = 1, remove = 1, type = 5, componentId = nil}; --26
    {label = "Couleur sourcils 2", model = "eyebrows_4", index = 1, remove = 1, type = 5, componentId = nil}; --27
    {label = "Hauteur sourcils", model = "eyebrows_5", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --28
    {label = "Profondeur sourcils", model = "eyebrows_6", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --29
    {label = "Couleur yeux", model = "eye_color", index = 1, remove = 1, type = 6, componentId = nil, maxData = 31}; --30
    {label = "Loucher des yeux", model = "eye_squint", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --31

    {label = "Largeur du nez", model = "nose_1", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --32
    {label = "Hauteur du pic du nez", model = "nose_2", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --33
    {label = "Pointe de nez", model = "nose_3", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --34
    {label = "Hauteur de l\'os du nez", model = "nose_4", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --35
    {label = "Pointe du nez", model = "nose_5", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --36
    {label = "Torsion de l\'os du nez", model = "nose_6", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --37

    {label = "Hauteur des pommettes", model = "cheeks_1", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --38
    {label = "Largeur des pommettes", model = "cheeks_2", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --39
    {label = "Largeur des joues", model = "cheeks_3", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --40
    {label = "Plénitude des lèvres", model = "lip_thickness", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --41

    {label = "Largeur de la Mâchoire", model = "jaw_1", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --42
    {label = "Longueur mâchoire", model = "jaw_2", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --43

    {label = "Hauteur du menton", model = "chin_1", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --44
    {label = "Longueur du menton", model = "chin_2", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --45
    {label = "Largeur du menton", model = "chin_3", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --46
    {label = "Taille du trou du menton", model = "chin_4", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --47
    {label = "Épaisseur du cou", model = "neck_thickness", index = 1, remove = 10, type = 6, componentId = nil, maxData = 10}; --48

    {label = "Opacité Pillositée Torse", model = "chest_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --49
    {label = "Pillositée Torse", model = "chest_1", index = 1, remove = 1, type = 3, componentId = 10}; --50
    {label = "Couleur pillositée", model = "chest_3", index = 1, remove = 1, type = 5, componentId = nil}; --51

    {label = "Opacité imperfections", model = "bodyb_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --52
    {label = "Imperfections du corps", model = "bodyb_1", index = 1, remove = 1, type = 3, componentId = 11}; --53
    {label = "Bodyb Extra Opacité", model = "bodyb_3", index = 1, remove = 1, type = 3, componentId = 12}; --54
    {label = "Body Extra", model = "bodyb_4", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --55

    {label = "Opacité des Boutons", model = "blemishes_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --56
    {label = "Type boutons", model = "blemishes_1", index = 1, remove = 1, type = 3, componentId = 0}; --57
    {label = "Opacité Dommages UV", model = "sun_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --58
    {label = "Dommages UV", model = "sun_1", index = 1, remove = 1, type = 3, componentId = 7}; --59

    {line = true}; --60

    {label = "Torse 1", model = "torso_1", index = 1, remove = 1, type = 1, componentId = 11}; --61
    {label = "Torse 2", model = "torso_2", index = 1, remove = 1, type = 2, componentId = 11, drawableId = 61}; --62

    {label = "T-Shirt 1", model = "tshirt_1", index = 1, remove = 1, type = 1, componentId = 8}; --63
    {label = "T-Shirt 2", model = "tshirt_2", index = 1, remove = 1, type = 2, componentId = 8, drawableId = 63}; --64

    {label = "Bras 1", model = "arms", index = 1, remove = 1, type = 1, componentId = 3}; --65
    {label = "Bras 2", model = "arms_2", index = 1, remove = 1, type = 6, componentId = nil, maxData = 10}; --66

    {label = "Jambes 1", model = "pants_1", index = 1, remove = 1, type = 1, componentId = 4}; --67
    {label = "Jambes 2", model = "pants_2", index = 1, remove = 1, type = 2, componentId = 4, drawableId = 67}; --68

    {label = "Chaussures 1", model = "shoes_1", index = 1, remove = 1, type = 1, componentId = 6}; --69
    {label = "Chaussures 2", model = "shoes_2", index = 1, remove = 1, type = 2, componentId = 6, drawableId = 69}; --70
    
    {label = "Calques 1", model = "decals_1", index = 1, remove = 1, type = 1, componentId = 10}; --71
    {label = "Calques 2", model = "decals_2", index = 1, remove = 1, type = 2, componentId = 10, drawableId = 71}; --72

    {label = "Kevlar 1", model = "bproof_1", index = 1, remove = 1, type = 1, componentId = 9}; --73
    {label = "Kevlar 2", model = "bproof_2", index = 1, remove = 1, type = 2, componentId = 9, drawableId = 73}; --74

    {label = "Chaine 1", model = "chain_1", index = 1, remove = 1, type = 1, componentId = 7}; --75
    {label = "Chaine 2", model = "chain_2", index = 1, remove = 1, type = 2, componentId = 7, drawableId = 75}; --76

    {label = "Lunettes 1", model = "glasses_1", index = 1, remove = 1, type = 4, componentId = 1}; --77
    {label = "Lunettes 2", model = "glasses_2", index = 1, remove = 1, type = 7, componentId = 1, drawableId = 77}; --78

    {label = "Montre 1", model = "watches_1", index = 1, remove = 1, type = 4, componentId = 6}; --79
    {label = "Montre 2", model = "watches_2", index = 1, remove = 1, type = 7, componentId = 6, drawableId = 79}; --80

    {label = "Bracelet 1", model = "bracelets_1", index = 1, remove = 1, type = 4, componentId = 7}; --81
    {label = "Bracelet 2", model = "bracelets_1", index = 1, remove = 1, type = 7, componentId = 7, drawableId = 81}; --82

    {label = "Oreilles 1", model = "ears_1", index = 1, remove = 1, type = 4, componentId = 7}; --83
    {label = "Oreilles 2", model = "ears_2", index = 1, remove = 1, type = 7, componentId = 7, drawableId = 83}; --84

    {label = "Casque 1", model = "helmet_1", index = 1, remove = 1, type = 4, componentId = 0}; --85
    {label = "Casque 2", model = "helmet_2", index = 1, remove = 1, type = 7, componentId = 0, drawableId = 85}; --86

    {label = "Sac 1", model = "bags_1", index = 1, remove = 1, type = 1, componentId = 5}; --87
    {label = "Sac 2", model = "bags_2", index = 1, remove = 1, type = 2, componentId = 5, drawableId = 87}; --88

}



_Admin.PedList = {
    {label = "Gros zizi à l'air",   name = "a_m_m_acult_01"},
    {label = "Gros black toufu",    name = "a_m_m_afriamer_01"},
    {label = "Stock black torse nu",name = "a_m_m_beach_01"},
    {label = "Jaune pâle en short", name = "a_m_m_beach_02"},
    {label = "Beach",               name = "a_f_m_beach_01"},
    {label = "Bevhills",            name = "a_f_m_bevhills_01"},
    {label = "Bevhills2 ",          name = "a_f_m_bevhills_02"},
    {label = "BodyBuild",           name = "a_f_m_bodybuild_01"},                
    {label = "Business",            name = "a_f_m_business_02"},             
    {label = "DownTown",            name = "a_f_m_downtown_01"},  
    {label = "Eastsa",              name = "a_f_m_eastsa_01"},                   
    {label = "Eastsa2",             name = "a_f_m_eastsa_02"},    
    {label = "FatBlack",            name = "a_f_m_fatbla_01"},
    {label = "FatWhite",            name = "a_f_m_fatwhite_01"},              
    {label = "FatCult",             name = "a_f_m_fatcult_01"},                          
    {label = "Ktown",               name = "a_f_m_ktown_01"},                        
    {label = "Ktown2",              name = "a_f_m_ktown_02"},                       
    {label = "Prolhost",            name = "a_f_m_prolhost_01"},
    {label = "Salton",              name = "a_f_m_salton_01"},                       
    {label = "Skidrow",             name = "a_f_m_skidrow_01"},
    {label = "Sanglier",            name = "a_c_boar"},
    {label = "Chat",                name = "a_c_cat_01"},          
    {label = "Singe",               name = "a_c_chimp"}, 
    {label = "Rhesus",              name = "a_c_rhesus"},                     
    {label = "Vache",               name = "a_c_cow"},
    {label = "Coyote",              name = "a_c_coyote"},          
    {label = "Chevreuil",           name = "a_c_deer"},              
    {label = "Cochon",              name = "a_c_pig"},
    {label = "Caniche",             name = "a_c_poodle"},
    {label = "Mini pitbull",        name = "a_c_pug"},
    {label = "Lapin",               name = "a_c_rabbit_01"},
    {label = "Rat",                 name = "a_c_rat"},            
    {label = "Poulet",              name = "a_c_hen"},                                 
    {label = "Hirondelle",          name = "a_c_seagull"},
    {label = "Pigeon",              name = "a_c_pigeon"},
    {label = "Corbeau",             name = "a_c_crow"},
    {label = "Canard",              name = "a_c_cormorant"},
    {label = "Aigle",               name = "a_c_chickenhawk"},
    {label = "Dauphin",             name = "a_c_dolphin"},
    {label = "Poisson",             name = "a_c_fish"},
    {label = "Orc",                 name = "a_c_killerwhale"},
    {label = "Requin marteau",      name = "a_c_sharkhammer"},
    {label = "Baleine",             name = "a_c_humpback"},
    {label = "Stingray",            name = "a_c_stingray"},

}