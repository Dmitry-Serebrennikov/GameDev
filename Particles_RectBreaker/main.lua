require("vector")
require("particle")

function love.load()
   length = love.graphics.getWidth()
   height = love.graphics.getHeight()
   --particle = Particle:create(Vector:create(length / 2, height / 2))
   

   systems = {}

   for i = 1, 3 do
      table.insert(systems, system)
   end

   systems[1] =  ParticleSystem:create(Vector:create(150, 200), 50, {1, 0,  0})
   systems[2] = ParticleSystem:create(Vector:create(300, 250), 100, {0, 1, 0})
   systems[3] = ParticleSystem:create(Vector:create(500, 300), 200, {0, 0, 1})

   --system = ParticleSystem:create(Vector:create(length / 2, height / 2), 100)
   gravity = Vector:create(0, 0.1)
end

function love.update(dt)
    --particle:update()
    --system:applyForce(gravity)
    --system:update()
   for k,v in pairs(systems) do
      systems[k]:update()
      systems[k]:applyForce(gravity)  
   end
end

function love.draw()
   --particle:draw()
   --system:draw()
   for k,v in pairs(systems) do 
      systems[k]:draw()  
   end
end

function love.mousepressed(x, y, button, istouch, presses)
   if button == 1 then 
      for k,v in pairs(systems) do
         if x >= systems[k].origin.x and x <= systems[k].origin.x + systems[k].length 
            and y >= systems[k].origin.y and y <= systems[k].origin.y + systems[k].length then
            for k, v in pairs(systems[k].particles) do
               v.isActive = true			
            end
         end
      end
  end
end