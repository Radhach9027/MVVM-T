import UIKit

extension Date {
    
     enum DateFormats: String {
        case yyyyMMdd = "yyyy-MM-dd"
        case yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
        case MMMddyyyy = "MMM dd,yyyy"
    }
    
    func toString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    static func time(since fromDate: Date) -> String {
        guard fromDate < Date() else { return "Back to the future" }
        
        let allComponents: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components:DateComponents = Calendar.current.dateComponents(allComponents, from: fromDate, to: Date())
        
        for (period, timeAgo) in [
            ("year", components.year ?? 0),
            ("month", components.month ?? 0),
            ("week", components.weekOfYear ?? 0),
            ("day", components.day ?? 0),
            ("hour", components.hour ?? 0),
            ("minute", components.minute ?? 0),
            ("second", components.second ?? 0),
            ] {
                if timeAgo > 0 {
                    return "\(timeAgo.of(period)) ago"
                }
        }
        
        return "Just now"
    }
}

extension Int {
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
}
