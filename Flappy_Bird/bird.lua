Bird = {}
Bird.__index = Bird

function Bird:create()
    local bird = {}
    setmetatable(bird, Bird)
    bird.downFlap = love.graphics.newImage("assets/sprites/yellowbird-downflap.png")
    bird.midFlap = love.graphics.newImage("assets/sprites/yellowbird-midflap.png")
    bird.upFlap = love.graphics.newImage("assets/sprites/yellowbird-upflap.png")
    bird.die_audio = love.audio.newSource("assets/audio/die.wav", "static")

    screen_width = 288
    screen_height = 512

    bird.x = (screen_width - bird.downFlap:getWidth()) / 2
    bird.y = (screen_height - bird.downFlap:getHeight()) * 3/5

    bird.velocity = 0
    bird.gravity = 15

    return bird
end

function Bird:update(dt)
    self.velocity = self.velocity + self.gravity * dt
    
    self.y = self.y + self.velocity
    
    self:checkCollision()
end

function Bird:draw()
    if self.velocity < 0 then
        love.graphics.draw(self.downFlap, self.x, self.y)
    end
    if self.velocity == 0 then
        love.graphics.draw(self.midFlap, self.x, self.y)
    end
    if self.velocity > 0 then
        love.graphics.draw(self.upFlap, self.x, self.y)
    end
end

function Bird:checkCollision()
    if self.y < 0 or self.y > height - ground:getHeight() then
        self.die_audio:play()
        Page = 'gameover_page'
        gameover_page.score = play_page.score
    end
end