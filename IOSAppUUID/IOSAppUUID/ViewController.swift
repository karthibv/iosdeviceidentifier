//
//  ViewController.swift
//  IOSAppUUID
//
//  Created by Karthik 
//  Copyright © 2018 Karthik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" Unique deviceid \(UUID())")

        // Do any additional setup after loading the view, typically from a nib.
    }

    func UUID() -> String {
        
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let accountName = Bundle.main.bundleIdentifier! + String(Bundle.main.bundleIdentifier!.characters.reversed()) // just one extra layer of protection.. :p
        
        var applicationUUID = UIDKeychain.password(forService: bundleName, account: accountName)
        
        if applicationUUID == nil {
            
            applicationUUID = (UIDevice.current.identifierForVendor?.uuidString)!
            
            // Save applicationUUID in keychain without synchronization
            let query = UIDKeychainQuery()
            query.service = bundleName
            query.account = accountName
            query.password = applicationUUID
            query.synchronizationMode = UIDKeychainQuerySynchronizationMode.no
            
            do {
                try query.save()
            } catch let error as NSError {
                print("SAMKeychainQuery Exception: \(error)")
            }
        }
        
        return applicationUUID!
    }

}

