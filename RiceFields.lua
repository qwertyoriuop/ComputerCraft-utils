-- Function to check if the block below is rice
function isRiceBelow()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice"
end

-- Function to check if the block in front is a mature rice crop
function isMature()
    local success, data = turtle.inspect()
    if success then
        -- Check for mature rice crop
        return data.name == "farmersdelight:rice" and data.state.age == 3
    else
        return false
    end
end

-- Function to mine a mature crop
function mineIfMature()
    if isMature() then
        turtle.dig()
    end
end

-- Function to move in the pattern you described
function ricePattern()
    while isRiceBelow() do
        mineIfMature()
        turtle.forward()
    end

    -- Move one block to the side
    turtle.turnRight()
    if isRiceBelow() then  -- Check if there is rice in the next row
        turtle.forward()
        turtle.turnLeft()
    end
end

-- Start the rice pattern mining
ricePattern()
