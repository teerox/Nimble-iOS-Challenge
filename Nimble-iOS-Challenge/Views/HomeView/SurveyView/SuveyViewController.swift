//
//  SuveyViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import UIKit
import Cosmos

class SuveyViewController: UIViewController {

    @IBOutlet weak var mesageCountLabel: UILabel!
    @IBOutlet weak var suveyTitle: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var backGroundimage: UIImageView!
    @IBOutlet weak var mainSubmitBtn: UIButton!
    
    lazy var heartView : CosmosView = {
        let view = CosmosView()
        view.settings.totalStars = 5
        view.rating = 0
        view.settings.filledImage = UIImage(named: "heart_fill")
        view.settings.emptyImage = UIImage(named: "heart_faint")
        return view
    }()
    
    lazy var thumbs : CosmosView = {
        let view = CosmosView()
        view.settings.totalStars = 5
        view.rating = 0
        view.settings.filledImage = UIImage(named: "thumbs_fill")
        view.settings.emptyImage = UIImage(named: "thumbs_faint")
        return view
    }()
    
    lazy var star : CosmosView = {
        let view = CosmosView()
        view.settings.totalStars = 5
        view.rating = 0
        view.settings.filledImage = UIImage(named: "star_fill")
        view.settings.emptyImage = UIImage(named: "start_faint")
        return view
    }()
    
    var viewModel: HomeViewModel?
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSubmitBtn.isHidden = true
        submitBtn.isHidden = false
        showView(number: count)
    }
    

    @IBAction func gotoNextBtn(_ sender: Any) {
        bodyView.subviews.forEach({ $0.removeFromSuperview() })
        if count < ((viewModel?.displayType().count ?? 0) - 1) {
            count += 1
            showView(number: count)
            if count == ((viewModel?.displayType().count ?? 0) - 1) {
                submitBtn.isHidden = true
                mainSubmitBtn.isHidden = false
            }
        }
    }
    
    func showView(number:Int) {
        mesageCountLabel.text = "\(number + 1)/\(viewModel?.displayType().count ?? 0)"
        bodyView.subviews.forEach { value in
            value.fadeTransition(0.4)
        }
        if showSurvey(number: number)?.attributes?.displayType == "star" {
            suveyTitle.text = showSurvey(number: number)?.attributes?.text
            backGroundimage.sd_setImage(with: URL(string: showSurvey(number: number)?.attributes?.coverImageURL ?? ""))
            bodyView.addSubview(star)
            star.center = CGPoint(x: bodyView.frame.size.width  / 2,
                                         y: bodyView.frame.size.height / 2)
        } else if showSurvey(number: number)?.attributes?.displayType == "heart" {
            suveyTitle.text = showSurvey(number: number)?.attributes?.text
            backGroundimage.sd_setImage(with: URL(string: showSurvey(number: number)?.attributes?.coverImageURL ?? ""))
            bodyView.addSubview(heartView)
            heartView.center = CGPoint(x: bodyView.frame.size.width  / 2,
                                         y: bodyView.frame.size.height / 2)
        } else if showSurvey(number: number)?.attributes?.displayType == "smiley" {
            suveyTitle.text = showSurvey(number: number)?.attributes?.text
            backGroundimage.sd_setImage(with: URL(string: showSurvey(number: number)?.attributes?.coverImageURL ?? ""))
            bodyView.addSubview(thumbs)
            thumbs.center = CGPoint(x: bodyView.frame.size.width  / 2,
                                         y: bodyView.frame.size.height / 2)
        }
    }
   
    
    func showSurvey(number:Int) -> SingleSurveyIncluded? {
        if viewModel?.displayType().count == 0 {
            return nil
        } else {
            return viewModel?.displayType()[number]
        }
       
    }
    
    @IBAction func closeSurvey(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Warning!", message: "Are you sure you want to quit the survey?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
            self.dismiss(animated: true) {}
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitSurveyBtn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.openSuccessView()
        })
        dismiss(animated: true) {
            self.dismiss(animated: true)
        }
    }
    
    func openSuccessView() {
        let vc = SuccessPageViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
