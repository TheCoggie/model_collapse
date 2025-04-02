-- Constants --
local gfx <const> = playdate.graphics
local ldtk <const> = LDtk

ldtk.load("levels/labs.ldtk", false)

class('GameScene').extends()

function GameScene:init()
    self:goToLevel("level_0")

end

-- Moving levels --
function GameScene:goToLevel(level_0)
    -- Removing sprites stops lag and clutter.
    -- As everything is made of sprites, below is a fast way to get rid of them when you move levels.
    gfx.sprite.removeAll()

    -- layer loop --
    for layer_name, layer in pairs(ldtk.get_layers(level_0)) do
        if layer.tiles then 
            local tilemap = ldtk.create_tilemap(level_0, walls)

            -- this is the Playdate tile map object that causes the sprite to draw the tile map --
            local layerSprite = gfx.sprite.new()
            layerSprite:setTilemap(tilemap)
            layerSprite:setCenter(0,0)
            layerSprite:moveTo(0,0)
            layerSprite:setZIndex(layer.zIndex)
            layerSprite:add()

            local emptyTiles = ldtk.get_empty_tileIDs(level_0, "Solid", walls)
            if emptyTiles then
                gfx.sprite.addWallSprites(tilemap, emptyTiles)
            end
        end
    end
end
