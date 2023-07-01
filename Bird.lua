Bird = Class {}

function Bird:init()
  self.sprite = love.graphics.newImage('assets/imgs/bird.png')
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Bird:render()
  love.graphics.draw(self.sprite, self.x, self.y)
end
