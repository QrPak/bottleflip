//
//  GameScene.m
//  Bottleflip Template
//

#import "GameScene.h"
#import "MenuScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
	/* Setting the scene */
	self.physicsBody.restitution = 0;
	self.backgroundColor = UI_BACKGROUND_COLOR;
	
  [self setupUI];
  [self setupGameNodes];
  
  _popSound = [SKAction playSoundFileNamed:GAME_SOUND_POP waitForCompletion:NO];
  _successSound = [SKAction playSoundFileNamed:GAME_SOUND_SUCCESS waitForCompletion:NO];
  _failSound = [SKAction playSoundFileNamed:GAME_SOUND_FAIL waitForCompletion:NO];
  
  adCounter = 0;
}

-(void)setupGameNodes
{
  /* Table Node */
  SKSpriteNode *tableNode = [SKSpriteNode spriteNodeWithImageNamed:@"table"];
  
  tableNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tableNode.texture.size];
  tableNode.physicsBody.affectedByGravity = NO;
  tableNode.physicsBody.dynamic = NO;
  tableNode.xScale = GAME_TABLE_NODE_X_SCALE;
  tableNode.yScale = GAME_TABLE_NODE_Y_SCALE;
  tableNode.physicsBody.restitution = GAME_TABLE_NODE_RESTITUTION;
  tableNode.position = GAME_TABLE_NODE_POSITION;
  
  /* Bottle Node */
  Item *selectedItem = [self.userData objectForKey:@"item"];
  _itemNode = [[ItemNode alloc] initWithItem:selectedItem];
  
  [self resetBottle];
  
  /* Adding game nodes */
  [self addChild:tableNode];
  [self addChild:_itemNode];
  
}

-(void)setupUI
{
  /* ScoreLabelNode */
  _scoreLabelNode = [[GameLabelNode alloc] initWithText:@"0" withFontSize:UI_SCORE_LABEL_FONT_SIZE withPosition:UI_SCORE_LABEL_POSITION withColor:UI_FONT_COLOR];
  _scoreLabelNode.zPosition = UI_SCORE_LABEL_Z_POSITION;
  
  /* Highscore Label */
  _highscoreLabelNode = [[GameLabelNode alloc] initWithText:UI_NEW_HIGHSCORE_LABEL_TEXT withFontSize:UI_NEW_HIGHSCORE_LABEL_FONT_SIZE withPosition:UI_NEW_HIGHSCORE_LABEL_POSITION withColor:UI_FONT_COLOR];
  _highscoreLabelNode.hidden = YES;
  _highscoreLabelNode.zPosition = UI_NEW_HIGHSCORE_LABEL_Z_POSITION;
  
  /* Back Button */
  _backButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_BACK_BUTTON_IMAGE withName:UI_BACK_BUTTON_NAME withPosition:UI_BACK_BUTTON_POSITION withXScale:UI_BACK_BUTTON_X_SCALE withYScale:UI_BACK_BUTTON_Y_SCALE];
  
  /* Reset Button */
  _resetButtonNode = [[ButtonNode alloc] initWithImageNamed:UI_RESET_BUTTON_IMAGE withName:UI_RESET_BUTTON_NAME withPosition:UI_RESET_BUTTON_POSITION withXScale:UI_RESET_BUTTON_X_SCALE withYScale:UI_RESET_BUTTON_Y_SCALE];
  
  /* Tutorial Button */
  bool tutorialFinished = [[NSUserDefaults standardUserDefaults] boolForKey:@"tutorialFinished"];
  _tutorialNode = [[ButtonNode alloc] initWithImageNamed:UI_TUTORIAL_NODE_IMAGE withName:UI_TUTORIAL_NODE_NAME withPosition:UI_TUTORIAL_NODE_POSITION withXScale:UI_TUTORIAL_NODE_X_SCALE withYScale:UI_TUTORIAL_NODE_Y_SCALE];
  _tutorialNode.zPosition = UI_TUTORIAL_NODE_Z_POSITION;
  _tutorialNode.hidden = tutorialFinished;
  
  _tutorialOverlayNode = [SKSpriteNode spriteNodeWithImageNamed:@"overlay"];
  _tutorialOverlayNode.position = UI_TUTORIAL_NODE_POSITION;
  _tutorialOverlayNode.zPosition = UI_TUTORIAL_NODE_Z_POSITION-1;
  _tutorialOverlayNode.hidden = tutorialFinished;
  
  /* Adding user interface elements */
  [self addChild:_scoreLabelNode];
  [self addChild:_highscoreLabelNode];
  [self addChild:_backButtonNode];
  [self addChild:_resetButtonNode];
  [self addChild:_tutorialOverlayNode];
  [self addChild:_tutorialNode];
}

