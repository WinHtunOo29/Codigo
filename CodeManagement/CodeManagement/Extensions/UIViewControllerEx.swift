//
//  UIViewControllerEx.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

private var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.center = aView!.center
        activityIndicatorView.startAnimating()
        aView?.addSubview(activityIndicatorView)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func showErrorPopUp(errorMsg: String) {
        let alert = UIAlertController(title: "", message: errorMsg, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
