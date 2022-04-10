//
//  NotificationManager.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 10/04/22.
//

import Foundation
import NotificationCenter

class NotificationManager {
  let userNotificationCenter = UNUserNotificationCenter.current()
  
  var months = [Int]()
  var days = [Int]()
  var hours = [Int]()
  var weekdays = [1, 2, 3, 4, 5, 6, 7]
  var isCustomActivated = false
  
  func resetNotification() {
    userNotificationCenter.removeAllDeliveredNotifications()
    userNotificationCenter.removeAllPendingNotificationRequests()
    months = []
    days = []
    hours = []
  }
  
  func getNotification() {
    let notificationContent = UNMutableNotificationContent()
    
    notificationContent.title = "It's time to read!"
    notificationContent.body = "Let's start reading. Your progress is waiting to be completed"
    notificationContent.badge = NSNumber(value: 1)
    
    // add attachment
    if let url = Bundle.main.url(forResource: "logoOdy", withExtension: "png") {
      if let attachment = try? UNNotificationAttachment(identifier: "logoOdy",
                                                        url: url,
                                                        options: nil) {
        notificationContent.attachments = [attachment]
      }
    }
    
    for month in self.months {
      for day in self.days {
        for hour in self.hours {
          for weekday in weekdays {
            
            var dateComponents = DateComponents()
            
            dateComponents.calendar = Calendar.current
            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = hour
            dateComponents.weekday = weekday
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "\(month),\(day),\(hour)",
                                                content: notificationContent,
                                                trigger: trigger)
            userNotificationCenter.add(request) { (error) in
              if let error = error {
                print("Notification Error: ", error)
              }
            }
          }
        }
      }
    }
  }
  
  func monthDateFormatter(startDate: Date, endDate: Date) {
    let startcalendarDate = Calendar.current.dateComponents([.month], from: startDate)
    let endCalendarDate = Calendar.current.dateComponents([.month], from: endDate)
    arrayOfMonths(startMonth: startcalendarDate.month, endMonth: endCalendarDate.month)
  }
  
  func dayDateFormatter(startDate: Date, endDate: Date) {
    let startcalendarDate = Calendar.current.dateComponents([.day], from: startDate)
    let endCalendarDate = Calendar.current.dateComponents([.day], from: endDate)
    arrayOfMonths(startMonth: startcalendarDate.month, endMonth: endCalendarDate.month)
  }
  
  private func arrayOfMonths(startMonth: Int?, endMonth: Int?) {
    if let startMonth = startMonth,
       let endMonth = endMonth {
      for month in startMonth ... endMonth {
        self.months.append(month)
      }
    }
  }
  
  private func arrayOfDays(startDay: Int?, endDay: Int?) {
    if let startDay = startDay,
       let endDay = endDay {
      for day in startDay ... endDay {
        self.days.append(day)
      }
    }
  }
  
}

// MARK: - Unused Code

//func sendNotification() {
//  let notificationContent = UNMutableNotificationContent()
//
//  notificationContent.title = "Test"
//  notificationContent.body = "Test body"
//  notificationContent.badge = NSNumber(value: 3)
//
//  // add attachment
//  if let url = Bundle.main.url(forResource: "logoOdy", withExtension: "png") {
//    if let attachment = try? UNNotificationAttachment(identifier: "logoOdy",
//                                                      url: url,
//                                                      options: nil) {
//      notificationContent.attachments = [attachment]
//    }
//  }
//
//  // date components
//  var dateComponent = DateComponents()
//  dateComponent.hour = 9
//
//  // trigger and request
//  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//  let fireDate = Calendar.current.dateComponents([.day], from: startDate.date)
//  let trigger2 = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: true)
//  let request = UNNotificationRequest(identifier: "testNotification",
//                                      content: notificationContent,
//                                      trigger: trigger)
//  userNotificationCenter.add(request) { (error) in
//    if let error = error {
//      print("Notification Error: ", error)
//    }
//  }
//}
//
//func setNotification2() {
//
//  let center = UNUserNotificationCenter.current()
//  let content = UNMutableNotificationContent()
//
//  content.title = "Notifiaction on a certail date"
//  content.body = "This is a local notification on certain date"
//  content.sound = .default
//  content.userInfo = ["value": "Data with local notification"]
//
//  let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(20))
//  let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
//  let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
//
//  center.add(request) { (error) in
//    if error != nil {
//      print("Error = \(error?.localizedDescription ?? "error local notification")")
//    }
//  }
//}
