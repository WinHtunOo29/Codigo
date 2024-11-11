//
//  DietViewController.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class DietViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dietsTableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var dietsTableHeightConstraint: NSLayoutConstraint!
    
    let dataManager = DataManager()
    var selectedHealthConcerns: [HealthConcern] = []
    var diets: [Diet] = [Diet(id: 0, name: "None", tool_tip: nil)]
    var selectedDiets: [Diet] = []
    private var contentSizeObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dietData: DietData = dataManager.loadJSON(filename: "Diets", type: DietData.self) {
            diets += dietData.data
        }
        setUpUIs()
        setUpTableView()
    }
    
    private func setUpUIs() {
        RequiredText().makeStarRed(mainString: "Select the diets you follow. *", label: label)

        nextBtn.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 15
        nextBtn.backgroundColor = .lightGray
        nextBtn.isEnabled = false
    }
    
    private func setUpTableView() {
        contentSizeObservation = dietsTableView.observe(\.contentSize, options: .new, changeHandler: { [weak self] (tv, _) in
            guard let self = self else { return }
            self.dietsTableHeightConstraint.constant = tv.contentSize.height
        })
        
        dietsTableView.delegate = self
        dietsTableView.dataSource = self
        dietsTableView.allowsSelection = false
        dietsTableView.separatorStyle = .none
        dietsTableView.register(UINib(nibName: "DietsTableViewCell", bundle: nil), forCellReuseIdentifier: "DietsTableViewCell")
    }
    
    deinit {
        contentSizeObservation?.invalidate()
    }
    
    private func toggleNextBtn() {
        if selectedDiets.count > 0 {
            nextBtn.backgroundColor = .init(red: 240/255, green: 113/255, blue: 17/255, alpha: 1.0)
            nextBtn.isEnabled = true
        } else {
            nextBtn.backgroundColor = .lightGray
            nextBtn.isEnabled = false
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let vc = AllergiesRouter.createModule(selectedHealthConcerns: selectedHealthConcerns, selectedDiets: selectedDiets)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DietViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        diets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DietsTableViewCell", for: indexPath) as! DietsTableViewCell
        if indexPath.row == 0 {
            cell.tooltipImgView.isHidden = true
        } else {
            cell.tooltipImgView.isHidden = false
        }
        cell.dietsLb.text = diets[indexPath.row].name
        cell.checkboxTapped = {
            cell.isChecked = !cell.isChecked
            cell.checkBoxImgView.image = cell.isChecked ?  UIImage(named: "checkBox") :  UIImage(named: "uncheckBox")
            if cell.isChecked {
                self.selectedDiets.append(self.diets[indexPath.row])
                self.toggleNextBtn()
            } else {
                if let index = self.selectedDiets.firstIndex(where: { $0.name == self.diets[indexPath.row].name}) {
                    self.selectedDiets.remove(at: index)
                    self.toggleNextBtn()
                }
            }
        }
        
        cell.toolTipTapped = {
            let tooltip = TooltipView(text: self.diets[indexPath.row].tool_tip ?? "")
            tooltip.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(tooltip)
            
            NSLayoutConstraint.activate([
                tooltip.leadingAnchor.constraint(equalTo: cell.tooltipImgView.trailingAnchor, constant: 16),
                tooltip.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
            ])
            
            tooltip.alpha = 0
            UIView.animate(withDuration: 0.3) {
                tooltip.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 0.3) {
                    tooltip.alpha = 0
                } completion: { _ in
                    tooltip.removeFromSuperview()
                }
            }
        }
        return cell
    }
}
