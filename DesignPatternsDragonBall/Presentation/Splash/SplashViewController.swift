//
//  SplashViewController.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 19/3/25.
//

import UIKit


// Escucha los cambios de estado del ViewModel
final class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModel
    
    // MARK: - Outlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Initializer
    init(viewModel: SplashViewModel){
        self.viewModel = viewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        // llamamos a la función de carga del ViewModel
        // lo usamos en el viewDidLoad para que no se llame n veces
        viewModel.load()
    }
    
    // MARK: - Binding
    
    /// Nos vamos a "suscribir" a los cambios del ViewModel
    private func bind() {
        viewModel.onStateChanged.bind {[weak self] state in
            
            //Estamos observando los cambios de estado de una pantalla
            switch state {
            case .loading:
                print("Cargando") //TODO: Quitar estos prints
                self?.setAnimation(true)
            case .error:
                print("Terminado")
                self?.setAnimation(false)
            case .ready:
                self?.setAnimation(false)
                //Navegamos al login
                self?.present(LoginBuilder().build(), animated: true)
            }
        }
    }
    
    
    
    // MARK: - UI operation
    
    ///Función que permite arrancar y parar el activityIndicator
    private func setAnimation(_ animating: Bool) {
        switch activityIndicator.isAnimating{
        case true where !animating:
            activityIndicator.stopAnimating()
        case false where animating:
            activityIndicator.startAnimating()
        default: break
        }
    }
}
/*
#Preview {
    SplashBuilder().build()
}
*/
