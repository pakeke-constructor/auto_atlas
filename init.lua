local PATH = (...):gsub('%.[^%.]+$',"" )
local binpack = require(PATH..".binpack")


local lg = love.graphics

local atlas = {}

local atlas_mt = { __index = atlas }

atlas.new = function(x, y)
    local x = x or 2048
    local y = y or 2048
    return setmetatable({
        width, height = x, y,
        binpack = binpack(x, y),
        canvas = lg.newCanvas(x, y)
    }, atlas_mt)
end

function atlas:add(sprite, quad)
    assert(sprite:typeOf("image"), " atlas:add( image, [quad] )  expected image to be of type \n Image. instead, got type:  "..tostring(type(sprite)))

    local width = sprite:getWidth()
    local height = sprite:getHeight()

    if quad then
        assert(quad:typeOf("quad"), " atlas:add( image, [quad] )  expected optional arg [quad] to be of type \n quad. instead, got type:  "..tostring(type(quad)))
        local new = self.binpack:insert(width+1, height+1)
        lg.setCanvas(self.canvas)
            lg.draw(sprite, quad, new.x, new.y)
        lg.setCanvas()
        return lg.newQuad(new.x, new.y, width, height, self.width, self.height)
    else
        local new = self.binpack:insert(width+1, height+1)
        lg.setCanvas(self.canvas)
            lg.draw(sprite, new.x, new.y)
        lg.setCanvas()
        return lg.newQuad(new.x, new.y, width, height, self.width, self.height)
    end
end

return setmetatable( atlas, {__call = atlas.new} )

