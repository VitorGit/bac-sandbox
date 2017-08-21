print("food.lua loaded")

require "love.graphics"
require "entityManager"
vector = require "hump.vector"

local rot = math.random(2*math.pi)
local scale = 0.1

drawFoodAsNumbers = false

local imageFood, h, w, pos, selfIndex
	
return {
	draw = function()
				if drawFoodAsNumbers then
					love.graphics.setColor(0, 4, 212)
					love.graphics.setFont(font20)
					love.graphics.print(""..selfIndex, pos.x+3, pos.y+3)
				else
					--love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy )
					love.graphics.setColor(255, 255, 255, 255)
					love.graphics.draw(imageFood, pos.x, pos.y, rot, scale, scale, w/2, h/2)
				end
			end,
	
	getPos = function() return pos end,
	
	setSelfIndex = function(number)
					selfIndex = number
			end,
	
	setDrawFoodAsNumbers = function(bool)
					drawFoodAsNumbers = bool
			end,
			
	setImage = function(image, x, y)
				imageFood = image

				h = imageFood:getHeight()
				w = imageFood:getWidth()
				
				if x == nil or y == nil then
				pos = vector.new( math.random(w * scale, love.graphics.getWidth() - w * scale), 
					math.random(h * scale, love.graphics.getHeight() - h * scale) )
				else
				pos = vector.new(x, y)
				end
			end
	
} --return (end of file)