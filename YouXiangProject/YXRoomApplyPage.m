//
//  YXRoomApplyPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXRoomApplyPage.h"
#import "UIView+Border.h"
#import "YXHttpRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "YXUserDefaultsHelper.h"
#import "YXLoginPage.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface YXRoomApplyPage ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    __weak IBOutlet UITextField *_sayField;
    __weak IBOutlet UIImageView *_picImageView;
    __weak IBOutlet UIButton *_addButton;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UIButton *_yesButton;
    __weak IBOutlet UIButton *_NoButton;
    __weak IBOutlet UIButton *_pwButton;
    BOOL _isLoading;
    
    UIImage * _selectedImage;
}
@end

@implementation YXRoomApplyPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavgationTitle:@"申请房间"];
    
    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setTitle:@"申请" forState:UIControlStateNormal];
    itemBtn.frame = CGRectMake(0, 0,32, 16);
    itemBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [itemBtn addTarget:self action:@selector(applyItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    NSArray * itemArray = @[addItem];
    
    self.navigationItem.rightBarButtonItems = itemArray;
    
    //[_timeLabel setBorderColor:[UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1] width:1];
    
    [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)applyItemClicked
{
    [self addroom];
}

- (void)addButtonClicked
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }else {
        [self showAlertWithMessage:@"无法获取相册"];
    }

}

//调用相机和相册库资源
- (void)loadImagePickerWithSourceType:(UIImagePickerControllerSourceType)type
{
    //系统封装号的加载相机、相册库的资源类
    UIImagePickerController * picker  = [[UIImagePickerController alloc] init];
    
    //加载不同的资源
    picker.sourceType = type;
    //是否允许picker对图片资源进行优化
    picker.allowsEditing = YES;
    
    picker.delegate = self;
    
    //软件中习惯通过present，方式呈现相册库。
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//点击choose按钮的时候，触发此方法
//资源在info字典里面
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取资源的类型（图片or视频）
    NSString * mediaTpype = info[UIImagePickerControllerMediaType];
    
    //kUTTypeImage 代表图像资源
    if ([mediaTpype isEqualToString:(NSString*)kUTTypeImage]) {
        
        //手机拍出的照片大概2m左右，拿到程序中对图片进行频繁处理之前，需要对图片进行转换，否则很容易引起内存超范围，程序被操作系统杀掉
        UIImage * image = info[UIImagePickerControllerEditedImage];
        _selectedImage = image;
        UIImage * smallImage = [self resizeImageToSize:CGSizeMake(45, 45) sizeOfImage:image];
    
        [_picImageView setImage:smallImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel!");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];
}


-(UIImage*)resizeImageToSize:(CGSize)size
                 sizeOfImage:(UIImage*)image
{
    UIGraphicsBeginImageContext(size);
    //获取上下文内容
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0.0, size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    //重绘image
    CGContextDrawImage(ctx,CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    //根据指定的size大小得到新的image
    UIImage* scaled= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaled;
}


- (void)addroom
{
    if (_isLoading) {
        return;
    }
    
    if (_sayField.text.length == 0 || _selectedImage == nil) {
        [self showAlertWithMessage:@"请选择图片"];
        return;
    }
    
    if ([YXUserDefaultsHelper getSessionkey] == nil) {
        YXLoginPage * login = [[YXLoginPage alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    NSData *dataObj = UIImageJPEGRepresentation(_selectedImage, 1.0);
    
    NSDictionary * parm = @{@"name":_sayField.text,
                            @"sesskey": [YXUserDefaultsHelper getSessionkey]
                            };
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    HUD.labelText = @"正在上传数据，请稍等...";
    [HUD show:YES];
    
    _isLoading = YES;
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/html", nil];
    [manger POST:kCreateRoom parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
        [formData appendPartWithFileData:dataObj name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 1) {
            HUD.labelText = @"申请成功";
        }else {
            HUD.labelText = @"上传失败";
            
            YXLoginPage * login = [[YXLoginPage alloc] init];
            [self.navigationController pushViewController:login animated:YES];


        }
        
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [HUD removeFromSuperview];
            if (code == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    
         _isLoading = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         _isLoading = NO;
        [HUD removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_sayField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
