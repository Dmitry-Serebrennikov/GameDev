GamePage = {}
GamePage.__index = GamePage

function GamePage:create()
	local page = {}
    setmetatable(page, GamePage)
    page.ball = {}
    page.ball.location = Vector:create(width/2, 0)
    page.ball.xspeed = 6
    page.ball.r = 13
    page.ball.velocity = Vector:create(-page.ball.xspeed, 1.8)
    page.win_audio = love.audio.newSource("resources/victory.wav", "static")
    page.go_audio = love.audio.newSource("resources/gameover.wav", "static")
    page.pong_audio = love.audio.newSource("resources/pong.wav", "static")

    page.score = {0, 0}
    page.player = {}
    page.player.width = 15
    page.player.height = 80
    page.player.location = Vector:create(page.player.width/2, height/2)
    page.player.velocity = Vector:create(0, 0)

    page.enemy = {}
    page.enemy.width = 15
    page.enemy.height = 80
    page.enemy.location = Vector:create(width-page.enemy.width/2, 40)
    page.enemy.velocity = Vector:create(0, 0)
    return page
end

function GamePage:restart()
    self.ball = {}
    self.ball.location = Vector:create(width/2, 0)
    self.ball.xspeed = 6
    self.ball.r = 13
    self.ball.velocity = Vector:create(-self.ball.xspeed, 1.8)
    self.win_audio = love.audio.newSource("resources/victory.wav", "static")
    self.go_audio = love.audio.newSource("resources/gameover.wav", "static")
    self.pong_audio = love.audio.newSource("resources/pong.wav", "static")

    self.score = {0, 0}
    self.player = {}
    self.player.width = 15
    self.player.height = 80
    self.player.location = Vector:create(self.player.width/2, height/2)
    self.player.velocity = Vector:create(0, 0)

    self.enemy = {}
    self.enemy.width = 15
    self.enemy.height = 80
    self.enemy.location = Vector:create(width-self.enemy.width/2, 40)
    self.enemy.velocity = Vector:create(0, 0)
end

function GamePage:draw()
    love.graphics.setFont(scoreFont);
    if self.score[1] > self.score[2] then
        love.graphics.setColor(0, 255, 0)
    else 
        love.graphics.setColor(255, 255, 255)
    end
	love.graphics.print(tostring(self.score[1]), width/2 - 48, 10)
    if self.score[1] < self.score[2] then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end
	love.graphics.print(tostring(self.score[2]), width/2 + 18, 10)
    love.graphics.setColor(255, 255, 255)
    -- love.graphics.setLineWidth(10)
    -- love.graphics.line(width/2, 0, width/2, 40)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", self.enemy.location.x - self.enemy.width/2, self.enemy.location.y-self.enemy.height/2, self.enemy.width, self.enemy.height)
    love.graphics.setColor(r,g,b,a)
    love.graphics.circle("fill", self.ball.location.x, self.ball.location.y, self.ball.r)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", self.player.location.x - self.player.width/2, self.player.location.y-self.player.height/2, self.player.width, self.player.height)
    love.graphics.setColor(r, g, b, a)

    line_height = height / 40
    love.graphics.setLineWidth(1)
    for i = 0, 40 do
        if i % 2 == 0 then
            love.graphics.line(width / 2, line_height * i, width / 2, line_height * (i + 1))
        end
    end

    love.graphics.setFont(sFont)
    love.graphics.setColor(192, 192, 192)
    love.graphics.printf('press esc to return to the menu', 0, height * (95 / 100), width, 'center')
    love.graphics.setColor(255, 255, 255)
end



