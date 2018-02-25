//
//  GameLabelNode.m
//  Bottleflip Template
//

#import "GameLabelNode.h"

@implementation GameLabelNode

- (id)initWithText:(NSString *)text withFontSize:(int)fontSize withPosition:(CGPoint)position withColor:(UIColor *)color {
  /* Initializing game label */
  if (self = [super init]) {
    self = [GameLabelNode labelNodeWithFontNamed:UI_FONT];
    self.fontSize = fontSize;
    self.position = position;
    self.fontColor = color;
    self.text = text;
  }
  return self;
}

@end
