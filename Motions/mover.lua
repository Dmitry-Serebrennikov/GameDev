Mover = {}

Mover.__index = Mover

function Mover:create(location, velocity, size, weight, color)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.acceleration = Vector:create(0, 0)
    mover.size = size or 1
    mover.weight = weight or 1
    mover.color = color
    return mover
end

function Mover:applyForce(force)
    self.acceleration:add(force / self.weight)
end

function Mover:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end

    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y
    end
    
end

function Mover:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.color) 
    love.graphics.circle("fill", self.location.x, self.location.y, self.size)
    love.graphics.setColor(r, g, b, a)
end

function Mover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end