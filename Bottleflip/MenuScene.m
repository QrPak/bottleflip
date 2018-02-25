//
//  MenuScene.m
//  Bottleflip Template
//

#import "MenuScene.h"
#import "GameScene.h"

@implementation MenuScene

-(void)didMoveToView:(SKView *)view
{
	/* Setting the scene */
	self.backgroundColor = UI_BACKGROUND_COLOR;
  
	/* Loading from the items.plist */
  _items = [BottleController readItems];
  totalBottles = [_items count];
  
  /* Get total flips */
  highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"localHighscore"];
  totalFlips = [[NSUserDefaults standardUserDefaults] integerForKey:@"flips"];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterPurchaseUpdate) name:@"afterPurchaseUpdate" object:nil];
  
  _popSound = [SKAction playSoundFileNamed:GAME_SOUND_POP waitForCompletion:NO];
  
  [self setupUI];
}

-(void)setupUI
{
  /* Logo Node */
  
 SKSpriteNode *logoNode = [[ButtonNode alloc] initWithImageNamed:UI_MENU_LOGO_IMAGE withName:UI_MENU_LOGO_NAME withPosition:UI_MENU_LOGO_POSITION withXScale:UI_MENU_LOGO_X_SCALE withYScale:UI_MENU_LOGO_Y_SCALE];
  
  /* Best Score Label */
  GameLabelNode *bestScoreLabelNode = [[GameLabelNode alloc] initWithText:UI_BEST_SCORE_LABEL_TEXT withFontSize:UI_BEST_SCORE_LABEL_FONT_SIZE withPosition:UI_BEST_SCORE_LABEL_POSITION withColor:UI_MENU_FONT_COLOR];
  
  /* Best Score Label */
  GameLabelNode *highScoreLabelNode = [[GameLabelNode alloc] initWithText:[NSString stringWithFormat:@"%ld", highscore] withFontSize:UI_HIGH_SCORE_LABEL_FONT_SIZE withPosition:UI_HIGH_SCORE_LABEL_POSITION withColor:UI_MENU_FONT_COLOR];
  
  /* Total Flips Label */
  GameLabelNode *totalFlipsLabelNode = [[GameLabelNode alloc] initWithText:UI_TOTAL_FLIPS_LABEL_TEXT withFontSize:UI_TOTAL_FLIPS_LABEL_FONT_SIZE withPosition:UI_TOTAL_FLIPS_LABEL_POSITION withColor:UI_MENU_FONT_COLOR];
  
  /* Total Flips Score Label */
  GameLabelNode *flipsLabelNode = [[GameLabelNode alloc] initWithText:[NSString stringWithFormat:@"%ld", totalFlips] withFontSize:UI_FLIPS_LABEL_FONT_SIZE withPosition:UI_FLIPS_LABEL_POSITION withColor:UI_MENU_FONT_COLOR];
  
  /* Item */
  selectedItemIndex = [BottleController getSavedItemIndex];
  Item *selectedItem = [_items objectAtIndex:selectedItemIndex];
  
  _itemNode = [SKSpriteNode spriteNodeWithImageNamed:selectedItem.Sprite];
  _itemNode.name = UI_ITEM_NODE_NAME;
  _itemNode.zPosition = UI_ITEM_NODE_Z_POSITION;
  
  /* Unlock Label */
  _unlockLabelNode = [[GameLabelNode alloc] initWithText:@"0" withFontSize:UI_UNLOCK_LABEL_FONT_SIZE withPosition:UI_UNLOCK_LABEL_POSITION withColor:UI_MENU_FONT_COLOR];
  _unlockLabelNode.zPosition = UI_UNLOCK_LABEL_Z_POSITION;
  
  /* Play button */
  _playButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_PLAY_BUTTON_IMAGE withName:UI_PLAY_BUTTON_NAME withPosition:UI_PLAY_BUTTON_POSITION withXScale:UI_PLAY_BUTTON_X_SCALE withYScale:UI_PLAY_BUTTON_Y_SCALE];
  
  /* Restore button button */
  _restoreButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_RESTORE_BUTTON_IMAGE withName:UI_RESTORE_BUTTON_NAME withPosition:UI_RESTORE_BUTTON_POSITION withXScale:UI_RESTORE_BUTTON_X_SCALE withYScale:UI_RESTORE_BUTTON_Y_SCALE];
  _restoreButtonNode.zPosition = UI_RESTORE_BUTTON_Z_POSITION;
  
  /* Leaderboard button */
  _leaderboardButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_LEADERBOARD_BUTTON_IMAGE withName:UI_LEADERBOARD_BUTTON_NAME withPosition:UI_LEADERBOARD_BUTTON_POSITION withXScale:UI_LEADERBOARD_BUTTON_X_SCALE withYScale:UI_LEADERBOARD_BUTTON_Y_SCALE];
  
  /*  Trophy button */
  _shareButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_SHARE_BUTTON_IMAGE withName:UI_SHARE_BUTTON_NAME withPosition:UI_SHARE_BUTTON_POSITION withXScale:UI_SHARE_BUTTON_X_SCALE withYScale:UI_SHARE_BUTTON_Y_SCALE];
  
  /* Table node */
  _tableNode = [[ButtonNode alloc] initWithImageNamed:UI_TABLE_NODE_IMAGE withName:UI_TABLE_NODE_NAME withPosition:UI_TABLE_NODE_POSITION withXScale:UI_TABLE_NODE_X_SCALE withYScale:UI_TABLE_NODE_Y_SCALE];
  _tableNode.zPosition = UI_TABLE_NODE_Z_POSITION;
  
  /* Left Button */
  _leftButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_LEFT_BUTTON_IMAGE withName:UI_LEFT_BUTTON_NAME withPosition:UI_LEFT_BUTTON_POSITION withXScale:UI_LEFT_BUTTON_X_SCALE withYScale:UI_LEFT_BUTTON_Y_SCALE];
  [self changeButtonSpriteState:_leftButtonNode withState:NO];
  
  /* Right Button */
  _rightButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_RIGHT_BUTTON_IMAGE withName:UI_RIGHT_BUTTON_NAME withPosition:UI_RIGHT_BUTTON_POSITION withXScale:UI_RIGHT_BUTTON_X_SCALE withYScale:UI_RIGHT_BUTTON_Y_SCALE];
  [self changeButtonSpriteState:_rightButtonNode withState:YES];
  
  /* Lock Node */
  _flipsTagNode = [[ButtonNode alloc] initWithImageNamed:UI_FLIPS_TAG_IMAGE withName:UI_FLIPS_TAG_NAME withPosition:UI_FLIPS_TAG_POSITION withXScale:UI_FLIPS_TAG_X_SCALE withYScale:UI_FLIPS_TAG_Y_SCALE];
  _flipsTagNode.zPosition = UI_FLIPS_TAG_Z_POSITION;
  _flipsTagNode.zRotation = UI_FLIPS_TAG_Z_ROTATION;

  /* Update the selected item */
  [self updateSelectedItem:selectedItem];
  
  /* Adding user interface objects to scene */
  [self addChild:logoNode];
  [self addChild:bestScoreLabelNode];
  [self addChild:highScoreLabelNode];
  [self addChild:totalFlipsLabelNode];
  [self addChild:flipsLabelNode];
  [self addChild:_playButtonNode];
  [self addChild:_restoreButtonNode];
  [self addChild:_leaderboardButtonNode];
  [self addChild:_shareButtonNode];
  [self addChild:_tableNode];
  [self addChild:_leftButtonNode];
  [self addChild:_rightButtonNode];
  [self addChild:_itemNode];
  [self addChild:_flipsTagNode];
  [_flipsTagNode addChild:_unlockLabelNode];
  
  [self pulseNode:_flipsTagNode];
}

