//
//  ViewController.m
//  36-demo-01
//
//  Created by zcz on 15-9-8.
//  Copyright (c) 2015年 zcz. All rights reserved.
//


#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

static SystemSoundID shake_sound_male_id = 0;

@interface ViewController ()

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIImageView *up;
@property (nonatomic, strong) UIImageView *down;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"bg2"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    self.bg = bg;
    
    
    UIImageView *up = [[UIImageView alloc] init];
    up.image = [UIImage imageNamed:@"Shake_01"];
    up.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.5);
    [bg addSubview:up];
    self.up = up;
    
    
    UIImageView *down = [[UIImageView alloc] init];
    down.image = [UIImage imageNamed:@"Shake_02"];
    down.frame = CGRectMake(0, self.view.bounds.size.height * 0.5, self.view.bounds.size.width, self.view.bounds.size.height * 0.5);
    [bg addSubview:down];
    self.down = down;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
    }
}


-(void) playSound

{
    //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    AudioServicesPlaySystemSound(shake_sound_male_id);
    //让手机震动
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - 摇一摇动画效果
- (void)addAnimations
{
    CGFloat imgW=self.view.bounds.size.width;
    CGFloat imgH=self.view.bounds.size.height;
    
    //让down上下移动
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(imgW/2, 400)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(imgW/2,550)];
    translation.duration = 0.4;
    translation.repeatCount = 1;
    translation.autoreverses = YES;
    
    //让up上下移动
    CABasicAnimation *translation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(imgW/2, 115)];
    translation1.toValue = [NSValue valueWithCGPoint:CGPointMake(imgW/2, 40)];
    translation1.duration = 0.4;
    translation1.repeatCount = 1;
    translation1.autoreverses = YES;
    
    [self.down.layer addAnimation:translation forKey:@"translation"];
    [self.up.layer addAnimation:translation1 forKey:@"translation1"];
    

    
}

#pragma mark -摇一摇

- (BOOL)canBecomeFirstResponder
{
    // default is NO
    return YES;
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"shake");
    //播放声音
    [self playSound];
    //添加
    [self addAnimations];
    
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"stop");
    
    /*
     UIAlertView *yaoyiyao = [[UIAlertView alloc]initWithTitle:@"温馨提示：" message:@"您摇动了手机" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles: nil];
     [yaoyiyao show];
     
     */
    
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"cancel");
}


@end
