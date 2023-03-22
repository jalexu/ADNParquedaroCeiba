//
//  BaseViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import RappleProgressHUD

class BaseViewModel {
    init() {}
    
    var loading: Bool = false {
        didSet {
            if loading {
                RappleActivityIndicatorView.startAnimating()
            } else {
                RappleActivityIndicatorView.stopAnimation(
                    completionIndicator: .success,
                    completionLabel: "Completado",
                    completionTimeout: 1.0)
            }
        }
    }
}
