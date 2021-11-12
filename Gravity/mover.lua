Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity, size, weight)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.acceleration = Vector:create(0, 0)
    mover.size = size
    mover.weight = weight or 1
     
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

function Mover:checkMoverBoundaries(otherMover)
    if (self.location - otherMover.location):mag() < self.size / 2 + otherMover.size / 2 then
        self.velocity.x = self.velocity.x * -1
        self.velocity.y = self.velocity.y * -1
        otherMover.velocity.x = otherMover.velocity.x * -1
        otherMover.velocity.y = otherMover.velocity.y * -1
    end
end

function Mover:attract(mover)
    force = self.location - mover.location
    distance = force:mag()

    if distance then
        if distance < 5 then
            distance = 5
        end
        if distance > 25 then
            distance = 25
        end

        force = force:norm()
        strength = (G * self.weight * mover.weight) / (distance * distance)
        force:mul(strength)
        mover:applyForce(force)
    end

end

--old_realization
-- function Mover:attract(mover)
--     for i = 1, 10 do
--         force = self.location - mover.location
--         distance = force:mag()

--         if distance then
--             if distance < 5 then
--                 distance = 5
--             end
--             if distance > 25 then
--                 distance = 25
--             end
--         end
--         force = force:norm()
--         strength = (G * self.weight * mover.weight) / (distance * distance)
--         force:mul(strength)
--         mover:applyForce(force)
--     end
-- end

function Mover:draw()
    love.graphics.circle("fill", self.location.x, self.location.y, self.size)
end

function Mover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end