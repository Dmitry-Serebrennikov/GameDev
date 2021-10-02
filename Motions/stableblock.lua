Stableblock = {}

Stableblock.__index = Stableblock

function Stableblock:create(x, y, width, height)
    local stableblock = {}
    setmetatable(stableblock, Stableblock)
    stableblock.x = x
    stableblock.y = y
    stableblock.width = width
    stableblock.height = height    
    return stableblock
end

function Stableblock:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end