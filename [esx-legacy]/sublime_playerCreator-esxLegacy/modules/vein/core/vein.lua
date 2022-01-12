local _context = context.new()

local _painter = _context:getPainter()

function getContext()
	return _context
end



VeinUI.setDebugEnabled = function(enabled)
	_context:setDebugEnabled(enabled)
end

VeinUI.isDebugEnabled = function(enabled)
	return _context:isDebugEnabled()
end

VeinUI.setNextWindowNoDrag = function(isNoDrag)
	_context:setNextWindowNoDrag(isNoDrag)
end

VeinUI.beginWindow = function(x, y)
	_context:beginWindow(x, y)
end

VeinUI.endWindow = function()
	return _context:endWindow()
end

VeinUI.isWidgetHovered = function()
	return _context:isWidgetHovered()
end

VeinUI.isWidgetClicked = function()
	return _context:isWidgetClicked()
end

VeinUI.beginRow = function()
	_painter:beginRow()
end

VeinUI.endRow = function()
	_painter:endRow()
end

VeinUI.setNextTextEntry = function(entry, ...)
	_context:setNextTextEntry(entry, ...)
end

VeinUI.pushTextEntry = function(entry, ...)
	_context:pushTextEntry(entry, ...)
end

VeinUI.popTextEntry = function()
	_context:popTextEntry()
end

VeinUI.setNextWidgetWidth = function(w)
	_context:setNextWidgetWidth(w)
end

VeinUI.pushWidgetWidth = function(w)
	_context:pushWidgetWidth(w)
end

VeinUI.popWidgetWidth = function()
	_context:popWidgetWidth()
end

VeinUI.setDarkColorTheme = function()
	_painter:getStyle():setDarkColorTheme()
end

VeinUI.setLightColorTheme = function()
	_painter:getStyle():setLightColorTheme()
end
