//
//  FeedbackViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/22.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *feedBack;
@property (strong, nonatomic)UILabel *successLable;

@property (weak, nonatomic) IBOutlet UITextField *titleTextFiled;

@end

@implementation FeedbackViewController

- (IBAction)clicksubmit:(id)sender {
    self.feedBack.textColor = [UIColor blackColor];
   //提交成功
    if (_titleTextFiled.text.length > 0&&_feedBack.text.length >0) {
        self.successLable = [[UILabel alloc]initWithFrame:self.view.frame];
        self.successLable.hidden = NO;
        self.successLable.text = @"提交成功!";
        self.successLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.successLable];
        self.successLable.textColor = [UIColor blackColor];
        self.successLable.font = [UIFont boldSystemFontOfSize:20];
        self.successLable.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8];
        
        
        
        [self performSelector:@selector(hidesuccessLable) withObject:nil afterDelay:2.0];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"标题或者反馈内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:NO completion:nil];
        

    }
    
    
   



}

-(void)hidesuccessLable{
    self.successLable.hidden = YES;
    self.titleTextFiled.text = @"";
    self.feedBack.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationItem.title = @"意见反馈";
    self.titleTextFiled.delegate = self;
    self.feedBack.delegate =self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_feedBack resignFirstResponder];
    [_titleTextFiled resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}



@end
