--[[
	Brief Music Player V1.0
	Author: Neer
	Was originally written to  the power and simplicity of lovely-imgui!
	But look what a mess I have done!
]]

imgui=require 'lib.imgui'  -- <-- Our lovely-imgui module
clove=require 'lib.clove'
euler=require 'lib.euler'
Timer=require 'lib.Timer'
gi=clove.loadImages('assets/images')
require 'override' require 'util' require 'renderer' require 'player'

imgui.noOptimize() --imgui optimizations are still buggy i guess

love.window.setTitle('Brief Music Player')
love.window.setMode(440,480,{
	minwidth=440,minheight=480,
	msaa=5,
	resizable=true,borderless=true
})

function love.load()
	music={} -- all our music go here
	current=1 -- the current music that is playing
	loadResources() --init fonts
	initPayload() --init payload for imgui widgets
	loadMusic() --TODO: load the music from music folder!
	Timer.every(1,function()
		if music[current] then
			soundSlider.value=music[current].sound:tell('seconds')
			if euler.dif(soundSlider.value,music[current].sound:getDuration())<1 then
				soundSlider.value=0
				if shuffle then randomSong()
				else nextSong() end
			end
		end
	end)
end

function love.focus(val)
	if not val then love.window.requestAttention() end
end

function love.update(dt)
	if dt>.5 then return end --we are setting window position so!!
	Timer.update(dt)
	imgui.update(dt)
	-- music[current].sound:seek(soundSlider.value,'seconds')
end

function love.draw()
	-- lg.draw(gi.image)
	renderGUI()
	imgui.draw()
end


function love.mousepressed(x,y,btn)
	imgui.mousepressed(x,y,btn)
	if btn==1 then
		if not imgui.uiState.hotItem then
			showVolumeSlider=false
			love.mouse.setCursor(love.mouse.getSystemCursor('hand'))
			windowMoving=true
		end
	end
end

function love.mousemoved(x,y,dx,dy)
	if windowMoving then
		if love.math.random(1,2)==1 or love.math.random(1,2)==1 then
			winx,winy=love.window.getPosition()
			love.window.setPosition(winx+dx,winy+dy)
		end
	else
		imgui.mousemoved(x,y,dx,dy)
	end
end

function love.mousereleased(x,y,btn)
	imgui.mousereleased(x,y,btn)
	if btn==1 then
		love.mouse.setCursor()
		windowMoving=false
	end
end