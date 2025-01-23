local character_type = require "world.character_type"
character_type.set_initializer(
    character_type.WEASEL, 
    function(character_id) 
        print("Initialized WEASEL for character_id "..character_id)
    end)
return nil