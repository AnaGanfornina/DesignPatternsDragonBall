//
//  HeroListViewController.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import UIKit

class HeroesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel:  HeroesListViewModel
    
    // MARK: - Outlets
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Initializer
    init(viewModel: HeroesListViewModel){
        self.viewModel = viewModel
        super.init(nibName: "HeroesListView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super .viewDidLoad()
        bind()
        viewModel.loadHeroes()
        //Conformamos el delegado de la tabla
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeroCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: HeroCell.reuseIdentifier)
    }
    
    // MARK: - IBActions
    @IBAction func onRetryButtonTapped(_ sender: UIButton) {
        viewModel.loadHeroes()
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
    
    // MARK: - State rendering
    
    private func renderError(_ reason: String){
        errorLabel.text = reason
        errorStackView.isHidden = false
        activityIndicator.stopAnimating()
    }
    private func renderLoading(){
        errorStackView.isHidden = true
        activityIndicator.startAnimating()
    }
    private func renderSuccess(){
        errorStackView.isHidden = true
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    
    //MARK: - UITableViewDataSource conformance
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.heroes.count // numero de celdas que tenemos
    }
    
    // Le damos el tamaño a la vista
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        HeroCell.height
    }
    
    //Como le damos el elemento a la vista
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.reuseIdentifier)
        if let cell = cell as? HeroCell {
            let hero = viewModel.heroes[indexPath.row]
            //Le metemos los datos que estan en una función de HeroCell
            cell.setData(name: hero.name, photo: hero.photo)
        }
        return cell ?? UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    //son las funciones del delegado
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navega al detalle // TODO: Navega al detalle
    }
    
}
