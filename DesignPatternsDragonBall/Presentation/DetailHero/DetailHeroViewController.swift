//
//  DetailHeroViewController.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import UIKit

class DetailHeroViewController: UIViewController {
    
    private let viewModel: DetailHeroViewModel
    
    // MARK: - Outlets
    @IBOutlet private weak var heroImage: AsyncImage!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    // MARK: - Initializer
    
    init(viewModel: DetailHeroViewModel){
        self.viewModel = viewModel
        super.init(nibName: "DetailHeroView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super .viewDidLoad()
        bind()
        viewModel.loadHero()
        
    }
    
    // MARK: - Binding
    
    private func bind(){
        viewModel.onStateChanged.bind {[weak self] state in
            switch state {
                
            case .error(let reason):
                self?.renderError(reason)
            case .loading:
                self?.renderLoading()
            case .succcess:
                self?.renderSuccess()
            }
        }
    }
    
    // MARK: Stage management
    
    private func renderError(_ reason: String){} 
    private func renderLoading(){}
    
    private func renderSuccess(){
        
        guard let hero = viewModel.hero?.first else {
            return
        }
        
        heroImage.setImage(hero.photo)
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
    }
    
    
    
}
