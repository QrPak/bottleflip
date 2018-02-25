//
//  GameViewController.h
//  Bottleflip Template
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import <StoreKit/StoreKit.h>
#import <GameKit/GameKit.h>
#import "AdConfig.h"

@import GoogleMobileAds;

@interface GameViewController : UIViewController<SKProductsRequestDelegate, SKPaymentTransactionObserver, GKGameCenterControllerDelegate, GADInterstitialDelegate, GADBannerViewDelegate>
{
  bool gameCenterEnabled;
}

@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, strong) GADBannerView *bannerView;

@property bool allAreUnlocked;
@end
