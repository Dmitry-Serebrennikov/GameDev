require("vector")
require("particle")
require("repeller")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   system = ParticleSystem:create(100)
   gravity = Vector:create(0, 0.1)
   wind = Vector:create(-0.1, 0)
end

function love.update(dt)
  system:applyForce(gravity)
  system:applyForce(wind)
  --cursor-------
  -- x, y = love.mouse.getPosition()
  -- system:attraction(x, y)
  ---------------
  system:update()
end

function love.draw()
  system:draw()
end

function love.keypressed(key)
  if key == "left" then
      wind.x = wind.x - 0.1
  elseif key == "right" then
      wind.x = wind.x + 0.1
  end
end