--[[
	This file contains all logic related to music player (of-course trivial!)
]]

local function getRandomSongNumber()
	local r=love.math.random(1,#music)
	if r==current then
		getRandomSongNumber()
	else
		current=r
	end
end

function randomSong()
	if not music[current] then return end
	music[current].sound:stop()
	getRandomSongNumber()
	updateSong()
end

function nextSong()
	if not music[current] then return end
	music[current].sound:stop()
	current=current+1
	if current>#music then current=1 end
	updateSong()
end

function previousSong()
	if not music[current] then return end
	music[current].sound:stop()
	current=current-1
	if current<1 then current=#music end
	updateSong()
end

function updateSong()
	if not music[current] then return end
	discLabel.text=music[current].songName
	artistLabel.text=music[current].artistName
	albumLabel.text=music[current].albumName
	discImage=music[current].image or gi.image
	soundSlider.max=music[current].sound:getDuration()
	soundSlider.value=0

	if playBtn.image~=gi.playBtn then
		music[current].sound:play()
	end
end