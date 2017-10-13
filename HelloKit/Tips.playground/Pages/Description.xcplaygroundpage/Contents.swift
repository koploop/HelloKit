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
 
 
 
 */









//: [Next](@next)
