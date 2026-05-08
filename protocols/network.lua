local network = {}

-- Waits until a signal is received on a channel.
function network.poll(receiveChannel, time)
	local event, key, origin, data
	-- Timer
	local timer = os.startTimer(time)
	while true do
		event, key, _, origin, data = os.pullEvent()
		if event == "modem_message" and origin == receiveChannel then
			print(string.format("Received message from %s.. ", receiveChannel))
			return data
		elseif event == "timer" and key == timer then
			print(string.format("Polling %s seconds.. ", time))
		end
	end
end

-- Signal strength has a maximum value of 14
function network.poll_redstone(side, signal_strength, time)
	signal_strength = math.min(signal_strength, 14)
	-- Timer
	local signal
	while true do
		os.pullEvent()
		signal = redstone.getAnalogInput(side)
		if signal >= signal_strength then
			print(string.format("Redstone signal is %s.. ", signal))
			return true
		else
			print(string.format("Polling %s seconds for redstone.. ", time))
		end
	end
end

return network
