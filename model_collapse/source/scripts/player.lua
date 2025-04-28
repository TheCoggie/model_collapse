-- Constants --
local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(AnimatedSprite)

function Player:init(x, y)
    -- State Machine --
    local playerImageTable = gfx.imagetable.new("images/player-table-16-16")
    Player.super.init(self, playerImageTable)

    -- States --
    self:addState("idle", 1, 1)
    self:addState("run", 1, 3, {tickStep = 4})
                            -- A tick is how often code updates. The update for the animation is done here every 4 updates--
    self:addState("jump", 4, 4)
    self:playAnimation()


    --Sprite properties--
    self:moveTo(x, y)
    self:setZIndex(Z_INDEXES.Player)
    self:setTag(TAGS.Player)
    self:setCollideRect(3, 3, 10, 13)

    --Physics Properties-- There's no built in way to do physics so it needs to be done manually...
    self.xVelocity = 0
    self.yVelocity = 0
    self.gravity = 1.0
    self.maxSpeed = 2

    -- Player state --
    self.touchingGround = false
end

function Player:collisionResponse()
    return gfx.sprite.kCollisionTypeSlide

end

function Player:update()
    self:updateAnimation()

    self:handleState()
    self:handleMovementAndCollisions()
end

function Player:handleState()
    if self.currentState == "idle" then
        self:applyGravity()
        self:handleGroundInput()
    elseif self.currentState == "run" then
        self:applyGravity()
        self:handleGroundInput()
    elseif self.currentState == "jump" then

    end
end

function Player:handleMovementAndCollisions()
    local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)

    self.touchingGround = false
    for i=1,length do
        local collision = collisions[i]
        if collision.normal.y == -1 then
            self.touchingGround = true
        end
    end
end

-- Input Method --
function Player:handleGroundInput()
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self:changeToRunState("left")
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        self:changeToRunState("right")
    else
        self:changeToIdleState()
    end
end

-- State Transition Method --
function Player:changeToIdleState()
    self.xVelocity = 0
    self:changeState("idle")
end

function Player:changeToRunState(direction)
    if direction == "left" then
        self.xVelocity = -self.maxSpeed
    elseif direction == "right" then
        self.xVelocity = self.maxSpeed
    end
self:changeState("run")
end

-- Physics Helper Functions --
function Player:applyGravity()
    self.yVelocity += self.gravity
    if self.touchingGround then
        self.yVelocity = 0
    end
end