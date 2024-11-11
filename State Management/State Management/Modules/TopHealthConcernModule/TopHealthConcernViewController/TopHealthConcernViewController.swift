//
//  TopHealthConcernViewController.swift
//  State Management
//
//  Created by Win Htun Oo on 11/11/2024.
//

import Foundation
import UIKit

class TopHealthConcernViewController: UIViewController {
    @IBOutlet weak var selectLb: UILabel!
    @IBOutlet weak var upToLb: UILabel!
    @IBOutlet weak var healthConcernsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedHealthTableView: UITableView!
    @IBOutlet weak var selectedHealthTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBtn: UIButton!
    
    var healthConcerns: [HealthConcern] = []
    let dataManager = DataManager()
    let selectionLimit = 5
    var selectedHealthConcerns: [HealthConcern] = []
    private var contentSizeObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let healthConcernData: HealthConcernData = dataManager.loadJSON(filename: "Healthconcern", type: HealthConcernData.self) {
            healthConcerns = healthConcernData.data
        }
        setUpUIs()
        setUpCollectionView()
        setUpTableView()
    }
    
    private func setUpUIs() {
        RequiredText().makeStarRed(mainString: "Select the top health concerns. *", label: selectLb)
        upToLb.text = "(upto 5)"
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 15
        nextBtn.backgroundColor = .lightGray
        nextBtn.isEnabled = false
    }
    
    private func setUpCollectionView() {
        if let layout = healthConcernsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            healthConcernsCollectionView.collectionViewLayout = layout
        }
        
        healthConcernsCollectionView.delegate = self
        healthConcernsCollectionView.dataSource = self
        healthConcernsCollectionView.allowsMultipleSelection = true
        healthConcernsCollectionView.register(UINib(nibName: "HealthConcernsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HealthConcernsCollectionViewCell")
        collectionViewHeightConstraint.constant = healthConcernsCollectionView.collectionViewLayout.collectionViewContentSize.height
        healthConcernsCollectionView.reloadData()
        healthConcernsCollectionView.layoutIfNeeded()
    }
    
    private func setUpTableView() {
        contentSizeObservation = selectedHealthTableView.observe(\.contentSize, options: .new, changeHandler: { [weak self] (tv, _) in
            guard let self = self else { return }
            self.selectedHealthTableViewHeightConstraint.constant = tv.contentSize.height
        })
        
        selectedHealthTableView.delegate = self
        selectedHealthTableView.dataSource = self
        selectedHealthTableView.isEditing = true
        selectedHealthTableView.isScrollEnabled = false
        selectedHealthTableView.register(UINib(nibName: "SelectedHealthTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedHealthTableViewCell")
    }
    
    deinit {
        contentSizeObservation?.invalidate()
    }
    
    private func toggleNextBtn() {
        if selectedHealthConcerns.count > 0 {
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
        let vc = DietRouter.createModule(selectedHealthConcerns: self.selectedHealthConcerns)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopHealthConcernViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthConcernsCollectionViewCell", for: indexPath) as? HealthConcernsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.healthConcernLb.text = healthConcerns[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        if selectedItemsCount > selectionLimit {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            selectedHealthConcerns.append(healthConcerns[indexPath.row])
            toggleNextBtn()
            selectedHealthTableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectedItemId = healthConcerns[indexPath.row].id
        if let index = selectedHealthConcerns.firstIndex(where: { $0.id == deselectedItemId }) {
            selectedHealthConcerns.remove(at: index)
            toggleNextBtn()
            selectedHealthTableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = healthConcerns[indexPath.row].name
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
        return CGSize(width: cellWidth + 30, height: 30.0)
    }
}

extension TopHealthConcernViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedHealthConcerns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedHealthTableViewCell", for: indexPath) as? SelectedHealthTableViewCell else {
            return UITableViewCell()
        }
        cell.healthLb.text = selectedHealthConcerns[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        selectedHealthConcerns.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

