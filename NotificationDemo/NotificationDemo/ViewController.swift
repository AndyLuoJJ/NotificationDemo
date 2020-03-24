//
//  ViewController.swift
//  NotificationDemo
//
//  Created by My MacBook on 2020/3/24.
//  Copyright © 2020 My MacBook. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var mainPicture: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var tenSecondsNotiButton: UIButton!
    
    var timer: Timer?
    var counter = 0
    
    @IBAction func tenSecondsNoti(_ sender: UIButton) {
        // set the button unclickable
        tenSecondsNotiButton.isEnabled = false
        
        // create a new timer every time the button is clicked
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] timer in
            if (self?.counter == 10) {
                DispatchQueue.main.async {
                    [weak self] in
                    self?.tenSecondsNotiButton.isEnabled = true
                    self?.counterLabel.text = "0"
                }
                self?.timer?.invalidate()
                self?.timer = nil
                self?.counter = 0
            } else {
                // refresh the label
                DispatchQueue.main.async {
                    [weak self] in
                    self?.counterLabel.text = "\(11 - (self?.counter ?? 0))"
                }
                self?.counter = (self?.counter ?? 0) + 1
            }
        }
        
        // create user notification content
        let tenSecondsContent = UNMutableNotificationContent()
        tenSecondsContent.title = "Ten Seconds"
        tenSecondsContent.subtitle = "⏰⏰⏰"
        tenSecondsContent.sound = .default
        tenSecondsContent.categoryIdentifier = LocalNotificationActionAndCategoryIdentifiers.defaultCategory
        
        // create user notification trigger
        let tenSecondsTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // create user notification request
        let tenSecondsRequest = UNNotificationRequest(identifier: LocalNotificationRequestIdentifiers.tenSeconds, content: tenSecondsContent, trigger: tenSecondsTrigger)
        
        // add the request to current user notification
        UNUserNotificationCenter.current().add(tenSecondsRequest) {
            error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Add ten seconds trigger")
            }
        }
        
        // start the timer
        timer?.fire()
    }
    
    @IBAction func twoDaysNoti(_ sender: UIButton) {
        let twoDaysContent = UNMutableNotificationContent()
        twoDaysContent.title = "Ten Seconds"
        twoDaysContent.subtitle = "⏰⏰⏰"
        twoDaysContent.sound = .default
        twoDaysContent.categoryIdentifier = LocalNotificationActionAndCategoryIdentifiers.defaultCategory
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: Date(timeInterval: 48 * 3600, since: Date()))
        let dateComponent = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
        let twoDaysTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let twoDaysRequest = UNNotificationRequest(identifier: LocalNotificationRequestIdentifiers.twoDays, content: twoDaysContent, trigger: twoDaysTrigger)
        
        UNUserNotificationCenter.current().add(twoDaysRequest) { _ in
            print("Add two days trigger")
        }
    }
    
    @IBAction func refreshPicture(_ sender: UIButton) {
        // user NotificationCenter to refresh the picture
        let notiName = Notification.Name(NotificationCenterIdentifiers.refreshPicture)
        NotificationCenter.default.post(name: notiName, object: nil)
        
    }
    
    @objc private func changePicture(notification: Notification) {
        // change the picture randomly
        let index = Int(arc4random()) % 5
        mainPicture.image = UIImage(named: "pic\(index)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // For simplicity, add self as the observer
        let notiName = Notification.Name(NotificationCenterIdentifiers.refreshPicture)
        NotificationCenter.default.addObserver(self, selector: #selector(changePicture(notification:)), name: notiName, object: nil)
    }

}

