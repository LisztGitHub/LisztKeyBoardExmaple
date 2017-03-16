//
//  ViewController.m
//  LisztKeyBoardExmaple
//
//  Created by Liszt on 2017/1/11.
//  Copyright © 2017年 Liszt. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LisztKeyBoardControl.h"

@interface ViewController ()
/*工具栏*/
@property (nonatomic, strong) UIView *toolBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"LisztKeyBoardControl";
    [self.view addSubview:self.toolBar];
    
    self.view.keyboardTriggerOffset = self.toolBar.frame.size.height;
    __weak ViewController *weakSelf = self;
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        /*
         Try not to call "self" inside this block (retain cycle).
         But if you do, make sure to remove DAKeyboardControl
         when you are done with the view controller by calling:
         [self.view removeKeyboardControl];
         */
        
        CGRect toolBarFrame = weakSelf.toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        weakSelf.toolBar.frame = toolBarFrame;
        
//        CGRect tableViewFrame = tableView.frame;
//        tableViewFrame.size.height = toolBarFrame.origin.y;
//        tableView.frame = tableViewFrame;
    } constraintBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        
    }];
}

#pragma mark - 懒加载
- (UIView *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 45)];
        _toolBar.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        
        /*1.键盘*/
        UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20 - 50, 35)];
        textFiled.placeholder = @"请输入消息";
        textFiled.font = [UIFont systemFontOfSize:14.f];
        textFiled.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.borderStyle = UITextBorderStyleRoundedRect;
        [_toolBar addSubview:textFiled];
        
        /*2.发送按钮*/
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        sendButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)-60, 0, 60, CGRectGetHeight(_toolBar.frame));
        sendButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_toolBar addSubview:sendButton];
    }
    return _toolBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
