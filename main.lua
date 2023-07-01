Class = require 'class'
local push = require 'push'

GROUND_SCROLL_SPEED = 60
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'states/CountDownState'

local background = love.graphics.newImage('assets/imgs/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/imgs/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514

local bird = Bird()

local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

SCROLLING = true

G_StateMachine = nil

local smallFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
MEDIUM_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
FLAPPY_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
HUGE_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 56)

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle("David's Flappy Bird")

  love.graphics.setFont(FLAPPY_FONT)

  math.randomseed(os.time())

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })

  G_StateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end,
    ['countdown'] = function() return CountDownState() end
  }
  G_StateMachine:change('title')

  love.keyboard.keysPressed = {}
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

  G_StateMachine:update(dt)

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
  G_StateMachine:render()
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

  push:finish()
end
