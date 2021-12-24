HelloPage = {}
HelloPage.__index = HelloPage

function HelloPage:create()
	local page = {}
    setmetatable(page, HelloPage)
    return page
end

function HelloPage:draw()
	love.graphics.setFont(mainFont)
	love.graphics.setColor(255, 0, 0)
	love.graphics.printf("Pong", 0, 130, width, 'center')
	love.graphics.setColor(0, 0, 255)
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(sFont)
	if game_started then
		love.graphics.printf("Press any key to resume", 0, 230, width, 'center')
		love.graphics.printf("Press Esc key to close the game", 0, 300, width, 'center')
	else
		love.graphics.printf("Press any key to play", 0, 230, width, 'center')
	end
end

function HelloPage:update()
end

function HelloPage:keypressed(key)
	if game_started then
		if key == 'escape' then
			love.event.quit()
		end
	end
	love.mouse.setVisible(true)
	Page="game_page"
end