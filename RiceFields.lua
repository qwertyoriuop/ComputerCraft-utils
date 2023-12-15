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

-- Function to move to the next rice or panicle block
function moveToNextRiceOrPanicle()
    local moved = false
    for i = 1, 4 do  -- Check all four directions
        if isRiceBelow() or isRicePanicleBelow() then
            return true  -- Found rice or panicle in the current position
        end
        turtle.turnRight()
        turtle.forward()
        moved = true
    end

    if not moved then
        print("No rice or panicle nearby")
        return false
    end
end

-- Function to mine a mature crop
function mineIfMature()
    if checkMaturePanicle() then
        turtle.digDown()
    end
end

-- Function to follow the rice pattern
function ricePattern()
    while isRicePanicleBelow() or moveToNextRiceOrPanicle() do
        mineIfMature()
        turtle.forward()
    end
end

-- Start the rice pattern mining
ricePattern()
