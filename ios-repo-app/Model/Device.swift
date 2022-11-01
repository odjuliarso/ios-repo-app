//
//  Match.swift
//  ios-api-app
//
//  Created by Brian Bansenauer on 10/5/19.
//  Copyright © 2019 Cascadia College. All rights reserved.
//
enum DeviceType:String, Codable, CaseIterable{
        case iPad = "iPad"
        case iPhone = "iPhone"
        case iPodTouch = "iPod Touch"
        case AndroidPhone = "Android Phone"
        case AndroidTablet = "Android Tablet"
    
    static func withLabel(_ label: String) -> DeviceType? {
        return self.allCases.first{ "\($0)" == label }
    }
}

class Device: Codable {
    var DeviceID: String?
    var DeviceNum: String?
    var DeviceType: DeviceType?
    var DeviceName: String?
}
