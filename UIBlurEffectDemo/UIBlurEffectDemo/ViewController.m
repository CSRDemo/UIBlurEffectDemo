//
//  ViewController.m
//  UIBlurEffectDemo
//
//  Created by 曹书润 on 2017/6/4.
//  Copyright © 2017年 LeoAiolia. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIImage+ImageEffects.h"

typedef NS_ENUM(NSInteger,ImageBlurEffect) {
    ImageBlurEffectNone, //原图
    ImageBlurEffectUIToolBar,
    ImageBlurEffectUIBlurEffect,
    ImageBlurEffectLBBluredImage,
};

@interface ViewController ()

@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,assign) ImageBlurEffect effect;
@property(nonatomic,assign) CGSize screenSize;

@end

@implementation ViewController

@synthesize screenSize;

- (void)viewDidLoad {
    [super viewDidLoad];
     screenSize = [[UIScreen mainScreen] bounds].size;

    self.dataArr = @[@"原图",@"UIToolBar",@"UIBlurEffect",@"LBBluredImage"];
    self.effect = ImageBlurEffectNone;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    imageView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [self.view addSubview:imageView];
    self.imageView = imageView;

    CGFloat btnWidth = 120;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor greenColor];
    button.alpha = 0.8;
    [button setTitle:@"点击切换实现方法" forState:UIControlStateNormal];
    button.frame = CGRectMake((screenSize.width-btnWidth)/2,(screenSize.height - 60),btnWidth, 40);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:button];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(10, 20, 200, 20);
    _label.font = [UIFont systemFontOfSize:18 weight:20];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.text = self.dataArr[_effect];
    [self.view addSubview:_label];
    
    
}

- (void)buttonClick:(UIButton *)sender
{
    _effect = (_effect + 1) % 4;
    _label.text = self.dataArr[_effect];
    
    [self.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (_effect) {
        case ImageBlurEffectNone:
        {
            self.imageView.image = [UIImage imageNamed:@"1"];
        }
            break;
            
        case ImageBlurEffectUIToolBar:
        {
            [self method1];
        }
            break;
            
        case ImageBlurEffectUIBlurEffect:
        {
            [self method2];
        }
            break;
            
        case ImageBlurEffectLBBluredImage:
        {
            [self method3];
        }
            break;
    }
}

- (void)method1
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.translucent = YES;
    [self.imageView addSubview:toolbar];
}

- (void)method2
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [self.imageView addSubview:effectView];
    
}

- (void)method22222
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVibrancyEffect *effect2 = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect2];
    effectView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor redColor];
    yellowView.frame = effectView.frame;
    [effectView.contentView addSubview:yellowView];
    
    [self.imageView addSubview:effectView];
    
}

- (void)method3
{
    //使用这个方法会略有延迟，先显示原图，等原图改好之后才变成blurImage,因为此方法使用了异步，此时imageNamed后会是原图，等模糊了之后，才在主线程更新，如果想使用此方法，且不出现闪一下原图，需要都在主线程操作。或者使用下面的方法
//    [self.imageView setImageToBlur:self.imageView.image completionBlock:^{
//         NSLog(@"The LBBlurred image has been set");
//    }];
    self.imageView.image = [[UIImage imageNamed:@"1"] applyDarkEffect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
