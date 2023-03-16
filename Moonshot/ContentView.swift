//
//  ContentView.swift
//  Moonshot
//
//  Created by Jan Stusio on 13/03/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    

    
    @State private var isShowingGrid = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    ScrollView {
                        GridLayout()
                    }
                } else {
                    List(missions) { mission in
                        NavigationLink { //it could be a seperate view
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                        .listRowBackground(Color.darkBackground)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button("Change view mode", action: changeView)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
    func changeView() {
        isShowingGrid.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
