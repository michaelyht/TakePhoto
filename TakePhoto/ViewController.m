//
//  ViewController.m
//  TakePhoto
//
//  Created by Michael on 2018/3/28.
//  Copyright © 2018年 michaelyht. All rights reserved.
//

#import "ViewController.h"
#import "TakePhoto.h"

@interface ViewController (){
    
    __weak IBOutlet UIImageView *_photo;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _photo.layer.cornerRadius = CGRectGetWidth(_photo.frame)/2.f;
    _photo.layer.masksToBounds = YES;
    
}

- (IBAction)bntClick:(id)sender {
    [TakePhoto sharePicture:^(UIImage *image){
        [_photo setImage:image];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
