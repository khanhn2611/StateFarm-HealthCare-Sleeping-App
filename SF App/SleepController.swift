//
//  SleepController.swift
//  SF App
//
//  Created by Khanh Nguyen on 1/30/22.
//
import UIKit
import Foundation

/*https://betterprogramming.pub/5-ways-to-pass-data-between-view-controllers-18acb467f5ec*/
class SleepController: UIViewController {
    @IBOutlet weak var out: UILabel!
    let percentage = 0.10
    let user_sleep_time = 460.0
    let age = 25


    let average1 = 480.0
    let average2 = 480.0
    let average3 = 450.0

    let stdv1 = 102.0
    let stdv2 = 90.0
    let stdv3 = 78.0
    var result = 0.0

    func age_group_calc(age_: Int) -> (Double, Double){
        if (age_ >= 18 && age_ <= 25){
            return (average1, stdv1)
        }
        else if (age_ >= 26 && age_<=64){
            return (average2, stdv2)
        }
        else{
            return (average3, stdv3)
        }
    }

    func z(x:Double, avg:Double, std: Double) -> (Double){
        return (abs(x - avg) / std)
    }

    func discount(u: Double, avg: Double, std: Double) -> (Double){
        if(z(x:u, avg:avg, std:std) > 1.5){
            return percentage * 0.2
        }
        return((4 - z(x:u, avg:avg, std:std)) / 4 * percentage)

    }
    func final() -> Double{
        let average = age_group_calc(age_:age).0
        let stdv = age_group_calc(age_:age).1

        let result = discount(u: user_sleep_time, avg: average, std: stdv)
        return result
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let c: String = String(format: "%.2f", final()*100)
        
        out.text = c + "%"
    }
    //    @IBInspectable var localisedKey: String? {
//            didSet {
//                guard let key = localisedKey else { return }
//                text = NSLocalizedString(key, comment: "")
//            }
//        }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    var discount_tot = calc_percent()
//
//    func final_calc() {
//
//    }
//
//    func updateUI() {
//
//    }
    
    
}
