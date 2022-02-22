//
//  ViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        imageView.image = UIImage(named: "LogoWhite")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = view.bounds
        view.addSubview(imageView)
        view.addSubview(logoImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
    }
    
    
    func animate() {
        UIView.animate(withDuration: 1) {
            self.imageView.image = UIImage(named: "SplashBacgroundBlur")
            let vc = LoginViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}

