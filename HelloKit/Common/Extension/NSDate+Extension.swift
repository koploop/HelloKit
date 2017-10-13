//
//  NSDate+Extension.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/9/29.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation

public extension Date {
    
    static var milliseconds: TimeInterval {
        get{
            return Date().timeIntervalSince1970 * 1000
        }
    }
    
    
    // 返回当前星期几
    func week() -> String {
        
        let myWeekday: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: self).weekday!
        
        switch myWeekday {
        case 0:
            return "周日"
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        default:
            break
        }
        return ""
    }
    
    
    // 将时间转为几天前这样的格式
    static func messageAgoSinceDate(_ date:Date) -> String {
        return self.timeAgoSinceDate(date, numericDates: false)
    }
    
    static func timeAgoSinceDate(_ date:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date) //earlierDate返回日期早的date, laterDate返回晚的date
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if components.year! >= 1 {
            return "\(String(describing: components.year!))年前"
        }
        if components.month! >= 1 {
            return "\(String(describing: components.month!))月前"
        }
        if components.weekOfYear! >= 1 {
            return "\(String(describing: components.weekOfYear!))周前"
        }
        if components.day! >= 2 {
            return "\(String(describing: components.day!))天前"
        } else if components.day! >= 1 {
            return "昨天"
        }
        if components.hour! >= 1 {
            return "\(String(describing: components.hour!))小时前"
        }
        if components.minute! >= 5 {
            return "\(String(describing: components.minute!))分钟前"
        } else {
            return "刚刚"
        }
            
    }
    
    
    // 时间格式化为字符串
    var chatTimeString: String {
        get {
            let calendar = Calendar.current
            let now = Date()
            let unit: NSCalendar.Unit = [
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
                ]
            let nowComponents:DateComponents = (calendar as NSCalendar).components(unit, from: now)
            let targetComponents:DateComponents = (calendar as NSCalendar).components(unit, from: self)
            
            let year = nowComponents.year! - targetComponents.year!
            let month = nowComponents.month! - targetComponents.month!
            let day = nowComponents.day! - targetComponents.day!
            
            if year != 0 {
                return String(format: "%zd年%zd月%zd日 %02d:%02d", targetComponents.year!, targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
            } else {
                if (month > 0 || day > 7) {
                    return String(format: "%zd月%zd日 %02d:%02d", targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
                } else if (day > 2) {
                    return String(format: "%@ %02d:%02d",self.week(), targetComponents.hour!, targetComponents.minute!)
                } else if (day == 2) {
                    if targetComponents.hour! < 12 {
                        return String(format: "前天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else if (day == 1) {
                    if targetComponents.hour! < 12 {
                        return String(format: "昨天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else if (day == 0){
                    if targetComponents.hour! < 12 {
                        return String(format: "上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else {
                    return ""
                }
            }
        }
    }
    
    
}
