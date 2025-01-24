local character_type = require "world.character_type"
character_type.set_initializer(
    character_type.WEASEL, 
    function(character_id) 
    end)
character_type.set_verb_doer(
    character_type.WEASEL,
    function(character_id, verb_type_id, context)
        print("Do verb " .. verb_type_id .. " for character " .. character_id)
    end)
return nil