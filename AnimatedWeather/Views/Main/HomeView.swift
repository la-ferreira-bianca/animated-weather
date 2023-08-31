//
//  HomeView.swift
//  AnimatedWeather
//
//  Created by Bianca Ferreira on 31/08/23.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: Background Color
                Color.background
                    .ignoresSafeArea()
                
                //MARK: Background image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                //MARK: House image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                        
                        Text("H: 24 L:18")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                
                //MARK: BottomSheet
                BottomSheetView(position: $bottomSheetPosition) {
//                    Text(bottomSheetPosition.rawValue.formatted())
                } content: {
                    ForecastView()
                }

                
                
                //MARK: TabBar
                TabBar(action: {
                    bottomSheetPosition = .top
                })
            }
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostly Clear")
        
        if let temp = string.range(of: "19°"),
           let weather = string.range(of: "Mostly Clear") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
            
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
