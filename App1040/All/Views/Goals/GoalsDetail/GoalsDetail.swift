//
//  GoalsDetail.swift
//  App1040
//
//  Created by IGOR on 09/11/2024.
//

import SwiftUI

struct GoalsDetail: View {
    
    @StateObject var viewModel: GoalsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(viewModel.selectedGoal?.gName ?? "")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {

                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                            
                        })
                        
                        Spacer()

                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "trash.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .regular))
                        })
                    }
                }
                .padding(.vertical, 20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        Image(viewModel.selectedGoal?.gPhoto ?? "")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 290)
                            .overlay(
                            
                                VStack {
                                    
                                    HStack {
                                        
                                        Text(viewModel.selectedGoal?.gDate ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 5).fill(.black))
                                            .padding()
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                            )
                        
                        Text(viewModel.selectedGoal?.gName ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.selectedGoal?.gTitle ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
                    }
                }
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteGoal(withGName: viewModel.selectedGoal?.gName ?? "", completion: {
                            
                            viewModel.fetchGoals()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            viewModel.isDetail = false

                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    GoalsDetail(viewModel: GoalsViewModel())
}
