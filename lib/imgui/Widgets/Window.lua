--[[
	Even if a program doesn't have any widget it'd still have
	a window!!
	Window can refer to the program window or the user-created
	window (also called frame!)
]]


--The first element in the stack will always be root window!
local stack={
	--The Window will house all the widgets
	{x=0,y=0,widgets={}}
}
stack[1].width,stack[1].height=love.graphics.getDimensions()

local Window={stack=stack}

--Get the top-left most point (origin) of the window!
Window.getTopLeft=function()
	return stack[#stack].x,stack[#stack].y
end

--Get the dimensions of the window!
Window.getTopDimensions=function()
	return stack[#stack].width,stack[#stack].height
end

--Gets the bottom-right most point of the window
Window.getBottomRight=function()
	local w,h=Window.getTopDimensions()
	return stack[#stack].x+w,stack[#stack].y+h
end

--Gets the center of the window!
Window.getCenter=function()
	local w,h=Window.getTopDimensions()
	return w/2,h/2
end

Window.getOrigin=Window.getTopLeft
Window.getCenterX=Window.getCenter
Window.getCenterY=function() return select(2,Window.getCenter()) end
Window.getTop=function() return select(2,Window.getTopLeft()) end
Window.getLeft=Window.getTopLeft
Window.getBottom=function() return select(2,Window.getBottomRight()) end
Window.getRight=Window.getBottomRight


return Window