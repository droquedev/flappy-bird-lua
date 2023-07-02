require 'Globals'
local push = require 'push'

local background = love.graphics.newImage('assets/imgs/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/imgs/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 50
local BACKGROUND_LOOPING_POINT = 413


function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle("David's Flappy Bird")

  local fileName = 'score.txt'

  local exists = love.filesystem.getInfo(fileName)
  if not exists then
    local saveFile = love.filesystem.newFile(fileName)
    saveFile:open('w')
    saveFile:write(tostring(0))
    saveFile:close()
  else
    GetMaxScore()
  end

  love.graphics.setFont(FLAPPY_FONT)

  SOUNDS['music']:setLooping(true)
  SOUNDS['music']:setVolume(0.1)
  SOUNDS['music']:play()

  math.randomseed(os.time())

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })

  STATE_MACHINE = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end,
    ['countdown'] = function() return CountDownState() end
  }
  STATE_MACHINE:change('title')

  love.keyboard.keysPressed = {}
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

  STATE_MACHINE:update(dt)

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.draw()
  push:start()

  love.graphics.draw(background, -backgroundScroll, 0)
  STATE_MACHINE:render()
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

  push:finish()
end
