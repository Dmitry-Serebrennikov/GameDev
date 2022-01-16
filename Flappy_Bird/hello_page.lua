HelloPage = {}
HelloPage.__index = HelloPage

hello_message = love.graphics.newImage("assets/sprites/message.png")
bird_image = love.graphics.newImage("assets/sprites/yellowbird-midflap.png")

function HelloPage:create()
	local page = {}
    setmetatable(page, HelloPage)
    return page
end

function HelloPage:draw()
    love.graphics.clear()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(hello_message, (width - hello_message:getWidth()) / 2, (height - hello_message:getHeight()) / 2)
    love.graphics.draw(bird_image, (width - bird_image:getWidth()) / 2, (height - bird_image:getHeight()) * 3/5)
end

function HelloPage:update()
end

function HelloPage:mousepressed(button)
    if button == 1 then
        Page = "play_page"
    end
end

function HelloPage:keypressed(key)
    if key == 'escape' then
		love.event.quit()
	end

    if key == 'space' then
        Page = "play_page"
    end
end