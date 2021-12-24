LossPage = {}
LossPage.__index = LossPage

function LossPage:create()
	local page = {}
    setmetatable(page, LossPage)
    return page
end

function LossPage:draw()
	love.graphics.setFont(mainFont)
    love.graphics.setColor(255, 0, 0)
	love.graphics.printf("You've lost!", 0, 130, width, 'center')
	love.graphics.setFont(sFont)
    love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Press Enter to restart", 0, 210, width, 'center')
    love.graphics.printf("Press Esc to exit game", 0, 290, width, 'center')
end

function LossPage:update()
end

function LossPage:keypressed(key)
	if key == 'return' then
        love.mouse.setVisible(true)
        Page="game_page"
        game_page:restart()
    end
    if key == 'escape' then
        love.event.quit()
    end
end