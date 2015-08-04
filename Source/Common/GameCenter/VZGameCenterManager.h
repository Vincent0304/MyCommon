//
//  MyGameCenterManager.h
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-25.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "VZCommonDefine.h"
#import "GameCenterManager.h"

@class GameCenterManager;

@protocol VZGameCenterManagerDelegate
- (void)matchStarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID;
- (void)inviteReceived;
@end

@interface VZGameCenterManager : NSObject <UIActionSheetDelegate,GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate, GKMatchmakerViewControllerDelegate, GKMatchDelegate>
{
    GameCenterManager*  _gameCenterManager;
    UIViewController*   _rootViewController;
    BOOL                _isGameCenterAvailable;
    NSString*           _currentLeaderBoard;
    
    BOOL                _userAuthenticated;
    
    BOOL                _matchStarted;
}

VZ_DECLARE_SINGLETON_FOR_CLASS(VZGameCenterManager)
@property (nonatomic, retain) UIViewController* rootViewController;
@property (nonatomic, retain) GameCenterManager* gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;

@property (nonatomic, retain) UIViewController *presentingViewController;
@property (nonatomic, retain) GKMatch *match;
@property (nonatomic, assign) id <VZGameCenterManagerDelegate> delegate;
@property (nonatomic, retain) NSMutableDictionary* playersDict;
@property (nonatomic, retain) GKInvite* pendingInvite;
@property (nonatomic, retain) NSArray* pendingPlayersToInvite;

-(void)authenticateLocalUser;

-(void)submitScore: (int64_t) score forCategory: (NSString*) category;
-(void)showLeaderboardForCategory:(NSString*)catrgory;



-(void)submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete;
-(void)resetAchievements;
-(void)showAchievements;

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController
                       delegate:(id<VZGameCenterManagerDelegate>)theDelegate;


@end
