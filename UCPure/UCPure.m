//
//  UCPure.m
//  UCPure
//
//  Created by h4ck on 2019/4/1.
//  Copyright (c) 2019年 猿码工作室（https://ymlab.net）. All rights reserved.
//

#import "UCPure.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>

CF_EXPORT CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

#import "NewsFlowItem.h"
#import "NewsFlowResponse.h"
#import "NewsFlowItemParse.h"
#import "NewsFlowArticleItem.h"
#import "NewsFlowItemFactory.h"
#import "NFADContent.h"

static NSDictionary *g_prefs = nil;

//CHDeclareClass(NewsFlowManager)
//CHMethod1(id, NewsFlowManager, requestForChannel, id, arg1){
//    // 推荐：100，
//    return CHSuper1(NewsFlowManager, requestForChannel, arg1);
//}
//
//CHMethod4(void, NewsFlowManager, requestSucceed, NSDictionary *, arg1, reqInfo, id/*ReqArticlesItem*/, arg2, dataLen, unsigned long long, arg3, costTime, double, arg4)
//{
////    -[NewsFlowModel updateRequestData:reqInfo:]
//    CHSuper4(NewsFlowManager, requestSucceed, arg1, reqInfo, arg2, dataLen, arg3, costTime, arg4);
//}
//
//CHDeclareClass(NewsFlowDataParse)
//CHClassMethod2(id/*NewsFlowResponse*/, NewsFlowDataParse, parseNewsFlowDict, id, arg1, channelId, id, arg2){
//    // NewsFlowArticleItem
//
//    return CHSuper2(NewsFlowDataParse, parseNewsFlowDict, arg1, channelId, arg2);
//}

//CHDeclareClass(NewsFlowArticleItem)
//CHMethod0(BOOL, NewsFlowArticleItem, nextIsAd){
//    return NO;
//}
//
//CHMethod0(id/*NFADContent*/, NewsFlowArticleItem, adContent){
//    return nil;
//}

CHDeclareClass(NewsFlowResponse)
CHMethod0(NSArray *, NewsFlowResponse, articles){
    NSArray *articles = CHSuper0(NewsFlowResponse, articles);
    if([g_prefs[@"kEnableBlockArticleAd"] boolValue]){
        NSMutableArray *list = [NSMutableArray array];
        for(NewsFlowArticleItem *item in articles){
            if(!item.adContent){
                [list addObject:item];
            }
            else{
                NSLog(@"已过滤广告 %@",item.title);
            }
            item.adContent = nil;
            item.nextIsAd = NO;
        }
        return list;
    }
    return articles;
}

CHDeclareClass(CDProxy)
CHMethod1(id, CDProxy, stringValueForCDParamKey,NSString *,arg1){
    if([g_prefs[@"kEnableChangeHomePage"] boolValue]){
        if([@"default_start_screen" isEqualToString:arg1]){
            return @"right";
        }
    }
    
    return CHSuper1(CDProxy, stringValueForCDParamKey, arg1);
}

// 去启动广告
CHDeclareClass(FlashScreenDataModel)
CHMethod0(id, FlashScreenDataModel, init){
    if([g_prefs[@"kEnableBlockLaunchAd"] boolValue]){
         return nil;
    }
    return CHSuper0(FlashScreenDataModel, init);
}

CHDeclareClass(UCHomePageToolViewEx)
CHMethod1(void, UCHomePageToolViewEx, onButtonClick, UIButton *, arg1)
{
    if([g_prefs[@"kDisableMiniVideoPage"] boolValue]){
        // 小视频按钮
        if(arg1.tag == 0x11){
            return;
        }
    }
    
    CHSuper1(UCHomePageToolViewEx, onButtonClick, arg1);
}

CHDeclareClass(UCUserCenterWelfareView)
CHMethod0(void, UCUserCenterWelfareView, createUIComponents){
    if(![g_prefs[@"kRemoveMyWelfare"] boolValue]){
        CHSuper0(UCUserCenterWelfareView, createUIComponents);
    }
}

//static void notifyCallback(CFNotificationCenterRef center,
//                     void *observer,
//                     CFStringRef name,
//                     const void *object,
//                     CFDictionaryRef userInfo)
//{
//    NSLog(@"userInfo %@",userInfo);
//
//}

CHConstructor // code block that runs immediately upon load
{
    NSLog(@"++++++++ UCPure loaded ++++++++");
    
    g_prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/net.ymlab.dev.UCPure.plist"];
    
//    CHLoadLateClass(NewsFlowManager);
//    CHHook1(NewsFlowManager, requestForChannel);
//    CHHook4(NewsFlowManager, requestSucceed, reqInfo,  dataLen,costTime);
//    CHLoadLateClass(NewsFlowDataParse);
//    CHClassHook2(NewsFlowDataParse, parseNewsFlowDict, channelId);
    
    // 去除列表中的广告
//    CHLoadLateClass(NewsFlowArticleItem)
//    CHHook0(NewsFlowArticleItem, nextIsAd);
//    CHHook0(NewsFlowArticleItem, adContent);
    
    CHLoadLateClass(NewsFlowResponse);
    CHHook0(NewsFlowResponse, articles);
    
//    CHLoadLateClass(UCHomePageViewController);
//    CHHook0(UCHomePageViewController, currentPageIndex);
    
    CHLoadLateClass(CDProxy);
    CHHook1(CDProxy, stringValueForCDParamKey);
    
    CHLoadLateClass(FlashScreenDataModel);
    CHHook0(FlashScreenDataModel, init);
    
    CHLoadLateClass(UCHomePageToolViewEx);
    CHHook1(UCHomePageToolViewEx, onButtonClick);
    
    CHLoadLateClass(UCUserCenterWelfareView);
    CHHook0(UCUserCenterWelfareView, createUIComponents);
    
//    CFNotificationCenterRef distributedCenter =
//    CFNotificationCenterGetDistributedCenter();
//    CFNotificationCenterAddObserver(distributedCenter,
//                                    NULL,
//                                    notifyCallback,
//                                    CFSTR("net.ymlab.dev.UCPure-preferencesChanged"),
//                                    NULL,
//                                    CFNotificationSuspensionBehaviorDeliverImmediately);

}
