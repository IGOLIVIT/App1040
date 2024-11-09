//
//  AddDist.swift
//  App1040
//
//  Created by IGOR on 07/11/2024.
//

import SwiftUI

struct AddDist: View {

    @StateObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New distances")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.trSP = ""
                            viewModel.trTime = ""
                            viewModel.distForAdd = ""
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                            
                        })
                        
                        Spacer()

                    }
                }
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        Text("Swim pool")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.trSP.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.trSP)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.4)))
                        
                        Text("Time")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("2,45")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.trTime.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.trTime)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.4)))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                
                                Button(action: {
                                    
                                    viewModel.distForAdd = "All"
                                    
                                }, label: {
                                    
                                    Text("All")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .regular))
                                        .padding(6)
                                        .padding(.horizontal, 5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.distForAdd == "All" ? Color("prim") : .gray.opacity(0.5)))
                                })
                                
                                ForEach(viewModel.distances, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.distForAdd = index
                                        
                                    }, label: {
                                        
                                        Text(index)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.distForAdd == index ? Color("prim") : .gray.opacity(0.5)))
                                    })
                                }
                                
                            }
                        }
                        .frame(height: 50)

                    }
                }
                
                Button(action: {
                    
                    viewModel.trDist = viewModel.distForAdd
                    
                    viewModel.addRec()
                    
                    viewModel.trSP = ""
                    viewModel.trTime = ""
                    viewModel.distForAdd = ""
                    
                    viewModel.fetchRecss()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAddRecord = false
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                })
                .opacity(viewModel.distForAdd.isEmpty || viewModel.trSP.isEmpty || viewModel.trTime.isEmpty ? 0.5 : 1)
                .disabled(viewModel.distForAdd.isEmpty || viewModel.trSP.isEmpty || viewModel.trTime.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddDist(viewModel: HomeViewModel())
}
