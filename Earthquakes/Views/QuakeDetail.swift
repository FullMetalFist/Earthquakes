//
//  QuakeDetail.swift
//  Earthquakes-iOS
//
//  Created by Michael Vilabrera on 5/25/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    @State var precisionHigh = false
    @EnvironmentObject private var quakesProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color).ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted(date: .complete, time: .standard))")
                .foregroundStyle(Color.secondary)
            if let location = self.location {
                let displayLatitude = precisionHigh ? "\(location.latitude)" : location.latitude.formatted(.number.precision(.fractionLength(3)))
                let displayLongitude = precisionHigh ? "\(location.longitude)" : location.longitude.formatted(.number.precision(.fractionLength(3)))
                Text("Latitude: \(displayLatitude)")
                Text("Longitude: \(displayLongitude)")
            }
        }.task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
        .onTapGesture {
            precisionHigh.toggle()
        }
    }
}

struct QuakeDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuakeDetail(quake: Quake.preview)
    }
}
