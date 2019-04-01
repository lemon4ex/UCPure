//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@class NFPullDownHint, NSArray, NSMutableArray;

@interface NewsFlowResponse : NSObject
{
    _Bool _isCleanCache;
    _Bool _enableCollapseBanner;
    NSMutableArray *_articles;
    NSMutableArray *_banners;
    NSArray *_removeIDs;
    NFPullDownHint *_pullDownHint;
    long long _updateCountForDoubleColumn;
}

@property(nonatomic) _Bool enableCollapseBanner; // @synthesize enableCollapseBanner=_enableCollapseBanner;
@property(nonatomic) long long updateCountForDoubleColumn; // @synthesize updateCountForDoubleColumn=_updateCountForDoubleColumn;
@property(retain, nonatomic) NFPullDownHint *pullDownHint; // @synthesize pullDownHint=_pullDownHint;
@property(nonatomic) _Bool isCleanCache; // @synthesize isCleanCache=_isCleanCache;
@property(retain, nonatomic) NSArray *removeIDs; // @synthesize removeIDs=_removeIDs;
@property(retain, nonatomic) NSMutableArray *banners; // @synthesize banners=_banners;
@property(retain, nonatomic) NSMutableArray *articles; // @synthesize articles=_articles;

@end
