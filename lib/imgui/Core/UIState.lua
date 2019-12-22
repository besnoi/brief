--[[
	ImGUI needs window-dimensions, cursor-positon, etc
	So UIState stores all these information!
]]

local UIState={
	mouseX,
	mouseY,
	scrollDX,
	scrollDY,
	mouseUp,   --meant to be used externally through an interface!
	mouseDown,  --used internally
	hotItem,
	activeItem,
	lastActiveItem,
	winWidth,
	winHeight
}

return UIState