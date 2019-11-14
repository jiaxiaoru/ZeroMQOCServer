//
//  main.m
//  ZeroMQOCServer
//
//  Created by Judith on 2019/11/13.
//  Copyright © 2019 Judith. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ZMQObjC.h"

void zmq_server_Reply() {
    ZMQContext *context = [[ZMQContext alloc] initWithIOThreads:1];
    ZMQSocket *responder = [context socketWithType:ZMQ_REP];
    BOOL bind = [responder bindToEndpoint:@"tcp://*:5555"];
    if (bind) {
        NSLog(@"绑定5555端口成功！\n");
        while (1) {
            NSData *rData = [responder receiveDataWithFlags:0];
            NSString *rStr = [[NSString alloc] initWithData:rData encoding:NSUTF8StringEncoding];
            NSLog(@"%@\n",rStr);
            NSData *sData = [@"How are you" dataUsingEncoding:NSUTF8StringEncoding];
            BOOL send = [responder sendData:sData withFlags:0];
            if (send) {
                //                    NSLog(@"服务器发送数据成功！");
            }
            
        }
    }
    
}

void zmq_server_pub() {
    ZMQContext *context = [[ZMQContext alloc] initWithIOThreads:1];
    ZMQSocket *publisher = [context socketWithType:ZMQ_PUB];
    BOOL bind = [publisher bindToEndpoint:@"tcp://*:5555"];
    int i = 0;
    if (bind) {
        NSLog(@"绑定5555端口成功！\n");
        while (1) {
            [publisher sendData:[[NSString stringWithFormat:@"%d广播啦",i] dataUsingEncoding:NSUTF8StringEncoding] withFlags:0];
            sleep(1);
            i++;
        }
    }
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        zmq_server_Reply();
//        zmq_server_pub();
    }
    return 0;
}
