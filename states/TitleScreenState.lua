TitleScreenState = Class { __includes = BaseState }

function TitleScreenState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    G_StateMachine:change('countdown')
  end
end

function TitleScreenState:render()
  love.graphics.setFont(FLAPPY_FONT)
  love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(MEDIUM_FONT)
  love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end