function GamePage:update()
    if love.keyboard.isDown("up") then
        self.player.velocity.y = - 6
    elseif love.keyboard.isDown("down") then
        self.player.velocity.y = 6
    else
        self.player.velocity.y = 0
    end
    self.player.location.y = self.player.location.y + self.player.velocity.y
	yspeed = self.player.velocity.y

	self.ball.location = self.ball.location + self.ball.velocity
	move_random = love.math.random()
	if move_random > 0.9 then self.enemy.velocity.y = self.ball.velocity.y end
	self.enemy.location = self.enemy.location + self.enemy.velocity
	if self.ball.location.x > self.player.location.x - self.player.width/2 - self.ball.r and self.ball.location.x < self.player.location.x + self.player.width/2 + self.ball.r and self.ball.location.y < self.player.location.y + self.player.height/2 + self.ball.r and self.ball.location.y > self.player.location.y - self.player.height/2 - self.ball.r then
		if self.ball.location.x - self.ball.velocity.x >= self.player.location.x + self.player.width/2 + self.ball.r then
			self.ball.velocity.x = self.ball.velocity.x * -1
			self.pong_audio:play()
			if yspeed > 3 then yspeed = 3 end
			if yspeed < -3 then yspeed = -3 end
			self.ball.velocity.y = self.ball.velocity.y + yspeed
			if self.ball.velocity.y > 5 then self.ball.velocity.y = 5 end
			if self.ball.velocity.y < -5 then self.ball.velocity.y = -5 end
		end
		if self.ball.location.y - self.ball.velocity.y >= self.player.location.y + self.player.height/2 + self.ball.r then
			self.pong_audio:play()
			self.ball.velocity.y = self.ball.velocity.y * -1
		end
		if self.ball.location.y - self.ball.velocity.y <= self.player.location.y - self.player.height/2 - self.ball.r then
			self.pong_audio:play()
			self.ball.velocity.y = self.ball.velocity.y * -1
		end
	end

	if self.ball.location.x > self.enemy.location.x - self.enemy.width/2 - self.ball.r and self.ball.location.x < self.enemy.location.x + self.enemy.width/2 + self.ball.r and self.ball.location.y < self.enemy.location.y + self.enemy.height/2 + self.ball.r and self.ball.location.y > self.enemy.location.y - self.enemy.height/2 - self.ball.r then
		if self.ball.location.x - self.ball.velocity.x <= self.enemy.location.x - self.enemy.width/2 - self.ball.r then
			self.ball.velocity.x = self.ball.velocity.x * -1
			self.pong_audio:play()
		end
		if self.ball.location.y - self.ball.velocity.y >= self.enemy.location.y + self.enemy.height/2 + self.ball.r then
			self.ball.velocity.y = self.ball.velocity.y * -1
			self.pong_audio:play()
		end
		if self.ball.location.y - self.ball.velocity.y <= self.enemy.location.y - self.enemy.height/2 - self.ball.r then
			self.ball.velocity.y = self.ball.velocity.y * -1
			self.pong_audio:play()
		end
	end


    if self.ball.location.y > height - self.ball.r then 
        self.ball.location.y = height - self.ball.r
        self.ball.velocity.y = -1*self.ball.velocity.y
    elseif self.ball.location.y < self.ball.r then 
        self.ball.location.y = self.ball.r
        self.ball.velocity.y = -1*self.ball.velocity.y
    end
    if self.player.location.y > height - self.player.height/2 then 
        self.player.location.y = height - self.player.height/2
    elseif self.player.location.y < self.player.height/2 then 
        self.player.location.y = self.player.height/2
    end
    if self.enemy.location.y > height - self.enemy.height/2 then 
        self.enemy.location.y = height - self.enemy.height/2
    elseif self.enemy.location.y < self.enemy.height/2 then 
        self.enemy.location.y = self.enemy.height/2
    end

    if self.ball.location.x > width - self.ball.r then 
        if self.score[1] == 9 then 
        	Page = "win_page"
            game_started = false
        	self.win_audio:play() 
        end
        self.ball.location.x = width/2
        self.ball.location.y = 0
        throw_random = love.math.random(2)
    	if throw_random==1 then self.ball.velocity.x = -self.ball.xspeed else self.ball.velocity.x = self.ball.xspeed end
    	self.ball.xspeed = self.ball.xspeed + 0.5
    	self.score[1] = self.score[1] + 1;

    	self.enemy.location.x = width-self.enemy.width/2
    	self.enemy.location.y = self.enemy.height/2

    elseif self.ball.location.x < self.ball.r then 
        if self.score[2] == 9 then 
        	Page = "loss_page"
            game_started = false
        	self.go_audio:play() 
        end
        self.ball.location.x = width/2
        self.ball.location.y = math.random() * height

        self.ball.velocity = (self.ball.velocity - Vector:create(0, math.random() * height)):norm()

        throw_random = love.math.random(2)
    	if throw_random==1 then self.ball.velocity.x = -self.ball.xspeed else self.ball.velocity.x = self.ball.xspeed end
    	self.ball.xspeed = self.ball.xspeed + 0.5
    	self.score[2] = self.score[2] + 1;

    	self.enemy.location.x = width-self.enemy.width/2
    	self.enemy.location.y = self.enemy.height/2
    end

end

function GamePage:keypressed(key)
	if key == 'escape' then
        Page="hello_page"
    end
end