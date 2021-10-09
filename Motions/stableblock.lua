Stableblock = {}

Stableblock.__index = Stableblock

function Stableblock:create(x, y, width, height, color)
    local stableblock = {}
    setmetatable(stableblock, Stableblock)
    stableblock.x = x
    stableblock.y = y
    stableblock.width = width
    stableblock.height = height
    stableblock.color = color    
    return stableblock
end

function Stableblock:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(r, g, b, a)
end