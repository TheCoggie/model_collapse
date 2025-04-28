-- Constants --
local gfx <const> = playdate.graphics
local ldtk <const> = LDtk

TAGS = {
    Player = 1
}

Z_INDEXES = {
    Player = 100
}

ldtk.load("levels/labs.ldtk", false)

class('GameScene').extends()

function GameScene:init()
    self:goToLevel("Level_0")
    self.spawnX = 5 * 16
    self.spawnY = 10 * 16
    self.player = Player(self.spawnX, self.spawnY)

end

-- Moving levels --
function GameScene:goToLevel(level_name)
    -- Removing sprites stops lag and clutter.
    -- As everything is made of sprites, below is a fast way to get rid of them when you move levels.
    gfx.sprite.removeAll()

    -- layer loop --
    for layer_name, layer in pairs(ldtk.get_layers(level_name)) do
        if layer.tiles then
            local tilemap = ldtk.create_tilemap(level_name, layer_name)

            -- this is the Playdate tile map object that causes the sprite to draw the tile map --
            local layerSprite = gfx.sprite.new()
            layerSprite:setTilemap(tilemap)
            layerSprite:setCenter(0,0)
            layerSprite:moveTo(0,0)
            layerSprite:setZIndex(layer.zIndex)
            layerSprite:add()

            local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Solid", layer_name)
            if emptyTiles then
                gfx.sprite.addWallSprites(tilemap, emptyTiles) -- "source/levels/tileset-table-16-16.png"
            end
        end
    end
end
