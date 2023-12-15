-- Function to check if the block below is rice
function isRiceBelow()
    local success, data = turtle.inspectDown()
    return success and (data.name == "farmersdelight:rice")
end

-- Function to check if the block below is a rice panicle
function isRicePanicleBelow()
    local success, data = turtle.inspectDown()
    return success and (data.name == "farmersdelight:rice_panicles")
end

-- Function to check for mature rice panicle
function checkMaturePanicle()
    local success, data = turtle.inspectDown()
    return success and (data.name == "farmersdelight:rice_panicles" and data.metadata.age == 3)
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

-- Function to move to next panicle
function moveToNextPanicle()
    local success = false
    -- Check the front, right, and left for a panicle. If one exists, move to it.
    local directions = {turtle.forward, turtle.turnRight, turtle.forward, turtle.turnLeft, turtle.forward}
    for i, action in ipairs(directions) do
        if i == 2 or i == 4 then
            action() -- turn, don't check
        else
            action()
            if isRicePanicleBelow() then
                success = true
                break
            end
        end
    end
    return success
end

-- Function to start the harvesting process
function startHarvesting()
    -- If turtle starts on top of a panicle, mine it.
    if not mineIfMature() then
        -- If it wasn't a mature panicle, or there was no panicle, move down to check for rice.
        turtle.down()
        if not isRiceBelow() then
            -- If there's no rice below, we're in the air and need to move to find the rice layer.
            if not moveToNextPanicle() then
                -- If we can't find the next panicle, the field might be harvested, and we can stop.
                print("No more panicles found. Stopping.")
                return
            end
        end
        -- Now we should be on the rice layer, move back up to the panicle layer.
        turtle.up()
    end
    -- Continue with the next panicle.
    moveToNextPanicle()
end

-- Main function to handle the pattern
function ricePattern()
    while true do
        startHarvesting()
        if isRiceBelow() then
            -- We expect to be above a rice block now, so let's move forward to the next panicle.
            turtle.forward()
        else
            -- If we find ourselves not above a rice block, we should search for the next panicle.
            if not moveToNextPanicle() then
                print("No more panicles found. Stopping.")
                break
            end
        end
    end
end

-- Start the rice pattern mining
ricePattern()
