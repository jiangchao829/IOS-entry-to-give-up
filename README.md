
^-^ ^=^    学习总结 详情wiki    ^-^ ^=^

Router（降级 解析 复制参数）
 hybird （原声和H5交互）
 RX（响应式）
 组件化（模块拆分 保证输入输出。单侧）
网络
强制升级
模型转换 （隔离。有待商榷）
多了莫名其妙的url，app的某些请求被重定向了，原因可能是DNS被劫持了，我们正在接入HTTPDNS来解决这个问题。
bugly作用
* 异常 App在运行过程中发生的崩溃、卡顿、ANR、错误，统称为异常。 
* 崩溃 用户在使用App过程中发生一次闪退，计为一次崩溃。 
* 卡顿 用户在使用App过程中发生卡顿现象，计为一次卡顿，卡顿时间默认是5s，也支持自定义时间。 
* ANR 用户在使用App过程中出现弹框，提示应用无响应，计为一次ANR，ANR仅用于Android平台应用。 
* 错误 主动上报的Exception、Error，或脚本(如C#、Lua、JS等)错误，统称为错误。 
Model隔离 方法1两个model 2框架自带的转换功能 这样后台更改字段影响也不是很大
手指触摸屏幕：首先IOKit接受事件 通过mach port传递到app 激活runloop 出发souce1事件（souce1是苹果注册触发系统事件的）souce1内部调用了souce0 souce0内部将IOHIDEvent事件转化为UIevent 传递给uiwindow hittest 逆向递归便利 找到了就执行 找不到响应者链条传递一知道UIAppliacation 被忽略 runloop进入休眠

mach port 进程端口，各进程之间通过它进行通信。
SpringBoad.app 是一个系统进程，可以理解为桌面系统，可以统一管理和分发系统接收到的触摸事件
手势识别器比UIResponder具有更高的事件响应优先级


==操作符只是比较了两个指针所指对象的地址是否相同，而不是指针所指的对象的值
所以最后一个为0


************************** https://gmtc.geekbang.org *******************

刷题 leetcode
苹果是如何让iOS12加速的
（1）改进预加载功能)
CPU响应机制升级
怠速模式-加快频率(智能化加快，智能化降到合适的怠速水平）
Auto-layout（自动布局）功能升级
自动备份存储技术


重复资源（主要指图片）不是指命名重复而是内容相同。
fdupes 是Linux下的一个工具，可以在指定的目录及子目录中查找重复的文件。fdupes通过对比文件的MD5签名，以及逐字节比较文件来识别重复内容
C++有命名空间 pod里的不同工程 存在相同的方法。可以编译通过 但是运行gg
.GCDTimer与NStimer对比
①NSTimer 需要一个运行的Runloop 来处理其定时任务, MainThread是一直启动并运行的,所以在自定的线程如果使用NSTIme必须手动开启并运行子线程的Runloop
②NSTimer 必须调用 invalidate 来停止其定时任务,并且NSTimer 对其Target是强引用,要注意Target 与 - NSTimer间造成的循环引用造成的内存泄漏(可以封装成一个类方法来解决此问题)
③NSTimer 的创建和 invalidate必须放在相同的线程中进行
④GCDTimer 是基于GCD实现的,使用的时候只要我们把任务提交给相应队列就好
⑤GCDTimer 在使用时要注意 dispatch_resume（obj） dispatch_suspend(obj) -dispatch_source_cancel(obj）API 的使用
⑥GCDTimer 在对文件资源定期进行读写操作时很方便,其他与NSTimer使用场景差不多
在 图形渲染原理 中提到纹理本质上就是一张图片，因此 CALayer 也包含一个 contents 属性指向一块缓存区，称为 backing store，可以存放位图（Bitmap）
今年上半年时候看到微信开发团队的这么一篇文章MMKV--基于 mmap 的 iOS 高性能通用 key-value 组件，文中提到了用mmap实现一个高性能KV组件
是这两段代码却在特定的场景下发生crash，发生异常的原因在于子类在没有重写方法的情况下，子类先于父类进行了swizzle的操作。iOS使用中方法名称SEL和方法实现IMP是分开存放的，使用结构体Method将两者关联到一起
交换方法会将两个method中的imp进行交换。而在理想情况下，父类先于子类完成了swizzle，原有方法保存了swizzle之后的imp，这时候子类再进行swizzle就能正确调用。下图标识了SEL和IMP的关联，箭头表示IMP的调用次序
Swift 里的 defer 大家应该都很熟悉了，defer 所声明的 block 会在当前代码执行退出后被调用。正因为它提供了一种延时调用的方式，所以一般会被用来做资源释放或者销毁，这在某个函数有多个返回出口的时候特别有用。比如下面的通过 FileHandle 打开文件进行操作的方法：

JORDAN SMITH大神给出了一种很巧解决方案.UIApplication有一个next属性,它会在applicationDidFinishLaunching之前被调用,这个时候通过runtime获取到所有类的列表,然后向所有遵循SelfAware协议的类发送消息
通过Protocol或者URL获取对应的Module：
- (id)interfaceForProtocol:(Protocol *)protocol {
    Class class = [self classForProtocol:protocol];
    return [[class alloc]init];
}

- (id)interfaceForURL:(NSURL *)url {
    id result = [self interfaceForProtocol:objc_getProtocol(url.scheme.UTF8String)];
    NSURLComponents *cp = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    [cp.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result setValue:obj.value forKey:obj.name];//KVC设置
    }];
    return result;
}

