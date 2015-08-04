//
//  MyGameCenterManager.m
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-25.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "VZGameCenterManager.h"

@implementation VZGameCenterManager

@synthesize rootViewController = _rootViewController;
@synthesize gameCenterManager = _gameCenterManager;
@synthesize currentLeaderBoard = _currentLeaderBoard;

VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZGameCenterManager)

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
//	UIAlertView* alert= [[UIAlertView alloc] initWithTitle: title
//                                                    message: message
//                                                   delegate: NULL
//                                          cancelButtonTitle: @"OK"
//                                          otherButtonTitles: NULL];
//	[alert show];
}

-(id)init
{
    if(self = [super init])
    {
        _isGameCenterAvailable = [GameCenterManager isGameCenterAvailable];
        if(_isGameCenterAvailable)
        {
            self.gameCenterManager= [[GameCenterManager alloc] init];
            [self.gameCenterManager setDelegate: self];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
        else
        {
//            [self showAlertWithTitle: @"Game Center Support Required!"
//                             message: @"The current device does not support Game Center, which this sample requires."];
        }
    }
    return self;
}

- (void)authenticationChanged
{
    if ([GKLocalPlayer localPlayer].isAuthenticated && !_userAuthenticated)
    {
        NSLog(@"Authentication changed: player authenticated.");
        _userAuthenticated = TRUE;
        
        [GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
            
            NSLog(@"Received invite");
            self.pendingInvite = acceptedInvite;
            self.pendingPlayersToInvite = playersToInvite;
            [self.delegate inviteReceived];
            
        };
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && _userAuthenticated)
    {
        NSLog(@"Authentication changed: player not authenticated");
        _userAuthenticated = FALSE;
    }
}

-(void)dealloc
{
    self.gameCenterManager = nil;
    self.rootViewController = nil;
    self.currentLeaderBoard = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark AuthenticateLocalUser

// 验证结束警告框回调
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    // 如果不是取消，怎重试验证
//    if(buttonIndex != [alertView cancelButtonIndex])
//    {
//        [self.gameCenterManager authenticateLocalUser];
//    }
}

// GameCenter验证回调
- (void) processGameCenterAuth: (NSError*) error
{
    // 验证成功
	if(error == NULL)
	{
        if([GKLocalPlayer localPlayer].authenticated == YES)
        {
            NSLog(@"GameCenter AuthenticateLocalUser Succeed！");
        }
	}
    // 验证失败
	else
	{
        NSLog(@"GameCenter AuthenticateLocalUser Failed！");
        
        // 用户取消或者GameCenter禁用
        if([[error domain] isEqualToString:GKErrorDomain] && [error code] == GKErrorCancelled)
        {
            NSLog(@"Reason: GameCenter is Disabled or User Canceled ！");
//            [self showAlertWithTitle: @"Game Center Account Required!"
//                             message:[NSString stringWithFormat: @"Please sign in."]];
           
        }
        // 其他原因
        else
        {
            NSLog(@"Reason: %@", [error localizedDescription]);
            
//            UIAlertView* alert= [[UIAlertView alloc] initWithTitle: @"Game Center Account Required"
//                                                            message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]
//                                                           delegate: self
//                                                  cancelButtonTitle: @"Cancel"
//                                                  otherButtonTitles: @"Try again", NULL];
//            [alert show];
        }
	}
}

// 验证用户
-(void)authenticateLocalUser;
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Authenticating");
    [self.gameCenterManager authenticateLocalUser];
}


#pragma mark LeaderBorder

// 上传分数
-(void)submitScore: (int64_t) score forCategory: (NSString*) category
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Report %lld Score for Category %@", score, category);
    // 记录上传的ID
    self.currentLeaderBoard = category;
    [self.gameCenterManager reportScore: score forCategory: self.currentLeaderBoard];
}

