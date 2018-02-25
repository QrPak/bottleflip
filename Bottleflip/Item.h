//
//  Item.h
//  Bottleflip Template
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, copy) NSString* Name;
@property (nonatomic, copy) NSString* Sprite;
@property (nonatomic, copy) NSNumber* Mass;
@property (nonatomic, copy) NSNumber* Restitution;
@property (nonatomic, copy) NSNumber* XScale;
@property (nonatomic, copy) NSNumber* YScale;
@property (nonatomic, copy) NSNumber* MinFlips;

@end
