Particle = {}
Particle.__index = Particle

function Particle:create(location, color)
    local particle = {}
    setmetatable(particle, Particle)
    particle.location = location
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    particle.lifespan = 50
    particle.decay = math.random(3, 8) / 10
    particle.isActive = false
    particle.color = color
    --particle.texture = love.graphics.newImage("resources/coin.png")
    return particle 
end

function Particle:update()
    if self.isActive == true then
        self.velocity:add(self.acceleration)
        self.location:add(self.velocity)
        self.acceleration:mul(0)
        self.lifespan = self.lifespan - self.decay
    end
end

function Particle:applyForce(force)
    if self.isActive == true then
        self.acceleration:add(force)
    end
end

function Particle:isDead()
    return self.lifespan < 0
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    --love.graphics.setColor(1, 1, 1, self.lifespan / 100)
    love.graphics.setColor(self.color[1],  self.color[2], self.color[3], self.lifespan / 100) --
    love.graphics.rectangle("line", self.location.x, self.location.y, 10, 10)
    --love.graphics.draw(self.texture, self.location.x, self.location.y, 0.1, 0.1)
    love.graphics.setColor(r, g, b, a)
end


ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, length, color, cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
    system.length = length

    local index = 1

    for i = 1, length / 10 do
        for j = 1, length / 10 do
            system.particles[index] = system.cls:create(system.origin:copy() + Vector:create((i - 1) * 10, (j - 1) * 10), color)
            index = index + 1
        end
    end
    return system
end

function ParticleSystem:draw()
    --love.graphics.circle("line", self.origin.x, self.origin.y, 10)
    for k, v in pairs(self.particles) do
        v:draw()
    end
end

function ParticleSystem:update()
    for k, v in pairs(self.particles) do
		v:update()
	end
end

function ParticleSystem:applyForce(force)
    for k, v in pairs(self.particles) do
        v:applyForce(force)
    end
end