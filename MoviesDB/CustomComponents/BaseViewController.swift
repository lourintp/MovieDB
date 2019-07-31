//
//  BaseViewController.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol BaseView {
    func showLoading()
    func hideLoading()
}

class BaseViewController: UIViewController, BaseView {

    var overlay : UIView?
    var viewLoading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            overlay = UIView(frame: window.frame)

            let viewLoadingYesCgRect = CGRect(x: 0, y: 0, width: window.frame.size.width * 0.150, height: window.frame.size.width * 0.150)
            viewLoading = NVActivityIndicatorView(frame: viewLoadingYesCgRect, type: .circleStrokeSpin, color: UIColor.colorWithHexString("00dc81", alpha: 0.90), padding: 0.5)

            overlay!.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5)
            overlay!.backgroundColor = UIColor.colorWithHexString("ffffff", alpha: 0.80)

            if (self.navigationController?.isNavigationBarHidden == false) {
                viewLoading.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5-64)
            } else {
                viewLoading.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5-20)
            }

            overlay!.addSubview(viewLoading)
            viewLoading.startAnimating()
        }

        if (!(overlay?.isDescendant(of: view))!){
            view.addSubview(overlay!)
        }

    }

    func hideLoading() {
        if (overlay != nil){
            self.viewLoading.stopAnimating()
            overlay!.removeFromSuperview()
        }
    }

}
