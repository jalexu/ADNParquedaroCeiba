//
//  ExitVehicleRepositoryRealm.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 4/04/23.
//

import Domain
import Combine
import CoreData

@_implementationOnly import RealmSwift

final class ExitVehicleRepositoryRealm: ExitVehicleRepositoryProtocol {
    private var realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<Domain.ExitVehicle?, Error> {
        return Publishers.Zip(findCarDto(plaqueId: numerPlaque), findMotorcycleDto(plaqueId: numerPlaque))
            .flatMap { (registerCarDTO, registerMotorcycleDTO)   in
                
                var exitVehicle: Domain.ExitVehicle?
                if let registerCarDto = registerCarDTO {
                    exitVehicle = ExitCar(plaqueId: registerCarDto.plaqueId,
                                          registerDay: registerCarDto.registerDay,
                                          exitDate: Date())
                    return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
                }
                
                if let registerMotorcycleDto = registerMotorcycleDTO {
                    exitVehicle = ExitMotorcycle(plaqueId: registerMotorcycleDto.plaqueId,
                                                 registerDay: registerMotorcycleDto.registerDay,
                                                 exitDate: Date(),
                                                 cylinderCapacity: registerMotorcycleDto.cylinderCapacity)
                    return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
                }
                
                return CurrentValueSubject<Domain.ExitVehicle?, Error>(exitVehicle)
            }
            .eraseToAnyPublisher()
    }
    
    private func findMotorcycleDto(plaqueId: String) -> AnyPublisher<RegisterMotorcycleDTO?, Never> {
        realmManager.fetchObject(plaqueId: plaqueId, RegisterMotorcycleDTO.self)
    }
    
    private func findCarDto(plaqueId: String) -> AnyPublisher<RegisterCarDTO?, Never> {
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
