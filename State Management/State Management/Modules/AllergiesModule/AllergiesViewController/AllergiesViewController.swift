//
//  AllergiesViewController.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class AllergiesViewController: UIViewController {
    
    @IBOutlet weak var allergiesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var allergiesTableView: UITableView!
    @IBOutlet weak var allergiesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBtn: UIButton!
    
    let dataManager = DataManager()
    var selectedHealthConcerns: [HealthConcern] = []
    var selectedDiets: [Diet] = []
    var allergies: [Allergies] = []
    var selectedAllergies: [Allergies] = []
    private var contentSizeObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let allergiesData: AllergiesData = dataManager.loadJSON(filename: "Allergies", type: AllergiesData.self) {
            allergies += allergiesData.data
        }
        setUpUIs()
        setUpCollectionView()
        setUpTableView()
    }
    
    private func setUpUIs() {
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 15
    }
    
    private func setUpCollectionView() {
        if let layout = allergiesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            allergiesCollectionView.collectionViewLayout = layout
        }
        
        allergiesCollectionView.delegate = self
        allergiesCollectionView.dataSource = self
        allergiesCollectionView.register(UINib(nibName: "AllergiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllergiesCollectionViewCell")
        collectionViewHeightConstraint.constant = 50
        allergiesCollectionView.reloadData()
        allergiesCollectionView.layoutIfNeeded()
    }
    
    private func setUpTableView() {
        contentSizeObservation = allergiesTableView.observe(\.contentSize, options: .new, changeHandler: { [weak self] (tv, _) in
            guard let self = self else { return }
            self.allergiesTableViewHeightConstraint.constant = tv.contentSize.height
        })
        
        allergiesTableView.delegate = self
        allergiesTableView.dataSource = self
        allergiesTableView.separatorStyle = .none
        allergiesTableView.isScrollEnabled = false
        allergiesTableView.register(UINib(nibName: "AllergiesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllergiesTableViewCell")
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let vc = GetVitaminRouter.createModule(selectedHealthConcerns: self.selectedHealthConcerns, selectedDiets: self.selectedDiets, selectedAllergies: self.selectedAllergies)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllergiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllergiesTableViewCell", for: indexPath) as? AllergiesTableViewCell else {
            return UITableViewCell()
        }
        cell.allergyLb.text = allergies[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAllergies.append(allergies[indexPath.row])
        let didselectedItemId = allergies[indexPath.row].id
        if let index = allergies.firstIndex(where: { $0.id == didselectedItemId }) {
            allergies.remove(at: index)
        }
        collectionViewHeightConstraint.constant = allergiesCollectionView.collectionViewLayout.collectionViewContentSize.height
        tableView.reloadData()
        allergiesCollectionView.reloadData()
    }
}

extension AllergiesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedAllergies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllergiesCollectionViewCell", for: indexPath) as? AllergiesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.selectedAllergyLb.text = selectedAllergies[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deselectedItemId = selectedAllergies[indexPath.row].id
        if let index = selectedAllergies.firstIndex(where: { $0.id == deselectedItemId }) {
            allergies.append(selectedAllergies[indexPath.row])
            selectedAllergies.remove(at: index)
            allergiesTableView.reloadData()
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = selectedAllergies[indexPath.row].name
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
        return CGSize(width: cellWidth + 30, height: 30.0)
    }
}
