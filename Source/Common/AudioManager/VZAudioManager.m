//
//  AudioManager.m
//  CommonTest
//
//  Created by 张朴军 on 13-6-3.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "VZAudioManager.h"
#import "VZUserDefault.h"
#import "OALSimpleAudio.h"
@implementation VZAudioManager


VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZAudioManager)

-(id)init
{
    if(self = [super init])
    {
        if(![[VZUserDefault sharedVZUserDefault] objectForKey:@"AudioData"])
        {
            NSMutableDictionary* InitialDictionary = [NSMutableDictionary dictionary];
            

            
            [InitialDictionary setObject:[NSNumber numberWithFloat:1.0] forKey:@"AudioMusic"];
            [InitialDictionary setObject:[NSNumber numberWithFloat:1.0] forKey:@"AudioSound"];

            
            [[VZUserDefault sharedVZUserDefault] setObject:InitialDictionary forKey:@"AudioData"];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        @try {
            [OALSimpleAudio sharedInstance];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        [self load];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)isSoundEnable
{
    if(self.sound > 0)
    {
        return YES;
    }
    return NO;
}
-(BOOL)isMusicEnable
{
    if(self.music > 0)
    {
        return YES;
    }
    return NO;
}

-(float)sound
{
    NSNumber* sound = [self.dictionary objectForKey:@"AudioSound"];
    return [sound floatValue];
}

-(void)setSound:(float)sound
{
    NSNumber* soundn = [NSNumber numberWithFloat:sound];
    [self.dictionary setObject:soundn forKey:@"AudioSound"];
    [OALSimpleAudio sharedInstance].effectsVolume = sound;
}

-(float)music
{
    NSNumber* music = [self.dictionary objectForKey:@"AudioMusic"];
    return [music floatValue];
}

-(void)setMusic:(float)music
{
    NSNumber* musicn = [NSNumber numberWithFloat:music];
    [self.dictionary setObject:musicn forKey:@"AudioMusic"];
    [OALSimpleAudio sharedInstance].bgVolume = music * BGM_FACTOR;
}

-(void)loadResource
{
 
}

- (BOOL) playBGM:(NSString*) filePath loop:(bool) loop
{
    if(filePath &&![_currentBGM isEqualToString:filePath])
    {
        _currentBGM = [filePath copy];
        return [[OALSimpleAudio sharedInstance] playBg:filePath loop:loop];
    }
    return NO;
}

-(void)stopBGM
{
    _currentBGM = nil;
    [[OALSimpleAudio sharedInstance] stopBg];
}

- (id<ALSoundSource>) playEffect:(NSString*) filePath
{
    return [[OALSimpleAudio sharedInstance] playEffect:filePath];
}

-(void)load
{
    [self loadResource];
    self.dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"AudioData"];
    [OALSimpleAudio sharedInstance].bgVolume = self.music * BGM_FACTOR;
    [OALSimpleAudio sharedInstance].effectsVolume = self.sound;
}

-(void)save
{
    [[VZUserDefault sharedVZUserDefault] setObject:self.dictionary forKey:@"AudioData"];
    [[VZUserDefault sharedVZUserDefault] synchronize];
}

-(void)pause
{
    [[OALSimpleAudio sharedInstance] setPaused:YES];
}

-(void)resume
{
    [[OALSimpleAudio sharedInstance] setPaused:NO];
}

@end
