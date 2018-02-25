//
//  GameViewController.m
//  Bottleflip Template
//

#import "GameViewController.h"
#import "MenuScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	/* COnfigure view */
	SKView * skView = (SKView *)self.view;
	skView.ignoresSiblingOrder = YES;
	
	/* Create and configure the scene. */
	MenuScene *scene = [MenuScene nodeWithFileNamed:@"MenuScene"];
	scene.scaleMode = SKSceneScaleModeResizeFill;
	
	[skView presentScene:scene];
	
	/* Setup notification center */
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"reportScore" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeaderboard) name:@"showLeaderboard" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showShareSheet) name:@"showShareSheet" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restorePurchases) name:@"restorePurchases" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPurchase) name:@"requestPurchase" object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentInterstitial) name:@"presentInterstitial" object:nil];
  
  if(USE_ADMOB)
  {
    if(USE_INTERSTITIAL)
      [self createAndLoadInterstitial];
    
    if(USE_BANNER)
      [self createAndLoadBanner];
  }
	
	/* Authenticate players with GameCenter */
	[self authenticateLocalPlayer];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)interstitial
{
  [self createAndLoadInterstitial];
}

-(void)createAndLoadBanner
{
  self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-GAD_SIZE_468x60.height, GAD_SIZE_468x60.width, GAD_SIZE_468x60.height)];

  self.bannerView.adUnitID = ADMOB_AD_UNIT_BANNER_ID;
  self.bannerView.rootViewController = self;
  self.bannerView.delegate = self;
  
  GADRequest *request = [GADRequest request];
  request.testDevices = @[kGADSimulatorID, ADMOB_TEST_DEVICE_ID];
  [self.bannerView loadRequest:request];
  
  [self.view addSubview:self.bannerView];
}

- (void)createAndLoadInterstitial
{
  self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:ADMOB_AD_UNIT_INTERSTITIAL_ID];
  self.interstitial.delegate = self;
  GADRequest *request = [GADRequest request];
  // Request test ads on devices you specify. Your test device ID is printed to the console when
  // an ad request is made.
  request.testDevices = @[kGADSimulatorID, ADMOB_TEST_DEVICE_ID];
  [self.interstitial loadRequest:request];
}

-(void)presentInterstitial
{
  if (self.interstitial.isReady && USE_ADMOB && USE_INTERSTITIAL)
  {
    [self.interstitial presentFromRootViewController:self];
  }
  else
  {
    NSLog(@"Not ready/ads disabled");
  }
}

- (BOOL)shouldAutorotate
{
	return YES;
}

- (void)handleNotification:(NSNotification *)notification
{
	/* Score report requested */
	if ([notification.name isEqualToString:@"reportScore"])
	{
		/* Get data from notification center and pass on */
		NSDictionary* userInfo = notification.userInfo;
		NSNumber* score = (NSNumber*)userInfo[@"score"];
		
		[self reportScore:[score intValue]];
	}
}

-(void)authenticateLocalPlayer
{
	/* Do GameCEnter authentication */
	GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
	
	localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
		if (viewController != nil) {
			[self presentViewController:viewController animated:YES completion:nil];
		}
		else{
			if ([GKLocalPlayer localPlayer].authenticated) {
				gameCenterEnabled = YES;
			}
			else{
				gameCenterEnabled = NO;
			}
		}
	};
}

-(void)showLeaderboard
{
	/* Display the GameCenter leaderboard */
	if (gameCenterEnabled) {
		GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
  
		gcViewController.gameCenterDelegate = self;
  
		gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
		gcViewController.leaderboardIdentifier = LEADERBOARD_ID;
		
		[self presentViewController:gcViewController animated:YES completion:nil];
	}
	else
	{
		[self showAlert:@"Please authenticate with GameCenter." isError:YES];
	}
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController {
	/* Dismiss it */
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showShareSheet
{
  /* Present the share sheet */
	NSString *textToShare = [NSString stringWithFormat:GAME_SHARE_MESSAGE, [[NSUserDefaults standardUserDefaults] integerForKey:@"localHighscore"]];
	NSURL *website = [NSURL URLWithString:GAME_URL];
	
	NSArray *objectsToShare = @[textToShare, website];
	
	UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
	
	NSArray *excludeActivities = @[UIActivityTypeAirDrop,
								   UIActivityTypePrint,
								   UIActivityTypeAssignToContact,
								   UIActivityTypeAddToReadingList,
								   UIActivityTypePostToFlickr,
								   UIActivityTypePostToVimeo];
	
	activityVC.excludedActivityTypes = excludeActivities;
	
	[self presentViewController:activityVC animated:YES completion:nil];
}

-(void)reportScore:(int)score {
  /* Report score to GameCenter */
	GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:LEADERBOARD_ID];
	gkScore.value = score;
	
	[GKScore reportScores:@[gkScore] withCompletionHandler:^(NSError *error) {
		if (error != nil) {
			NSLog(@"%@", [error localizedDescription]);
		}
	}];
}

-(void)showAlert:(NSString*)message isError:(BOOL)isError
{
  /* Show info/error alert */
	UIAlertController * alert = [UIAlertController
								 alertControllerWithTitle:(isError ? @"Error" : @"Info")
								 message:message
								 preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
	
	[alert addAction:defaultAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)purchase:(SKProduct *)product
{
  /* Start payment transaction */
	SKPayment *payment = [SKPayment paymentWithProduct:product];
	
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
  /* Determine method paid/unlock items if necessary */
	for(SKPaymentTransaction *transaction in transactions)
	{
		switch(transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				[self unlockAllItems];
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
			case SKPaymentTransactionStateRestored:
				[self unlockAllItems];
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
			case SKPaymentTransactionStateFailed:
				if(transaction.error.code == SKErrorPaymentCancelled){
					[self showAlert:@"Purchase was cancelled." isError:NO];
				}
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
			default:
				break;
		}
	}
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
  /* Find the product requested */
	SKProduct *validProduct = nil;
	int count = (int)[response.products count];
	
	if(count > 0)
	{
		validProduct = [response.products objectAtIndex:0];
		[self purchase:validProduct];
	}
	else if(!validProduct)
	{
		[self showAlert:@"An error with purchasing the item occurred." isError:YES];
		NSLog(@"No products available!");
	}
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
  /* Restore */
	for(SKPaymentTransaction *transaction in queue.transactions)
	{
		if(transaction.transactionState == SKPaymentTransactionStateRestored)
		{
			[self unlockAllItems];
			
			[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
			break;
		}
	}
}

- (void)unlockAllItems
{
  /* Unlocks all items */
	[self showAlert:@"Thanks for your purchase! All items are now unlocked." isError:NO];
	_allAreUnlocked = YES;
	
	[[NSUserDefaults standardUserDefaults] setBool:_allAreUnlocked forKey:@"unlockAll"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afterPurchaseUpdate" object:nil];
}

-(void)restorePurchases
{
  /* When restore is initiated */
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

-(void)requestPurchase
{
  /* Requesting purchase */
	if([SKPaymentQueue canMakePayments])
	{
		SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:UNLOCK_ALL_PRODUCT_ID]];
		productsRequest.delegate = self;
		
		[productsRequest start];
	}
	else
	{
		[self showAlert:@"Parental control are preventing purchase or other error." isError:YES];
	}
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end
