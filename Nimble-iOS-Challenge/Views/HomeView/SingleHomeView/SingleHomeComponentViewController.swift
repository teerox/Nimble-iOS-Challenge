//
//  SingleHomeComponentViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import UIKit
import SDWebImage
class SingleHomeComponentViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bigDateLabel: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var surveyTitle: UILabel!
    @IBOutlet weak var suveyDescription: UILabel!
    @IBOutlet weak var pagerTab: UIPageControl!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var proceedBtn: UIButton!
    
    let viewModel = HomeViewModel(apiClient: APIClient(cachedData:CacheData()))
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSurvey()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if count < viewModel.filterSurveyList().count - 1  {
            count += 1
            showSurvey(number: count)
        }
    }
    
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getUserData {
                DispatchQueue.main.async { [weak self] in
                    self?.userimage.sd_setImage(with: URL(string: self?.viewModel.userData?.attributes?.avatarURL ?? ""))
                }
            } onFailure: { error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.showAlert("Error", error)
                }
            } loading: { _ in }
        }
    }
    
    func loadSurvey() {
        let views = [ dateLabel , bigDateLabel , userimage, surveyTitle, suveyDescription, pagerTab]
        viewModel.getAllSurvey {
            DispatchQueue.main.async { [weak self] in
                self?.pagerTab.numberOfPages = self?.viewModel.filterSurveyList().count ?? 0
                self?.loadData()
                self?.showSurvey(number:self?.count ?? 0)
            }
        } onFailure: { error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert("Error", error)
            }
        } loading: { loading in
            DispatchQueue.main.async { [weak self] in
                if loading {
                    self?.proceedBtn.isHidden = true
                    self?.backgroundImage.image = UIImage(named: "black_background")
                    views.forEach { value in
                        value?.addSkeleton()
                    }
                } else {
                    self?.proceedBtn.isHidden = false
                    self?.backgroundImage.image = UIImage(named: "defaultBackground")
                    views.forEach { value in
                        value?.removeSkeleton()
                    }
                }
            }
        }
    }
    
    func showSurvey(number:Int) {
        let views = [ backgroundImage, surveyTitle, suveyDescription]
        let result = viewModel.filterSurveyList()[number]
        pagerTab.currentPage = number
        // This will fade:
        views.forEach { value in
            value?.fadeTransition(0.4)
        }
        surveyTitle.text = result.attributes?.title
        suveyDescription.text = result.attributes?.attributesDescription
        backgroundImage.sd_setImage(with: URL(string: result.attributes?.coverImageURL ?? ""))
    }
    
    
    
}
