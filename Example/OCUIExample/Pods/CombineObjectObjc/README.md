---
typora-root-url: ./images
typora-copy-images-to: ./images
---

# CombineObject-Objc
`CombineObject` 响应式框架 `Objective-C` 版本, `Value` 和 `View` 相互绑定。

![image-20190806101237397](/image-20190806101237397.png)

## 安装

### CocoaPods

```ruby
pod 'CombineObjectObjc'
```

### Carthage

```ruby
github "combineobject/CombineObject-Objc"
```

## 怎么使用

### Example1

> 假如我们界面一个`UIView`和`UILabel`，我们想让`UIView`的背景颜色和`UILabel`的文本颜色一直保持统一。做法很多种，我们看看这个库可以做什么。

- 声明一个变量做控制

  ```objc
  /// 声明绑定属性
  @property (nonatomic, strong) UIColor *displayViewBackgroundColor;
  /// 初始化
  self.displayViewBackgroundColor = [UIColor grayColor];
  ```

- 绑定到试图

  ```objc
  /// 绑定到试图默认的 BackgroundColor 属性
  self.displayView.viewBind(self.displayViewBackgroundColor.bind,@"");
  /// 绑定UILabel 的文本颜色
  self.displayColorText.viewBind(self.displayViewBackgroundColor.bind,UILabelIdentifier.textColor);
  ```

- 更新属性更新试图

  ```objc
  /// 更改属性的值
  self.displayViewBackgroundColor.wrappedValue = [UIColor redColor];
  ```

- 直接更新一个试图的值

``` objc
/// 更改试图的值
self.displayView.updateWrappedValue([UIColor blueColor],@"");
```

![2019-08-06 10-22-35.2019-08-06 10_24_52](/2019-08-06 10-22-35.2019-08-06 10_24_52.gif)

### Example2

> 比如我们的属性没有我们试图绑定属性 我们想接受到属性变化时候更改值

```objc
__weak typeof(self) weakSelf = self;
self.displayViewBackgroundColor.bind.contentChanged = ^(id<CombineValue>  _Nonnull content) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
    strongSelf.displayLabel.layer.borderWidth = 1;
    strongSelf.displayLabel.layer.borderColor = [(UIColor *)content CGColor];
};
```

![2019-08-06 10-39-10.2019-08-06 10_39_44](/2019-08-06 10-39-10.2019-08-06 10_39_44.gif)

### Example3

> 属性控制`UIProgressView`属性

![2019-08-06 11-18-14.2019-08-06 11_18_55](/2019-08-06 11-18-14.2019-08-06 11_18_55.gif)

### Example4

> 监听输入框的内容

![2019-08-06 11-34-01.2019-08-06 11_34_27](/2019-08-06 11-34-01.2019-08-06 11_34_27.gif)

### Example5

> 监听`UISlider`值

![2019-08-06 11-45-34.2019-08-06 11_45_56](/2019-08-06 11-45-34.2019-08-06 11_45_56-5063215.gif)

### Example6

> 监听`UISwitch`的状态

![2019-08-06 11-55-15.2019-08-06 11_55_32](/2019-08-06 11-55-15.2019-08-06 11_55_32.gif)

### Example6

> 监听`UItextView`值变化

![2019-08-06 12-07-29.2019-08-06 12_07_49](/2019-08-06 12-07-29.2019-08-06 12_07_49.gif)

## 接口文档

### 目前支持的属性

#### UIView

- backgroundColor
- userInteractionEnabled
- frame
- alpha
- hidden

#### UILabel

- text
- font
- textColor
- attributedText

#### UISwitch

- on

#### UITextField

- text
- placeholder

#### UISlider

- value

#### UIProgressView

- progress

#### UITextView

- text

### 扩展`UIView`的赋值支持属性方法

```objc
- (void)setOtherCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier 
```

### 让其他的对象支持属性绑定

> 实现`CombineView`协议

```objc
- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier
```

### 自定义赋值

> 实现属性`bine`值的代理方法``

```objc
self.color.bine.customSetWrappedValueBlock = ^(CombineBindBlockContent *content) {
}
```

