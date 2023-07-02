Bird = Class {}

local GRAVITY = 0

function Bird:init()
  self.sprite = love.graphics.newImage('assets/imgs/bird.png')
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

  self.dy = 0
end

function Bird:render()
  love.graphics.draw(self.sprite, self.x, self.y)
end

function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt

  local wasSpacePressed = love.keyboard.wasPressed('space')
  local isOutScreen = self.y <= 0 + self.height
  if wasSpacePressed and isOutScreen == false then
    GRAVITY = 0
    self.dy = -3
    SOUNDS['jump']:play()
  end

  if (GRAVITY < 25) then
    GRAVITY = GRAVITY + 1
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
