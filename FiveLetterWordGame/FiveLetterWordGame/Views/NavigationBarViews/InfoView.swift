//
//  InfoView.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/28/24.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .center, content: {
                    Text(StringCentral.infoParagraph1)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text(StringCentral.infoParagraph2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text(StringCentral.infoLine3)
                        .padding(.vertical, 5)
                    Image("InfoViewImg1")
                    Text(StringCentral.infoParagraph4)
                        .multilineTextAlignment(.center)
                        .padding()
                    Image("InfoViewImg2")
                    Text(StringCentral.infoLine5)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    Text(StringCentral.tipsTitle)
                        .padding(.vertical, 4)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(StringCentral.tipsList)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                        .navigationBarTitle(StringCentral.infoViewTitle, displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                        })
                    //.padding()
                    Spacer()
                })
            }
        }
    }
}

#Preview {
    InfoView()
}
