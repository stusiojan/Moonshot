//
//  MissionView.swift
//  Moonshot
//
//  Created by Jan Stusio on 14/03/2023.
//

import SwiftUI

struct MissionView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding()
                    
                    Text("Launch date \(mission.formattedLaunchDate)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.vertical, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronauts)
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(crew, id: \.role) { crewMember in
//                                NavigationLink {
//                                    AstronautView(astronaut: crewMember.astronaut)
//                                } label: {
//                                    HStack {
//                                        Image(crewMember.astronaut.id)
//                                            .resizable()
//                                            .frame(width: 104, height: 72)
//                                            .clipShape(Capsule())
//                                            .overlay(
//                                                Capsule()
//                                                    .strokeBorder(.white, lineWidth: 1)
//                                            )
//                                        
//                                        VStack(alignment: .leading) {
//                                            Text(crewMember.astronaut.name)
//                                                .foregroundColor(.white)
//                                                .font(.headline)
//                                            
//                                            Text(crewMember.role)
//                                                .foregroundColor(.white)
//                                                .opacity(0.5)
//                                                .font(.callout)
//                                        }
//                                    }
//                                    .padding(.horizontal)
//                                }
//                            }
//                        }
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(.lightBackground)
//                    }
                }
                .padding(.top)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[3], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
