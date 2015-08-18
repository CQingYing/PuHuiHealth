//
//  SendPostController.h
//  PuHui
//
//  Created by rp.wang on 15/7/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendPostController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *contentField;
@property (strong, nonatomic) IBOutlet UITextField *oldFied;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *manBtn;
@property (strong, nonatomic) IBOutlet UIButton *womanBtn;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *isEditTV;
@end
