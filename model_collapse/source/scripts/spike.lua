local gfx <const> = playdate.graphics


class('Spike').extends(AnimatedSprite)

function Spike:init(x, y)
    local spikeImageTable <const> = gfx.imagetable.new("images/spike-table-16-16")
    Spike.super.init(self, spikeImageTable)

    self:addState("sparkle", 1, 9, {tickStep = 5})
    self:playAnimation()

    self:setZIndex(Z_INDEXES.Hazard)
    self:setCenter(0, 0)
    self:moveTo(x, y)
    self:add()
    
    self:setTag(TAGS.Hazard)
    self:setCollideRect(0, 10, 16, 7)
end