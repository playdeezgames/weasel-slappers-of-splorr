local M = {}
M.UP = "up"
M.RIGHT = "right"
M.DOWN = "down"
M.LEFT = "left"
local data = {
    [M.UP] = {
        delta_x = 0,
        delta_y = 1
    },
    [M.RIGHT] = {
        delta_x = 1,
        delta_y = 0
    },
    [M.DOWN] = {
        delta_x = 0,
        delta_y = -1
    },
    [M.LEFT] = {
        delta_x = -1,
        delta_y = 0
    }
}
function M.get_delta_x(direction_id)
    assert(type(direction_id)=="string", "direction_id should be a string")
    return data[direction_id].delta_x
end
function M.get_delta_y(direction_id)
    assert(type(direction_id)=="string", "direction_id should be a string")
    return data[direction_id].delta_y
end
function M.get_all()
    return {M.UP, M.RIGHT, M.DOWN, M.LEFT}
end
function M.step(direction_id, column, row)
    return column + M.get_delta_x(direction_id), row + M.get_delta_y(direction_id)
end
return M