--[[
	lovely-imgui V. 0.5 (beta)
	Author: Neer (https://github.com/YoungNeer/lovely-imgui)
]]

local LIB_PATH=(...)

local imgui=require(LIB_PATH..'.Core')

imgui.label=require(LIB_PATH..'.Widgets.Label')
imgui.button=require(LIB_PATH..'.Widgets.Button')
imgui.tooltip=require(LIB_PATH..'.Widgets.Tooltip')
imgui.checkBox=require(LIB_PATH..'.Widgets.CheckBox')
imgui.radioButton=require(LIB_PATH..'.Widgets.RadioButton')
imgui.image=require(LIB_PATH..'.Widgets.Image')
imgui.imageButton=require(LIB_PATH..'.Widgets.ImageButton')
imgui.scaler=require(LIB_PATH..'.Widgets.Scaler')
imgui.canvas=imgui.image

-- assetLoader=require(LIB_PATH..'.Core.assetLoader')
-- require(LIB_PATH..'.Themes.Light')


love.draw = love.draw or imgui.draw
love.mousepressed = love.mousepressed or imgui.mousepressed
love.mousereleased = love.mousereleased or imgui.mousereleased
love.mousemoved = love.mousemoved or imgui.mousemoved
love.resize = love.resize or imgui.resize

return imgui