OS开发中较常见的两类锁:
1. 互斥锁: 同一时刻只能有一个线程获得互斥锁,其余线程处于挂起状态.
2. 自旋锁: 当某个线程获得自旋锁后,别的线程会一直做循环,尝试加锁,当超过了限定的次数仍然没有成功获得锁时,线程也会被挂起.
自旋锁较适用于锁的持有者保存时间较短的情况下,实际使用中互斥锁会用的多一些.
四种锁分别是:
NSLock、NSConditionLock、NSRecursiveLock、NSCondition
因此，在将磁盘中的图片渲染到屏幕之前，必须先要得到图片的原始像素数据，才能执行后续的绘制操作，这就是为什么需要对图片解压缩的原因。
事实上，解压缩后的图片大小与原始文件大小之间没有任何关系，而只与图片的像素有关
* 使用 CGBitmapContextCreate 函数创建一个位图上下文；
* 使用 CGContextDrawImage 函数将原始位图绘制到上下文中；
* 使用 CGBitmapContextCreateImage 函数创建一张新的解压缩后的位图
也就是说，一个UIControl子类(UIButton/UISwitch)方法，其响应事件的方式不同于普通的UIView，它们的事件处理由UIApplication单例直接控制！尽管文档中提到其事件处理部分仍可能使用UIResponder响应链逻辑，但其事件分发与普通的UIView完全不同



、手势响应是大哥，点击事件响应链是小弟。单击手势优先于UIView的事件响应。大部分冲突，都是因为优先级没有搞清楚。
就是按钮的点击 和添加一个手势。会走手势。不走按钮本身的点击

Fishhook是facebook出品的，可以用来Hook C函数的一个开源库。它的主要接口就一个： （hook 胡可）
这是常见的 UIView 和 CALayer 的关系：View 持有 Layer 用于显示，View 中大部分显示属性实际是从 Layer 映射而来；Layer 的 delegate 在这里是 View，当其属性改变、动画产生时，View 能够得到通知。UIView 和 CALayer 不是线程安全的，并且只能在主线程创建、访问和销毁

FBRetainCycleDetector 在对象中查找强引用取决于类的 Ivar Layout，它为我们提供了与属性引用强弱有关的信息，帮助筛选强引用
FBRetainCycleDetector 在对关联对象进行追踪时，修改了底层处理关联对象的两个 C 函数，objc_setAssociatedObject 和 objc_removeAssociatedObjects，在这里不会分析它是如何修改底层 C 语言函数实现的，如果想要了解相关的内容，可以阅读下面的文章
关于如何动态修改 C 语言函数实现可以看动态修改 C 语言函数的实现这篇文章，使用的第三方框架是 fishhook。

1. 在对象类的 dispatch table 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；
2. 如果没有找到，Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve 这个消息；
3. 如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；
4. 如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。

