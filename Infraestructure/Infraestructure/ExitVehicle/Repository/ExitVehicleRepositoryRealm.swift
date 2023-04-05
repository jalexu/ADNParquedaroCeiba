//
//  ExitVehicleRepositoryRealm.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 4/04/23.
//

import Domain
import Combine

final class ExitVehicleRepositoryRealm: ExitVehicleRepositoryProtocol {
    private var realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<Domain.ExitVehicle?, Error> {
        var exitVehicle: Domain.ExitVehicle?
        
        return Publishers.Zip(findCarDto(plaqueId: numerPlaque), findMotorcycleDto(plaqueId: numerPlaque))
            .flatMap { (registerCarDTO, registerMotorcycleDTO) in
                
                if let registerCarDto = registerCarDTO {
                    exitVehicle = ExitCarTraslator.registerCarDTOToExitCar(carDTO: registerCarDto)
                    return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
                }
                
                if let registerMotorcycleDto = registerMotorcycleDTO {
                    exitVehicle = ExitMotorcycleTraslator.motorcycleDtoToExitMotorcycle(motorcycleDTO: registerMotorcycleDto)
                    return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
                }
                
                return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
            }
            .eraseToAnyPublisher()
    }
    
    func findMotorcycleDto(plaqueId: String) -> AnyPublisher<RegisterMotorcycleDTO?, Never> {
        realmManager.fetchObject(plaqueId: plaqueId, RegisterMotorcycleDTO.self)
    }
    
    func findCarDto(plaqueId: String) -> AnyPublisher<RegisterCarDTO?, Never> {
        realmManager.fetchObject(plaqueId: plaqueId, RegisterCarDTO.self)
    }
    
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Publishers.Zip(deleteRegisterCarDTO(plaqueId: numerPlaque), deleteRegisterCarDTO(plaqueId: numerPlaque))
            .flatMap { (registerCarDTO, registerMotorcycleDTO)  in
                
                if registerCarDTO || registerMotorcycleDTO {
                    return CurrentValueSubject<Bool, Error>(true)
                }
                return CurrentValueSubject<Bool, Error>(false)
            }
            .eraseToAnyPublisher()
    }
    
    private func deleteRegisterMotorcycleDTO(plaqueId: String) -> AnyPublisher<Bool, Error> {
        realmManager.delete(plaqueId: plaqueId, RegisterMotorcycleDTO.self)
    }
    
    private func deleteRegisterCarDTO(plaqueId: String) -> AnyPublisher<Bool, Error> {
        realmManager.delete(plaqueId: plaqueId, RegisterCarDTO.self)
    }
}
