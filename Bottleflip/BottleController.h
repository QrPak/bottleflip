//
//  BottleController.h
//  Bottleflip Template
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "Item.h"

@interface BottleController : NSObject

+ (NSMutableArray*)readItems;
+ (void)saveSelectedItem:(int)index;
+ (int)getSavedItemIndex;

@end
