local gfx <const> = playdate.graphics


class('Bouncy').extends(AnimatedSprite)

function Bouncy:init(x, y)
    local bouncyImageTable <const> = gfx.imagetable.new("images/bouncy-table-16-16")
    Bouncy.super.init(self, bouncyImageTable)

    self:addState("boing", 1, 12, {tickStep = 5})
    self:playAnimation()

    self:setZIndex(Z_INDEXES.Bouncy)
    self:setCenter(0, 0)
    self:moveTo(x, y)
    self:add()
    
    self:setTag(TAGS.Bouncy)
    self:setCollideRect(0, 8, 16, 8)
end