//
//  ViewController.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "ViewController.h"
#import "OCUI.h"
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <Masonry/Masonry.h>
#import "DetailViewController.h"
#import "OCUIExample.h"
#import "PageRowView.h"
#import "DetailViewController.h"

@interface ViewController ()


@end

@implementation ViewController {
    NSString *_title;
    DetailViewController *_destinationViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeRenderView:self.view];
}

//- (void)bodyUI:(OCUICreate *)c {
//    c.NavigationView(OCUICreateElenment{
//        c.List(OCUICreateElenment{
//            Section(OCUICreateElenment{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"WebView",@"用于展示一个打开的网页");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"UIViewController",@"打开 UIViewController");
//                });
//            })
//            .header(^{
//                Text(@"特殊视图");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Text",@"显示一行或多行只读文本");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"TextField",@"显示可编辑文本界面的输入控件");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"SecureField",@"安全输入私密文本的输入控件");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Image",@"用以展示本地图片");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"WebImage",@"下载网络图片并展示");
//                });
//            })
//            .header(^{
//                Text(@"基础控件");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Button",@"触发时执行操作的按钮");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"NavigationButton",@"按下时触发导航跳转的按钮");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"PresentationButton",@"触发时显示内容的按钮控件");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"EditButton",@"用于切换当前编辑模式的按钮");
//                });
//            })
//            .header(^{
//                Text(@"按钮");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Picker",@"可自定义数据源的 Picker 选择器");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"DatePicker",@"日期展示与选择");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Toggle",@"开关状态切换");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Slider",@"用以设置指定范围内的值");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Stepper",@"用以增加或减少数值");
//                });
//            })
//            .header(^{
//                Text(@"选择器");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"HStack",@"将子视图排列在水平线上的视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"VStack",@"将子视图排列在垂直线上的视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"ZStack",@"覆盖子视图，在两轴上对齐");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"List",@"列表容器，用以显示一列数据");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"ScrollView",@"滚动视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"ForEach",@"用于根据已有数据的集合展示视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Group",@"用于集合多个视图，对 Group 设置的属性，将作用于每个子视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Section",@"用于创建带头/尾部的视图内容，一般结合 `List` 组件使用");
//                });
//            })
//            .header(^{
//                Text(@"布局");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"NavigationView",@"用于创建包含顶部导航栏的视图容器");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"TabBar",@"用于创建包含底部 TabBar 的视图容器");
//                });
//            })
//            .header(^{
//                Text(@"导航视图");
//            });
//            Section(^{
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Alert",@"展示一个弹框提醒");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"ActionSheet",@"弹出一个选择框");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Modal",@"Modal 弹出一个视图");
//                });
//                NavigationLink(UIViewController.self, ^{
//                    PageRow(@"Popover",@"Pop 弹出一个视图");
//                });
//            })
//            .header(^{
//                Text(@"Alert 弹框视图");
//            });
//        })
//        .listStyle(GroupedListStyle())
//        .navigationBarTitle(Text(@"Example"),OCUITitleDisplayModeLarge)
//        .navigationBarItems(nil,^{
//            Button(^{
//                NSLog(@"Tap");
//            }, ^{
//                Text(@"Right")
//                .foregroundColor(OCUIColor.orange);
//            });
//        });
//    });
//}

@end
