//
//  RegisterVehicleRepositoryRealm.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Domain
import Combine

@_implementationOnly import RealmSwift

final class RegisterVehicleRepositoryRealm: RegisterVehicleRepository {
    
    private var realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func save(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        var vehicleDTO: Object
        if (data.getVehicle() as? Motorcycle) != nil {
            vehicleDTO = RegisterMotorcycleTraslator.toRegisterMotorcycleDTO(data: data)
        } else {
            vehicleDTO = RegisterCarTraslator.toRegisterCarDTO(data: data)
        }
        
        return realmManager.save(dto: vehicleDTO)
    }
    
    func retrieveByPlaque(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Publishers.Zip(findCarDto(plaqueId: numerPlaque), findMotorcycleDto(plaqueId: numerPlaque))
            .flatMap { (registerCarDTO, registerMotorcycleDTO)  in
                if registerCarDTO != nil {
                    return CurrentValueSubject<Bool, Error>(true)
                }
                
                if registerMotorcycleDTO != nil {
                    return CurrentValueSubject<Bool, Error>(true)
                }
                
                return CurrentValueSubject<Bool, Error>(false)
            }
            .eraseToAnyPublisher()
    }
    
    func retrieveAll() -> AnyPublisher<[RegisterVehicle], Error> {
        return Publishers.Zip(getCarDtos(), getMotorcycleDtos())
            .flatMap { (carsDto, motociclesDtos) in
                var registerVehicle: [RegisterVehicle] = []
                do {
                    let motorcycles = try RegisterMotorcycleTraslator
                        .motorcyclesDtoToRegisterVehicle(motorcyclesDTO: motociclesDtos)
                    let cars = try RegisterCarTraslator.carDtosToRegisterVehicle(carsDTO: carsDto)
                    
                    registerVehicle.append(contentsOf: motorcycles)
                    registerVehicle.append(contentsOf: cars)
                    
                    return CurrentValueSubject<[RegisterVehicle], Error>(registerVehicle)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func getMotorcycleDtos() -> AnyPublisher<[RegisterMotorcycleDTO], Never> {
        realmManager.fetchObjects(RegisterMotorcycleDTO.self)
    }
    
    private func getCarDtos() -> AnyPublisher<[RegisterCarDTO], Never> {
        realmManager.fetchObjects(RegisterCarDTO.self)
    }
    
    private func findMotorcycleDto(plaqueId: String) -> AnyPublisher<RegisterMotorcycleDTO?, Never> {
        realmManager.fetchObject(plaqueId: plaqueId, RegisterMotorcycleDTO.self)
    }
    
    private func findCarDto(plaqueId: String) -> AnyPublisher<RegisterCarDTO?, Never> {
        realmManager.fetchObject(plaqueId: plaqueId, RegisterCarDTO.self)
    }
}
