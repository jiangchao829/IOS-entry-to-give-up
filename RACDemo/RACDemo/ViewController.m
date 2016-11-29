//
//  RAC_01______Tests.m
//  RAC-01-联系人列表Tests
//
//  Created by 姜超 on 16/3/24.
//  Copyright © 2016年 jiangchao. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Person.h"

@interface ViewController ()
@property (nonatomic) UIButton *demoButton;
@end

@implementation ViewController {
    Person *_person;
}
//{
//    UIButton *_demoButton;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 准备数据
    _person = [[Person alloc] init];
    _person.name = @"zhangsan";
    _person.age = 18;
    
    
    //    组合信号
    //       [self demoButtonFunc];
    //       [self demoCombineField3];
    //     双向绑定！
    [self bindDemo];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

/// 使用 RAC 的原因：`响应式`编程！
/**
 b = 3;
 c = 4;
 a = b + c;      7
 
 b = 100;        a 的值不会发生改变
 
 `响应式`，当修改 b / c 的时候 a 同时发生变化！
 
 在 iOS 开发中，可以使用 KVO 监听对象的属性值，达到这一效果！
 因为 苹果的 KVO 会统一调用同一个方法，方法是固定的，如果监听属性过多，方法非常难以维护！
 
 RAC 是目前实现响应式编程的唯一解决方案！
 拦截了苹果自带的 kvo 通知 代理 addtarget
 
 * MVVM
 双向绑定！
 */
- (void)bindDemo {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 300, 40)];
    ageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:ageTextField];
    
    // 双向绑定
    // 1> 模型(KVO 数据) => UI(text 属性)
    // a) name(string) -> text(string)
    RAC(nameTextField, text) = RACObserve(_person, name);
    NSLog(@"%@", RACObserve(_person, name));
    // b) age(NSInteger) -> text(string) RAC 中传递的数据都是 id 类型
    /**
     - 如果使用 基本数据类型绑定 UI 的内容，需要使用 map 函数，通过 block 对 value 的数值进行转换之后
     - 才能够绑定
     
     
     可以被修改(map)，过滤(filter)，叠加(combine)，串联(chain)
     */
    RAC(ageTextField, text) = [RACObserve(_person, age) map:^id(id value) {
        //        NSLog(@"%@ %@", value, [value class]);
        
        // 错误的转换，value 本身已经是 NSNumber，需要字符串
        //        return [NSString stringWithFormat:@"%zd", value];
        return [value description];
    }];
    // 2> UI => 模型的绑定
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, ageTextField.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        
        _person.name = [x first];
        _person.age = [[x second] integerValue];
    }];
    
    // 3> 添加按钮，输出结果
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // ！！！循环引用
        NSLog(@"%@ %zd", _person.name, _person.age);
    }];
    
}

/// 组合文本框
/**
 RAC 在使用的时候，因为系统提供的`信号`是始终存在的！
 
 因此，所有的 block 中，如果出现 `self.`／`成员变量` 几乎百分百会循环引用！
 
 解除循环的方法
 1. __weak
 2. 利用 RAC 提供的 weak-strong dance
 在 block 的外部使用 @weakify(self)
 在 block 的内部使用 @strongify(self)
 */
- (void)demoCombineField3 {
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    // reduce -> 减少的意思，合并两个信号的数据，进行汇总计算时使用的！
    // id 是返回值
    // reduce 中，可以通过接收的参数进行计算，并且返回需要的数值！
    // 举个栗子：只有用户名和密码同时存在，才允许登录！
    //    __weak typeof(self)weakSelf = self;
    @weakify(self)
    [[RACSignal
      combineLatest:@[nameTextField.rac_textSignal, pwdTextField.rac_textSignal]
      reduce:^id (NSString *name, NSString *pwd) {
          
          NSLog(@"%@ %@", name, pwd);
          // 判断用户名和密码是否同时存在，需要转换成 NSNumber 类型，才能被当作 id 传递
          return @(name.length > 0 && pwd.length > 0);
      }] subscribeNext:^(id x) {
          NSLog(@"%@", x);
          
          //         weakSelf.demoButton.enabled = [x boolValue];
          @strongify(self)
          
          self.demoButton.enabled = [x boolValue];
      }];
}

- (void)demoCombineField2 {
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    // 组合信号 Tuple - 元组，可以包含多值，通过 1,2,3,4,5,last 获取
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextField.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        
        NSString *name = x.first;
        NSString *pwd = x.second;
        
        NSLog(@"%@ %@", name, pwd);
    }];
}

//单个信号
- (void)demoCombineField1 {
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    // 监听文本输入内容 - 参数就是输入的文本内容！
    [[nameTextField rac_textSignal] subscribeNext:^(id x) {
        
        NSLog(@"%@ %@", x, [x class]);
    }];
    [[pwdTextField rac_textSignal] subscribeNext:^(id x) {
        
        NSLog(@"%@ %@", x, [x class]);
    }];
}

#pragma mark - 常规 RAC 演练
- (void)demoTextField {
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    // 监听文本输入内容 - 参数就是输入的文本内容！
    [[nameTextField rac_textSignal] subscribeNext:^(id x) {
        
        NSLog(@"%@ %@", x, [x class]);
    }];
}

- (void)demoButtonFunc {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    // 监听按钮事件 - 不再需要新建一个方法
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    _demoButton = btn;
}

@end
