local character_type = require "world.character_type"
local verb_type = require "world.verb_type"
local character = require "world.character"
local direction = require "game.direction"
local room_cell = require "world.room_cell"
local room      = require "world.room"
character_type.set_initializer(
    character_type.WEASEL, 
    function(character_id) 
    end)
local function do_step(character_id, context)
    local room_cell_id = character.get_room_cell(character_id)
    local column, row = room_cell.get_column(room_cell_id), room_cell.get_row(room_cell_id)
    local room_id = room_cell.get_room(room_cell_id)
    local candidates = {}
    for _, direction_id in ipairs(direction.get_all()) do
        local next_column, next_row = direction.step(direction_id, column, row)
        local next_room_cell_id = room.get_room_cell(room_id, next_column, next_row)
        local is_candidate = next_room_cell_id ~= nil and not room_cell.has_character(next_room_cell_id)
        if is_candidate then
            table.insert(candidates, next_room_cell_id)
        end
    end
    if #candidates > 0 then
        local next_room_cell_id = candidates[math.random(1, #candidates)]
        character.set_room_cell(character_id, next_room_cell_id)
    end
end
character_type.set_verb_doer(
    character_type.WEASEL,
    function(character_id, verb_type_id, context)
        if verb_type_id == verb_type.STEP then
            do_step(character_id, context)
        else
            print("Do verb " .. verb_type_id .. " for character " .. character_id)
        end
    end)
return nil