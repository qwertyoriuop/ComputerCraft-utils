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
    if success and data.name == "farmersdelight:rice_panicles" and data.state.age == 3 then
        print("Mature rice panicle found")
        return true
    end
    return false
end

-- Function to mine a mature crop
function mineIfMature()
    if checkMaturePanicle() then
        turtle.digDown()
    end
end

-- Function to check if the turtle is at the edge of the field
function isAtFieldEdge()
    local success, data = turtle.inspectDown()
    -- Assuming that the presence of air or water signifies the edge of the field
    return not success or data.name == "minecraft:air" or data.name == "minecraft:water"
end

-- Function to explore for new rows
function exploreForNewRows()
    local moveCount = 0
    local turnCount = 0
    while turnCount < 4 do -- Try all four directions
        if isAtFieldEdge() then
            turtle.turnRight()
            turnCount = turnCount + 1
        else
            turtle.forward()
            moveCount = moveCount + 1
            if isRiceBelow() or isRicePanicleBelow() then
                -- Found a new row to harvest
                return true
            end
        end
    end

    -- If a new row wasn't found, back up to the original position and return false
    for i = 1, moveCount do
        turtle.back()
    end
    return false
end

-- Function to follow the rice pattern
function ricePattern()
    while true do
        mineIfMature()
        if isAtFieldEdge() then
            -- At the edge, so explore for new rows
            if not exploreForNewRows() then
                print("No new rows found, ending pattern.")
                break -- No more rows to harvest, end the pattern
            end
        else
            -- Not at the edge, so keep moving forward
            turtle.forward()
        end
    end
end

-- Start the rice pattern mining
ricePattern()
