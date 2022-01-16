GameoverPage = {}
GameoverPage.__index = GameoverPage

gameover = love.graphics.newImage("assets/sprites/gameover.png")

function GameoverPage:create()
    local page = {}
    setmetatable(page, GameoverPage)
    page.score = 0
    return page
end

function GameoverPage:draw()
    love.graphics.clear()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(gameover, (width - gameover:getWidth()) / 2, (height - gameover:getHeight()) / 4)
    
    love.graphics.print("Your result: " .. tostring(self.score), width * 5 / 13, height *  2 / 5)
end

function GameoverPage:update()
end

function GameoverPage:mousepressed(button)
    if button == 1  then 
        play_page = PlayPage:create()
        Page = "hello_page"
    end
end

function GameoverPage:keypressed(key)
    if key == 'space' then
        play_page = PlayPage:create()
        Page = "hello_page"
    end
end