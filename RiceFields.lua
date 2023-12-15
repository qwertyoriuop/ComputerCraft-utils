-- Function to check if the block below is rice
function isRiceBelow()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice"
end

-- Function to check if the block below is a rice panicle
function isRicePanicleBelow()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice_panicles"
end

-- Function to check for mature rice panicle
function checkMaturePanicle()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice_panicles" and data.state.age == 3
end

-- Function to mine a mature crop
function mineIfMature()
    if checkMaturePanicle() then
        turtle.digDown()
        return true
    else
        return false
    end
end

-- Function to check if the turtle is facing an edge or a non-rice block
function isFacingNonRiceBlock()
    local success, data = turtle.inspect()
    return not success or (data.name ~= "farmersdelight:rice" and data.name ~= "farmersdelight:rice_panicles")
end

-- Function to move to the next row
function moveToNextRow()
    -- Turn to the right and check if the next block is part of the rice field
    turtle.turnRight()
    if isFacingNonRiceBlock() then
        -- If facing an edge or non-rice block, turn left and move to the next line
        turtle.turnLeft()
        turtle.turnLeft()
        if not turtle.forward() then
            -- If unable to move forward, we have reached the end of the field
            print("Reached the end of the rice field. Stopping.")
            return false
        end
        turtle.turnRight()
        return true
    else
        -- If the next block is rice, simply turn back and continue
        turtle.turnLeft()
        return true
    end
end

-- Main function to handle the pattern
function ricePattern()
    while true do
        if not mineIfMature() then
            -- Move down to check for rice if not mining
            turtle.down()
            if not isRiceBelow() then
                -- If there's no rice below, move up and try the next row
                turtle.up()
                if not moveToNextRow() then
                    print("No more rows to harvest. Stopping.")
                    break
                end
            else
                -- Move up to the panicle layer
                turtle.up()
            end
        end

        -- Move forward only if there's more rice or panicle ahead
        if isFacingNonRiceBlock() then
            if not moveToNextRow() then
                print("No more rows to harvest. Stopping.")
                break
            end
        else
            turtle.forward()
        end
    end
end

-- Start the rice pattern mining
ricePattern()
