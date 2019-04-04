//
//  UCPure.m
//  UCPure
//
//  Created by h4ck on 2019/4/1.
//  Copyright (c) 2019年 猿码工作室（https://ymlab.net）. All rights reserved.
//

#import "UCPure.h"
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(AccountManager)
CHMethod0(BOOL, AccountManager, isVipMember){
    return YES;
}

CHConstructor // code block that runs immediately upon load
{
    NSLog(@"++++++++ UCPure loaded ++++++++");
    
    CHLoadLateClass(AccountManager);
    CHHook0(AccountManager, isVipMember);
}
