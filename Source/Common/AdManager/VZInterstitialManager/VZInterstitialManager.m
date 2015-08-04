//
//  VZInterstitialManager.m
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZInterstitialManager.h"
#import "VZInterstitialChartboost.h"
#import "VZInterstitialApple.h"
#import "VZInterstitialAdmob.h"
#import "VZInterstitialAdcolony.h"

@implementation VZInterstitialManager

VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZInterstitialManager)

- (id)init
{
    if(self = [super init])
    {
        [VZReachability sharedVZReachability];
        self.items = [NSMutableDictionary dictionaryWithCapacity:3];
        
        VZInterstitialChartboost* chartboost = [[VZInterstitialChartboost alloc] init];
        chartboost.priority = 100;
        [self.items setObject:chartboost forKey:VZPlatformChartboost];
        
        VZInterstitialApple* apple = [[VZInterstitialApple alloc] init];
        apple.priority = 100;
        [self.items setObject:apple forKey:VZPlatformApple];
        
        VZInterstitialAdmob* admob = [[VZInterstitialAdmob alloc] init];
        admob.priority = 100;
        [self.items setObject:admob forKey:VZPlatformAdmob];
        
        VZInterstitialAdcolony* adcolony = [[VZInterstitialAdcolony alloc] init];
        adcolony.priority = 100;
        [self.items setObject:adcolony forKey:VZPlatformAdcolony];
        
        
        self.intervalRange = NSMakeRange(0,1);
        self.showInterval = arc4random() % self.intervalRange.length + self.intervalRange.location;
        self.requestTimes = 0;
        
        
    }
    return self;
}

- (void)dealloc
{
   
}

-(void)config
{
    NSEnumerator* enumerator = [self.items objectEnumerator];
    
    VZInterstitialBase* object = nil;
    while ((object = [enumerator nextObject]))
    {
        [object config];
    }
}

-(void)cache
{
    NSEnumerator* enumerator = [self.items objectEnumerator];
    
    VZInterstitialBase* object = nil;
    while ((object = [enumerator nextObject]))
    {
        [object cache];
    }
}

-(void)show:(VZLocation)location
{
    self.requestTimes++;
    if(self.requestTimes < self.showInterval)
        return;
    
    self.requestTimes = 0;
    self.showInterval = arc4random() % self.intervalRange.length + self.intervalRange.location;
        
    [self printPercentage:location];
    
    float totalPriority = 0;
    NSInteger totalDispalyTimes = 0;
    NSMutableArray* platforms = [NSMutableArray arrayWithCapacity:4];
    
    NSEnumerator* enumerator = [self.items objectEnumerator];
    
    //[object show:location];
    
    VZInterstitialBase* object = nil;
    while ((object = [enumerator nextObject]))
    {
        if([object isReady:location])
        {
            totalDispalyTimes += object.displayTimes;
            totalPriority+= object.priority;
            [platforms addObject:object.platform];
        }
    }
    
    if(totalDispalyTimes == 0)
    {
        for (VZAdPlatform platform in platforms)
        {
            object = [self.items objectForKey:platform];
            if([object isReady:location])
            {
                [object show:location];
                break;
            }
        }
    }
    else
    {
        
        
        NSInteger index = -1;
        float minpercentage = 0;
        float minpriority = 0;
        for (int i = 0; i < platforms.count; i++)
        {
            object = [self.items objectForKey:[platforms objectAtIndex:i]];
            
            if([object isReady:location])
            {
                float percentage = object.displayTimes * 1.0f / totalDispalyTimes * 1.0f;
                float priority = object.priority * 1.0f / totalPriority * 1.0f;
                
                if(percentage < priority)
                {
                    if(index == -1)
                    {
                        index = i;
                        minpercentage = percentage;
                        minpriority = priority;
                    }
                    else
                    {
                        if((priority - percentage) < (minpriority - minpercentage))
                        {
                            index = i;
                            minpercentage = percentage;
                            minpriority = priority;
                        }
                    }
                    break;
                }
            }
        }
        if(index == -1)
        {
            index = arc4random() % platforms.count;
        }
        object = [self.items objectForKey:[platforms objectAtIndex:index]];
        [object show:location];
    }
    
}

-(void)pauseDirector
{
    [[CCDirector sharedDirector] pause];
    [[CCDirector sharedDirector] stopAnimation];
    [[VZAudioManager sharedVZAudioManager] pause];
}

-(void)resumeDirector
{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] startAnimation];
    [[VZAudioManager sharedVZAudioManager] resume];
}

-(void)printPercentage:(VZLocation)location
{

    NSInteger totalDispalyTimes = 0;
    float totalPriority = 0;
    
    VZInterstitialBase* object = nil;
    NSEnumerator* enumerator = [self.items objectEnumerator];
    while ((object = [enumerator nextObject]))
    {
        totalDispalyTimes += object.displayTimes;
        totalPriority += object.priority;
    }
    
    if(totalDispalyTimes > 0)
    {
        enumerator = [self.items objectEnumerator];
        while ((object = [enumerator nextObject]))
        {
            float percentage = object.displayTimes * 1.0f / totalDispalyTimes * 1.0f;
            float priority = object.priority * 1.0f / totalPriority * 1.0f;
            NSLog(@"%@ : [Percentage %.4f -- Priority %.4f]", object.platform, percentage, priority);
        }
    }
}


//- (void) testSEL
//{
//    SEL say1 = @selector(say); //创建say方法的SEL对象
//    SEL say2 = NSSelectorFromString(@"say"); //从方法名字符串 创建SEL对象
//    [self performSelector:say1]; //执行 ss指向的方法
//    [self performSelector:say2]; //-[NSObject performSelector]
//    
//    /*
//     以下可以作为Log输出
//     */
//    NSLog(@"------------------------------------------------");
//    SEL s = _cmd; // 每一个方法内都有一个_cmd，表示方法自身
//    NSLog(@"当前方法（NSStringFromSelector）：%@", NSStringFromSelector(s)); //NSStringFromSelector 返回方法名
//    NSLog(@"所在文件完整路径（__FILE__）：%s", __FILE__);
//    NSLog(@"所在文件名：%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent]);
//    NSLog(@"当前行号（__LINE__）：%d", __LINE__);
//    NSLog(@"当前方法签名（__func__）：%s", __func__);
//    NSLog(@"当前方法签名（__PRETTY_FUNCTION__）：%s", __PRETTY_FUNCTION__);//在c++代码中，会包含类型的详细信息
//    NSString* clz = NSStringFromClass([self class]); //返回一个Class对象的类名
//    NSLog(@"当前类名（NSStringFromClass）：%@", clz);
//    
//    NSLog(@"%@", [NSThread callStackSymbols]);// 返回当前调用栈信息
//}

@end
