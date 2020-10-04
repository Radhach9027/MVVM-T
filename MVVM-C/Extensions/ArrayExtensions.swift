import Foundation

extension Array {
    func groupByDates<T: Dated>(model: [T]) -> [Date: [T]] {
        let empty: [Date: [T]] = [:]
        return model.reduce(into: empty) { acc, cur in
            let components = Calendar.current.dateComponents([.day,.month], from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
    }
}

protocol Dated {
    var date: Date { get }
}
