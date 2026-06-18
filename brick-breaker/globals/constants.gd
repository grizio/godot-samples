extends Node

enum Variant {
  NORMAL,
  FLOW,
}

const collision_physics = 1
const collision_ball = 2
const collision_brick = 3
const collision_brick_solid = 4

# https://lospec.com/palette-list/pico-8
var color_black = Color.html("#000000")
var color_dark_blue = Color.html("#1D2B53")
var color_dark_purple = Color.html("#7E2553")
var color_dark_green = Color.html("#008751")
var color_brown = Color.html("#AB5236")
var color_dark_grey = Color.html("#5F574F")
var color_light_grey = Color.html("#C2C3C7")
var color_wheat = Color.html("#FFF1E8")
var color_red = Color.html("#FF004D")
var color_orange = Color.html("#FFA300")
var color_yellow = Color.html("#FFEC27")
var color_light_green = Color.html("#00E436")
var color_light_blue = Color.html("#29ADFF")
var color_light_purple = Color.html("#83769C")
var color_pink = Color.html("#FF77A8")
var color_peach = Color.html("#FFCCAA")

# powers
const power_ball_power_up_1: String = "ball_power_up_1"
const power_ball_generator: String = "ball_generator"
const power_fire: String = "fire"

# groups
const group_level: String = "level"
const group_ball: String = "ball"