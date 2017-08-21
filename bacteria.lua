print("bacteria.lua loaded")

require "love.graphics"
require "entityManager"
require "worldUtilities"
vector = require "hump.vector"

local drawLine = true
local drawHealth = false
local transparentBacteria = false

local rot = 0
local scale = 0.1

local updateInterval = math.random(4 - 0.5, 4 + 0.5) --each one has a slighly different time
local speed = 5										--so they don't update all at once

local elapsedUpTime = 0
local elapsedDmgTime = 0

local maxHealth = 100
local health = maxHealth / 2
local healthIncr = 15

local pos, targetPos, targetIndex, selfIndex, h, w, imageBac, distance, newRot, reproduce

function isTimeToUpdate(dt)
	elapsedUpTime = elapsedUpTime + dt
	if(elapsedUpTime >= updateInterval) then
		elapsedUpTime = 0
		return true
	else
		return false
	end
end

local function eat()
		destroyTarget(targetIndex)
		health = health + healthIncr
		if health >= maxHealth then
			health = maxHealth / 2
			createBacterias(1, pos)
		end
end

local function takeDamage(dt)
	elapsedDmgTime = elapsedDmgTime + dt
	if elapsedDmgTime > 3 then 
		health = health - 2
		elapsedDmgTime = 0				
	end
	
	if health < 0 then 
		destroySelf(selfIndex) 
	end
end

local function update()
	targetPos, targetIndex = getTarget(pos)
	if targetPos == nil then --there's no food, go to a random direction
		targetPos = vector.new( math.random(love.graphics.getWidth()),
			math.random(love.graphics.getHeight()) )
	end
	newRot = math.atan2((targetPos.y - pos.y), (targetPos.x - pos.x)) + 1.5708
end

return {
	draw = function()
				--love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy )
				if transparentBacteria then 
				love.graphics.setColor(255, 0, 255, 50)
				else
				love.graphics.setColor(255, 255, 255, 255)
				end
				love.graphics.draw(imageBac, pos.x, pos.y, rot, scale, scale, w/2, h/2)
				love.graphics.setColor(0, 0, 0)
				--love.graphics.print("Distance: "..distance:len(), WMargin * 6, HMargin * 6 + textSpacing * 5)
				--love.graphics.print("Health: "..health, WMargin * 6, HMargin * 6 - textSpacing)
				
				if drawLine then
				love.graphics.setLineWidth( 2 )
				love.graphics.setColor(0, 0, 0)
				love.graphics.line(pos.x, pos.y, targetPos.x, targetPos.y)
				love.graphics.circle( "fill", pos.x, pos.y, 5)
				end
				
				if drawHealth then
				love.graphics.setLineWidth( 7 )
				love.graphics.setColor(0, 0, 0)
				love.graphics.line(pos.x, pos.y, pos.x + maxHealth, pos.y)
				love.graphics.setColor(20, 250, 20)
				love.graphics.line(pos.x, pos.y, pos.x + health, pos.y)
				end
			end,
			
	update = function(dt)
				--find target
				if isTimeToUpdate(dt) then
					update()
				end
				
				--movement
				if pos == nil then
					if imageBac == nil then imageBac = love.graphics.newImage("bacteriaSprite.png") end
					if w == nil then w = imageBac:getHeight() end
					if h == nil then h = imageBac:getWidth() end
					pos = vector.new( math.random(w * scale, love.graphics.getWidth() - w * scale), 
					math.random(h * scale, love.graphics.getHeight() - h * scale) )
				end
				if targetPos == nil then update() end
				
				distance = targetPos - pos
				pos = pos + (distance / distance:len() * speed * dt)
				rot = smooth(newRot, rot, dt)
				
				--target reached
				if distance:len() <= 10 then 
					eat()
					update()
				end
				--periodical damage
				takeDamage(dt)
			end,
	
	--setters
	setDrawLine = function(bool)
				drawLine = bool
			end,
			
	setDrawHealth = function(bool)
				drawHealth = bool
			end,
			
	setSelfIndex = function(number)
				selfIndex = number
			end,
			
	setTransparentBac = function(bool)
				transparentBacteria = bool
			end,
	--this one works as a constructor
	setImage = function(image, parentPos)
				imageBac = image
				
				h = imageBac:getHeight()
				w = imageBac:getWidth()
				
				if parentPos == nil then
					pos = vector.new( math.random(w * scale, love.graphics.getWidth() - w * scale), 
					math.random(h * scale, love.graphics.getHeight() - h * scale) )
				else
					pos = parentPos:clone()
				end
				
				targetPos = vector.new( math.random(love.graphics.getWidth()), 
					math.random(love.graphics.getHeight()) )
					
				distance = targetPos - pos
				newRot = math.atan2((targetPos.y - pos.y), (targetPos.x - pos.x)) + 1.5708
			end
	
} --return (end of file)