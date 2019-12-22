--[[
	This draws the Scaler at a relative/absolute position!
	A Scaler is different than a slider in that it doesn't have
	a "thumb"! It also doesn't have to worry about slide-increments
	and stuff like that!
	Scaler can be horizontal or vertical! Orientation is something
	left for themes to implement on their own! By default the orientation
	is either right-to-left or top-to-down.
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Scaler(scaler,x,y,w,h)
	if core.idle then return end
	local id=core.genID()

	x,y,w,h=util.getScalerParams(scaler,x,y,w,h)

	--Normalize the value of the scaler!
	local fraction = (scaler.value - scaler.min) / (scaler.max - scaler.min)
	core.pianoMode=not core.pianoMode
	core.updateWidget(id,util.mouseOver(x,y,w,h))
	core.pianoMode=not core.pianoMode

	-- local
	if uiState.activeItem==id then
		if scaler.vertical then
			fraction = math.min(1, math.max(0, (uiState.mouseY - y) / h))
			-- fraction = math.max(1, math.min(0, -(uiState.mouseY - y) / h))
		else
			fraction = math.min(1, math.max(0, (uiState.mouseX - x) / w))
		end
		DrawCommands.registerCommand(function()
			theme.drawScalerPressed(fraction,scaler.vertical,x,y,w,h,scaler.style)
		end)
		local v = fraction * (scaler.max - scaler.min) + scaler.min
		if v ~= scaler.value then
			scaler.value = v
			return true
		end
	elseif uiState.hotItem==id then
		DrawCommands.registerCommand(function()
			theme.drawScalerHover(fraction,scaler.vertical,x,y,w,h,scaler.style)
		end)
	else
		DrawCommands.registerCommand(function()
			theme.drawScalerNormal(fraction,scaler.vertical,x,y,w,h,scaler.style)
		end)
	end
end

return Scaler