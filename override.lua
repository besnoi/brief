--[[
	This file simply contains theme-overriding functions
]]

local lg=love.graphics

-- We could @override the previous imgui theme with a custom theme
-- But i'll go for "minimal invasive surgery" (quoted from vrld)

imgui.theme.drawTooltip=function(text,x,y)
	x=x-57/2+15
	love.graphics.setColor(1,1,1)
	x=euler.constrain(x,0,love.graphics.getWidth()-57)
	love.graphics.draw(gi.tooltip,x,y-10)
	love.graphics.setFont(imgui.theme.current.font)

	love.graphics.printf(text,x,y-3,57,'center')
end

imgui.theme.drawScalerHover=function(fraction,vertical,x,y,w,h,style)
	if vertical then
		lg.setColor(.9,.9,.9)
		local sx,sy=w/gi.volumeBG:getWidth(),h/gi.volumeBG:getHeight()
		local hh=h
		w,h=w/gi.volumeBar:getWidth()+.01,h/gi.volumeBar:getHeight()
		lg.draw(gi.volumeBG,x,y,0,sx,sy)

		lg.draw(
			gi.volumeBar,x,
			y+hh*(1-fraction)-(fraction<1 and 2 or 0),
			0,
			sx,
			h*fraction>2.56 and 2.56 or h*fraction
		)
		lg.draw(gi.volumeKnob,x-2,y+hh*(1-fraction)-(fraction<1 and 2 or 0))
	else
		lg.setColor(1,1,1)
		local sx,sy=w/gi.scalerBG:getWidth(),h/gi.scalerBG:getHeight()
		w,h=w/gi.scalerBar:getWidth()+.01,h/gi.scalerBar:getHeight()
		lg.draw(gi.scalerBG,x,y,0,sx,sy)
		lg.draw(gi.scalerBar,x+1,y,0,w*fraction,sy+.25)
	end
end
imgui.theme.drawScalerPressed=function(fraction,vertical,x,y,w,h,style)
	if vertical then
		lg.setColor(.6,.6,.6)
		local sx,sy=w/gi.volumeBG:getWidth(),h/gi.volumeBG:getHeight()
		local hh=h
		w,h=w/gi.volumeBar:getWidth()+.01,h/gi.volumeBar:getHeight()
		lg.draw(gi.volumeBG,x,y,0,sx,sy)
		
		lg.draw(
			gi.volumeBar,x,
			y+hh*(1-fraction)-(fraction<1 and 2 or 0),
			0,
			sx,
			h*fraction>2.56 and 2.56 or h*fraction
		)
		lg.draw(gi.volumeKnob,x-2,y+hh*(1-fraction)-(fraction<1 and 2 or 0))
	else
		lg.setColor(.6,.6,.6)
		local sx,sy=w/gi.scalerBG:getWidth(),h/gi.scalerBG:getHeight()
		w,h=w/gi.scalerBar:getWidth()+.01,h/gi.scalerBar:getHeight()
		lg.draw(gi.scalerBG,x,y,0,sx,sy)
		lg.draw(gi.scalerBar,x+1,y,0,w*fraction,sy+.25)
	end
end
imgui.theme.drawScalerNormal=function(fraction,vertical,x,y,w,h,style)
	if vertical then
		lg.setColor(1,1,1)
		local sx,sy=w/gi.volumeBG:getWidth(),h/gi.volumeBG:getHeight()
		local hh=h
		w,h=w/gi.volumeBar:getWidth()+.01,h/gi.volumeBar:getHeight()
		lg.draw(gi.volumeBG,x,y,0,sx,sy)
		lg.draw(
			gi.volumeBar,x,
			y+hh*(1-fraction)-(fraction<1 and 2 or 0),
			0,
			sx,
			h*fraction>2.56 and 2.56 or h*fraction
		)
		lg.draw(gi.volumeKnob,x-2,y+hh*(1-fraction)-(fraction<1 and 2 or 0))

	else
		lg.setColor(.8,.8,.8)
		local sx,sy=w/gi.scalerBG:getWidth(),h/gi.scalerBG:getHeight()
		w,h=w/gi.scalerBar:getWidth()+.01,h/gi.scalerBar:getHeight()
		lg.draw(gi.scalerBG,x,y,0,sx,sy)
		lg.draw(gi.scalerBar,x+1,y,0,w*fraction,sy+.25)
	end
end
