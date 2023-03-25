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
    var body: some View {
        ZStack{
            VStack {
                navigationTitleView
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y:5)
                    .frame(maxWidth: .infinity)
                ScrollView {
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            Text("Cantidad carros parqueados:")
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
                        TextField("Ingresa la placa", text: $viewModel.state.inputPlaque)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.top, .trailing, .leading], 20)
                            .font(.system(size: 24))
                        
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
                            title: Text("No se puede parquear"),
                            message: Text(viewModel.state.message),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
            .background(Color("ColorBackground").ignoresSafeArea(.all,edges: .all))
        }
        .ignoresSafeArea(.all)
    }
}
