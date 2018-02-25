//
//  MainMenuConfig.h
//  Bottleflip Template
//

#ifndef MainMenuConfig_h
#define MainMenuConfig_h

// Main menu font and color settings

#define UI_MENU_FONT_COLOR [UIColor colorWithRed:0/255.0f green:84/255.0f blue:104/255.0f alpha:1.0]

#define UI_HIGHLIGHT_FONT_COLOR [UIColor colorWithRed:255/255.0f green:140/255.0f blue:27/255.0f alpha:1.0]

#define UI_DISABLED_MENU_FONT_COLOR [UIColor colorWithRed:0/255.0f green:84/255.0f blue:104/255.0f alpha:0.2]

// Logo

#define UI_MENU_LOGO_NAME @"logo"

#define UI_MENU_LOGO_IMAGE @"logo"

#define UI_MENU_LOGO_X_SCALE 0.7

#define UI_MENU_LOGO_Y_SCALE 0.7

#define UI_MENU_LOGO_POSITION CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - 75)

// Best Score Label

#define UI_BEST_SCORE_LABEL_TEXT @"BEST SCORE"

#define UI_BEST_SCORE_LABEL_FONT_SIZE 16

#define UI_BEST_SCORE_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMaxY(self.frame) - 165)

// High Score Label

#define UI_HIGH_SCORE_LABEL_FONT_SIZE 73

#define UI_HIGH_SCORE_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMaxY(self.frame) - 235)

// Total Flips Label

#define UI_TOTAL_FLIPS_LABEL_TEXT @"TOTAL FLIPS"

#define UI_TOTAL_FLIPS_LABEL_FONT_SIZE 16

#define UI_TOTAL_FLIPS_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMaxY(self.frame) - 165)

// Flips Tag

#define UI_FLIPS_TAG_IMAGE @"lock"

#define UI_FLIPS_TAG_NAME @"flipsNode"

#define UI_FLIPS_TAG_POSITION CGPointMake(CGRectGetMidX(self.frame) + _itemNode.size.width*0.5, CGRectGetMinY(self.frame) +_itemNode.size.height/2 + 87)

#define UI_FLIPS_TAG_X_SCALE 0.5

#define UI_FLIPS_TAG_Y_SCALE 0.5

#define UI_FLIPS_TAG_Z_POSITION 20

#define UI_FLIPS_TAG_Z_ROTATION 0.3

// Unlock Label

#define UI_UNLOCK_LABEL_FONT_SIZE 36

#define UI_UNLOCK_LABEL_POSITION CGPointMake(0, -_unlockLabelNode.frame.size.height-15)

#define UI_UNLOCK_LABEL_Z_POSITION 30

// Flips Label

#define UI_FLIPS_LABEL_FONT_SIZE 73

#define UI_FLIPS_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMaxY(self.frame) - 235)

// Play/Shop Button

#define UI_SHOP_BUTTON_IMAGE @"shop_button"

#define UI_PLAY_BUTTON_IMAGE @"play_button"

#define UI_PLAY_BUTTON_NAME @"playButton"

#define UI_PLAY_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 15)

#define UI_PLAY_BUTTON_X_SCALE 0.9

#define UI_PLAY_BUTTON_Y_SCALE 0.9

// Restore Button

#define UI_RESTORE_BUTTON_IMAGE @"restore_button"

#define UI_RESTORE_BUTTON_NAME @"restoreButton"

#define UI_RESTORE_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) +_restoreButtonNode.size.height + 78)

#define UI_RESTORE_BUTTON_X_SCALE 0.4

#define UI_RESTORE_BUTTON_Y_SCALE 0.4

#define UI_RESTORE_BUTTON_Z_POSITION 5

// Leaderboard Button

#define UI_LEADERBOARD_BUTTON_IMAGE @"leaderboard_button"

#define UI_LEADERBOARD_BUTTON_NAME @"leaderboardButton"

#define UI_LEADERBOARD_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame) - _playButtonNode.size.width + 10, CGRectGetMidY(self.frame) - 15)

#define UI_LEADERBOARD_BUTTON_X_SCALE 0.6

#define UI_LEADERBOARD_BUTTON_Y_SCALE 0.6

// Share Button

#define UI_SHARE_BUTTON_IMAGE @"trophy_button"

#define UI_SHARE_BUTTON_NAME @"shareButton"

#define UI_SHARE_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame) + _playButtonNode.size.width - 10, CGRectGetMidY(self.frame) - 15)

#define UI_SHARE_BUTTON_X_SCALE 0.6

#define UI_SHARE_BUTTON_Y_SCALE 0.6

// Table Node

#define UI_TABLE_NODE_IMAGE @"table"

#define UI_TABLE_NODE_NAME @"tableNode"

#define UI_TABLE_NODE_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+20)

#define UI_TABLE_NODE_X_SCALE 0.45

#define UI_TABLE_NODE_Y_SCALE 0.45

#define UI_TABLE_NODE_Z_POSITION 3

// Left Button

#define UI_LEFT_BUTTON_IMAGE @"left_button"

#define UI_LEFT_BUTTON_NAME @"leftButton"

#define UI_LEFT_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame) + _leftButtonNode.size.width - 130, CGRectGetMinY(self.frame)-_leftButtonNode.size.height + 150)

#define UI_LEFT_BUTTON_X_SCALE 0.8

#define UI_LEFT_BUTTON_Y_SCALE 0.8

// Right Button

#define UI_RIGHT_BUTTON_IMAGE @"right_button"

#define UI_RIGHT_BUTTON_NAME @"rightButton"

#define UI_RIGHT_BUTTON_POSITION CGPointMake(CGRectGetMidX(self.frame) + _rightButtonNode.size.width + 130, CGRectGetMinY(self.frame) + _rightButtonNode.size.height + 150)

#define UI_RIGHT_BUTTON_X_SCALE 0.8

#define UI_RIGHT_BUTTON_Y_SCALE 0.8

// Item Node

#define UI_ITEM_NODE_NAME @"bottle"

#define UI_ITEM_NODE_Z_POSITION 10

#define UI_ITEM_NODE_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) +_itemNode.size.height/2 + 87)

#define UI_ITEM_NODE_SIZE CGSizeMake(_itemNode.texture.size.width * [item.XScale floatValue], _itemNode.texture.size.height * [item.YScale floatValue])

#endif /* MainMenuConfig_h */
