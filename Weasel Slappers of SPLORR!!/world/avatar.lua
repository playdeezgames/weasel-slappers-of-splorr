local world = require "world.world"
local character = require "world.character"
local interaction_type = require "world.interaction_type"
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
    local dialog = get_avatar_data().dialog
    if dialog == nil then
        local character_id = M.get_character()
        local interaction = character.get_interaction(character_id)
        if interaction ~= nil then
            dialog = interaction_type.generate_dialog(interaction.interaction_type_id, interaction.context)
			M.set_dialog(dialog)
			M.set_dialog_choice(1)
        end
    end
    return dialog
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
function M.previous_dialog_choice()
	local dialog = M.get_dialog()
	if dialog == nil then
		return
	end
	if M.get_dialog_choice() == 1 then
		M.set_dialog_choice(#dialog.choices)
	else
		M.set_dialog_choice(M.get_dialog_choice() - 1)
	end
end
function M.next_dialog_choice()
	local dialog = M.get_dialog()
	if dialog == nil then
		return
	end
	if M.get_dialog_choice() == #dialog.choices then
		M.set_dialog_choice(1)
	else
		M.set_dialog_choice(M.get_dialog_choice() + 1)
	end
end
function M.confirm_dialog_choice()
    local dialog = M.get_dialog()
	if dialog == nil then
		return
	end
	local character_id = M.get_character()
	local choice = dialog.choices[M.get_dialog_choice()]
	character.set_interaction(character_id, choice.interaction.interaction_type_id, choice.interaction.context)
	M.set_dialog(nil)
end
function M.cancel_dialog_choice()
    local dialog = M.get_dialog()
	if dialog == nil then
		return
	end
	local character_id = M.get_character()
	if dialog.cancel ~= nil then
		character.set_interaction(character_id, dialog.cancel.interaction_type_id, dialog.cancel.context)
		M.set_dialog(nil)
	end
end
return M