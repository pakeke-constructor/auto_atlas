
local PATH = (...):gsub('%.[^%.]+$','')
local binpack = require(PATH..".binpack")


local lg = love.graphics

local atlas = {}

local atlas_mt = { __index = atlas }

atlas.new = function(x, y)
    x = x or 2048
    y = y or 2048
    return setmetatable({
        width = x, height = y,
        binpack = binpack(x, y),
        image = love.image.newImageData(x, y),
        path = ""
    }, atlas_mt)
end


function atlas:draw(quad, x, y, r, sx, sy, ox, oy, kx, ky )
    lg.draw( self.image, quad, x, y, r, sx, sy, ox, oy, kx, ky )
end

function atlas:add( sprite, quad )
    assert(sprite, " atlas:add(sprite) missing compulsory first argument: sprite.\n Arg sprite must be an image path, or love image.")
    
    lg.push()
    lg.reset()


    if type(sprite) == "string" then
        local sprite_path = self.path..sprite
        sprite = lg.newImage(sprite_path)
        local width,height = sprite:getWidth(), sprite:getHeight()
        local new = self.binpack:insert(width+1, height+1)
        -- Converting Image to Canvas:
        local temp_canvas = lg.newCanvas(width, height)
        temp_canvas:draw(sprite)
        -- Canvas to ImageData:
        local img_data = temp_canvas:getImageData()
        -- ImageData w/ Image:replacePixels
        self.image:replacePixels(img_data, nil, 1, new.x, new.y)
        lg.pop()
        return lg.newQuad(new.x, new.y, width, height, self.width, self.height)
    end

    -- Is image  +  quad.
    if quad then
        assert(quad:typeOf("quad"), " atlas:add( image, [quad] )  expected optional arg [quad] to be of type \n quad. instead, got type:  "..tostring(type(quad)))
        local _, _, width, height = quad:getViewport()
        local new = self.binpack:insert(width+1, height+1)
        -- Converting Image to Canvas:
        local temp_canvas = lg.newCanvas(width, height)
        temp_canvas:draw(sprite, quad)
        local img_data = temp_canvas:getImageData()
        -- ImageData w/ Image:replacePixels
        self.image:replacePixels(img_data, nil, 1, new.x, new.y)
        lg.pop()
        return lg.newQuad(new.x, new.y, width, height, self.width, self.height)

    -- Is image.
    else
        local width, height = sprite:getWidth(), sprite:getHeight()
        local new = self.binpack:insert(width+1, height+1)
        -- Converting Image to Canvas:
        local temp_canvas = lg.newCanvas(width, height)
        temp_canvas:draw(sprite)
        -- Canvas to ImageData:
        local img_data = temp_canvas:getImageData()
        -- ImageData w/ Image:replacePixels
        self.image:replacePixels(img_data, nil, 1, new.x, new.y)
        lg.pop()
        return lg.newQuad(new.x, new.y, width, height, self.width, self.height)
    end
end

return setmetatable(atlas, {__call = atlas.new})


