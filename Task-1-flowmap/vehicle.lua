Vehicle = {}
Vehicle.__index = Vehicle

function Vehicle:create (x,y)
    local vehicle = {}
    setmetatable(vehicle, Vehicle)
    vehicle.velocity = Vector:create(1, 1)
    vehicle.acceleration = Vector:create(0, 0)
    vehicle.location = Vector:create(x, y)
    vehicle.r = 5
    vehicle.vertices = {0, -vehicle.r*2, -vehicle.r, vehicle.r*2, vehicle.r, vehicle.r*2}
    vehicle.maxSpeed = 7
	vehicle.maxForce = 100 -- 10
    return vehicle
end 

function Vehicle:update()
	self.velocity:add(self.acceleration)
	self.velocity:limit(self.maxSpeed)
	self.location:add(self.velocity)
	self.acceleration:mul(0)
end

function Vehicle:applyForce(force)
	self.acceleration:add(force / 250)
end

function Vehicle:borders()
	if self.location.x < -self.r then
		self.location.x = width +self.r
	end
	if self.location.y < -self.r then
		self.location.y = height +self.r
	end
	if self.location.x > width+self.r then
		self.location.x = -self.r
	end
	if self.location.y > height+self.r then
		self.location.y = -self.r
	end
end

function Vehicle:draw()
	local theta = self.velocity:heading() + math.pi/2
	love.graphics.push()
	love.graphics.translate(self.location.x, self.location.y)
	love.graphics.rotate(theta)
	love.graphics.polygon("fill", self.vertices)
	love.graphics.pop()
end

function Vehicle:follow(flow)
	local desired = flow:lookup(self.location)
	desired:mul(self.maxSpeed)
	local steer = desired - self.velocity * 0.001--- self.velocity * 0.0001  -* 0.5
	steer:limit(self.maxForce)
	self:applyForce(steer)
end