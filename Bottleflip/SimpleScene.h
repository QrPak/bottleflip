//
//  SimpleScene.h
//  Bottleflip Template
//

#import <SpriteKit/SpriteKit.h>

@interface SimpleScene : SKScene

- (void)changeToSceneByName:(NSString *)nameScene andUserData:(NSMutableDictionary*)userData;

- (void)playSoundFX:(SKAction*)action;

@end
