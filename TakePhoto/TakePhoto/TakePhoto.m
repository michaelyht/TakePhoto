//
//  TakePhoto.m
//  LargeCommunity
//
//  Created by michaelyht on 2017/8/4.
//  Copyright © 2017年 michaelyht. All rights reserved.
//
#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])

#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])

#import "TakePhoto.h"

@implementation TakePhoto{
    NSUInteger sourceType;
}

+ (TakePhoto *)sharedModel{
    static TakePhoto *sharedModel = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

+(void)sharePicture:(GetPictureBlock)block{
    
    TakePhoto *tP = [TakePhoto sharedModel];
    
    tP.getPictureBlock = block;
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"设置图像" delegate:tP cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册中获取", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"设置图像" delegate:tP cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册中获取", nil];
    }

     sheet.tag = 255;
    
    [sheet showInView:AppRootView];
    

}


#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
         sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0://相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1://相册
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2://取消
                    return;
                default:
                    break;
            }
    }else {
        if (buttonIndex == 2) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
        
        // 跳转到相机或相册页面
       UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [AppRootViewController presentViewController:imagePickerController animated:YES completion:NULL];

    }
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    TakePhoto *tPhoto = [TakePhoto sharedModel];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

    [tPhoto getPictureBlock](image);
    
}


@end
