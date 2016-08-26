//
//  UpdatePersonaInfo.m
//  MKBanTang
//
//  Created by mike on 16/8/19.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "UpdatePersonaInfo.h"
#import "NSString+File.h"
#import "XYBSavingTool.h"
@interface UpdatePersonaInfo ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UITextField *nameField;
@property(nonatomic,strong)UITextField *descView;
@property (nonatomic, strong)UIScrollView *sv;
@property (nonatomic, strong)NSMutableArray *selectedImageViews;
@end

@implementation UpdatePersonaInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HWColor(240, 240, 240);
    
    self.navigationItem.title = @"修改个人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    
    [_nameField becomeFirstResponder];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(self.view.width /2 -50, self.view.height *0.13, 80, 80);
    [iconView.layer setCornerRadius:(iconView.frame.size.height/2)];
    [iconView.layer setMasksToBounds:YES];
    [iconView setContentMode:UIViewContentModeScaleAspectFill];
    [iconView setClipsToBounds:YES];
    iconView.layer.shadowColor = [UIColor blackColor].CGColor;
    iconView.layer.shadowOffset = CGSizeMake(4, 4);
    iconView.layer.shadowOpacity = 0.5;
    iconView.layer.shadowRadius = 2.0;
    iconView.layer.borderColor = [[UIColor whiteColor] CGColor];
    iconView.layer.borderWidth = 2.0f;
    iconView.userInteractionEnabled = YES;
    iconView.image = [UIImage imageNamed:@"icon"];
    UITapGestureRecognizer *iconViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewDidTap)];
    [iconView addGestureRecognizer:iconViewTap];
    self.iconView = iconView;
    [self.view addSubview:iconView];

    _nameField = [[UITextField alloc]init];
    [self.view addSubview:_nameField];
    _nameField.font = [UIFont systemFontOfSize:14];
    UILabel *descLabel = [[UILabel alloc]init];
    _nameField.backgroundColor = [UIColor whiteColor];
    [_nameField setBackground:[UIImage imageNamed:@"tab_bar_bg_15x50_"]];

    _nameField.text = self.name;
    descLabel.width = 60;
    descLabel.height = 30;
    descLabel.text = [NSString stringWithFormat:@"昵称:"];
    descLabel.font = _nameField.font;
    descLabel.textColor = HWColor(100, 100, 100);
    _nameField.leftView=descLabel;
    descLabel.textAlignment = NSTextAlignmentCenter;
    _nameField.leftViewMode = UITextFieldViewModeAlways;
    _descView.backgroundColor = [UIColor whiteColor];
    
    
    _descView = [[UITextField alloc]init];
    [self.view addSubview:_descView];
    _descView.backgroundColor = [UIColor whiteColor];
    _descView.text = self.desc;
     [_descView setBackground:[UIImage imageNamed:@"tab_bar_bg_15x50_"]];
//    _descView.backgroundColor = HWRandomColor;
    _descView.font = [UIFont systemFontOfSize:14];
    UILabel *descInfoLabel = [[UILabel alloc]init];
    _descView.leftViewMode = UITextFieldViewModeAlways;
    descInfoLabel.width = 90;
    descInfoLabel.height = 30;
    descInfoLabel.text = [NSString stringWithFormat: @"个性签名:"];
    descInfoLabel.font = _nameField.font;
    descInfoLabel.textAlignment = NSTextAlignmentCenter;
    descInfoLabel.textColor = HWColor(100, 100, 100);
    _descView.leftView = descInfoLabel;
    
    _nameField.sd_layout.topSpaceToView(self.view,220).leftSpaceToView(self.view,8).rightSpaceToView(self.view,8).heightIs(40);
    
    _descView.sd_layout.topSpaceToView(_nameField,8).leftSpaceToView(self.view,8).rightSpaceToView(self.view,8).heightIs(40);
    
    
    
}

-(void)saveInfo{
//
//    [XYBSavingTool setStr:_nameField.text key:@"infoName"];
//    [XYBSavingTool setStr:_descView.text key:@"infoDesc"];
//    
////    NSLog(@"%@",[NSString documentFolder]);
//    if ([self.delegate respondsToSelector:@selector(UpdatePersonaInfoDidUpdate:Name:Desc:)]) {
////        [self.delegate UpdatePersonaInfoDidUpdate:nil Name:_nameField.text Desc:_descView.text];
//
//        [self.delegate UpdatePersonaInfoDidUpdate:self Name:_nameField.text Desc:_descView.text];
//    }
//    
// 
//    
//    [self.navigationController popViewControllerAnimated:YES];
}
//
- (void)iconViewDidTap
{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *pickImg = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *pickImg2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImage];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertSheet addAction:pickImg];
    [alertSheet addAction:pickImg2];
    [alertSheet addAction:cancle];
    
    [self presentViewController:alertSheet animated:YES completion:nil];
    
}
-(void)pickImage{

    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
     pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    NSData *imageDate = UIImageJPEGRepresentation(image, 0);
    
    NSString *path = [NSString stringWithFormat:@"%@/userInfo.data",[NSString cachesFolder]];
    
    [imageDate writeToFile:path atomically:YES];
    
    self.iconView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];


}



@end
