local grimoire = require "game.grimoire"
local M = {}
M.HERO = "HERO"
M.WEASEL = "WEASEL"
local data = {
    [M.HERO] = {
        tile = grimoire.TILE_HERO
    },
    [M.WEASEL] = {
        tile = grimoire.TILE_WEASEL
    }
}
local function get_descriptor(character_type_id)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    if data[character_type_id] == nil then
        data[character_type_id] = {}
    end
    return data[character_type_id]
end
function M.get_tile(character_type_id)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    return get_descriptor(character_type_id).tile
end
function M.get_initializer(character_type_id)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    return get_descriptor(character_type_id).initializer
end
function M.set_initializer(character_type_id, initializer)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    assert(type(initializer) == "function", "initializer should be a function")
    local old_initializer = M.get_initializer(character_type_id)
    get_descriptor(character_type_id).initializer = initializer
    return old_initializer
end
function M.get_verb_doer(character_type_id)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    return get_descriptor(character_type_id).verb_doer
end
function M.set_verb_doer(character_type_id, verb_doer)
    assert(type(character_type_id) == "string", "character_type_id should be a string")
    assert(type(verb_doer) == "function", "verb_doer should be a function")
    local old_verb_doer = M.get_initializer(character_type_id)
    get_descriptor(character_type_id).verb_doer = verb_doer
    return old_verb_doer
end
return M