//
//  ViewController.m
//  JHUploadImage
//
//  Created by Jivan on 2017/11/8.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import "ViewController.h"
#import "JHUploadImage.h"

@interface ViewController ()<JHUploadImageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)upLoadImageToServer:(UIButton *)sender {
    
    [JHUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
}


-(void)uploadImageToServerWithImage:(UIImage *)image OriginImage:(UIImage *)originImage
{
    NSLog(@"%@\n%@",originImage,image);
}




#pragma mark - JHUploadImageDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
