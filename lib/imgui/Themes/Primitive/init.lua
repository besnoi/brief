--[[
	The thing about primitive theme is that it's more efficient!
]]

local ASSETS_PATH=(...):gsub('[.]','/')..'/assets/'

local theme={}
local lg,ef=love.graphics,function() end

theme.update=ef

local nc,hc,ac={.5,.5,.5},{.55,.55,.55},{.45,.45,.45}

--For Primitive theme, all widgets will have same color palette!
theme.normalColor=nc
theme.hotColor=hc
theme.activeColor=ac

-- For Primitive Theme, all widgets will have same font but you can change this if you like!
theme.font=lg.newFont(ASSETS_PATH..'roboto.ttf',15)

--[[
	Widgets can have different fonts but as a rule they must have
	the same font across different states (hovered,clicked,etc)
	getFontSize takes in the type of the widget and the text
	and returns the minimum-size that is required by that text!
	[Themes can be malice and return a greater or lower size!]
]]

function theme.getFontSize(widget,text)
	local w,h=theme.font:getWidth(text),theme.font:getHeight()
	if widget=='button' then
		w,h=w+50,h+30
	end
	return w,h
end

function theme.drawOutline(widget,x,y,w,h)
	if widget=='button' then return end
	lg.setColor(0,.1,.1)
	lg.rectangle('line',x,y,w,h)
end

local function drawButtonText(text,x,y,w,h)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.printf(text,x,y+(h-theme.font:getHeight())/2,w,'center')
end

local function drawCheckBoxText(text,x,y,h)
	lg.setColor(.2,.2,.2)
	lg.setFont(theme.font)
	lg.print(text,x,y+(h-theme.font:getHeight())/2)
end

local drawRadioButtonText=drawCheckBoxText

function theme.drawLabel(text,x,y)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y)
end

function theme.drawTooltip(text,x,y)
	lg.setColor(0,0,0)
	lg.rectangle('fill',x-4,y-2,theme.font:getWidth(text)+8,theme.font:getHeight()+2)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y)
end

local function drawTick(x,y,w,h)
	lg.setLineStyle('smooth')
	lg.setLineWidth(w/16)
	lg.setLineJoin("bevel")
	lg.line(x+h*.2,y+h*.6, x+h*.45,y+h*.75, x+h*.8,y+h*.2)
	lg.setLineWidth(1)
end

----------------------SCALER WIDGET---------------------

function theme.drawScalerNormal(fraction,vertical,x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('fill', x,y,w,h,2,2)

	if vertical then h = h * fraction
	else w = w * fraction end

	lg.setColor(nc[1]-.1,nc[2]-.1,nc[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

function theme.drawScalerHover(fraction,vertical,x,y,w,h)
	lg.setColor(unpack(hc))
	lg.rectangle('fill', x,y,w,h,2,2)

	if vertical then h = h * fraction
	else w = w * fraction end
	
	lg.setColor(hc[1]-.1,hc[2]-.1,hc[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

function theme.drawScalerPressed(fraction,vertical,x,y,w,h)
	x=x+1 y=y+1
	lg.setColor(unpack(ac))
	lg.rectangle('fill', x,y,w,h,2,2)

	if vertical then h = h * fraction
	else w = w * fraction end
	
	lg.setColor(ac[1]-.1,ac[2]-.1,ac[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

-------------------RADIOBUTTON WIDGET----------------------

function theme.drawRadioButtonNormal(isChecked,text,x,y,w,h)
	lg.setColor(nc[1]-.15,nc[2]-.15,nc[3]-.15)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(unpack(nc))
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(nc[1]-.25,nc[2]-.25,nc[3]-.25)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

function theme.drawRadioButtonHover(isChecked,text,x,y,w,h)
	lg.setColor(hc[1]-.15,hc[2]-.15,hc[3]-.15)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(unpack(hc))
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(hc[1]-.25,hc[2]-.25,hc[3]-.25)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

function theme.drawRadioButtonPressed(isChecked,text,x,y,w,h)
	y=y+1
	lg.setColor(ac[1]-.2,ac[2]-.2,ac[3]-.2)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(ac[1]-.05,ac[2]-.05,ac[3]-.05)
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y-1,h) end
	if isChecked then
		lg.setColor(ac[1]-.15,ac[2]-.15,ac[3]-.15)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

-------------------CHECKBOX WIDGET----------------------

function theme.drawCheckBoxNormal(isChecked,text,x,y,w,h)
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',x,y,w,h+math.floor(1+h/16),2,2)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y,w,h)
	end
end

function theme.drawCheckBoxHover(isChecked,text,x,y,w,h)
	lg.setColor(hc[1]-.05,hc[2]-.05,hc[3]-.05)
	lg.rectangle('fill',x,y,w,h+math.floor(1+h/16),2,2)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x,y,w,h,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y,w,h)
	end
end

function theme.drawCheckBoxPressed(isChecked,text,x,y,w,h)
	lg.setColor(ac[1]-.15,ac[2]-.15,ac[3]-.15)
	lg.rectangle('fill',x,y+2,w,h-2+math.floor(1+h/16),2,2)
	lg.setColor(unpack(ac))
	lg.rectangle('fill',x,y+2,w,h-2,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y+2,w,h)
	end
end

-------------------BUTTON WIDGET----------------------

function theme.drawButtonNormal(text,x,y,w,h)
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',x,y,w,h+6,5,5)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h,5,5)
	drawButtonText(text,x,y,w,h)
end

function theme.drawButtonHover(text,x,y,w,h)
	lg.setColor(hc[1]-.05,hc[2]-.05,hc[3]-.05)
	lg.rectangle('fill',x,y,w,h+6,5,5)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x,y,w,h,5,5)
	drawButtonText(text,x,y,w,h)
end

function theme.drawButtonPressed(text,x,y,w,h)
	lg.setColor(ac[1]-.1,ac[2]-.1,ac[3]-.1)
	lg.rectangle('fill',x,y+3,w,h+3,5,5)
	lg.setColor(unpack(ac))
	lg.rectangle('fill',x,y+3,w,h-3,5,5)
	drawButtonText(text,x,y+2,w,h)
end

return theme