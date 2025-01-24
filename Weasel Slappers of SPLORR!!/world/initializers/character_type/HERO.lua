local character_type = require "world.character_type"
local verb_type      = require "world.verb_type"
local direction = require "game.direction"
local character = require "world.character"
local room_cell = require "world.room_cell"
local room      = require "world.room"
local interaction_type = require "world.interaction_type"
local room_cell_type   = require "world.room_cell_type"

character_type.set_initializer(
    character_type.HERO,
    function(character_id)
    end)
local function move_other_characters(character_id, room_id)
    local other_characters = {}
    for column = 1, room.get_columns(room_id) do
        for row = 1, room.get_rows(room_id) do
            local room_cell_id = room.get_room_cell(room_id, column, row)
            local other_character_id = room_cell.get_character(room_cell_id)
            if other_character_id ~= nil and other_character_id ~= character_id then
                table.insert(other_characters, other_character_id)
            end
        end
    end
    for _, other_character_id in ipairs(other_characters) do
        character.do_verb(other_character_id, verb_type.STEP, {})
    end
end
local function do_move(character_id, direction_id)
    local room_cell_id = character.get_room_cell(character_id)
    local room_id = room_cell.get_room(room_cell_id)
    local next_column, next_row = room_cell.get_column(room_cell_id) + direction.get_delta_x(direction_id), room_cell.get_row(room_cell_id) + direction.get_delta_y(direction_id)
    local next_room_cell_id = room.get_room_cell(room_id, next_column, next_row)
    if next_room_cell_id == nil then
        return
    end
    local next_room_cell_type_id = room_cell.get_room_cell_type(next_room_cell_id)
    if room_cell_type.get_blocking(next_room_cell_type_id) then
        return
    end
    local other_character_id = room_cell.get_character(next_room_cell_id)
    if other_character_id ~= nil then
        character.set_interaction(character_id, interaction_type.ENCOUNTER, {other_character_id = other_character_id})
        return
    end
    character.set_room_cell(character_id, next_room_cell_id)
    move_other_characters(character_id, room_id)
end
character_type.set_verb_doer(
    character_type.HERO,
    function(character_id, verb_type_id, context)
        if verb_type_id == verb_type.MOVE then
            do_move(character_id, context.direction_id)
        else
            print("Do Verb "..verb_type_id)
        end
    end)
return nil