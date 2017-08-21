--main.lua
require "worldUtilities"
require "entityManager"

function love.load()
   nBac = 1
   
	loadImages()
   --windows
   love.window.setMode(windowX, windowY)
   love.graphics.setBackgroundColor(0,0,0)
   love.window.setTitle("Bac Sandbox")
   local imagedata = love.image.newImageData("sprites/icon.png")
   love.window.setIcon(imagedata)
   
   --background
   background = love.graphics.newImage( "sprites/background.png" )
   backScaleX = love.graphics.getWidth() / background:getWidth()
   backScaleY = love.graphics.getHeight() / background:getHeight()

   --mouse
   local cursor = love.mouse.newCursor("sprites/pointer.png", 0, 0)
   love.mouse.setCursor(cursor)
   
   --debug variables
   time = 0
   
   down = 0
end

function love.update(dt)
	if gameIsPaused then return end
	
	time = time + dt
	
	updateWorld(dt)
	
	if love.mouse.isDown(1) then down = down + 1 end
	if down > 2 then
	createFoods(1, love.mouse.getX(), love.mouse.getY()) 
	down = 0
	end
end

function love.draw()
   --background
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.draw(background, 0, 0, 0, backScaleX * windowScaleX, backScaleY * windowScaleY)
   
   drawWorld()
	
	   --debug info
	love.graphics. setColor(textColor, textColor, textColor)
	love.graphics.setFont(font15)
    love.graphics.print("Tempo: "..string.format("%.3f", time), WMargin * 15, HMargin * 1)
    love.graphics.print("FPS: "..love.timer.getFPS(), WMargin * 15, HMargin * 1 + textSpacing * 1)
end

function love.mousepressed(x, y, button)
   if button == '1' then
	--createFoods(1, x, y)
	print("mouse clicked")
   end
end

function love.mousereleased(x, y, button)
   if button == '1' then end
end

function love.keypressed(key)
	if key == 'f4' then
		love.window.setFullscreen( not love.window.getFullscreen() )
	end
	
	if key == 'h' then
      love.mouse.setVisible(not love.mouse.isVisible())
	end
	
	if key == 'l' then 
		showBacteriasLines()
	end
	
	if key == 'j' then 
		showBacteriasHealth() 
	end
	
	if key == 'v' then 
		showFoodNumbers()  
	end
	
	if key == '5' then
		nBac = 10000
	end
	
	if key == '4' then
		nBac = 1000
	end
	
	if key == '3' then
		nBac = 100
	end
	
	if key == '2' then
		nBac = 10
	end
	
	if key == '1' then
		nBac = 1
	end
	
	if key == 'n' then
		math.randomseed( time * 10000)
		createBacterias(nBac, nil)
	end
	
	if key == 'm' then
		math.randomseed( time * 10000)
		createFoods(200, nil, nil)
	end
	
	if key == 'k' then
		showBacteriasTransparent()
	end
	
	if key == 'c' then
		clearEntities()
	end
end

function love.keyreleased(key)
end

function love.resize( w, h )
	windowScaleX, windowScaleY = w/windowX, h/windowY
	
	font15 = love.graphics.newFont( 15 * windowScaleX)
	font20 = love.graphics.newFont( 20 * windowScaleX)
	
	WMargin, HMargin = love.graphics.getWidth()/20, love.graphics.getHeight()/20
	textSpacing = 20 * windowScaleY
end

function love.focus(f) 
gameIsPaused = not f 
 print("LOST FOCUS")
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end