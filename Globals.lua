Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'states/CountDownState'

GROUND_SCROLL_SPEED = 80
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

SOUNDS = {
  ['jump'] = love.audio.newSource('assets/sfx/jump.wav', 'static'),
  ['explosion'] = love.audio.newSource('assets/sfx/explosion.wav', 'static'),
  ['hurt'] = love.audio.newSource('assets/sfx/hurt.wav', 'static'),
  ['score'] = love.audio.newSource('assets/sfx/score.wav', 'static'),

  ['music'] = love.audio.newSource('assets/music/marios_way.mp3', 'static')
}

SCROLLING = true

STATE_MACHINE = nil

MEDIUM_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
FLAPPY_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
HUGE_FONT = love.graphics.newFont('assets/fonts/flappy.ttf', 56)
MAX_SCORE = 0
SAVE_FILE = nil

PIPE_SPEED = 100
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function SaveScore(score)
  love.filesystem.write('score.txt', tostring(score))
end

function GetMaxScore()
  local score = love.filesystem.read('score.txt')
  MAX_SCORE = tonumber(score)
end
