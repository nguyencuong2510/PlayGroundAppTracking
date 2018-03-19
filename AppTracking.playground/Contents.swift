//: Playground - noun: a place where people can play

import UIKit

extension Date {
    func dayOfTheWeek() -> String? {
        let weekdays = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"]
        let calendar = Calendar.current
        let components = calendar.component(.weekday, from: self)
        return weekdays[components - 1]
    }
}

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
}

class DataModel{
    var day: Date
    var state: Bool
    
    init(day: Date, state: Bool) {
        self.day = day
        self.state = state
    }
}

//MARK: List array trong 30 ngay
var exc = "T7 T2"
var numberDay: [Double] = [Double](repeating: 1, count: 5)
let calendar = Calendar.current


//MARK: Reset 1 ngay thi cong them 1.5 ngay
func addDays(numberAppend: Double){
    if (Int(numberAppend * 2) % 2) == 1 {
        for _ in 0..<Int(numberAppend) {
            numberDay.append(1)
        }
        numberDay.append(0.5)
    }else{
        numberDay.append(1)
    }
}
addDays(numberAppend: 1.5)
print(numberDay)

//MARK: get list day from listnumberDay
var listDay: [DataModel] = []
func loadListDate(numberDay: [Double]) -> [DataModel]{
    for value in 0..<numberDay.count {
        if let day = calendar.date(byAdding: .day, value: value, to: Date()),
            let stringDay = day.dayOfTheWeek() {
                if (exc.range(of: stringDay) == nil) {
                    if numberDay[value] == 1 {
                        listDay.append(DataModel(day: day, state: false))
                        listDay.append(DataModel(day: day, state: false))
                    }else{
                        listDay.append(DataModel(day: day, state: false))
                    }
                }
        }
    }
    return listDay
}

//MARK: Neu bo 3 ngay thi tu dong reset ve ban dau va luu thoi gian da lam lai.

//Return number date from two days.
let startDay = calendar.date(byAdding: .day, value: -10, to: Date())
let numberPassDay = Date().interval(ofComponent: Calendar.Component.day, fromDate: startDay!)
addDays(numberAppend: 2.5)
var c = loadListDate(numberDay: numberDay)

let arrayPassDay = numberDay.prefix(numberPassDay)
func passDay() -> [DataModel]{
    var num = 0
    for item in arrayPassDay {
        (Int(item * 2) % 2) == 1 ? (num += 1) : (num += 2)
    }
    return Array(listDay.prefix(num))
}

var aa = passDay()
for item in 0..<listDay.count{
    print(listDay[item].day)
}
print("-------")

for item in 0..<aa.count {
    print(aa[item].day)
}



