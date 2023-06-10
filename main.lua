-- Author: Mark
-- GitHub: https://github.com/Mark-TinZ
-- Workshop: https://steamcommunity.com/id/MarkTin_Sovet/myworkshopfiles/
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setProperty("Power", 0.2)
    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)
        -- NEW! button/slider options from the UI
        simulator:setInputNumber(1, -1+(simulator:getSlider(1)*2)) -- A/D
        simulator:setInputNumber(2, -1+(simulator:getSlider(2)*2)) -- W/S
    end;
end
---@endsection

--[====[ IN-GAME CODE ]====]
Power = property.getNumber("Power")
function onTick()
    AD = input.getNumber(1)
    WS = input.getNumber(2)

    Right = WS - AD
    Left = WS + AD

    RightReverse = false
    if Right < 0 then
        RightReverse = true
    end

    LeftReverse = false
    if Left < 0 then
        LeftReverse = true
    end    

    Throttle = math.abs(WS+AD)*Power

    output.setNumber(1,math.abs(Right))
	output.setNumber(2,math.abs(Left))
    output.setBool(1,RightReverse)
	output.setBool(2,LeftReverse)
    output.setNumber(3,Throttle)
end