local interaction_type = require "world.interaction_type"

interaction_type.set_dialog_generator(
    interaction_type.INTRO, 
    function(context) 
        return {
            lines = {"This is the intro!"},
            choices = {
                {text="OK", interaction = {}}
            },
            cancel = {}
        }
    end)
return nil