//
//  GameConfig.h
//  Bottleflip Template
//

#ifndef GameConfig_h
#define GameConfig_h

// Gameplay settings

#define GAME_ANGULAR_VELOCITY 5.10

#define GAME_MAGNITUDE_MULTIPLIER 1.8

#define GAME_ANGULAR_DAMPING 0.25

#define GAME_SWIPE_MIN_DISTANCE 20

#define GAME_SWIPE_MIN_SPEED 20

// Game sounds

#define GAME_SOUND_POP @"pop.wav"

#define GAME_SOUND_SUCCESS @"fanfare.wav"

#define GAME_SOUND_FAIL @"fail.wav"

// Game node settings

#define GAME_TABLE_NODE_X_SCALE 0.45

#define GAME_TABLE_NODE_Y_SCALE 0.45

#define GAME_TABLE_NODE_POSITION CGPointMake(CGRectGetMidX(self.frame), 20)

#define GAME_TABLE_NODE_RESTITUTION 0

#define GAME_ITEM_NODE_NAME @"name"

#define GAME_ITEM_NODE_POSITION CGPointMake(CGRectGetMidX(self.frame), _itemNode.size.height)

#endif /* GameConfig_h */
