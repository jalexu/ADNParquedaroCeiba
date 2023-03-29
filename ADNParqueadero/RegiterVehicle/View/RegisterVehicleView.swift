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
    
    @Environment(\.presentationMode) var presentation
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var registerButtonView: some View {
        Button {
            if viewModel.state.seletedVehicleType == .car {
                viewModel.registerCar {
                    presentation.wrappedValue.dismiss()
                }
            } else {
                viewModel.registerMotocicle {
                    presentation.wrappedValue.dismiss()
                }
            }
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
    var body: some View {
        ZStack{
            VStack {
                ScrollView {
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            Text("Cantidad carros parqueados: ")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text(String(viewModel.state.numersOfCars))
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        HStack(spacing: 5) {
                            Text("Catidad motos parqueadas:")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text(String(viewModel.state.numersOfMotocicles))
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding([.top, .trailing, .leading], 20)
                    
                    Text("Ingrese datos del vehículo")
                        .fontWeight(.black)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding([.top, .trailing, .leading], 20)
                    
                    
                    VStack(spacing: 20) {
                        TextField(Constants.Labels.enterPlaque, text: $viewModel.state.inputPlaque)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.top, .trailing, .leading], 20)
                            .font(.system(size: 24))
                            .keyboardType(.asciiCapable)
                        
                        VStack(spacing: 0) {
                            Text(Constants.Labels.selectTypeVehicle)
                                .foregroundColor(.gray)
                            Picker(Constants.Labels.typeVehicle, selection: $viewModel.state.seletedVehicleType) {
                                ForEach(VehicleType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding([.top, .bottom, .trailing, .leading], 20)
                        
                        TextField("Ingresa cilindraje", text: $viewModel.state.inputCylinderCapacity)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 24))
                            .padding([.trailing, .leading], 20)
                            .opacity(viewModel.state.seletedVehicleType == .motocicle ? 1 : 0)
                        
                        Spacer()
                        
                        registerButtonView
                            .padding(.bottom, 50)
                        
                    }
                    .onAppear {
                        viewModel.onAppear()
                    }
                    .onDisappear {
                        viewModel.onDisappear()
                    }
                    .alert(isPresented: $viewModel.state.showAlert) {
                        Alert(
                            title: Text(Constants.Labels.noParkingMessage),
                            message: Text(viewModel.state.message),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
            .background(Color("ColorBackground").ignoresSafeArea(.all,edges: [.bottom, .leading, .trailing]))
        }
        .navigationTitle("Parqueadero ADN")
    }
}
