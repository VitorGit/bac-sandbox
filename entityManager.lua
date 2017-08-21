require "love.graphics"

local bacterias = {}
local foods = {}
local loaded_bac, loaded_food, imageBac, imageFood
local foodSize = 0
local bacSize = 0

function loadImages()
	loaded_bac = love.filesystem.load("bacteria.lua")
	loaded_food = love.filesystem.load("food.lua")

	imageBac = love.graphics.newImage("sprites/bacteriaSprite.png")
	imageFood = love.graphics.newImage("sprites/food.png") --load once use forever, spritebatch?
	
	windowScaleX = 1
	windowScaleY = 1
	font15 = love.graphics.newFont( 15 * windowScaleX)
	font20 = love.graphics.newFont( 20 * windowScaleX)
	
	windowX, windowY = 720, 480
	
	WMargin, HMargin = love.graphics.getWidth()/20, love.graphics.getHeight()/20
	textSpacing = 20 * windowScaleY
	
	textColor = 190
end

local drawAllLines = false
local drawAllHealth = false
local showNumbers = false
local drawAllTransparent = false

   function createBacterias(number, pos)
		assert(type(number) == "number", "abs expects a number")
		if number < 1 then 
			print("createBacterias(number) parameter is smaller than 1") return end
			for i = bacSize + 1,bacSize + number,1 do
				bacterias[i] = loaded_bac()
				--setup
				bacterias[i].setDrawLine(drawAllLines)
				bacterias[i].setImage(imageBac, pos)
				bacterias[i].setDrawHealth(drawAllHealth)
				bacterias[i].setSelfIndex(i)
				bacterias[i].setTransparentBac(drawAllTransparent)
			end
			bacSize = bacSize + number
	end
   --remove nil values from the table
   function updateBacterias(dt)
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k].update(dt)
			end
		end
	end
	
	function drawBacterias()
	bacsizeShow = 0
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k].draw()
				bacsizeShow = bacsizeShow + 1
			end
		end
	end
	
	function showBacteriasLines() 
	drawAllLines = not drawAllLines
	
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k].setDrawLine(drawAllLines)
			end
		end
	end
	
		function showBacteriasHealth() 
	drawAllHealth = not drawAllHealth
	
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k].setDrawHealth(drawAllHealth)
			end
		end
	end
	
	function showBacteriasTransparent() 
	drawAllTransparent = not drawAllTransparent
	
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k].setTransparentBac(drawAllTransparent)
			end
		end
	end
	
	function getTarget(bacPos)
		if foodSize == 0 then return nil end -- tell bac there's no food to go after
	
		local distance = 0
		local nearestLenght = 999999999
		local index = nil
	
		for k in pairs(foods) do
			if foods[k] ~= nil then
				distance  = (foods[k].getPos() - bacPos):len()
		
				if distance < nearestLenght then
					nearestLenght = distance
					index = k
				end
			end
		end
		
		if foods[index] == nil then return nil, index
		else
		return foods[index].getPos(), index
		end
	end
	
	function destroyTarget(targetIndex)
		if foods[targetIndex] ~= nil then
			foods[targetIndex] = nil
			foodSize = foodSize - 1
		end
	end
	
	function destroySelf(selfIndex)
		if bacterias[selfIndex] then
			bacterias[selfIndex] = nil
		end
	end
	
	function createFoods(number, x, y) 
		assert(type(number) == "number", "abs expects a number")
		if number < 1 then
			print("createBacterias(number) parameter is smaller than 1") return end
			
			for i= foodSize + 1,foodSize + number,1 do
				foods[i] = loaded_food()
				--setup
				foods[i].setImage(imageFood, x, y)
				foods[i].setSelfIndex(i)
				foods[i].setDrawFoodAsNumbers(showNumbers)
			end
			foodSize = foodSize + number
	end
	
	function drawFoods()
	foodsizeShow = 0
		for k in pairs(foods) do
			if foods[k] ~= nil then
				foods[k].draw()
				foodsizeShow = foodsizeShow + 1
			end
		end
	end
	
	function showFoodNumbers() 
	showNumbers = not showNumbers
	
		for k in pairs(foods) do
			if foods[k] ~= nil then
				foods[k].setDrawFoodAsNumbers(showNumbers)
			end
		end
	end
	
	function clearEntities()
	
		for k in pairs(foods) do
			if foods[k] ~= nil then
				foods[k] = nil
			end
		end
		
		for k in pairs(bacterias) do
			if bacterias[k] ~= nil then
				bacterias[k] = nil
			end
		end
	end
	
	function updateWorld(dt)
		updateBacterias(dt)
	end
	
	function drawWorld()
		drawFoods()
		drawBacterias()
		
		love.graphics.setColor(textColor, textColor, textColor)
		love.graphics.setFont(font15)
		love.graphics.print("Numero de nutrientes: "..foodsizeShow, WMargin * 1, HMargin * 1)
		love.graphics.print("Numero de bacterias: "..bacsizeShow, WMargin * 1, HMargin * 1 + textSpacing * 1)
	end