local interaction_type = require "world.interaction_type"
local character = require "world.character"
local room_cell = require "world.room_cell"

interaction_type.set_dialog_generator(
    interaction_type.FIGHT, 
    function(context) 
        local character_id = context.other_character_id
        local room_cell_id = character.get_room_cell(character_id)
        room_cell.set_character(room_cell_id, nil)
        character.recycle(character_id)
        return {
            lines = {"You killed it!"},
            choices = {
                {text="OK", interaction = {}}
            },
            cancel = {}
        }
    end )
return nil