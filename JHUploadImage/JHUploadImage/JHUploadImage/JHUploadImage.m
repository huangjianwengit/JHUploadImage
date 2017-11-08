//
//  JHUploadImage.m
//  SmallCityStory
//
//  Created by Jivan on 2017/5/4.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import "JHUploadImage.h"
static JHUploadImage *_jhUploadImage = nil;

@implementation JHUploadImage
+ (JHUploadImage *)shareUploadImage {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _jhUploadImage = [[JHUploadImage alloc] init];
    });
    return _jhUploadImage;
}
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC  delegate:(id<JHUploadImageDelegate>)aDelegate {
    _jhUploadImage.uploadImageDelegate = aDelegate;
    _fatherViewController = fatherVC;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从手机相册上传", @"相机拍照", nil];
    [sheet showInView:fatherVC.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self fromPhotos];
    }else if (buttonIndex == 1) {
        [self createPhotoView];
    }
}
#pragma mark - 头像(相机和从相册中选择)
- (void)createPhotoView {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType                = UIImagePickerControllerSourceTypeCamera;
        imagePC.delegate                  = self;
        imagePC.allowsEditing             = YES;
        [_fatherViewController presentViewController:imagePC
                                            animated:YES
                                          completion:^{
                                          }];
    }else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"该设备没有照相机"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
}
//图片库方法(从手机的图片库中查找图片)
- (void)fromPhotos {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.navigationBar.translucent = NO;
    imagePC.sourceType                = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.delegate                  = self;
    imagePC.allowsEditing             = YES;
    [_fatherViewController presentViewController:imagePC
                                        animated:YES
                                      completion:^{
                                      }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
     // 原始图片
    UIImage * OriginalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
      //裁剪后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
     //上传用户头像
    if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadImageToServerWithImage:OriginImage:)]) {
        [self.uploadImageDelegate uploadImageToServerWithImage:image OriginImage:OriginalImage];
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
