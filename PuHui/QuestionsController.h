//
//  QuestionsController.h
//  PuHui
//
//  Created by rp.wang on 15/7/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendPostController.h"
#import "PhoneAskController.h"

@interface QuestionsController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) NSString *questionId;
@property (strong, nonatomic) SendPostController *sendPostCtlr;
@property (strong, nonatomic) PhoneAskController *phoneAskCtlr;
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;

- (IBAction)phoneTap:(id)sender;
@end
