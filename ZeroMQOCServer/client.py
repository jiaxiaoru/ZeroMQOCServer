#!/usr/bin/python
#-*-coding:utf-8-*-

import time
import zmq
context = zmq.Context()
# socket = context.socket(zmq.SUB)
# socket.connect("tcp://127.0.0.1:5555")
# socket.setsockopt(zmq.SUBSCRIBE,'1')
# while True:
#     print  socket.recv()

socket = context.socket(zmq.REQ)
socket.connect("tcp://127.0.0.1:5555")
while True:
    msg = raw_input("向服务器说点啥：")
    socket.send(msg)
    print  socket.recv()