// 上传分数回调
- (void) scoreReported: (NSError*) error;
{
    // 上传成功
	if(error == NULL)
	{
        NSLog(@"GameCenter Report Score Succeed！");
        
//		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
//		[self showAlertWithTitle: @"High Score Reported!"
//						 message: [NSString stringWithFormat: @"%@", [error localizedDescription]]];
	}
	else
	{
        NSLog(@"GameCenter Report Score Failed！");
        NSLog(@"Reason: %@", [error localizedDescription]);
        
//		[self showAlertWithTitle: @"Score Report Failed!"
//						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

// 下载最高分数的回调
- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
{
    // 下载成功
	if(error == NULL)
	{
//		int64_t personalBest= leaderBoard.localPlayerScore.value;
//		self.personalBestScoreDescription= @"Your Best:";
//		self.personalBestScoreString= [NSString stringWithFormat: @"%ld", personalBest];
//		if([leaderBoard.scores count] >0)
//		{
//			self.leaderboardHighScoreDescription=  @"-";
//			self.leaderboardHighScoreString=  @"";
//			GKScore* allTime= [leaderBoard.scores objectAtIndex: 0];
//			self.cachedHighestScore= allTime.formattedValue;
//			[gameCenterManager mapPlayerIDtoPlayer: allTime.playerID];
//		}
	}
	else
	{
//		self.personalBestScoreDescription= @"GameCenter Scores Unavailable";
//		self.personalBestScoreString=  @"-";
//		self.leaderboardHighScoreDescription= @"GameCenter Scores Unavailable";
//		self.leaderboardHighScoreDescription=  @"-";
//		[self showAlertWithTitle: @"Score Reload Failed!"
//						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) mappedPlayerIDToPlayer: (GKPlayer*) player error: (NSError*) error
{
	if((error == NULL) && (player != NULL))
	{
//      self.leaderboardHighScoreDescription= [NSString stringWithFormat: @"%@ got:", player.alias];
//		
//		if(self.cachedHighestScore != NULL)
//		{
//			self.leaderboardHighScoreString= self.cachedHighestScore;
//		}
//		else
//		{
//			self.leaderboardHighScoreString= @"-";
//		}
	}
	else
	{
//      self.leaderboardHighScoreDescription= @"GameCenter Scores Unavailable";
//		self.leaderboardHighScoreDescription=  @"-";
	}
}

// 展示Leaderboard
-(void)showLeaderboardForCategory:(NSString*)category
{
    if(_isGameCenterAvailable == NO)
        return;
    
    if([GKLocalPlayer localPlayer].authenticated == NO)
    {
        [self.gameCenterManager authenticateLocalUser];
    }
    else
    {
        NSLog(@"GameCenter Show Leaderboard for Category %@", category);
        
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if (leaderboardController != NULL)
        {
            leaderboardController.category = category;
            leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
            leaderboardController.leaderboardDelegate = self;
            [self.rootViewController presentViewController:leaderboardController animated:YES completion:NULL];
        }
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark Achievement

- (void) checkAchievements
{
    //	NSString* identifier= NULL;
    //	double percentComplete= 0;
    //	switch(self.currentScore)
    //	{
    //		case 1:
    //		{
    //			identifier= kAchievementGotOneTap;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //		case 10:
    //		{
    //			identifier= kAchievementHidden20Taps;
    //			percentComplete= 50.0;
    //			break;
    //		}
    //		case 20:
    //		{
    //			identifier= kAchievementHidden20Taps;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //		case 50:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 50.0;
    //			break;
    //		}
    //		case 75:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 75.0;
    //			break;
    //		}
    //		case 100:
    //		{
    //			identifier= kAchievementBigOneHundred;
    //			percentComplete= 100.0;
    //			break;
    //		}
    //			
    //	}
    //	if(identifier!= NULL)
    //	{
    //		[self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];
    //	}
}

// 上传成就
- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Submit Achievement %@ for Percent %f", identifier, percentComplete);
    [self.gameCenterManager submitAchievement:identifier percentComplete:percentComplete];
}

- (void) resetAchievements
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Reset Achievement");
	[self.gameCenterManager resetAchievements];
}

- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
{
	if((error == NULL) && (ach != NULL))
	{
        NSLog(@"GameCenter Submit Achievement Succeed！");
		if(ach.percentComplete == 100.0)
		{
            NSLog(@"GameCenter Achievement %@ Earned",NSLocalizedString(ach.identifier, NULL));
//			[self showAlertWithTitle: @"Achievement Earned!"
//                             message: [NSString stringWithFormat: @"Great job!  You earned an achievement: \"%@\"", NSLocalizedString(ach.identifier, NULL)]];
		}
		else
		{
			if(ach.percentComplete > 0)
			{
                NSLog(@"GameCenter Achievement %@ got %.0f\%%", NSLocalizedString(ach.identifier, NULL), ach.percentComplete);
//				[self showAlertWithTitle: @"Achievement Progress!"
//                                 message: [NSString stringWithFormat: @"Great job!  You're %.0f\%% of the way to: \"%@\"",ach.percentComplete, NSLocalizedString(ach.identifier, NULL)]];
			}
		}
	}
	else
	{
        NSLog(@"GameCenter Submit Achievement Failed！");
        NSLog(@"Reason: %@", [error localizedDescription]);
        
//		[self showAlertWithTitle: @"Achievement Submission Failed!"
//                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) achievementResetResult: (NSError*) error;
{
    NSLog(@"GameCenter Reset Achievement Succeed！");
	if(error != NULL)
	{
        NSLog(@"GameCenter Reset Achievement Failed！");
//		[self showAlertWithTitle: @"Achievement Reset Failed!"
//                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

- (void) showAchievements
{
    if(_isGameCenterAvailable == NO)
        return;
    
    NSLog(@"GameCenter Show Achievement!");
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL)
	{
		achievements.achievementDelegate = self;
        [self.rootViewController presentViewController:achievements animated:YES completion:NULL];
	}
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController
                       delegate:(id<VZGameCenterManagerDelegate>)theDelegate {
    
    if (!_isGameCenterAvailable) return;
    
    _matchStarted = NO;
    self.match = nil;
    self.presentingViewController = viewController;
    self.delegate = theDelegate;
    
    
    if (self.pendingInvite != nil)
    {
        
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithInvite:self.pendingInvite];
        mmvc.matchmakerDelegate = self;
        [self.presentingViewController presentViewController:mmvc animated:YES completion:nil];
        
        self.pendingInvite = nil;
        self.pendingPlayersToInvite = nil;
        
    }
    else
    {
        
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        GKMatchRequest *request = [[GKMatchRequest alloc] init] ;
        request.minPlayers = minPlayers;
        request.maxPlayers = maxPlayers;
        request.playersToInvite = self.pendingPlayersToInvite;
        
        GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
        mmvc.matchmakerDelegate = self;
        
        [self.presentingViewController presentViewController:mmvc animated:YES completion:nil];
        
        self.pendingInvite = nil;
        self.pendingPlayersToInvite = nil;
        
    }
}


- (void)lookupPlayers
{
    
    NSLog(@"Looking up %d players...", (int)self.match.playerIDs.count);
    [GKPlayer loadPlayersForIdentifiers:self.match.playerIDs withCompletionHandler:^(NSArray *players, NSError *error)
    {
        
        if (error != nil)
        {
            NSLog(@"Error retrieving player info: %@", error.localizedDescription);
            _matchStarted = NO;
            [self.delegate matchEnded];
        }
        else
        {
            
            // Populate players dict
            self.playersDict = [NSMutableDictionary dictionaryWithCapacity:players.count];
            for (GKPlayer *player in players)
            {
                NSLog(@"Found player: %@", player.alias);
                [self.playersDict setObject:player forKey:player.playerID];
            }
            
            // Notify delegate match can begin
            _matchStarted = YES;
            [self.delegate matchStarted];
            
        }
    }];
    
}

#pragma mark GKMatchmakerViewControllerDelegate

// The user has cancelled matchmaking
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// Matchmaking has failed with an error
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

// A peer-to-peer match has been found, the game should start
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)theMatch
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.match = theMatch;
    self.match.delegate = self;
    if (!_matchStarted && self.match.expectedPlayerCount == 0)
    {
        NSLog(@"Ready to start match!");
        [self lookupPlayers];
    }
}

#pragma mark GKMatchDelegate

// The match received data sent from the player.
- (void)match:(GKMatch *)theMatch didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    if (self.match != theMatch) return;
    
    [self.delegate match:theMatch didReceiveData:data fromPlayer:playerID];
}

// The player state changed (eg. connected or disconnected)
- (void)match:(GKMatch *)theMatch player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state
{
    if (self.match != theMatch) return;
    
    switch (state)
    {
        case GKPlayerStateConnected:
            // handle a new player connection.
            NSLog(@"Player connected!");
            
            if (!_matchStarted && theMatch.expectedPlayerCount == 0)
            {
                NSLog(@"Ready to start match!");
                [self lookupPlayers];
            }
            
            break;
        case GKPlayerStateDisconnected:
            // a player just disconnected.
            NSLog(@"Player disconnected!");
            _matchStarted = NO;
            [self.delegate matchEnded];
            break;
        default:
            break;
    }
}

// The match was unable to connect with the player due to an error.
- (void)match:(GKMatch *)theMatch connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error
{
    
    if (self.match != theMatch) return;
    
    NSLog(@"Failed to connect to player with error: %@", error.localizedDescription);
    _matchStarted = NO;
    [self.delegate matchEnded];
}

// The match was unable to be established with any players due to an error.
- (void)match:(GKMatch *)theMatch didFailWithError:(NSError *)error
{
    
    if (self.match != theMatch) return;
    
    NSLog(@"Match failed with error: %@", error.localizedDescription);
    _matchStarted = NO;
    [self.delegate matchEnded];
}

@end