当需要回滚时，说明已经发生了启动crash，此时根据日志内容，也有不同的处理方式：
* 日志文件是空文件 这种情况是最危险的情况，如果日志文件为空，说明文件已经建立，但是还没有产生任何方法调用。很有可能在fishhook的处理过程中存在crash，此时应该直接关闭监控方案，即便不是它的原因，并且快速增发版本
* 日志文件不为空 如果日志文件不为空，说明成功的监控到了crash，此时应该同步上传日志文件，快速反馈到业务方及时止损。首先止损手段都应该采用同步的方式，保证应用能够继续运行，根据情况不同，止损的回滚方式包括以下：
1. 如果crash发生在并不干扰正常业务执行的功能组件中，可以通过A/B线上开关关闭对应的功能，前提是功能组件使用开关控制
2. 崩溃处代码已经干扰正常业务执行，但是错误代码短，可以尝试通过服务器下发patch包动态修复错误代码，但是patch包要提防引入其他问题
3. 在A/B Test和patch包都无法解决问题的情况下，假如项目采用了合理的组件化设计，通过路由转发来使用h5完成应用的正常运行
4. 缺少动态修复的手段且crash不干扰正常业务执行，考虑停止一切插件、辅助组件运行
5. 缺少动态修复的手段，包括1, 2, 3的方案。可考虑通过第三方越狱市场提供逆向包，提示用户下载安装
6. 缺少动态修复的手段，包括1, 2, 3的方案。增发版本快速止损，使用Test Flight分批次快速让用户恢复使用

santa0000
2018-12-25 19:05:17
理论上可变参数的函数可以使用x0~x18存参数，所以都要保存
同时，当参数是浮点型时，还会使用到你的浮点寄存器d0~d31，所以也要保存起来

如图，首页的ViewController就是AWEFeedTableViewController。
carrier_region	CN
key	value
mcc_mnc	46001
方案一：通过Hook第三方网络库AFNetWorking或内部封装的NetService类来修改carrier_region字段
iOS系统的CoreTelephony.framework的CTCarrier类提供了carrier_region、mnc和mcc的获取。通过Hook他们来实现土突破地区限制。

https://juejin.im/post/5c19a38ae51d453e0a209256?utm_source=gold_browser_extension



1. 通过请求下载大图
2. 使用工具压缩图片
3. 查找删除重复图片
4. 查找复用相似图片
通常来说，出现重复图片的原因包括模块间需求开发没有打通或是缺少统一的图片命名规范。通过图片MD5摘要是识别重复图片的最快方法


一、CALayer如何添加点击事件
两种方法: convertPoint和hitTest:，hitTest: 返回的顺序严格按照图层树的图层顺
堆空间的存在主要是为了延长对象的生命周期，并使得对象的生命周期可控

二、为什么会存在堆空间
如果试图用栈空间取代堆空间，显然是不可行的。栈是向低地址扩展的数据结构，是一块连续的内存的区域。这句话的意思是栈顶的地址和栈的最大容量是系统预先规定好的，如果申请的空间超过栈的剩余空间时，将出现栈溢出，发生未知错误。因此，能从栈获得的空间较小。而堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。 但是栈空间比堆空间响应速度更快，所以一般类似int、NSInteger等占用内存比较小的通常放在栈空间，对象一般放在堆空间。
如果试图用数据区（全局区）取代堆空间，显然也是不可行的。因为全局区的生命周期会伴随整个应用而存在，比较消耗内存，生命周期不像在堆空间那样可控，堆空间中可以随时创建和销毁。
代码区就不用想了，如果能够轻易改变代码区，一个应用就无任何安全性可言了

五、缓存 NSDateFormatter
、performSelector:afterDelay:的坑

上述代码的执行结果并非 1 2 3 ，而是 1 3。原因是performSelector: withObject: afterDelay:的本质是往 RunLoop中添加定时器，而子线程默认是没有启动RunLoop。performSelector: withObject: afterDelay:接口虽然和performSelector:系列接口长得很类似。但前者存在于RunLoop相关文件，后者存在于NSObject相关文件。


struct __AtAutoreleasePool {
    __AtAutoreleasePool() { // 构造函数，在创建结构体的时候调用
        atautoreleasepoolobj = objc_autoreleasePoolPush();
    }
    ~__AtAutoreleasePool() { // 析构函数，在结构体销毁的时候调用
        objc_autoreleasePoolPop(atautoreleasepoolobj);
    }
    void * atautoreleasepoolobj;
 };

