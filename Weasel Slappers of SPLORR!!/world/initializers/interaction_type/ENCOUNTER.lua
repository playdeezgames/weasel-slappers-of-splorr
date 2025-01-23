local interaction_type = require "world.interaction_type"

interaction_type.set_dialog_generator(
    interaction_type.ENCOUNTER,
    function(context)
        return {
            lines = {"Yer in an encounter."},
            choices = {
                {text="ATTACK!", interaction = {interaction_type_id=interaction_type.ATTACK, context = context}},
                {text="RUN!", interaction = {}}
            },
            cancel = {}
        }
    end )
return nil