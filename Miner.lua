local area = {1,1,1}
local initFacing = ''
local facing = ''
print("Which direction am i facing?, example: north,east,west,south")
initFacing = read()
facing = initFacing
print("Give me the length to mine")
area[1] = read()
print("Give me the width to mine")
area[2] = read()
print("Give me the depth to mine")
area[3] = read()


function mineWidth()
    for i=2,area[2]do
        if facing == initFacing then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
            turtle.turnLeft()
            setFacing()
        else
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            turtle.turnRight()
            setFacing()
        end
        print("finished width")
        mineLength(2)
    end
     --mine down part
end

function setFacing()
    if facing == "north" then
        facing = "south"
    elseif facing == "east" then
        facing = "west"
    
    elseif facing == "west" then
        facing = "east"
    else
        facing = "north"
    end
end

function mineLength( j )
    j = j or 1
    for i=j,area[1] do
        checkFuel()
        checkItemCount()
        turtle.dig()
        turtle.forward()
    end
    print("finished Length")
    mineWidth()
end

function checkFuel( )
    turtle.select(1) --select the slot where our fuel is
    if turtle.getFuelLevel() == 0 then -- check if our fuellevel is empty(we can change this later)
        if turtle.refuel() then -- will try to refuel the turtle
            return true
        else
            return false
        end
    end
    return true --turtle still has fuel
end

function checkItemCount( )
    if turtle.getItemCount(16) ~= 0 then --check if the storage of the turtle is "full"
        for i=2,16 do --go through the slots to empty out inventory, sparing the first fuel slot
            turtle.select(i)
            turtle.drop()
        end
    end
end

mineLength()