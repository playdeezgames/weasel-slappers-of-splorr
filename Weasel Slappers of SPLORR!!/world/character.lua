local room_cell = require "world.room_cell"
local character_type = require "world.character_type"
local world = require "world.world"
local M = {}
world.data.characters = {}
local function get_character_data(character_id)
    assert(type(character_id)=="number", "character_id must be a number.")
    return world.data.characters[character_id]
end
function M.create(character_type_id, room_cell_id)
    assert(type(character_type_id)=="string", "character_type_id must be a string.")
    assert(type(room_cell_id)=="number", "room_cell_id must be a number")
    local character_id = #world.data.characters + 1
    world.data.characters[character_id] = {
        character_type_id = character_type_id
    }
    M.set_room_cell(character_id, room_cell_id)
    local initializer = character_type.get_initializer(character_type_id)
    if initializer ~= nil then
        initializer(character_id)
    end
    return character_id
end
function M.get_character_type(character_id)
    assert(type(character_id)=="number", "character_id must be a number.")
    return get_character_data(character_id).character_type_id
end
function M.get_room_cell(character_id)
    assert(type(character_id)=="number", "character_id must be a number.")
    return get_character_data(character_id).room_cell_id
end
function M.set_room_cell(character_id, room_cell_id)
    assert(type(character_id)=="number", "character_id must be a number.")
    assert(type(room_cell_id)=="number", "room_cell_id must be a number")
    local previous_room_cell_id = M.get_room_cell(character_id)
    if previous_room_cell_id ~= nil then
        room_cell.set_character(previous_room_cell_id, nil)
    end
    get_character_data(character_id).room_cell_id = room_cell_id
    if room_cell_id ~= nil then
        room_cell.set_character(room_cell_id, character_id)
    end
end
function M.set_statistic(character_id, statistic_type_id, statistic_value)
    assert(type(character_id)=="number", "character_id must be a number.")
    assert(type(statistic_type_id)=="string", "statistic_type_id must be a string")
    assert(type(statistic_value)=="number", "statistic_value must be a number")
    local character_data = get_character_data(character_id)
    if character_data.statistics == nil then
        character_data.statistics = {}
    end
    local previous_value = M.get_statistic(character_id, statistic_type_id)
    character_data.statistics[statistic_type_id] = statistic_value
    return previous_value
end
function M.get_statistic(character_id, statistic_type_id)
    assert(type(character_id)=="number", "character_id must be a number.")
    assert(type(statistic_type_id)=="string", "statistic_type_id must be a string")
    local character_data = get_character_data(character_id)
    if character_data.statistics == nil then
        return nil
    end
    return character_data.statistics[statistic_type_id]
end
function M.do_verb(character_id, verb_type_id, context)
    assert(type(character_id)=="number", "character_id must be a number.")
    assert(type(verb_type_id)=="string", "verb_type_id must be a string.")
    assert(type(context)=="nil" or type(context)=="table", "context must be a table or nil.")
    local character_type_id = M.get_character_type(character_id)
    local verb_doer = character_type.get_verb_doer(character_type_id)
    if verb_doer ~= nil then
        verb_doer(character_id, verb_type_id, context)
    end
end
function M.recycle(character_id)
    world.data.characters[character_id] = {}
end
return M