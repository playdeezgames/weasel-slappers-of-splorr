local M = {}
M.HERO = "HERO"
M.WEASEL = "WEASEL"
local data = {
    [M.HERO] = {
        tile = 2
    },
    [M.WEASEL] = {
        tile = 3
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
return M