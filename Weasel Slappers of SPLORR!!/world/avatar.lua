local world = require "world.world"
local M = {}
world.data.avatar = {}
local function get_avatar_data()
    return world.data.avatar
end
function M.get_character()
    return get_avatar_data().character_id
end
function M.set_character(character_id)
    assert(type(character_id) == "number", "character_id must be a number")
    get_avatar_data().character_id = character_id
end
return M