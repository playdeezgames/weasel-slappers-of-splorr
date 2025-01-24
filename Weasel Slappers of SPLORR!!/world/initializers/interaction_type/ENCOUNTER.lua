local interaction_type = require "world.interaction_type"

interaction_type.set_dialog_generator(
    interaction_type.ENCOUNTER,
    function(context)
        return {
            lines = {"Do you slap the weasel?"},
            choices = {
                {text="SLAPPIT!", interaction = {interaction_type_id=interaction_type.ATTACK, context = context}},
                {text="Don't slap.", interaction = {}}
            },
            cancel = {}
        }
    end )
return nil