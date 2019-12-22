--[[
	Nothing related to lovely-imgui!
]]

local loaded={}

function love.filedropped(file)
	if loaded[file:getFilename()] then return end
	if not isAudio(file) then
		if isImage(file) and music[current] then
			music[current].image=love.graphics.newImage(file)
			discImage=music[current].image
			loaded[file:getFilename()]=true
		end
		return
	end
	loaded[file:getFilename()]=true
	local songname,albumname,artistname=getDescription(file)
	local sound=love.audio.newSource(file,'stream')
	if not music[current] then
		discLabel.text=songname
		artistLabel.text=artistname
		albumLabel.text=albumname
		soundSlider.max=sound:getDuration()
		soundSlider.value=0
	end
	music[#music+1]={
		sound=sound,
		image=nil,
		albumName=albumname,
		songName=songname,
		artistName=artistname
	}
end

local delim=package.config:sub(1,1)

local path_cache={}
local function removePath(filename)
	if not path_cache[filename] then
		local pos=1
		local i = string.find(filename,'[\\/]', pos)
		pos=i
		while i do
			i = string.find(filename,'[\\/]', pos)
			if i then
				pos = i + 1
			else i=pos break
			end
		end
		if i then path_cache[filename]=filename:sub(i) end
	end
	return path_cache[filename]
end

local thumbExt={'png','jpg','jpeg'}

--I don't think I can get this to work without a platform-dependent library :(
function loadMusic() end
function getThumbnail(file,albumName)
	print(albumName)
	if not albumName or albumName=='' then return end
	local fn=file:getFilename()
	local dir=fn:sub(1,fn:len()-removePath(fn):len()):gsub('\\','/')
	for i=1,#thumbExt do
		print(dir..'/'..albumName..'.'..thumbExt[i])
		print(love.filesystem.newFile(dir..albumName..'.'..thumbExt[i], r))
		info=love.filesystem.getInfo(dir..albumName..'.'..thumbExt[i])
		if info then
			if info.type=="file" then
				-- love.filesystem.newFile(dir..'/'..)
				return love.graphics.newImage(dir..'/'..albumName..'.'..thumbExt[i])
			end
		end
	end
end

function isAudio(file)
	local filename=file:getFilename()
	return filename:sub(filename:len()-3)=='.mp3' or
		filename:sub(filename:len()-3)=='.wav' or
		filename:sub(filename:len()-3)=='.ogg'
end

function isImage(file)
	local filename=file:getFilename()
	for i=1,#thumbExt do
		if filename:sub(filename:len()-thumbExt[i]:len())=='.'..thumbExt[i] then
			return true
		end
	end
end

function getDescription(file)
	local filename=removePath(file:getFilename())
	:match("^(.+)%.[^%.]+")

	local artistName='Unknown Artist'
	if filename:find('[',1,true) then
		artistName=filename:sub(
			filename:find('[',1,true)+1,
			filename:find(']',1,true)-1
		)
	end

	local albumName,songName=''
	if filename:find('-',1,true) then
		albumName=filename:sub(
			filename:find('-',1,true)+1,
			(filename:find('[',1,true) or (filename:len()+1))-1
		)
	end

	songName=filename:sub(1,(filename:find('-',1,true) or (filename:len()+1))-1)
	
	--Trim all the strings!
	songName=songName:gsub("^%s*(.-)%s*$", "%1")
	albumName=albumName:gsub("^%s*(.-)%s*$", "%1")
	artistName=artistName:gsub("^%s*(.-)%s*$", "%1")

	if albumName~='' then
		artistName=artistName..' -'
	end

	return songName,albumName,artistName
end