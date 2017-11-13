//: [Previous](@previous)


/*:
 # Description Of The Project
 
 1. Swiftgen: 将项目中的资源文件以枚举的方式生成一个文件
 
 2. Pods中的TimeSliver是作者的一个集成了很多Extension文件的一个库
 
 3. 使用extension将某些很复杂的方法单独列出来,将协议单独列出来(UITableViewDelegate),好处就是看起来很清晰.
 
 4. ObjectMapper: 一个将model object 和 JSON 互转的开源库.
 
 5. typealias: 别名的意思, 用来为已经存在的类型重新定义名字的.某些情况下可以使代码的可读性更好,可以为一个protocol定义别名,可以为一个结构体定义别名等等;
 
 6. 使用{}快速创建一个匿名闭包. 使用 in 将参数声明和函数体分开
 
    {(parameter: String) -> String in
        reture ""
    }
 
 7. guard和if let的功能一样,都是用来判断是否满足条件,使用guard的好处是代码更加简洁,不满足条件就执行else, 避免了if嵌套
 
    guard let a = a else {
        return "a为空值,不满足条件"
    }
    a ++
    return a
 
 8. 使用lazy关键字定义一个懒加载的属性的时候,如果采用第二种闭包的方式,不要忘记在闭包后加上小括号(),这样在调用的时候,闭包才会立即执行.
    
    第一种方法:
    lazy var view: UIView = UIView.init()
 
    第二种方法: {}实际上就是定义了一个匿名闭包, 调用一个闭包,是需要加上()的
    lazy var view: UIView = { 
        return UIVIew.init() 
    }()
 
 9. @objc
    Swift中的协议默认情况下都是必须实现的,否则编译器会报错,那如何让协议成为可选的呢?
    这里就是用了@objc这个字段,使用这个字段可以保留OC的一些特性,在可选协议的前面加上optional就变成了可选的.
    在实现协议方法时,前面也要加上 @objc 关键字.
 
    @objc protocol HKProtocol: class {
        @objc optional func protocolMethod(_ para: String)
    }
 
 10. if let我们称之为'解包(unwrapping)', 从swift 1.2开始,它后面和可以跟多个条件判断.
 
 11. convenience: 便利构造方法,初始化方法中的"二等公民".必须调用同一个类中的designated初始化方法(特定初始化方法)
     designated: 特定的初始化方法,如果没有指定,即 init 初始化方法
     required: 必须实现方法. 对于希望子类中一定实现的designated初始化方法,可以使用required关键字.当然,convenience方法也可以使用这个关键字.
     参考: http://swifter.tips/init-keywords/
 
 12. 协议后面跟class关键字表明这个协议只能用在类上. 为什么要特别注明这个协议只能由class来实现呢? 因为Swift 的 protocol 也是可以被除了 class 以外的其他类型遵守的，像 struct 或是 enum 这样的类型. 而我们在声明一个delegate的时候,为了避免循环引用,要把它声明为weak,但是struct和enum这样的类型是不通过引用计数来管理内存的,所以当不加class的时候,使用weak protocol的时候会编译报错. 还有另外一种方法,在protocol前加上@bojc. 
     参考: http://swifter.tips/delegate/
 
 13. 防止循环引用, 使用weak 和 unowned 
     参考: http://swifter.tips/retain-cycle/
     从Swift 3 开始,闭包默认都是非逃逸的,如果要标明一个逃逸闭包,需要使用@escaping
     所谓逃逸闭包,就是指闭包是在函数执行完毕之后,才被调用.这个时候,函数执行完毕,很有可能函数,函数中的变量,甚至整个类self,已经被释
     放,这时候闭包中再使用这些变量,或者调用self,就可能发生崩溃. 所以要使用weak和unowned.
     这里写了markdown文件./Users/mario/Desktop/Markdown/Swift中的weak 和 unowned
 
14.  Swift的闭包可以省略很多东西
     /Users/mario/Desktop/Markdown/Swift闭包的简写.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */


//: [Next](@next)
