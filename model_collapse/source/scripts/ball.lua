local gfx <const> = playdate.graphics


class('Ball').extends(AnimatedSprite)

function Ball:init(x, y, entity)
    local ballImageTable <const> = gfx.imagetable.new("images/ball-table-32-24")
    Ball.super.init(self, ballImageTable)

    self:addState("upDown", 1, 6, {tickStep = 1})
    self:playAnimation()

    self:setZIndex(Z_INDEXES.Hazard)
    self:setCenter(0, 0)
    self:moveTo(x, y)
    self:add()

    self:setTag(TAGS.Hazard)
    self:setCollideRect(8, 5, 18, 16)

    local fields = entity.fields
    self.xVelocity = fields.xVelocity
    self.yVelocity = fields.yVelocity
end

function Ball:collisionResponse(other)
    if other:getTag() == TAGS.Player then
        return gfx.sprite.kCollisionTypeOverlap
    end
    return gfx.sprite.kCollisionTypeBounce
end

function Ball:update()
    local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)
    local hitWall = false
    for i=1, length do
        local collision = collisions[i]
        if collision.other:getTag() ~= TAGS.Player then
            hitWall = true
        end
    end
    self:updateAnimation()
    if hitWall then
        self.xVelocity *= -1
        self.yVelocity *= -1
    end
end