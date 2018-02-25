//
//  MenuScene.h
//  Bottleflip Template
//

#import <SpriteKit/SpriteKit.h>
#import <StoreKit/StoreKit.h>
#import <GameKit/GameKit.h>

#import "GlobalConfig.h"
#import "UIConfig.h"
#import "MainMenuConfig.h"

#import "Item.h"
#import "ButtonNode.h"
#import "GameLabelNode.h"

#import "BottleController.h"
#import "SimpleScene.h"

@interface MenuScene : SimpleScene
{
  long highscore;
  long totalFlips;
  short selectedItemIndex;
  short totalBottles;
  bool isShopButton;
}
@property SKAction *popSound;
@property NSMutableArray *items;
@property	SKSpriteNode *itemNode;
@property SKSpriteNode *playButtonNode;
@property	SKSpriteNode *leftButtonNode;
@property	SKSpriteNode *rightButtonNode;
@property	SKSpriteNode *shareButtonNode;
@property SKSpriteNode *restoreButtonNode;
@property SKSpriteNode *leaderboardButtonNode;
@property SKSpriteNode *tableNode;
@property SKSpriteNode *flipsTagNode;
@property SKLabelNode *unlockLabelNode;
@property SKLabelNode *flipsLabelNode;
	
@end
