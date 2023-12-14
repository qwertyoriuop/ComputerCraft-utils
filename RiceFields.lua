-- Function to check if the turtle has enough fuel
-- function checkFuel()
--     local fuelLevel = turtle.getFuelLevel()
--     if fuelLevel < 10 then
--         -- Assuming you have fuel in the first slot
--         turtle.select(1)
--         turtle.refuel(1)
--     end
-- end

-- Function to check if the block in front is a mature crop
function isMature()
    local success, data = turtle.inspect()
    if success then
        -- Adjust the condition based on how the game represents mature crops
        -- return data.state.growth == "mature"
        return data.state.age == 3
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

-- Main function to move in a square pattern
function squarePattern(n)
    for i = 1, 4 do -- four sides of the square
        for j = 1, n - 1 do -- move n-1 times for each side
            -- checkFuel()  --fuel check disabled for now
            mineIfMature()
            turtle.forward()
        end
        turtle.turnRight()
    end
end

-- Size of the square
local size = 5 -- Change this to your desired size

-- Start the square pattern mining
squarePattern(size)