十一、如何对 NSMutableArray 进行 KVO
NSMutableArray的 KVO，官方为我们提供了如下方法:
//添加元素操作
[[self mutableArrayValueForKey:@"arr"] addObject:item];
//移除元素操作
[[self mutableArrayValueForKey:@"arr"] removeObjectAtIndex:0]


被忽略的UIViewController两对API
@property(nonatomic,Â readonly,Â getter=isBeingPresented)Â BOOLbeingPresentedÂ 
;@property(nonatomic,Â readonly,Â getter=isBeingDismissed)Â BOOLbeingDismissedÂ
十三、抗压缩优先级
如果想让左边 label 自适应，右边 label 拉升，可以设置控件拉升阻力(即抗拉升)，拉升阻力越大越不容易被拉升。所以只要 label1 的拉升阻力比 label2 的大就能达到效果。
//UILayoutPriorityRequired = 1000 
    [label1 setContentHuggingPriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
//    //UILayoutPriorityDefaultLow = 250
    [label2 setContentHuggingPriority:UILayoutPriorityDefaultLow
                              forAxis:UILayoutConstraintAxisHorizontal];


Content Hugging Priority：拉伸阻力，即抗拉伸。值越大，越不容易被拉伸。
Content Compression Resistance Priority：压缩阻力，即抗压缩。值越大，越不容易被压缩

十五、设置代码只在 Debug 下起效
pod 'RongCloudIM/IMKit', '~> 2.8.3',:configurations => ['Debug']
十六、为什么会有深拷贝和浅拷贝之分
￼
上图中观察可知只有不可变 + 不可变组合的时候才出现浅拷贝，其他三种情况都是深拷贝。原因在于，两个不可变对象内容一旦确定都是不可变的，所以不会彼此干扰，为了节省内容空间，两个对象可以指向同一块内存。而其他三种情况，都有可变对象的存在，为了避免两个对象之间的彼此干扰，所有会开辟额外的空间


十八、为什么数组下标从零开始
数组下标最确切的定义应该偏移（offset），如果用 a 来表示数组的首地址，a[0] 就是偏移为 0 的位置，也就是首地址，a[k] 就表示偏移 k 个 type_size 的位置，所以计算 a[k] 的内存地址只需要用这个公式：a[k]_address = base_address + k * type_size
但是，如果数组从 1 开始计数，那我们计算数组元素 a[k]的内存地址就会变为：a[k]_address = base_address + (k-1)*type_size
对比两个公式，不难发现，从 1 开始编号，每次随机访问数组元素都多了一次减法运算，对于 CPU 来说，就是多了一次减法指令。数组作为非常基础的数据结构，通过下标随机访问数组元素又是其非常基础的编程操作，效率的优化就要尽可能做到极致。所以为了减少一次减法操作，数组选择了从 0 开始编号，而不是从 1 开始

二十、为什么量子密码学会有取代传统加密方法的趋势
关于互质关系
如果两个正整数，除了1以外，没有其他公因数，我们就称这两个数是互质关系（coprime）。
量子密码学是基于量子形态做加解密，如果想破解必须要介入到量子状态中，但是量子传输过程中可监听到监听者的介入。目前量子密码仍处于研究阶段，并没有成熟的应用，量子很容易收到外界的干扰而改变状态
二十一、引用计数是怎么管理的
在arm64架构之前，isa 就是一个普通的指针，存储着Class、Meta-Class对象的内存地址。从arm64架构开始，对isa进行了优化，变成了一个共用体（union）结构，还使用位域来存储更多的信息。 isa 的结构如下:
￼
weak 原理说明
一个对象可能会被多次弱引用，当这个对象被销毁时，我们需要找到这个对象的所有弱引用，所以我们需要将这些弱引用的地址（即指针）放在一个容器里(比如数组)。当对象不再被强引用时需要销毁的时候，可以在SideTable中 通过这个对象的地址找到引用值，清空引用值。同时， SideTable结构中还有weak_table_t结构，该结构也是一个散列表，key 为对象地址，value 为一个数组，里面保存着指向该对象的所有弱指针。当对象释放的时候，先清空引用哈希表RefcountMap对应的引用值，遍历弱指针数组，依次将各个弱指针置为 nil。

二十五、什么是User Agent

User Agent中文名为用户代理，简称 UA，它是一个特殊字符串头，使得服务器能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件等。网站在手机端 app 打开和直接在浏览器中打开看到的内容可能不一样，是因为网页可以根据 UA 判断是 app 打开的还是浏览器打开的。

二十七、UIScrollView 原理
UIScrollView继承自UIView，内部有一个 UIPanGestureRecongnizer手势。 frame 是相对父视图坐标系来决定自己的位置和大小，而bounds是相对于自身坐标系的位置和尺寸的。改视图 bounds 的 origin  视图本身没有发生变化，但是它的子视图的位置却发生了变化，因为 bounds 的 origin 值是基于自身的坐标系，当自身坐标系的位置被改变了，里面的子视图肯定得变化， bounds 和 panGestureRecognize 是实现 UIScrollView 滑动效果的关键技术点


二十八、--verbose 和 --no-repo-update


verbose意思为 冗长的、啰嗦的，一般在程序中表示详细信息。此参数可以显示命令执行过程中都发生了什么。

pod install或pod update可能会卡在Analyzing dependencies步骤，因为这两个命令会升级 CocoaPods 的 spec 仓库，追加该参数可以省略此步骤，命令执行速度会提升


二十九、dataSource 和 delegate 的本质区别  （输入 输出）
普遍开发者得理解是：一个是数据，一个是操作。如果从数据传递方向的角度来看，两者的本质是数据传递的方向不同。dataSource 是外部将数据传递到视图内，而 delegate 是将视图内的数据和操作等传递到外部。实际开发封装自定义视图，可以参照数据传递方向分别设置 dataSource 和 delegate

三十、变种 MVC
真正的 MVC 应该是苹果提供的经典UITableView的使用，实际开发中经常在 Cell 中引入Model，本质上来说不算是真正的 MVC ，只能算是 MVC 的变种


三十一、函数指针和 Block
相同点:

二者都可以看成是一个代码片段。
函数指针类型和 Block 类型都可以作为变量和函数参数的类型（typedef定义别名之后，这个别名就是一个类型）。

不同点：

函数指针只能指向预先定义好的函数代码块，函数地址是在编译链接时就已经确定好的。从内存的角度看，函数指针只不过是指向代码区的一段可执行代码，而 block 本质是 OC对象，是 NSObject的子类，是程序运行过程中在栈内存动态创建的对象，可以向其发送copy消息将block对象拷贝到堆内存，以延长其生命周期。

补充:指针函数和函数指针的区别
指针函数是指带指针的函数，即本质是一个函数，函数返回类型是某一类型的指针。它是一个函数，只不过这个函数的返回值是一个地址值。




三十二、内存(堆内存)回收是什么意思
NSObject *obj = [[NSObject alloc] init];

代码对应的内存布局如下，obj 指针存在于栈取，obj 对象存在于堆区。obj 指针的回收由栈区自动管理，堆区的内存需要开发者自己管理(MRC)情况。所谓的堆内存回收并不是指将 obj 对象占有的内存给挖去或是将空间数据清空为0，而是指 obj 对象原本占有的空间可以被其他人利用(即其他指针可以指向该空间)。其他指针指向该空间时，重新初始化该空间，将空间原有数据清零。

三十三、IP 和 MAC
IP 是地址，有定位功能；MAC 是身份唯一标识，无定位功能；有了 MAC 地址为什么还要有 IP 地址？举个例子，现在我要和你通信（写信给你），地址用你的身份证号，信能送到你手上吗？ 明显不能！身份证号前六位能定位你出生的县，MAC 地址前几位也可以定位生产厂家。但是你出生后会离开这个县(IP 地址变动)，哪怕你还在这个县，我总不能满大街喊着你的身份证号去问路边人是否认识这个身份证号的主人，所以此刻需要借助 IP 的定位功能

1.1 对称（AES）和非对称（RSA）


三十六、什么是线程不安全？线程不安全的本质原因？
不能确定代码的运行顺序和结果，是线程不安全的。线程安全是相对于多线程而言的，单线程不会存在线程安全问题。因为单线程代码的执行顺序是唯一确定的，进而可以确定代码的执行结果。
线程不安全的本质原因在于：表面展现在我们眼前的可能是一行代码，但转换成汇编代码后可能对应多行。当多个线程同时去访问代码资源时，代码的执行逻辑就会发生混乱。如数据的写操作，底层实现可能是先读取，再在原有数据的基础上改动。如果此时有一个读操作，原本意图是想在写操作完毕之后再读取数据，但不巧的这个读操作刚好发生在写操作执行的中间步骤中。虽然读操作后与写操作执行，但数据读取的值并不是写操作的结果值，运气不好时还可能发生崩溃。

三十七、App 启动流程
APP 启动分为冷启动和热启动，这里主要说下冷启动过程。冷启动分为三阶段: dyld 阶段、runtime阶段、main函数阶段，一般启动时间的优化也是从这三大步着手。

dyld阶段：dyld（dynamic link editor）是Apple的动态链接器，可以用来装载 Mach-O 文件（可执行文件、动态库等）。启动APP时，dyld 首先装载可执行文件，同时会递归加载所有依赖的动态库。
runtime 阶段：首先解析可执行文件，之后调用所有类和分类的+load方法，并进行各种objc结构的初始化（注册Objc类 、初始化类对象等等）。到此为止，可执行文件和动态库中所有的符号(Class、Protocol、Selector、IMP …)都已经按格式成功加载到内存中，被runtime 所管理。
main函数阶段：所有初始化工作结束后，dyld就会调用main函数
三十九、super 本质
super 调用底层会转换为objc_msgSendSuper函数的调用，objc_msgSendSuper 函数接收 2 个参数 objc_super 结构体和 SEL ，objc_super结构如下
四十四、自旋锁 & 互斥锁
线程安全中为了实现线程阻塞，一般有两种方案：一种是让线程处于休眠状态，此时不会消耗 CPU 资源；另一种方案是让线程忙等或空转，此时会消耗一定的 CPU 资源。前者属于互斥，后者属于自旋
多线程—线程的5种状态

线程从创建、运行到结束总是处于下面五个状态之一：新建状态、就绪状态、运行状态、阻塞状态及死亡状态。


“当一个系统的攻击成本远远高于攻击所带来的收益时，这个系统就相对安全了”


不要手贱写 “== YES” 和 “!= YES”
在 BOOL 为 bool 类型的时候，只有真假两个值，其实是可以写 “== YES” 和 “!= YES” 的。我们先举个例子：
BOOL a = 2;
if (a) {
    NSLog(@"a is YES");
} else {
    NSLog(@"a is NO");
}
if (a == YES) {
    NSLog(@"a == YES");
} else {
    NSLog(@"a != YES");
}
在 64-bit 设备我们将得到结果：
a is YES
a == YES
看上去没什么毛病，完美！
但是在 32-bit 设备我们将得到结果
这是为什么呢？因为在 32-bit 设备上 BOOL 是 signed char 类型的。ObjC 对数值类型做 (a) 这种真假判断时为 0 则假、非 0 则真，所以我们可以得到 a is YES 这种结果。但是对数值类型做 (a == YES) 这种判断时逻辑是什么样的，想必不用我说大家也猜到了，代码翻译出来就是类似这样的

static关键字会把一个变量的生命周期变成和程序的生命周期等同，这个感觉不用多介绍了，大家应该都懂的。
static变量对每个编译单元都是内部可见且分别独立的


extern关键字也是一个存储类型（storage class）。extern和static的不同点在于全程序共用一个变量而非每个编译单元有自己的独立变量，用了extern关键字之后变量将变得真正意义的全局可见。

关于HTTP 1.1和HTTP长连接
HTTP 1.0中，默认进行的都是短连接。一个HTTP请求会产生一个TCP连接，请求结束后就会关闭这个TCP连接。而自HTTP 1.1开始，默认进行的都是长连接。在一个HTTP请求结束之后，客户端和服务端之间的TCP连接并不会立即断开，而是按照约定的Keep-Alive时长维持一定时间的连接状态。这样在下一次HTTP请求发生时，如果TCP连接还存在就会复用之前的TCP连接，省去重新建立TCP连接的时间

SDWebImage里的问题
在SDWebImage中遇到此问题的现象：有些图片一旦请求失败一次就再也没法刷出来。
归根结底在于SDWebImage维护了一个failedURLs列表，请求失败的图片URL都会被加入到这个表中。下次请求的时候如果没有带上SDWebImageRetryFailed选项，SDWebImage就会自动忽略这些URL直接返回错误
