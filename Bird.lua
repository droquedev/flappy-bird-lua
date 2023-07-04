Bird = Class {}

local GRAVITY = 0
local ROTATION = 0

function Bird:init()
  self.sprite = love.graphics.newImage('assets/imgs/bird.png')
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  self.timer = 1
  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

  self.dy = 0
end

function Bird:render()
  love.graphics.draw(self.sprite, self.x, self.y, ROTATION)
  -- collider box
  -- love.graphics.rectangle('line', self.x + 2, self.y + 2, self.width - 4, self.height - 4)
end

function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt

  self.timer = self.timer + dt

  local wasSpacePressed = love.keyboard.wasPressed('space')
  local isOutScreen = self.y <= 0 + self.height
  if wasSpacePressed and isOutScreen == false then
    GRAVITY = 0
    self.dy = -2
    SOUNDS['jump']:play()
    ROTATION = -0.3
    self.timer = 0
  else
    if GRAVITY < 20 and self.timer >= 0.15 then
      GRAVITY = GRAVITY + 1
    end
    if ROTATION < 0.3 and self.timer >= 0.3 then
      ROTATION = ROTATION + 0.02
    end
  end

  self.y = self.y + self.dy
end

function Bird:collides(pipe)
  if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
    if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
      return true
    end
  end
end
