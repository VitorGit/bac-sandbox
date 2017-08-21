--functions created to provide basic functionality to the simulation
-- like collision detection etc

require "love.keyboard"

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function pointInRectangle(pointx, pointy, rectx, recty, rectwidth, rectheight)
    return pointx > rectx and 
			pointy > recty and 
			pointx < rectx + rectwidth and 
			pointy < recty + rectheight
end

function smooth(goal, current, dt)
  local diff = (goal-current+math.pi)%(2*math.pi)-math.pi --checking if there's a different between the goal and the current
  if(diff>dt)then --this means that we still need to speed up
    return current + dt
  end
  if(diff<-dt)then --and this means we need to slow down
    return current - dt
  end
  return goal --if diff equals 0 then just return goal
end

function moveArrows(x, y, speed)
	if love.keyboard.isDown("up") then y = y - speed end
	
	if love.keyboard.isDown("down") then y = y + speed end
	
	if love.keyboard.isDown("right") then x = x + speed end
	
	if love.keyboard.isDown("left") then x = x - speed end
	
	return x,y
end