//
//  GoalsView.swift
//  App1040
//
//  Created by IGOR on 06/11/2024.
//

import SwiftUI

struct GoalsView: View {

    @StateObject var viewModel = GoalsViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Goals")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold))
                            .padding(4)
                            .background(Circle().fill(Color("prim")))
                    })
                }
                .padding(.bottom, 20)

                if viewModel.goals.isEmpty {
                    
                    VStack(spacing: 18) {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .semibold))
                        
                        Text("Click the button above to add goals")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                                            
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.goals, id: \.self) { index in
                                
                                    HStack {
                                        
                                        Image(index.gPhoto ?? "")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            Text(index.gName ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .semibold))
                                            
                                            Text(index.gDate ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 12, weight: .medium))
                                                .padding(6)
                                                .padding(.horizontal, 5)
                                                .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedGoal = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDetail = true
                                                }
                                                
                                            }, label: {
                                                
                                                Text("Open")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 45)
                                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
                                            })
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                                }
                            }
                            
                        }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchGoals()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddGoal(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            GoalsDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    GoalsView()
}
