//
//  NotificationLiteral.swift
//  NotificationDemo
//
//  Created by My MacBook on 2020/3/24.
//  Copyright © 2020 My MacBook. All rights reserved.
//

import Foundation

struct LocalNotificationActionAndCategoryIdentifiers {
    static let remindLater = "REMIND_LATER"
    static let cancel = "CANCEL"
    static let defaultCategory = "DEFAULT_CATEGORY"
}

struct LocalNotificationRequestIdentifiers {
    static let fiveSeconds = "FIVE_SECONDS"
    static let tenSeconds = "TEN_SECONDS"
    static let twoDays = "TWO_DAYS"
    static let immediate = "IMMEDIATE"
}

struct NotificationCenterIdentifiers {
    static let refreshPicture = "REFRESH_PICTURE"
}
