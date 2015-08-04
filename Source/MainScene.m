#import "MainScene.h"
#import "VZInterstitialManager.h"

@implementation MainScene

- (void) didLoadFromCCB
{
    
}

-(void)dealloc
{
    
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
}

-(void)test:(id)sender
{
    [[VZInterstitialManager sharedVZInterstitialManager] show:VZLocationMainMenu];
}

@end
