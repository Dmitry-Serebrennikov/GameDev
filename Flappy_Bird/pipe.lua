Pipe = {}
Pipe.__index = Pipe

screen_width = 288
screen_height = 512

function Pipe:create(x, y)
    local pipe = {}
    setmetatable(pipe, Pipe)

    pipe.image = love.graphics.newImage("assets/sprites/pipe-green.png")
    pipe.height = pipe.image:getHeight()
    pipe.width = pipe.image:getWidth()

    pipe.x = x
    pipe.y = y - screen_width
    
    pipe.positon = math.random(-140, 60)
    pipe.space_between_pipes = 75
    pipe.speed = 0.5
    return pipe
end

function Pipe:update(dt)
    self.x = self.x - self.speed
    if self.x == -width then
        self.x = screen_width
    end
end

function Pipe:draw()
    love.graphics.draw(self.image, self.x, self.y + self.space_between_pipes + self.positon)
    love.graphics.draw(self.image, self.x + self.width, self.y - self.space_between_pipes + self.positon, math.pi)
end

function Pipe:checkCollision(bird)
    if (bird.x + bird.downFlap:getWidth() >= self.x and bird.x <= self.x + self.width) and 
    (bird.y <= self.y + self.positon - self.space_between_pipes or 
        bird.y + bird.downFlap:getHeight() >= self.y + self.positon + self.space_between_pipes) then
		return true
	else 
		return false
	end
end