//
//  AudioManager.h
//  CommonTest
//
//  Created by 张朴军 on 13-6-3.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZCommonDefine.h"
#import "OALSimpleAudio.h"


#define BGM_FACTOR  0.3f;

@interface VZAudioManager : NSObject
{
    NSString* _currentBGM;

}
@property (nonatomic, strong)NSMutableDictionary* dictionary;

VZ_DECLARE_SINGLETON_FOR_CLASS(VZAudioManager)

@property (nonatomic, assign)float sound;
@property (nonatomic, assign)float music;

-(BOOL)isSoundEnable;
-(BOOL)isMusicEnable;


- (BOOL) playBGM:(NSString*) filePath loop:(bool) loop;
- (void) stopBGM;

- (id<ALSoundSource>) playEffect:(NSString*) filePath;

-(void)load;
-(void)save;

-(void)pause;
-(void)resume;

@end
