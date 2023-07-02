ScoreState = Class { __includes = BaseState }

function ScoreState:enter(params)
  self.score = params.score
  SaveScore(self.score)
end

function ScoreState:update()
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    STATE_MACHINE:change('countdown')
  end
end

function ScoreState:render()
  love.graphics.setFont(FLAPPY_FONT)
  love.graphics.printf('Score: ' .. tostring(self.score), 0, 64, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Max Score: ' .. tostring(MAX_SCORE), 0, 100, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(MEDIUM_FONT)

  love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
