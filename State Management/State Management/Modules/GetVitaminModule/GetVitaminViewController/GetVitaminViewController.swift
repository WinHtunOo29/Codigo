//
//  GetVitaminViewController.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class GetVitaminViewController: UIViewController {
    
    @IBOutlet weak var exposureLb: UILabel!
    @IBOutlet weak var yesExposure: UIImageView!
    @IBOutlet weak var noExposure: UIImageView!
    @IBOutlet weak var smokeLb: UILabel!
    @IBOutlet weak var yesSmoke: UIImageView!
    @IBOutlet weak var noSmoke: UIImageView!
    @IBOutlet weak var alcoholLb: UILabel!
    @IBOutlet weak var firstAlcohol: UIImageView!
    @IBOutlet weak var thirdAlcohol: UIImageView!
    @IBOutlet weak var secondAlcohol: UIImageView!
    @IBOutlet weak var getVitaminBtn: UIButton!
    
    var selectedHealthConcerns: [HealthConcern] = []
    var selectedDiets: [Diet] = []
    var selectedAllergies: [Allergies]?
    var exposure: DailyExposure = DailyExposure()
    var smoke: Smoke = Smoke()
    var alcohol: Alcohol = Alcohol()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIs()
        let yesExposureTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYesExposure))
        yesExposure.isUserInteractionEnabled = true
        yesExposure.addGestureRecognizer(yesExposureTapGesture)
        
        let noExposureTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNoExposure))
        noExposure.isUserInteractionEnabled = true
        noExposure.addGestureRecognizer(noExposureTapGesture)
        
        let yesSmokeTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYesSmoke))
        yesSmoke.isUserInteractionEnabled = true
        yesSmoke.addGestureRecognizer(yesSmokeTapGesture)
        
        let noSmokeTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNoSmoke))
        noSmoke.isUserInteractionEnabled = true
        noSmoke.addGestureRecognizer(noSmokeTapGesture)
        
        let firstAlcoholTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFirstAlcohol))
        firstAlcohol.isUserInteractionEnabled = true
        firstAlcohol.addGestureRecognizer(firstAlcoholTapGesture)
        
        let secondAlcoholTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSecondAlcohol))
        secondAlcohol.isUserInteractionEnabled = true
        secondAlcohol.addGestureRecognizer(secondAlcoholTapGesture)
        
        let thirdAlcoholTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapThirdAlcohol))
        thirdAlcohol.isUserInteractionEnabled = true
        thirdAlcohol.addGestureRecognizer(thirdAlcoholTapGesture)
    }
    
    private func setUpUIs() {
        RequiredText().makeStarRed(mainString: "Is your daily exposure to sun is limited? *", label: exposureLb)
        RequiredText().makeStarRed(mainString: "Do you current smoke (tobacco or arijuana)? *", label: smokeLb)
        RequiredText().makeStarRed(mainString: "On average,how many alcoholic beverages do you have in a week? *", label: alcoholLb)
        
        getVitaminBtn.backgroundColor = .lightGray
        getVitaminBtn.isEnabled = false
    }
    
    @objc private func didTapYesExposure() {
        exposure.is_daily_exposure = true
        yesExposure.image = UIImage(named: "checkedRadio")
        noExposure.image = UIImage(named: "uncheckRadio")
        toggleBtn()
    }
    
    @objc private func didTapNoExposure() {
        exposure.is_daily_exposure = false
        yesExposure.image = UIImage(named: "uncheckRadio")
        noExposure.image = UIImage(named: "checkedRadio")
        toggleBtn()
    }
    
    @objc private func didTapYesSmoke() {
        smoke.is_smoke = true
        yesSmoke.image = UIImage(named: "checkedRadio")
        noSmoke.image = UIImage(named: "uncheckRadio")
        toggleBtn()
    }
    
    @objc private func didTapNoSmoke() {
        smoke.is_smoke = false
        yesSmoke.image = UIImage(named: "uncheckRadio")
        noSmoke.image = UIImage(named: "checkedRadio")
        toggleBtn()
    }
    
    @objc private func didTapFirstAlcohol() {
        alcohol.alcohol = "0 - 1"
        firstAlcohol.image = UIImage(named: "checkedRadio")
        secondAlcohol.image = UIImage(named: "uncheckRadio")
        thirdAlcohol.image = UIImage(named: "uncheckRadio")
        toggleBtn()
    }
    
    @objc private func didTapSecondAlcohol() {
        alcohol.alcohol = "2 - 5"
        firstAlcohol.image = UIImage(named: "uncheckRadio")
        secondAlcohol.image = UIImage(named: "checkedRadio")
        thirdAlcohol.image = UIImage(named: "uncheckRadio")
        toggleBtn()
    }
    
    @objc private func didTapThirdAlcohol() {
        alcohol.alcohol = "5 +"
        firstAlcohol.image = UIImage(named: "uncheckRadio")
        secondAlcohol.image = UIImage(named: "uncheckRadio")
        thirdAlcohol.image = UIImage(named: "checkedRadio")
        toggleBtn()
    }
    
    @IBAction func vitaminBtnTapped(_ sender: Any) {
        print("Health Concerns : \(selectedHealthConcerns)")
        print("Diets : \(selectedDiets)")
        print("Allergies : \(selectedAllergies)")
        print("Sun Exposure : \(exposure.is_daily_exposure)")
        print("Smoke : \(smoke.is_smoke)")
        print("Alcohol : \(alcohol.alcohol)")
    }
    
    private func toggleBtn() {
        if exposure.is_daily_exposure != nil && smoke.is_smoke != nil && alcohol.alcohol != nil {
            getVitaminBtn.backgroundColor = .init(red: 240/255, green: 113/255, blue: 17/255, alpha: 1.0)
            getVitaminBtn.isEnabled = true
        } else {
            getVitaminBtn.backgroundColor = .lightGray
            getVitaminBtn.isEnabled = false
        }
    }
}
