//
//  GameScene.h
//  Bottleflip Template
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

#import "SimpleScene.h"

#import "Item.h"

#import "GameLabelNode.h"
#import "ItemNode.h"

#import "GlobalConfig.h"
#import "GameConfig.h"
#import "UIConfig.h"
#import "GameUIConfig.h"
#import "AdConfig.h"

@interface GameScene : SimpleScene {
	CGPoint start;
	NSTimeInterval startTime;
	bool didSwipe;
	int currentScore;
  int adCounter;
}
@property SKAction *popSound;
@property SKAction *successSound;
@property SKAction *failSound;

@property SKSpriteNode *tutorialNode;
@property SKSpriteNode *tutorialOverlayNode;
@property SKSpriteNode *itemNode;
@property SKLabelNode *scoreLabelNode;
@property SKLabelNode *highscoreLabelNode;
@property SKSpriteNode *backButtonNode;
@property SKSpriteNode *resetButtonNode;

@end
