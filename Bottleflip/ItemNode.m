//
//  BottleNode.m
//  Bottleflip Template
//

#import "ItemNode.h"

@implementation ItemNode

- (id)initWithItem:(Item *)item
{
  /* Initializing the bottle item */
  if (self = [super init]) {
    self = [ItemNode spriteNodeWithImageNamed:item.Sprite];
    self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.texture.size];
    self.name = GAME_ITEM_NODE_NAME;
    self.xScale = [item.XScale floatValue];
    self.yScale = [item.YScale floatValue];
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = YES;
    self.physicsBody.angularDamping = GAME_ANGULAR_DAMPING;
    self.physicsBody.mass = [item.Mass doubleValue];
    self.physicsBody.restitution = [item.Restitution doubleValue];
  }
  return self;
}

@end
