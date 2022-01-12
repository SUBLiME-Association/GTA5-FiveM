local _context = getContext()
local _painter = _context:getPainter()
local _style = _painter:getStyle()


VeinUI.Sprite = function(dict, name, w, h)
	_context:beginDraw(w, h)

	_painter:setColor(_style.sprite.color)
	_painter:drawSprite(dict, name, w, h)

	_context:endDraw()
end
