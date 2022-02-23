//
//  HomeViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var profileImage : UIImageView = {
        let imgView = UIImageView()
        imgView.constrainWidth(36)
        imgView.constrainHeight(36)
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.contentMode = .scaleAspectFit
        imgView.cornerRadius = imgView.bounds.width / 2
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .left
        labText.font = UIFont.boldSystemFont(ofSize: 28)
        return labText
    }()
    
    lazy var descriptionLabel: UILabel = {
        let labText = UILabel()
        labText.textAlignment = .left
        labText.numberOfLines = 2
        labText.font = UIFont.systemFont(ofSize: 17)
        return labText
    }()
    
    lazy var surveyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "takeSuvey"), for: .normal)
        button.constrainWidth(36)
        button.constrainHeight(36)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var stackView: UIStackView = {
          let sv = UIStackView()
          sv.translatesAutoresizingMaskIntoConstraints = false
          sv.axis = .horizontal
          sv.distribution = .equalCentering
          sv.alignment = .center
          sv.addArrangedSubview(descriptionLabel)
          sv.addArrangedSubview(surveyButton)
          return sv
      }()
    
    lazy var stackView2: UIStackView = {
           let sv = UIStackView()
           sv.translatesAutoresizingMaskIntoConstraints = false
           sv.axis = .vertical
           sv.spacing = 5
           sv.alignment = .leading
           sv.addArrangedSubview(titleLabel)
           sv.addArrangedSubview(stackView)
           return sv
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func returnMyView(title: String, description: String, image:String) -> UIView {
        let view = UIView()
        
        
        
        return view
    }
    
}
