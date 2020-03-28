# auto_atlas
automatic sprite atlas constructor, using leafi's 2d packer.

#  unfinished
- Initialization

Can create as many atlases as you want, however 1 atlas is most efficient.
```lua
local new_atlas = require "atlas_path/init.lua"


local atlas = new_atlas(2000, 2000)    
-- Creates new atlas, of size 2000*2000.
--default size is 2048 * 2048
```



- Adding sprites
```lua
--  Set default path to get sprites from:  (optional)
atlas.path = "sprites/animals/"

--  Set default table to add new sprites to:   (optional)
local quads = {}
atlas.default = quads
--   This will add the quad to the table automatically, with the name as the key.

-- Set default filetype:
atlas.type = "png"


atlas:add("monkey")  -- Gets sprites/animals/monkey.png
quads["monkey"] --> Access to monkey sprite!
```
