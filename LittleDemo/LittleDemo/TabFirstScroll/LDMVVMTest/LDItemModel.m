//
//  LDItemModel.m
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDItemModel.h"

static int identify = 0;

@implementation LDItemModel

- (instancetype)init
{
    if (self = [super init]) {
        self.username = [NSString stringWithFormat: @"user_%d", identify];
        self.userAvatarURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534926548887&di=f107f4f8bd50fada6c5770ef27535277&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F11%2F67%2F23%2F69i58PICP37.jpg";
        self.summery = [NSString stringWithFormat:@"%@ %@", self.username, @"我的心情很好！！！！！😄🌹\n我的心情很好！！！！！😄🌹\n我的心情很好！！！！！😄🌹\n我的心情很好！！！！！😄🌹"];
        identify ++;
    }
    return self;
}

@end
