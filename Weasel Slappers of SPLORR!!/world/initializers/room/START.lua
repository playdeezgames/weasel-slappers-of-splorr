local grimoire = require "game.grimoire"
local room = require "world.room"
local room_type = require "world.room_type"
local character = require "world.character"
local character_type = require "world.character_type"
local avatar = require "world.avatar"
local room_cell = require "world.room_cell"
local room_cell_type = require "world.room_cell_type"

local room_id = room.create(room_type.START, grimoire.BOARD_COLUMNS, grimoire.BOARD_ROWS)
local room_cell_id = room.get_room_cell(room_id, math.floor(grimoire.BOARD_COLUMNS / 2), math.floor(grimoire.BOARD_ROWS / 2))
local avatar_character_id = character.create(character_type.HERO, room_cell_id)
avatar.set_character(avatar_character_id)

character.create(character_type.WEASEL, room.get_room_cell(room_id, grimoire.BOARD_COLUMNS - 1, grimoire.BOARD_ROWS - 1))
character.create(character_type.WEASEL, room.get_room_cell(room_id, 2, grimoire.BOARD_ROWS - 1))
character.create(character_type.WEASEL, room.get_room_cell(room_id, grimoire.BOARD_COLUMNS - 1, 2))
character.create(character_type.WEASEL, room.get_room_cell(room_id, 2, 2))

local stump_count = 25
while stump_count > 0 do
    local column, row = math.random(1, grimoire.BOARD_COLUMNS), math.random(1, grimoire.BOARD_ROWS)
    room_cell_id = room.get_room_cell(room_id, column, row)
    if not room_cell.has_character(room_cell_id) then
        if room_cell.get_room_cell_type(room_cell_id) ~= room_cell_type.STUMP then
            room_cell.set_room_cell_type(room_cell_id, room_cell_type.STUMP)
            stump_count = stump_count - 1
        end
    end
end