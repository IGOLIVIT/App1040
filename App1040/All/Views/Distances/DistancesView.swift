//
//  DistancesView.swift
//  App1040
//
//  Created by IGOR on 06/11/2024.
//

import SwiftUI

struct DistancesView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Distances")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddRecord = true
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.currentDist = "All"
                            
                        }, label: {
                            
                            Text("All")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .padding(6)
                                .padding(.horizontal, 5)
                                .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.currentDist == "All" ? Color("prim") : .gray.opacity(0.5)))
                        })
                        
                        ForEach(viewModel.distances, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.currentDist = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(6)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.currentDist == index ? Color("prim") : .gray.opacity(0.5)))
                            })
                        }
                        
                    }
                }
                .frame(height: 50)
        
                if viewModel.records.isEmpty {
                    
                    VStack(spacing: 18) {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .semibold))
                        
                        Text("Click the button above to add distances")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    if viewModel.currentDist == "All" {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.records, id: \.self) { index in
                                
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        HStack {
                                            
                                            Text("\(index.trTime ?? "") min")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20, weight: .medium))
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedRec = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 17, weight: .regular))
                                            })
                                        }
                                        
                                        HStack {
                                            
                                            Image(systemName: "clock")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                         
                                            Text("\(index.trDist ?? "") M")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Spacer()
                                        }
                                        
                                        Text(index.trSP ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                                }
                            }
                        }
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.records.filter{($0.trDist ?? "") == viewModel.currentDist}, id: \.self) { index in
                                
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        HStack {
                                            
                                            Text("\(index.trTime ?? "") min")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20, weight: .medium))
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedRec = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 17, weight: .regular))
                                            })
                                        }
                                        
                                        HStack {
                                            
                                            Image(systemName: "clock")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                         
                                            Text("\(index.trDist ?? "") M")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Spacer()
                                        }
                                        
                                        Text(index.trSP ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchRecss()
        }
        .sheet(isPresented: $viewModel.isAddRecord, content: {
            
            AddDist(viewModel: viewModel)
        })
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
                        
                        CoreDataStack.shared.deleteRecord(withTrSP: viewModel.selectedRec?.trSP ?? "", completion: {
                            
                            viewModel.fetchRecss()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false

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
    DistancesView()
}
