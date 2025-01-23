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
function M.get_dialog()
    return get_avatar_data().dialog
end
function M.set_dialog(dialog)
    assert(type(dialog)=="table" or type(dialog)=="nil", "dialog must be a table or nil.")
    get_avatar_data().dialog = dialog
end
function M.get_dialog_choice()
    return get_avatar_data().dialog_choice
end
function M.set_dialog_choice(dialog_choice)
    get_avatar_data().dialog_choice = dialog_choice
end
return M