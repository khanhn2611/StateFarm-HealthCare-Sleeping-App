//
//  Permission.swift
//  SF App
//
//  Created by Khanh Nguyen on 1/29/22.
//

import Foundation
import HealthKit

class PermissionHealthKitSetup {
    private enum PermissionHealthKitError: Error {
        
        case deviceNotAvailable
        case dataNotAvaailable
    }
    class func authorizedHealthKitSetup(completion:@escaping (Bool, Error?)-> Void) {
        func requestSleepAuthorization() {
            let healthStore = HKHealthStore()

            if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
                let setType = Set<HKSampleType>(arrayLiteral: sleepType)
                healthStore.requestAuthorization(toShare: setType, read: setType) { (success, error) in

                    if !success || error != nil {                                                                                                                                                       
                        // handle error
                        return
                    }
                    // handle success
                }
            }
            
            
        }
        requestSleepAuthorization()
        
        
        
        

    }
}
