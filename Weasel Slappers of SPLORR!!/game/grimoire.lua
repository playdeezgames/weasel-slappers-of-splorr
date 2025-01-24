local M = {}
M.BOARD_COLUMNS = 20
M.BOARD_ROWS = 20

M.URL_SCENE_TILEMAP = "/scene#scene"
M.URL_INTERACTOR_TEXT = "/interactor#output"

M.LAYER_ROOM_CELL = "room_cell"
M.LAYER_CHARACTER = "character"
M.LAYER_EFFECT = "effect"

M.TILE_GRASS = 1
M.TILE_HERO = 2
M.TILE_WEASEL = 3
M.TILE_DITHER = 4
M.TILE_STUMP = 5

M.ACTION_UP = "UP"
M.ACTION_DOWN = "DOWN"
M.ACTION_LEFT = "LEFT"
M.ACTION_RIGHT = "RIGHT"
M.ACTION_GREEN = "GREEN"
M.ACTION_RED = "RED"
return M