-(void)pulseNode:(SKSpriteNode *)node
{
  /* Pulse animation for lock */
  SKAction *scaleDownAction = [SKAction scaleTo:0.35 duration:0.5];
  SKAction *scaleUpAction = [SKAction scaleTo:0.5 duration:0.5];
  SKAction *intro = [SKAction sequence:@[scaleDownAction, scaleUpAction]];
  
  [node runAction:[SKAction repeatActionForever:intro]];
}

-(void)changeButtonSpriteState:(SKSpriteNode *)buttonNode withState:(bool)state
{
  /* Change arrow sprites accordingly */
	UIColor *buttonColor = UI_DISABLED_MENU_FONT_COLOR;
  
	if(state)
		buttonColor = UI_MENU_FONT_COLOR;
  
	buttonNode.color = buttonColor;
	buttonNode.colorBlendFactor = 1;
}

-(void)updateSelectedItem:(Item *)item
{
  /* Update to the selected item */
  long unlockFlips = [item.MinFlips longValue] - highscore;
  bool unlocked = (unlockFlips <= 0) || [[NSUserDefaults standardUserDefaults] boolForKey:@"unlockAll"];
  
  _restoreButtonNode.hidden = unlocked;
  _flipsTagNode.hidden = unlocked;
  _unlockLabelNode.hidden = unlocked;
  
  [_itemNode setTexture:[SKTexture textureWithImageNamed:item.Sprite]];
  [_playButtonNode setTexture:[SKTexture textureWithImageNamed:((unlocked) ? UI_PLAY_BUTTON_IMAGE : UI_SHOP_BUTTON_IMAGE)]];
  
  isShopButton = !unlocked;
  
  _itemNode.size = UI_ITEM_NODE_SIZE;
	_itemNode.position = UI_ITEM_NODE_POSITION;

  _flipsTagNode.position = UI_FLIPS_TAG_POSITION;
  
  _unlockLabelNode.text = [NSString stringWithFormat:@"%ld", [item.MinFlips longValue]];
  _unlockLabelNode.position = UI_UNLOCK_LABEL_POSITION;
	
	[self updateArrowsState];
}

