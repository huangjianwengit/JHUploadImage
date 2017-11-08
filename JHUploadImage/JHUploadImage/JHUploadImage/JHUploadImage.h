//
//  JHUploadImage.h
//  SmallCityStory
//
//  Created by Jivan on 2017/11/8.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//把单例方法定义为宏，使用起来更方便
#define JHUPLOAD_IMAGE [JHUploadImage shareUploadImage]

//代理方法
@protocol JHUploadImageDelegate <NSObject>

@optional

- (void)uploadImageToServerWithImage:(UIImage *) edittedImage OriginImage:(UIImage *)originImage;

@end

@interface JHUploadImage : NSObject < UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

{
    //如果你调不出来UIViewController,请添加UIKit头文件
    UIViewController *_fatherViewController;
}
@property (nonatomic, weak) id <JHUploadImageDelegate> uploadImageDelegate;
//单例方法
+ (JHUploadImage *)shareUploadImage;

//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<JHUploadImageDelegate>)aDelegate;

@end





