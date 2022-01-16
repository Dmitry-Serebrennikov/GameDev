GameoverPage = {}
GameoverPage.__index = GameoverPage

gameover = love.graphics.newImage("assets/sprites/gameover.png")

function GameoverPage:create()
    local page = {}
    setmetatable(page, GameoverPage)
    page.score = 0

    page.score_numbers = {}
    for i = 1, 10 do
        page.score_number_path = "assets/sprites/" .. (i - 1) .. ".png"
        page.score_numbers[i] = love.graphics.newImage(page.score_number_path)
    end

    resultFont = love.graphics.newFont("assets/FlappyBirdy.ttf", 60);
    return page
end

function GameoverPage:draw()
    love.graphics.clear()
    if self.score < 10 then
        love.graphics.draw(background, 0, 0)
    else
        love.graphics.draw(night_background, 0, 0)
    end
    love.graphics.draw(gameover, (width - gameover:getWidth()) / 2, (height - gameover:getHeight()) / 4) 
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(resultFont)
    love.graphics.printf("Result", width * 3 / 13, height *  2 / 5, width)
    love.graphics.setColor(255, 255, 255)

    if self.score < 10 then 
        love.graphics.draw(self.score_numbers[self.score + 1], width * 8 / 13, height *  2 / 5)
    else
        self.str_score = tostring(self.score)
        for i = 1, string.len(self.str_score) do
            love.graphics.draw(self.score_numbers[tonumber(string.sub(self.str_score, i, i)) + 1], width * 8 / 13 + (i - 1) * 25, height *  2 / 5)
        end
    end
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