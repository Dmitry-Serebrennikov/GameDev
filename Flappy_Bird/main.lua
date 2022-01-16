require "hello_page"
require "play_page"
require "gameover_page"
require "vector"

function love.load()
    
    background = love.graphics.newImage("assets/sprites/background-day.png")
    ground = love.graphics.newImage("assets/sprites/base.png")

    width = background:getWidth()
    height = background:getHeight()

    Page = "hello_page"
    hello_page = HelloPage:create()
    play_page = PlayPage:create()
    gameover_page = GameoverPage:create()
end

function love.draw()
    if Page == "hello_page" then
        hello_page:draw()
    elseif Page == "play_page" then
        play_page:draw()
    elseif Page == "gameover_page" then
        gameover_page:draw()
    end
end

function love.update(dt)
    if Page == "hello_page" then
        hello_page:update(dt)
    elseif Page == "play_page" then
        play_page:update(dt)
    elseif Page == "gameover_page" then
        gameover_page:update(dt)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if Page == "hello_page" then
            hello_page:mousepressed(button)
        elseif Page == "play_page" then
            play_page:mousepressed(button)
        elseif Page == "gameover_page" then
            gameover_page:mousepressed(button)
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    
    elseif key == 'space' then
        if Page == "hello_page" then
            hello_page:keypressed(key)
        elseif Page == "play_page" then
            play_page:mousepressed(1)
        elseif Page == "gameover_page" then
            gameover_page:keypressed(key)
        end
    end
end