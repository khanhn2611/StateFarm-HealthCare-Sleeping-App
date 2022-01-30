//
//  ViewController.swift
//  SF App
//
//  Created by Khanh Nguyen on 1/29/22.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    @IBOutlet weak var DataTableView: UITableView!

    @IBOutlet weak var authorizedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizedButton.addTarget(self, action: #selector(openPermissionSetup), for: .touchUpInside)
        authorizedButton.layer.cornerRadius = 22
        // Do any additional setup after loading the view.
       
    }
    
    @objc func openPermissionSetup() {
        
        PermissionHealthKitSetup.authorizedHealthKitSetup { (authorized,error) in
        guard authorized else {
            let message = "Failed!"
            if let error = error {
                print("\(message) reason \(error)")
            }
            return
        }
        print("Authorized!")
        }
        endTime = NSDate()
        saveSleepAnalysis()
        retrieveSleepAnalysis()
        
    }
    
    
    @IBOutlet var displayTimeLabel: UILabel!

    var startTime = TimeInterval()
    var timer:Timer = Timer()
    var endTime: NSDate!
    var Time: NSDate!
    let healthStore = HKHealthStore()
    func saveSleepAnalysis() {
        

            //1. startTime(alarmTime) and endTime are NSDate Objects//
            if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
                //we create a new object that we want to add into our Health app(This is our INBED object)//
                let object1 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: self.endTime as Date, end: self.endTime as Date)
                // Time to save the object//
                healthStore.save(object1, withCompletion: { (success, error) -> Void in

                    if error != nil
                    {
                        return
                    }

                    if success {
                        print("My new data was saved in HealthKit")

                    } else {
                        //something happened again//
                    }
                })
                //This our ASLEEP object//
                let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.asleep.rawValue, start: self.endTime as Date, end: self.endTime as Date)
                //now we save our objects to our mainLibrary known as HealthStore
                healthStore.save(object2, withCompletion: { (success, error) -> Void in
                    if error != nil {
                        //Something went wrong//
                        return
                    }
                    if success {
                        print("My new data (2: Asleep data) was saved into HealthKit")
                    } else {
                        //something happened again//
                    }
                    
                }
                )}


        }
    
    func retrieveSleepAnalysis() {
        
            //first, define our object type that we watn again in BOOLEAN FORMAT//
            if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {

                //use sortDescriptor to get teh recent data first: so from MostRecentData to PastData//
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

                //we create our query with a block completion to execute
                let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit:30, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in

                    if error != nil {
                        //something happends//
                        return
                    }
                    if let result = tmpResult {

                        //then i want the computer to do something with my data//
                        for item in result {
                            if let sample = item as? HKCategorySample {
                                let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                                print("Healthkit sleep: \(sample.startDate) \(sample.endDate) = value: \(value)")
                            }
                        }
                    }
                }

                //finally, we execute our query: Print out our output file //
                healthStore.execute(query)
            }
        }
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataTableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel?.text = "Hi"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print()
    }
    
}

