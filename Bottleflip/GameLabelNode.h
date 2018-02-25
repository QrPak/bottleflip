//
//  GameLabelNode.h
//  Bottleflip Template
//

#import <SpriteKit/SpriteKit.h>
#import "UIConfig.h"

@interface GameLabelNode : SKLabelNode

- (id)initWithText:(NSString *)text withFontSize:(int)fontSize withPosition:(CGPoint)position withColor:(UIColor *)color;

@end
