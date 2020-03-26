# auto_atlas
automatic sprite atlas constructor, using leafi's 2d packer.

Not yet tested

!!!!
TODO:
Back up the canvas with ImageData, 
because love.window.setMode calls wipe all canvases. 
!!!!
```lua
local new_atlas = require "atlas_path/init.lua"


local A = new_atlas()    --default size is 2048 * 2048

local monkey = A:add( love.graphics.newImage("monkey.png") )
-- Adds image to atlas, and gives quad in return.
-- "monkey" is now a quad to be used with atlas.

function love.draw()
   love.graphics.draw(A.image, monkey, x, y)
   -- OR, an easier way::
   
   A:draw( monkey, x, y )      -- executes love.graphics.draw normally, is just easier.
   
end
```