-(void)updateScore
{
  /* Updating score based on flips and saving highscore */
	_scoreLabelNode.text = [@(currentScore) stringValue];
	
	NSInteger localHighscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"localHighscore"];
	
	if(currentScore > localHighscore)
  {
		_highscoreLabelNode.hidden = NO;
		
		SKAction *fadeAction = [SKAction fadeAlphaTo:0 duration:2.0f];
		
		[_highscoreLabelNode runAction:fadeAction completion:^
    {
			_highscoreLabelNode.hidden = YES;
		}];
		
		[[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"localHighscore"];
		[[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reportScore:currentScore];
	}
}

-(void)reportScore:(int)score
{
  /* Report score to GameCenter */
  NSDictionary* userInfo = @{@"score": @(score)};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"reportScore" object:self userInfo:userInfo];
}

-(void)resetBottle
{
  /* Reset bottle after a failed or successful flip */
	_itemNode.position = GAME_ITEM_NODE_POSITION;
  _itemNode.physicsBody.angularVelocity = 0;
  _itemNode.physicsBody.velocity = CGVectorMake(0, 0);
	_itemNode.speed = 0;
  _itemNode.zRotation = 0;
	didSwipe = NO;
	
	[self playSoundFX:_popSound];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  /* Start recording touches */
	if ([touches count] > 1)
  {
		return;
	}
  
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];

	start = location;
	startTime = touch.timestamp;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  /* Determine what button was pressed */
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    
    if ([_backButtonNode containsPoint:location]) {
      [self playSoundFX:_popSound];
      [self changeToSceneByName:@"MenuScene" andUserData:[NSMutableDictionary dictionary]];
    }
    
    if([_resetButtonNode containsPoint:location] && didSwipe == YES)
    {
      [self playSoundFX:_popSound];
      [self failedFlip];
    }
    
    if([_tutorialNode containsPoint:location])
    {
      _tutorialNode.hidden = YES;
      _tutorialOverlayNode.hidden = YES;
      
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialFinished"];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
  }
	
  /* Bottle flipping logic */
	if(didSwipe == NO)
  {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
		CGFloat x = ceil(location.x - start.x);
		CGFloat y = ceil(location.y - start.y);
		
		CGFloat magnitude = sqrt(x*x+y*y);

		CGFloat t = touch.timestamp - startTime;
	
		if (magnitude >= GAME_SWIPE_MIN_DISTANCE && y > 0)
    {
			CGFloat speed = magnitude / t;
		
			if (speed >= GAME_SWIPE_MIN_SPEED)
      {
        /* Add angular velocity and impulse */
				_itemNode.physicsBody.angularVelocity = GAME_ANGULAR_VELOCITY;
				[_itemNode.physicsBody applyImpulse: CGVectorMake(0, magnitude * GAME_MAGNITUDE_MULTIPLIER)];
        
				didSwipe = YES;
      }
		}
	}
}

-(void)updateFlips
{
  /* Update total flips */
	NSInteger flips = [[NSUserDefaults standardUserDefaults] integerForKey:@"flips"];
  
  flips++;
	[[NSUserDefaults standardUserDefaults] setInteger:flips forKey:@"flips"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)successfulFlip
{
  /* Successfully flipped, so update scores & reset bottles */
  [self playSoundFX:_successSound];
  [self updateFlips];
  
  currentScore++;
  
  [self updateScore];
  [self resetBottle];
}

-(void)failedFlip
{
  adCounter++;
  
  if (USE_ADMOB && adCounter == ADMOB_INTERSTITIAL_RATE)
  {
    adCounter = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentInterstitial" object:nil];
  }
  
  /* Failed flips, reset score and bottle */
  [self playSoundFX:_failSound];
  
  currentScore = 0;
  
  [self updateScore];
  [self resetBottle];
}

-(void)update:(CFTimeInterval)currentTime
{
  [self checkIfSuccessfulFlip];
}

-(void)checkIfSuccessfulFlip
{
  /* Determine whether the item went off-screen */
  if(_itemNode.position.x <= 0 || _itemNode.position.x >= self.frame.size.width || _itemNode.position.y <= 0)
  {
    [self failedFlip];
  }
  
  /* Determine if landed upright */
  if(didSwipe && _itemNode.physicsBody.resting)
  {
    float bottleRotation = fabs(_itemNode.zRotation);
    
    if(bottleRotation > 0 && bottleRotation < 0.05)
    {
      [self successfulFlip];
    }
    else
    {
      [self failedFlip];
    }
  }
}

@end
