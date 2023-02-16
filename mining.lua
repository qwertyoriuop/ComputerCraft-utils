
-- Set the dimensions of the mining area
local width = 32
local length = 32
local depth = 32
local x, y, z = 0,0,0 --the relative position , x being forwards and backwards, y being height, z being left right
local cx, cy, cz = 0,0,0
local facing = "forward" --the chest is behind us
local down = false -- switches between true and false
-- Start mining
for k = 1, depth do 
    --print("k")
    for i = 1, length do --relative vanaf het begin links - rechts
        -- Mine the current row
        --print("i")
        for j = 1, width do -- relative vanaf het begin voor achter
            --print("j")
            -- Check for fuel
            if turtle.getFuelLevel() == 0 then
                turtle.select(1)
                if turtle.refuel() then
                    print("refueled")
                else
                    print("Out of fuel!")
                end
            end
            if turtle.getItemCount(16) ~= 0 then
                for i = 2, 16 do
                    turtle.select(i)
                    turtle.drop()
                end
            end
            -- Mine the current block
            turtle.dig()
            turtle.forward()
            --print("forwards")
            if facing == 'forward' then
                x = x + 1
            else
                x = x - 1
            end
        end
        -- Move to the next row
        if not down then -- if the 2,4,6,8,10 row down then it will go the other way
            if facing == "forward" then
                turtle.turnRight()
                turtle.dig()
                turtle.forward()
                z = z + 1
                turtle.turnRight()
                facing = 'backward'
            else 
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                z = z + 1
                turtle.turnLeft()
                facing = "forward"
            end
        else -- if the 1,3,5,7,9,11 row down it will go from right to left
            if facing == "forward" then
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                z = z - 1
                turtle.turnLeft()
                facing = "backward"
            else
                turtle.turnRight()
                turtle.dig()
                turtle.forward()
                z = z - 1
                turtle.turnRight()
                facing = "forward"
            end
        end
    end

    --makes turtle move down and position right
    if down then
        turtle.digDown()
        turtle.down()
        y = y - 1
        if facing == 'forward' then
            --turtle.turnLeft()
            --turtle.turnLeft()
            facing = 'backward'
        else
            --turtle.turnRight()
            --turtle.turnRight()
            facing = 'forward'
        end
        down = false
    else
        turtle.digDown()
        turtle.down()
        y = y - 1
        if facing == 'forward' then
            --turtle.turnRight()
            --turtle.turnRight()
            facing = 'backward'
        else
            --turtle.turnLeft()
            --turtle.turnLeft()
            facing = 'forward'
        end
        down = true
    end
end

-- Return to starting position and orientation
if facing == "north" then
    turtle.turnRight()
else
    turtle.turnLeft()
end