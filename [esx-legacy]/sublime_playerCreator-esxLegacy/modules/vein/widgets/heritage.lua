local _context = getContext()
local _painter = _context:getPainter()
local _style = _painter:getStyle()

local Heritage = {
    Background = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "mumdadbg", Width = 0.208, Height = 0.228 },
    Mum = { Dictionary = "char_creator_portraits", Width = 0.128, Height = 0.128 },
    Dad = { Dictionary = "char_creator_portraits", Width = 0.128, Height = 0.028 },
}


VeinUI.Heritage = function(Mum, Dad)
    if Mum < 0 or Mum > 21 then
        Mum = 0
    end
    if Dad < 0 or Dad > 23 then
        Dad = 0
    end
    if Mum == 21 then
        Mum = "special_female_" .. (tonumber(string.sub(Mum, 2, 2)) - 1)
    else
        Mum = "female_" .. Mum
    end
    if Dad >= 21 then
        Dad = "special_male_" .. (tonumber(string.sub(Dad, 2, 2)) - 1)
    else
        Dad = "male_" .. Dad
    end

    _painter:drawSprite(Heritage.Background.Dictionary, Heritage.Background.Texture, Heritage.Background.Width, Heritage.Background.Height)
    _painter:drawSprite(Heritage.Dad.Dictionary, Dad, Heritage.Mum.Width, Heritage.Mum.Height)
    _painter:drawSprite(Heritage.Mum.Dictionary, Mum, Heritage.Dad.Width, Heritage.Dad.Height)

    _context:endDraw()

end