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

GameScene()

local pd <const> = playdate
local gfx <const> = playdate.graphics

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end


