package.path = package.path .. ";/?.lua"
local network = require("protocols.network")
local sign
if args[1] == "1" then
	sign = 1
elseif args[1] == "2" then
	sign = -1
else
	printError("Must have parameter 1 (positive) or 2 (negative).")
end

for _, name in ipairs(peripheral.getNames()) do
	print(string.format("Found peripheral %s to the %s..", peripheral.getType(name), name))
end

local rotation_speed_controller = peripheral.wrap("back")

while true do
	local side = network.poll_redstone_all(0.1)
	local speed = sign * redstone.getAnalogInput(side)
	if side == "left" then
		rotation_speed_controller.setTargetSpeed(speed)
	elseif side == "right" then
		rotation_speed_controller.setTargetSpeed(speed)
	end
end
