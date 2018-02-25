//
//  BottleController.m
//  Bottleflip Template
//

#import "BottleController.h"

@implementation BottleController

-(id)init {
  return self;
}

+(NSMutableArray*)readItems
{
  /* Reading items from plist */
  NSString* path = [[NSBundle mainBundle] pathForResource:ITEM_FILE ofType:@"plist"];
  NSArray* plistArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray* items = [NSMutableArray arrayWithCapacity:[plistArray count]];
  
  for (NSDictionary *dictionaryItem in plistArray)
  {
    Item *item = [[Item alloc] init];
    
    item.Name = [dictionaryItem objectForKey:@"Name"];
    item.Sprite = [dictionaryItem objectForKey:@"Sprite"];
    item.Mass = [dictionaryItem objectForKey:@"Mass"];
    item.Restitution = [dictionaryItem objectForKey:@"Restitution"];
    item.XScale = [dictionaryItem objectForKey:@"XScale"];
    item.YScale = [dictionaryItem objectForKey:@"YScale"];
    item.MinFlips = [dictionaryItem objectForKey:@"MinFlips"];
    
    [items addObject:item];
  }
  
  return items;
}

+(void)saveSelectedItem:(int)index
{
  /* Save index */
  [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"selectedItem"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getSavedItemIndex
{
  /* Get saved index */
  return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"selectedItem"];
}

@end
