//
//  SwiftUIView.swift
//  FingerDragMultiplayer
//
//  Created by DarioNasti on 22/09/22.
//

import SwiftUI


struct UsernameView: View {
    @State var showingMultiView : Bool = false
    @State private var userName = ""
    @State var language = "en"
    @EnvironmentObject var nearbyService : NearbyService
    
    var body: some View {
        NavigationView{
            VStack(content: {
                Spacer()
                Section(header:Text("Username: ")){
                    TextField("Player", text: $userName).multilineTextAlignment(.center)
                }
                Button(action:{
                    if userName != "" {
                        showingMultiView.toggle()
                    }
                }) {
                    Text("Next")
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .padding(EdgeInsets(
                    top: 50, leading: 0, bottom: 100, trailing: 0))
                .font(.system(size: 25))
                Spacer()
            })
        }
        .sheet(isPresented: $showingMultiView, content: {MultiSheet(language: $language, userName: $userName)})
        }
}

struct MultiSheet: View {
    @Binding var language : String
    @Binding var userName : String
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        VStack{
            JoinOrHostView(language: $language, userName: $userName)
            Button(MenuView.LANGUAGESDICTS[language]!["close"]!, action: closeSheet)
                .font(.system(size: 20))
        }
        .interactiveDismissDisabled()
    }
    func closeSheet() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}


