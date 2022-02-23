//
//  TakeSurveyViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import UIKit

class TakeSurveyViewController: UIViewController {
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    var surveyId: String?
    var homeDatum: HomeDatum?
    let viewModel = HomeViewModel(apiClient: APIClient(cachedData:CacheData()))
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleName.text = homeDatum?.attributes?.title
        descriptionName.text = homeDatum?.attributes?.attributesDescription
        backGroundImage.sd_setImage(with: URL(string: homeDatum?.attributes?.coverImageURL ?? ""))
        loadSurvey()
    }
    
    func loadSurvey() {
        let progressBar = Loader(text: "Please Wait")
        self.view.addSubview(progressBar)
        viewModel.getUserSurvey(id: surveyId ?? "") {
        
        } onFailure: { error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert("Error", error)
            }
        } loading: { loading in
            DispatchQueue.main.async {
                if loading {
                    progressBar.show()
                } else {
                    progressBar.hide()
                }
            }
        }
    }
    
    
    @IBAction func goBackHome(_ sender: UIButton) {
        dismiss(animated: true) {}
    }
    
    @IBAction func startSurvey(_ sender: UIButton) {
        if viewModel.displayType().isEmpty {
            showAlert("Survey", "Survey Not available")
        } else {
            let vc = SuveyViewController()
            vc.viewModel = viewModel
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
