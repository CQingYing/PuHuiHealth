//
//  SendPostController.m
//  PuHui
//
//  Created by rp.wang on 15/7/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SendPostController.h"
#import "BBRim.h"

@interface SendPostController ()
@property (strong, nonatomic) IBOutlet UIButton *imageBtn;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (nonatomic) UIImagePickerController *imagePickerController;


@end

@implementation SendPostController
@synthesize sex,isEditTV,oldFied,manBtn,womanBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    // Do any additional setup after loading the view.
    sex = @"1";
    isEditTV = @"0";
    self.manBtn.selected = YES;
    [self.oldFied setDelegate:self];
    [self.contentField setDelegate:self];
    [self.oldFied setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
}

-(IBAction)manClicked {
    self.manBtn.selected = YES;
    self.womanBtn.selected = NO;
    sex = @"1";
}

-(IBAction)womanClicked {
    self.womanBtn.selected = YES;
    self.manBtn.selected = NO;
    sex = @"2";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ((textView == self.contentField)&&![isEditTV isEqualToString:@"1"]) {
        isEditTV = @"1";
        textView.text = @"";
    }
}

-(IBAction)ImageBtnClicked {
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相机选择" otherButtonTitles:@"拍照", nil];
    [self.actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self localPhoto];
    } else if (buttonIndex == 1) {
        [self takePhoto];
    } else {
        //取消
    }
}

-(void)localPhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController setDelegate:self];
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
    
    
}

-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imagePickerController setDelegate:self];
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:picker completion:^{
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
