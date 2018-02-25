//
//  ButtonNode.m
//  Bottleflip Template
//

#import "ButtonNode.h"

@implementation ButtonNode

- (id)initWithImageNamed:(NSString *)imageName withName:(NSString *)name withPosition:(CGPoint)position withXScale:(CGFloat)xScale withYScale:(CGFloat)yScale
{
  /* Initializing button */
  if (self = [super init]) {
    self = [ButtonNode spriteNodeWithImageNamed:imageName];
    self.name = name;
    self.xScale = xScale;
    self.yScale = yScale;
    self.position = position;
    originalScale = xScale;
    
    [self runIntroAnimation];
    
  }
  return self;
}

- (void)runIntroAnimation
{
  /* Neat little intro animation */
  SKAction *scaleDownAction = [SKAction scaleTo:0 duration:0];
  SKAction *scaleUpAction = [SKAction scaleTo:originalScale duration:0.15];
  SKAction *intro = [SKAction sequence:@[scaleDownAction, scaleUpAction]];
  
  [self runAction:intro];
}

@end