-(void)updateArrowsState
{
  /* Update arrow states */
  [self changeButtonSpriteState:_leftButtonNode withState:(bool)selectedItemIndex];
  [self changeButtonSpriteState:_rightButtonNode withState:(selectedItemIndex != totalBottles-1)];
}

-(void)startGame
{
  /* Not shop button, so start game */
  if(!isShopButton)
  {
    NSDictionary *userData = @{ @"item":[_items objectAtIndex:selectedItemIndex] };
    [self changeToSceneByName:@"GameScene" andUserData:[userData mutableCopy]];
  }
  else
  {
    /* Start iAP */
    [self requestPurchase];
  }
}

-(void)requestPurchase
{
  /* Send notification to purchase */
  [[NSNotificationCenter defaultCenter] postNotificationName:@"requestPurchase" object:nil];
}

-(void)afterPurchaseUpdate
{
  /* Called after successful iAp, reset the bottle */
  Item *currentItem = [_items objectAtIndex:selectedItemIndex];
  [self updateSelectedItem:currentItem];
}

-(void)updateByIndex:(int)index
{
  /* Update based on index */
  Item *item = [_items objectAtIndex:index];
    
  selectedItemIndex = index;
    
  [self updateSelectedItem:item];
  [BottleController saveSelectedItem:selectedItemIndex];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  /* Determine button pressed */
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    
    /* Play button is pressed */
    if ([_playButtonNode containsPoint:location]) {
      [self playSoundFX:_popSound];
      [self startGame];
    }
    
    /* Left button is pressed */
    if ([_leftButtonNode containsPoint:location]) {
      short prevIndex = selectedItemIndex - 1;
      if(prevIndex >= 0)
      {
        [self playSoundFX:_popSound];
        [self updateByIndex:prevIndex];
      }
    }
    
    /* Right button is pressed */
    if ([_rightButtonNode containsPoint:location]) {
      short nextIndex = selectedItemIndex + 1;
      if(nextIndex < totalBottles)
      {
        [self playSoundFX:_popSound];
        [self updateByIndex:nextIndex];
      }
    }
    
    /* Share button is pressed */
    if ([_shareButtonNode containsPoint:location]) {
      [self playSoundFX:_popSound];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"showShareSheet" object:nil];
    }
    
    /* Restor button is pressed */
    if ([_restoreButtonNode containsPoint:location]) {
      [self playSoundFX:_popSound];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"restorePurchases" object:nil];
      
      Item *currentItem = [_items objectAtIndex:selectedItemIndex];
      [self updateSelectedItem:currentItem];
    }
    
    /* Leaderboard button is pressed */
    if ([_leaderboardButtonNode containsPoint:location]) {
      [self playSoundFX:_popSound];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"showLeaderboard" object:nil];
    }
  }
}

@end
