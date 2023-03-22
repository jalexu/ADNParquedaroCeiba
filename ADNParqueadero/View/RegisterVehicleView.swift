//
//  RegisterVehicleView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import SwiftUI
import Domain
import Combine


struct RegisterVehicleView<ViewModel>: View where ViewModel: RegisterVehicleProtocol {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
   
    var navigationTitleView: some View {
        HStack(spacing: 4) {
            Spacer()
            Text("Parqueadero ADN")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
            Image(systemName: "flag.2.crossed")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 10, alignment: .center)
            Spacer()
        }
    }
    
    var registerButtonView: some View {
        Button {
            viewModel.registerVehicle()
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Text("Registar vehículo")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        
    }
    
    var retrieveVehiclesButtonView: some View {
        Button {
            viewModel.retrieveVehicle()
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Text("Obtener vehículos")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        
    }
    var body: some View {
        ZStack{
            VStack {
                navigationTitleView
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y:5)
                
                
                VStack(spacing: 20) {
                    TextField("Ingresa la placa", text: $viewModel.state.inputPlaque)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.top, .trailing, .leading], 20)
                    
                    VStack(spacing: 0) {
                        Text("Seleccione el tipo de vehículo a ingresar")
                            .foregroundColor(.gray)
                        Picker("Tipo de vehículo", selection: $viewModel.state.seletedVehicleType) {
                            ForEach(VehicleType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding([.trailing, .leading], 20)
                    
                    TextField("Ingresa cilindraje", text: $viewModel.state.inputCylinderCapacity)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.trailing, .leading], 20)
                    
                    Spacer()
                    
                    registerButtonView
                    
                    retrieveVehiclesButtonView
                    
                }
                .alert(isPresented: $viewModel.state.showMessagePlaqueA) {
                    Alert(
                        title: Text("No se puede parquear"),
                        message: Text(viewModel.state.messagePlaqueA),
                        dismissButton: .cancel(Text("OK"))
                    )
                }
                .padding(.bottom, 50)
                
            }
            .background(Color("ColorBackground").ignoresSafeArea(.all,edges: .all))
        }
        .ignoresSafeArea(.all)
    }
}
