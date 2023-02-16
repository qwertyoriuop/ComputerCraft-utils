print("Which direction am i facing?, example: north,east,west,south")
local initFacing = io.read()
local facing = initFacing

print("Give me an area to mine, example: 5 long 4 wide 1 deep ")
local area = {io.read("*n","*n","*n")}







function mineWidth()
    for i=2,area[2] do
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
        mineLength(2)
    end
     --mine down part
end

function setFacing()
    if initFacing == "north" then
        facing = "south"
    else if initFacing == "east" then
        facing = "west"
    
    else if initFacing == "west" then
        facing = "east"
    else
        facing = "north"
    end
    end
    end
end

function mineLength( j )
    for i=j,area[1] do
        checkFuel()
        checkItemCount()
        turtle.dig()
        turtle.forward()
    end
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