//
//  ButtonNode.h
//  Bottleflip Template
//

#import <SpriteKit/SpriteKit.h>

@interface ButtonNode : SKSpriteNode
{
  float originalScale;
}

- (id)initWithImageNamed:(NSString *)imageName withName:(NSString *)name withPosition:(CGPoint)position withXScale:(CGFloat)yScale withYScale:(CGFloat)yScale;

@end
