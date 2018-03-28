//
//  TakePhoto.h
//  LargeCommunity
//
//  Created by michaelyht on 2017/8/4.
//  Copyright © 2017年 michaelyht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//使用block 返回值
typedef void (^GetPictureBlock)(UIImage *image);

@interface TakePhoto : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic,copy)GetPictureBlock getPictureBlock;


+ (TakePhoto *)sharedModel;

+ (void)sharePicture:(GetPictureBlock)block;


@end


