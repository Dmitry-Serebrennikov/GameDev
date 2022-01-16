require "bird"
require "pipe"

PlayPage = {}
PlayPage.__index = PlayPage

function PlayPage:create()
    local page = {}
    setmetatable(page, PlayPage)

    page.bird = Bird:create()

    page.score_numbers = {}
    for i = 1, 10 do
        page.score_number_path = "assets/sprites/" .. (i - 1) .. ".png"
        page.score_numbers[i] = love.graphics.newImage(page.score_number_path)
    end

    page.pipes = {}
    -- 1 - upper_pipe, 2 - lower_pipe
    page.pipes[1] = Pipe:create(width, height)
    page.pipes[2] = Pipe:create(width + width / 2 + page.pipes[1].width, height)

    page.passed = false
    page.str_score = ""
    page.score = 0

    page.point_audio = love.audio.newSource("assets/audio/point.wav", "static")
    page.wing_audio = love.audio.newSource("assets/audio/wing.wav", "static")
    page.hit_audio = love.audio.newSource("assets/audio/hit.wav", "static")

    page.ground_x = 0
   
    page.speed = 0.5
    page.delta_speed = 0.2

    return page
end

function PlayPage:draw()
    love.graphics.clear()
    if self.score < 10 then
        love.graphics.draw(background, 0, 0)
    else
        love.graphics.draw(night_background, 0, 0)
    end
    
    for i, pipe in pairs(self.pipes) do
        pipe:draw()
    end
    love.graphics.draw(ground, self.ground_x, height - ground:getHeight())
    love.graphics.draw(ground, self.ground_x + width, height - ground:getHeight())

    self.bird:draw()

    if self.score < 10 then 
        love.graphics.draw(self.score_numbers[self.score + 1], 10, 10)
    else 
        self.str_score = tostring(self.score)
        for i = 1, string.len(self.str_score) do
            love.graphics.draw(self.score_numbers[tonumber(string.sub(self.str_score, i, i)) + 1], 10 + (i - 1) * 25, 10)
        end
    end
end

function PlayPage:update(dt)
    self.bird:update(dt)

    for i, pipe in pairs(self.pipes) do
        pipe:update(dt)
        if pipe:checkCollision(self.bird) then
            self.hit_audio:play()
            Page = "gameover_page"
            gameover_page.score = self.score
        end
    end
    self.ground_x = self.ground_x - self.speed 
    if self.ground_x < -width then 
        self.ground_x = 0
    end

    if self.bird.x >= self.pipes[1].x + self.pipes[1].width or self.bird.x >= self.pipes[2].x + self.pipes[2].width  then
        if self.passed == false then
            self.point_audio:play()
            self.score = self.score + 1
            self.passed = true
            self.speed = self.speed + self.delta_speed
            self.pipes[1].speed = self.speed
            self.pipes[2].speed = self.speed
        end
    end

    if self.pipes[1].x + self.pipes[1].width <= 0 then
        self.pipes[1] = Pipe:create(width + self.pipes[2].width,  height)
        self.pipes[1].speed = self.speed
        self.passed = false
    end
    if self.pipes[2].x + self.pipes[2].width <= 0 then
        self.pipes[2] = Pipe:create(width + self.pipes[1].width, height)
        self.pipes[2].speed = self.speed
        self.passed = false
    end
end

function PlayPage:mousepressed(button)
    if button == 1 then
        self.wing_audio:play()
        self.bird.velocity = -5
    end
end

function PlayPage:keypressed(key)
    if key == 'space' then
        self.wing_audio:play()
        self.bird.velocity = -5
    end
end