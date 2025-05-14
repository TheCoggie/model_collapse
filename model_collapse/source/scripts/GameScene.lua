-- Constants --
local gfx <const> = playdate.graphics
local ldtk <const> = LDtk

TAGS = {
    Player = 1,
    Hazard = 2,
    Pickup = 3,
    Bouncy = 4
}

Z_INDEXES = {
    Player = 100,
    Hazard = 20,
    Pickup = 50,
    Bouncy = 20
}

ldtk.load("levels/labs.ldtk", false)

class('GameScene').extends()

function GameScene:init()
    self:goToLevel("Level_5")
    self.spawnX = 5 * 16
    self.spawnY = 10 * 16

    self.player = Player(self.spawnX, self.spawnY, self)
end

function GameScene:resetPlayer()
self.player:moveTo(self.spawnX, self.spawnY)
end

function GameScene:enterRoom(direction)
    local level = ldtk.get_neighbours(self.levelName, direction)[1]
    self:goToLevel(level)
    self.player:add()
    local spawnX, spawnY
    if direction == "north" then 
        spawnX, spawnY = self.player.x, 240
    elseif direction == "south" then
        spawnX, spawnY = self.player.x, 0
    elseif direction == "east" then
        spawnX, spawnY = 0, self.player.y
    elseif direction == "west" then
        spawnX, spawnY = 400, self.player.y
    end
    self.player:moveTo(spawnX, spawnY)
    self.spawnX = spawnX
    self.spawnY = spawnY
end


    

-- Moving levels --
function GameScene:goToLevel(level_name)
    -- Removing sprites stops lag and clutter. --
    -- As everything is made of sprites, below is a fast way to get rid of them when you move levels. --
    gfx.sprite.removeAll()
    print(level_name)
    self.levelName = level_name

    -- layer loop --
    for layer_name, layer in pairs(ldtk.get_layers(level_name)) do
        if layer.tiles then
            local tilemap = ldtk.create_tilemap(level_name, layer_name)

            -- this is the Playdate tile map object that causes the sprite to draw the tile map. --
            local layerSprite = gfx.sprite.new()
            layerSprite:setTilemap(tilemap)
            layerSprite:setCenter(0,0)
            layerSprite:moveTo(0,0)
            layerSprite:setZIndex(layer.zIndex)
            layerSprite:add()

            local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Solid", layer_name)
            if emptyTiles then
                gfx.sprite.addWallSprites(tilemap, emptyTiles) -- "source/levels/tileset-table-16-16.png" --
            end
        end
    end
    for _, entity in ipairs(ldtk.get_entities(level_name)) do
        local entityX, entityY = entity.position.x, entity.position.y
        local entityName = entity.name
        if entityName == "Spike" then
            Spike(entityX, entityY)
        elseif entityName == "Ball" then
            Ball(entityX, entityY, entity)
        elseif entityName == "Ability" then
            Ability(entityX, entityY, entity)
        elseif entityName == "Bouncy" then
            Bouncy(entityX, entityY, entity)
        end
    end
end