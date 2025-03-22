//
//  LoginViewController.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 22/3/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    // MARK: - Outlets

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: - Initializer
    init(viewModel: LoginViewModel){
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - Binding
    
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .error(let reason): self?.renderError(reason)
            case .loading: self?.renderLoading()
            case .success: self?.renderSuccess()
            }
        }
    }
    
    // MARK: - IBActions
    
    /// Para emitir enventos al ViewModel, cuando pulse el botón la vista invoca el proceso de login del ViewModel
    @IBAction func onButtonTapped(_ sender: UIButton) {
        viewModel.login(username: usernameField.text, password: passwordField.text)
    }
    
    // MARK: Stage management
    //Renderizado de cada uno de los estados dividido por funciones. Para luego llamarlas desde el bind()
    
    
    private func renderSuccess(){
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        errorLabel.isHidden = true
    }
    
    private func renderLoading(){
        activityIndicator.startAnimating()
        loginButton.isHidden = true
        errorLabel.isHidden = true
    }
    private func renderError(_ message: String){
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
}
