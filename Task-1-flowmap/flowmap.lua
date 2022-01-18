FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create (size)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
    love.math.setRandomSeed(10000)
    return map
end 

function FlowMap:init()
	local cols = width/self.size
	local rows = height/self.size
	for i = 1, rows do
		self.field[i] = {}
		for j = 1, cols do
			if i % 2 == 1 then
				if j % 2 == 1 then
					self.field[i][j] = Vector:create(0, -1)
				else
					self.field[i][j] = Vector:create(0, 1)
				end
			else 
				if j % 2 == 1 then
					self.field[i][j] = Vector:create(1, 0)
				else
					self.field[i][j] = Vector:create(-1, 0)
				end
			end
		end
	end
end

function FlowMap:lookup(v)
	local col = math.constrain(math.floor(v.x/self.size)+1, 1, #self.field[1])
	local row = math.constrain(math.floor(v.y/self.size)+1, 1, #self.field)
	return self.field[row][col]:copy()

	-- local col = math.floor(v.x/self.size) % #self.field[1]
	-- local row = math.floor(v.y/self.size) % #self.field
	-- return self.field[row+1][col+1]:copy()
end

function FlowMap:draw()
	for i = 1, #self.field do
		for j = 1, #self.field[1] do
			drawVector(self.field[i][j], (j-1) * self.size, i * self.size , self.size-2)
		end
	end
end

function drawVector(v, x, y, s)
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(v:heading())
	local len = v:mag() * s
	love.graphics.line(0, 0, len / 3, 0)
	love.graphics.circle("fill", len / 3, 0, 3)
	love.graphics.pop()
end
