-- Function to check if the block below is rice
function isRiceBelow()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice"
end

function isRiceFanicleBelow()
    local success, data = turtle.inspectDown()
    return success and data.name == "farmersdelight:rice_panicles"
end

function goTillMature()
    print("going till mature is found")
    turtle.up()
    turtle.forward()
    if isRiceFanicleBelow() then
        if checkMatureFanicle() then
            turtle.digDown()
            turtle.down()
        end
    end
end

function checkMatureFanicle()
    local success, data = turtle.inspectDown()
    if success then
        if data.name == "farmersdelight:rice_panicles" then
            print("rice fanicle found")
            if data.state.age == 3 then
                print("mature rice fanicle found")
                return true
            else
                print("immature rice fanicle found")
                return false
            end
        else
            print("not rice fanicle")
            return false
        end
    else
        print("no block below")
        return false
    end
end
-- Function to check if the block in front is a mature rice crop
function isMature()
    local success, data = turtle.inspect()
    if success then
        -- Check for mature rice crop
        -- return data.name == "farmersdelight:rice" and data.state.age == 3
        if isRiceBelow() then
            print(data.state.age)
            if data.state.age == 3 then
                return data.state.age == 3
            else
                goTillMature()
                print("Not mature")
            end
        else
            print("Not rice")
            return false
        end
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
