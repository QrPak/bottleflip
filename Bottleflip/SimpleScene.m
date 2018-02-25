//
//  SimpleScene.m
//  Bottleflip Template
//

#import "SimpleScene.h"

#import "MenuScene.h"
#import "GameScene.h"

@implementation SimpleScene

- (void)changeToSceneByName:(NSString *)nameScene andUserData:(NSMutableDictionary*)userData
{
  /* Change to scene */
  SKScene *scene = ([nameScene isEqual: @"GameScene"] ? [[GameScene alloc] initWithSize:self.size] : [[MenuScene alloc] initWithSize:self.size]);
  
  SKTransition *transition = [SKTransition fadeWithColor:UI_BACKGROUND_COLOR duration:UI_TRANSITION_DURATION];
  
  scene.scaleMode = SKSceneScaleModeAspectFill;
  scene.userData = userData;

  [self.view presentScene:scene transition:transition];
}

- (void)playSoundFX:(SKAction*)action
{
  /* Play sound effect */
  [self runAction:action];
}

@end
