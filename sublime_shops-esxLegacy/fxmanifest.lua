fx_version 'adamant'
game 'gta5'
author 'SUP2Ak'
description 'sublime_shops'
version 'legacy'


shared_script '@es_extended/imports.lua'
client_scripts {
	--lib RageUI
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/Audio.lua",
    "src/components/Enum.lua",
    "src/components/Keys.lua",
    "src/components/Rectangle.lua",
    "src/components/Sprite.lua",
    "src/components/Text.lua",
    "src/components/Visual.lua",
    "src/menu/elements/ItemsBadge.lua",
    "src/menu/elements/ItemsColour.lua",
    "src/menu/elements/PanelColour.lua",
    "src/menu/items/UIButton.lua",
    "src/menu/items/UICheckBox.lua",
    "src/menu/items/UIList.lua",
    "src/menu/items/UISeparator.lua",
    "src/menu/items/UISlider.lua",
    "src/menu/items/UISliderHeritage.lua",
    "src/menu/items/UISliderProgress.lua",
    "src/menu/panels/UIColourPanel.lua",
    "src/menu/panels/UIGridPanel.lua",
    "src/menu/panels/UISliderPanel.lua",
    "src/menu/panels/UIPercentagePanel.lua",
    "src/menu/panels/UIStatisticsPanel.lua",   
    "src/menu/windows/UIHeritage.lua",
    --main--
    'function.lua',
	'config/config.lua',
    'config/config.npc.lua',
    'client/client.lua',
}
server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	--
    'function.lua',
    'config/config.lua',
    'config/config.npc.lua',
    'server/server.lua',
}

dependency {'es_extended'}