--[[
	To keep main.lua short all the imgui code is moved here!
]]
local lg=love.graphics

function renderGUI()
	drawPanel()
	drawMainButtons()
	drawOtherButtons()
	drawDescription()
	if music[current] then
		drawGlare()
	end
end

function loadResources()
	songFont=lg.newFont('assets/fonts/RobotoSlab-Bold.ttf',30)
	fedraSans=lg.newFont('assets/fonts/Fedra Sans Book.ttf',16)
	fedraSansItalic=lg.newFont('assets/fonts/Fedra Sans Book Italic.ttf',16)
end

function initPayload()
	local hc,ac={.9,.9,.9},{.4,.4,.4}
	discImage=gi.image

	soundSlider={}
	volumeSlider={value=1,vertical=true}

	playBtn={image=gi.playBtn,hover=hc,active=ac}
	prevBtn={image=gi.prevBtn,hover=hc,active=ac}
	nextBtn={image=gi.nextBtn,hover=hc,active=ac}
	audioBtn={image=gi.audioBtn1,hover=hc,active=ac}
	shuffleBtn={image=gi.shuffleBtn0,hover=hc,active=ac}

	overlay={image=gi.overlay,color={1,1,1,.4}}
	panel={image=gi.back,color={1,1,1,.9}}
	
	discLabel={font=songFont,text='Brief Music Player'}
	artistLabel={font=fedraSans,text='No Music Loaded!'}
	albumLabel={font=fedraSansItalic,text=''}

	-- love.filedropped(
	-- 	love.filesystem.newFile(
	-- 		'music/The BriefCase - The Amazing SpiderMan[James Horner].mp3','r'
	-- 	)
	-- )
end

function drawSplash()
	if not music[current] then
		imgui.image(gi.dropHere,'.5','.3',gi.dropHere:getDimensions())
	else
		-- imgui.image(gi.splash,'.5','.3',gi.splash:getDimensions())
		--> TODO: STILL WORKING ON A GOOD SPLASH
		if not music[current].image then
			imgui.image(gi.splash,'.5','.295','.99','.58')
			imgui.image(gi.logo,'.5','.3',gi.logo:getDimensions())
		end
	end
end

function drawPanel()
	imgui.image(panel,'center','top','1','1')
	imgui.image(discImage,'left','top','1','.6')
	drawSplash()
	if music[current] then
		local mx,rx=love.mouse.getX(),love.graphics.getWidth()
		local m,s=euler.toMinutes(euler.map(mx,0,rx,0,music[current].sound:getDuration()))
		imgui.tooltip(m..':'..s,mx,'.55')
		if imgui.scaler(soundSlider,'left','.6','1',15) then
			if music[current] then
				music[current].sound:seek(soundSlider.value,'seconds')
			end
		end
	end
end

function drawGlare()
	imgui.image(overlay,'right','top',gi.overlay:getDimensions())
end

function drawMainButtons()
	local cx=lg.getWidth()/2
	imgui.image(gi.btnBackground,'.5','.89',143,68)
	if imgui.imageButton(prevBtn,cx-45,'.887',50,50) then
		if imgui.isMouseReleased() then
			if shuffle then
				randomSong()
			else
				nextSong()
			end
		end
	end
	if imgui.imageButton(nextBtn,cx+45,'.887',50,50) then
		if imgui.isMouseReleased() then
			if shuffle then
				randomSong()
			else
				nextSong()
			end
		end
	end

	if imgui.imageButton(playBtn,cx,'.887',62,66) then
		if imgui.isMouseReleased() then
			if not music[current] then return end
			local play=playBtn.image==gi.playBtn
			playBtn.image=play and gi.pauseBtn or gi.playBtn
			if play then
				music[current].sound:play()
			else
				music[current].sound:pause()
			end
		end
	end
end

function drawOtherButtons()
	local rx,ry=lg.getDimensions()
	if imgui.imageButton(audioBtn,rx-40,'.883',45,45) then
		if imgui.isMouseReleased() then
			showVolumeSlider=not showVolumeSlider
		end
	end
	if showVolumeSlider then
		imgui.image(gi.popup,rx-40,.883*ry-(45+110)/2,40,115)
		if imgui.scaler(volumeSlider,rx-40,.883*ry-(45+110)/2-3,10,90) then
			audioBtn.image=volumeSlider.value==0 and gi.audioBtn0 or gi.audioBtn1
			love.audio.setVolume(volumeSlider.value)
		end
	end
	if imgui.imageButton(shuffleBtn,40,'.883',24,20) then
		if imgui.isMouseReleased() then
			shuffleBtn.image=shuffle and gi.shuffleBtn0 or gi.shuffleBtn1
			shuffle=not shuffle
		end
	end
end

function drawDescription()
	local cx=lg.getWidth()/2
	imgui.label(discLabel,'.5','.66')
	if albumLabel.text=='' then
		imgui.label(artistLabel,'center','.72')
	else
		local arw=artistLabel.font:getWidth(artistLabel.text)
		imgui.label(artistLabel,cx-arw/2-20,'.72')
		local alw=albumLabel.font:getWidth(albumLabel.text)
		imgui.label(albumLabel,cx+alw/2-15,'.72')
	end
end
