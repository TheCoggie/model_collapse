-- Corelibs from the Playdate SDK --
import "Corelibs/object"
import "Corelibs/timer"
import "Corelibs/graphics"
import "Corelibs/sprites"

-- Libraries from github --
import "scripts/libraries/AnimatedSprite"
import "scripts/libraries/LDtk"

-- Game --
import "scripts/player"
import "scripts/gameScene"
import "scripts/spike"
import "scripts/ball"
import "scripts/ability"
import "scripts/bouncy"

GameScene()

local pd <const> = playdate
local gfx <const> = playdate.graphics

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end

function dino()
    print("RAWR")-- make a Go-tan rawr noise here?
end

local menu = playdate.getSystemMenu()

local menuItem, error = menu:addMenuItem("\'\'\'\\|o vvvv o|/\'\'\'", function()
-- make a Go-tan rawr noise here.
    dino()
end)