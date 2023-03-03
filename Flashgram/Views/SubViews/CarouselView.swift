//
//  CarouselView.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI

struct CarouselView: View {
    @State var selection: Int = 1
    let maxCount: Int = 8
    @State var timerAdded: Bool = false
    
    var body: some View {
        TabView(selection: $selection, content: {
            ForEach(1..<maxCount, id: \.self) { count in
                Image("image\(count)")
                    .resizable()
                    .scaledToFill()
                    .tag(count)
            }
        })
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
        .animation(.default)
        .onAppear(perform: {
            if !timerAdded {
                addTimer()
            }
        })
    }
    
    //MARK: Helper Functions
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            selection = (selection + 1) % maxCount
        }
        timer.fire()
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .previewLayout(.sizeThatFits)
    }
}
