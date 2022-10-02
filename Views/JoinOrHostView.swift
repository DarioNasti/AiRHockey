//
//  JoinOrHostView.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 19/07/22.
//

import SwiftUI


struct JoinOrHostView: View {
    @Binding var language : String
    @Binding var userName : String
    @EnvironmentObject var nearbyService : NearbyService
    @EnvironmentObject var nickTracker : NickViewModel
    @State var joining : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack
        {
            Button(JoinOrHostView.LANGUAGESDICTS[language]!["host"]!, action:{
                nickTracker.nickGiocatore1 = userName
                nearbyService.beginHosting()
                presentationMode.wrappedValue.dismiss()
            })
            .padding(EdgeInsets(
                top: 150, leading: 0, bottom: 0, trailing: 0))
            .font(
                .system(size: 25))
            Button(JoinOrHostView.LANGUAGESDICTS[language]!["join"]!, action:
                    {
                joining = true
                nickTracker.nickGiocatore2 = userName
                nearbyService.beginBrowsing()
            })
            .padding(EdgeInsets(
                top: 50, leading: 0, bottom: 200, trailing: 0))
            .font(.system(size: 25))
        }
        .sheet(isPresented: $joining, onDismiss: {presentationMode.wrappedValue.dismiss()}, content: {PeerView()})
    }
    
    static let WORDSEN = [
        "host":"Host",
        "join":"Join"
    ]
    
    static let WORDSIT = [
        "host":"Ospita",
        "join":"Partecipa"
    ]
    
    static var LANGUAGESDICTS = ["en" : WORDSEN,"it" : WORDSIT]
}
