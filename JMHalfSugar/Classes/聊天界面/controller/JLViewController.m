//
//  JLViewController.m
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLViewController.h"
#import "JLMessage.h"
#import "JLMessageFrame.h"
#import "JLMessageCell.h"
#define ViewW self.view.bounds.size.width

#define ViewH self.view.bounds.size.height

@interface JLViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic)  UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messageFrames;

@property (strong, nonatomic)  UITextField *myText;

@end

@implementation JLViewController

-(UITableView *)tableView{

    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self inputView];
    
    int a=10,b=5;
     a=a^b;
    b=a^b;
    a=a^b;
    
    NSLog(@"%d,%d",a,b);
    
    
    // 1,UITableView的设置
    // 设置数据源
    self.tableView.dataSource = self;
    // 设置代理
    self.tableView.delegate = self;
    // 设置tableView的背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    // 去除cell之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 将cell设置为不可选中(点击)
    self.tableView.allowsSelection = NO;
    
//     2,监听键盘的通知，注册监听，一定要记得反注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
    //toolbar
    [self addTollBar];
    
    
}
-(void)addTollBar{

    UIImageView *backGroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, ViewH-40, ViewW, 40)];
    
    backGroundImage.image=[UIImage imageNamed:@"chat_bottom_bg"];
    
    backGroundImage.userInteractionEnabled = YES;
    
    [self.view addSubview:backGroundImage];
    
    _myText=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, ViewW*0.5-10, 36)];
    
    _myText.background=[UIImage imageNamed:@"chat_bottom_textfield"];
    
//    _myText.backgroundColor=[UIColor redColor];
    _myText.clearButtonMode=UITextFieldViewModeWhileEditing;
    _myText.delegate=self;
    [_myText setReturnKeyType:UIReturnKeySend];
    
    
    [backGroundImage addSubview:_myText];
    
    
    CGFloat BtnW=36;
    CGFloat padding=(ViewW-3*BtnW-_myText.bounds.size.width)*0.25;
    
    for (int i=0; i<3; i++) {
        
        
        CGFloat BtnX=_myText.bounds.size.width+padding+i*(BtnW+padding);
        //        NSLog(@"%f",BtnX);
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(BtnX, 2, BtnW, BtnW)];
        //        CGRect frame=_myText.frame;
        //
        //
        //        NSLog(@"%@",NSStringFromCGRect(frame));
        //
        NSString *normalImage=[NSString stringWithFormat:@"chat_bottom_%d",i+1];
        
        [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        
        NSString *selImage=[NSString stringWithFormat:@"chat_bottom_sel%d",i+1];
        
        [btn setImage:[UIImage imageNamed:selImage] forState:UIControlStateHighlighted];
        //        btn.backgroundColor=[UIColor redColor];
        
        [backGroundImage addSubview:btn];
        
        
    }

}

/**
 *  当键盘的frame改变了(位置和尺寸)的时候调用
 *
 *  @param notification 通知包含的信息
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification{

    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    NSDictionary *userInfo = notification.userInfo;

    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 3,计算控制器的view需要平移的距离
    CGFloat moveY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 4,执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}
/**
 *  在dealloc方法中反注册，移除对通知的监听
 */
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden{
//
//    return YES;
//}

- (NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
    
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            // 消息模型
            JLMessage *message = [JLMessage messageWithDict:dict];
            
            // 取出上一个模型
            JLMessageFrame *previousMessageFrame = [tempArray lastObject];
            JLMessage *previousMessage = previousMessageFrame.message;
            
            // 判断两个message的发送时间是否一致
            message.hideTime = [message.time isEqualToString:previousMessage.time];
            
            // frame模型
            JLMessageFrame *messageFrame = [[JLMessageFrame alloc] init];
            messageFrame.message = message;
            
            // 添加模型到数组
            [tempArray addObject:messageFrame];
        }
        _messageFrames = tempArray;
    }
    
    return _messageFrames;

}
/**
 *  发送一条消息
 */
- (void)sendMessage:(NSString *)text type:(JLMessageType)type{
    // 1,数据模型
    JLMessage *msg = [[JLMessage alloc] init];
    // 设置信息类型，是自己发送给别人
    msg.type = type;
    // 设置信息内容
    msg.text = text;
    // 设置信息发送时间
    NSDate *msgTime = [NSDate date];
    // 对当前时间进行格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    msg.time = [formatter stringFromDate:msgTime];
    // 是否需要隐藏时间
    JLMessageFrame *previousFrame = [self.messageFrames lastObject];
    JLMessage *previousMsg = previousFrame.message;
    msg.hideTime = [msg.time isEqualToString:previousMsg.time];
    
    // 2,frame模型
    JLMessageFrame *msgFrame = [[JLMessageFrame alloc] init];
    msgFrame.message = msg;
    [self.messageFrames addObject:msgFrame];
    
    // 3,刷新表格
    [self.tableView reloadData];
    
    // 4,自动滚动到表格的最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark -UITextField的代理方法
/**
 *  点击了手机键盘的最右下角的按钮
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // 1,发送一条消息
    [self sendMessage:_myText.text type:JLMessageTypeMeToOther];
    
    // 2,UITextField的文字
   _myText.text = nil;
    
    // 返回YES即可，不要问为什么
    return YES;
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//
//    return YES;
//}
//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//
//
//    return YES;
//}


#pragma mark -数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.messageFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建cell
    JLMessageCell *cell = [JLMessageCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.messageFrame = self.messageFrames[indexPath.row];
    
    // 返回cell
    return cell;
}

#pragma mark -代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    
    return messageFrame.cellHeight;
}
/**
 *  当开始拖拽表格的时候就退出键盘
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    // 退出键盘
    [self.view endEditing:YES];
}

@end
