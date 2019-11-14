require "zhelpers"
local zmq = require "lzmq"
local context = zmq.context()

local requester,err = context:socket{zmq.REQ,
	connect = "tcp://localhost:5555"}

if err == nil then
	print('连接成功')
	for i=1,10 do
		requester:send(string.format("%d %s",i, "我来啦"))
		s_sleep(1000)
		local msg =requester:recv();
		print(msg)
	end
end

-- local subcribe,err = context:socket{zmq.SUB,
-- 	subscribe = "1",
-- 	connect = "tcp://localhost:5555"}

-- if err == nil then
-- 	print('连接成功')
-- 	for i=1,10 do
-- 		local msg = subcribe:recv()
-- 		print(msg)
-- 	end
-- end