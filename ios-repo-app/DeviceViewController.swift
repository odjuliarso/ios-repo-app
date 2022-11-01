//
//  DeviceViewController.swift
//  ios-repo-app
//
//  Created by Student on 10/31/22.
//  Copyright © 2022 Cascadia College. All rights reserved.
//

import Foundation
import UIKit

class DeviceViewController: UIViewController{
    @IBOutlet weak var deviceID: UITextField!
    @IBOutlet weak var deviceNum: UITextField!
    @IBOutlet weak var deviceName: UITextField!
    @IBOutlet weak var resultInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveToAPI(_ sender: Any) {
        //TODO: create a Repository object needed to invoke the API's create method at http://216.186.69.45/services/device/users/
        let deviceRepo = Repository<Device>(withPath: "https://mikethetall.pythonanywhere.com/devices")
        
        let newDevice = Device()
        newDevice.DeviceID = deviceID.text
        newDevice.DeviceNum = deviceNum.text
        newDevice.DeviceType = DeviceType.AndroidPhone
        newDevice.DeviceName = deviceName.text
        
        deviceRepo.create(a: newDevice) { (element) in
            if let id = element?.DeviceID, let name = element?.DeviceName {
                self.resultInfo.text = "Successfully create device \(name) with id \(id)"
                print("Successfully create device \(name) with id \(id)")
            }
    }
    
}
}
