//
//  GameUIConfig.h
//  Bottleflip Template
//

#ifndef GameUIConfig_h
#define GameUIConfig_h

// Score Label

#define UI_SCORE_LABEL_FONT_SIZE 140

#define UI_SCORE_LABEL_Z_POSITION -1

#define UI_SCORE_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))

// New Highscore Label

#define UI_NEW_HIGHSCORE_LABEL_TEXT @"NEW HIGHSCORE"

#define UI_NEW_HIGHSCORE_LABEL_FONT_SIZE 32

#define UI_NEW_HIGHSCORE_LABEL_Z_POSITION -1

#define UI_NEW_HIGHSCORE_LABEL_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 40)

// Tutorial Node

#define UI_TUTORIAL_NODE_IMAGE @"tutorial"

#define UI_TUTORIAL_NODE_NAME @"tutorial"

#define UI_TUTORIAL_NODE_POSITION CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))

#define UI_TUTORIAL_NODE_X_SCALE 0.55

#define UI_TUTORIAL_NODE_Y_SCALE 0.55

#define UI_TUTORIAL_NODE_Z_POSITION 5

// Backs Button

#define UI_BACK_BUTTON_IMAGE @"back_button"

#define UI_BACK_BUTTON_NAME @"backButton"

#define UI_BACK_BUTTON_POSITION CGPointMake(CGRectGetMinX(self.frame)+_backButtonNode.size.width + 30, CGRectGetMaxY(self.frame) - _backButtonNode.size.height - 40)

#define UI_BACK_BUTTON_X_SCALE 0.65

#define UI_BACK_BUTTON_Y_SCALE 0.65

// Reset Button

#define UI_RESET_BUTTON_IMAGE @"reset_button"

#define UI_RESET_BUTTON_NAME @"resetButton"

#define UI_RESET_BUTTON_POSITION CGPointMake(CGRectGetMaxX(self.frame)-_resetButtonNode.size.width - 40, CGRectGetMaxY(self.frame)-_resetButtonNode.size.height - 40)

#define UI_RESET_BUTTON_X_SCALE 0.65

#define UI_RESET_BUTTON_Y_SCALE 0.65

#endif /* GameUIConfig_h */
