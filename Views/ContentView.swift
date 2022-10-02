//
//  ContentView.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import SwiftUI
import RealityKit
import MultipeerConnectivity
import Combine

struct ContentView : View {
    
    @EnvironmentObject var nearbyService : NearbyService
    @EnvironmentObject var pointTracker : PointsViewModel
    @EnvironmentObject var nickTracker : NickViewModel
    let victory = 1
    
    var body: some View {
        
        if nearbyService.isConnected
        {
            ZStack
            {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                VStack
                {
                    Spacer()
                    if pointTracker.punteggioGiocatore1 == victory {
                        if nearbyService.isHost{
                            Image(uiImage: UIImage(named: "Winner.jpeg")!)
                                .resizable()
                                .frame(width: 400, height: 300, alignment: .center)
                            Text("\(nickTracker.nickGiocatore1) won").bold()
                            .font(.system(size: 40))
                            
                        }
                        else if nearbyService.isClient {
                            Image(uiImage: UIImage(named: "GameOver.jpeg")!)
                                .resizable()
                                .frame(width: 300, height: 300, alignment: .center)
                            Text("\(nickTracker.nickGiocatore2) lost").bold()
                            .font(.system(size: 40))
                        }
                        Spacer()
                        Text("\(nickTracker.nickGiocatore1) : \(pointTracker.punteggioGiocatore1) \n\(nickTracker.nickGiocatore2) : \(pointTracker.punteggioGiocatore2)")
                            .font(.system(size: 30))
                        Spacer()
                        Spacer()
                    }
                    if pointTracker.punteggioGiocatore2 == victory {
                        if nearbyService.isHost {
                            Image(uiImage: UIImage(named: "GameOver.jpeg")!)
                                .resizable()
                                .frame(width: 300, height: 300, alignment: .center)
                            Text("\(nickTracker.nickGiocatore1) lost").bold()
                            .font(.system(size: 40))
                        }
                    else if nearbyService.isClient {
                        Image(uiImage: UIImage(named: "Winner.jpeg")!)
                            .resizable()
                            .frame(width: 400, height: 300, alignment: .center)
                        Text("\(nickTracker.nickGiocatore2) won").bold()
                        .font(.system(size: 40))
                    }
                    Spacer()
                    Text("\(nickTracker.nickGiocatore1) : \(pointTracker.punteggioGiocatore1)  \n\(nickTracker.nickGiocatore2) : \(pointTracker.punteggioGiocatore2)")
                            .font(.system(size: 30))
                    Spacer()
                    Spacer()
                        
                }
                    
                    if pointTracker.punteggioGiocatore1 < victory && pointTracker.punteggioGiocatore2 < victory {
                    Spacer()
                    Text("\(nickTracker.nickGiocatore1) : \(pointTracker.punteggioGiocatore1), \(nickTracker.nickGiocatore2) : \(pointTracker.punteggioGiocatore2)")
                    }
                }
            }
            
        }
        else
        {
            MenuView()
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var nearbyService : NearbyService
    @EnvironmentObject var pointTracker : PointsViewModel
    @EnvironmentObject var nickTracker : NickViewModel
    let victory = 1
    static var s : Cancellable?
    
    func makeUIView(context: Context) -> ARView {
        GoalComponent.registerComponent()
        
        
        let arView = ARView(frame: .zero)
        let arena = Arena(transformComponent: .init(scale: .one, rotation: .init(), translation: .zero ), movableComponent: .init(view: arView), isHost: nearbyService.isHost, nearbyService: nearbyService, pointTracker : pointTracker, nickTracker: nickTracker)

//        arView.debugOptions.update(with: .showPhysics)

        arView.scene.anchors.append(arena)
//        let anchor = AnchorEntity()
//        let ent : Entity
//        ent = AssetsRsources.piattino.clone(recursive: true)
//        anchor.children.append(ent)
//        arView.scene.anchors.append(anchor)
//        arView.installGestures(.all, for: ent as! HasCollision)
        print(arena)
        
        arena.activateChildren()
        
       
        arView.scene.synchronizationService = try?
        MultipeerConnectivityService(session: nearbyService.session )
        print(arena.dischetto.transform.translation)
        
//        if nearbyService.session.connectedPeers.count > 0 {
//            if nearbyService.isHost {
//                nearbyService.send(msg: "\(NearbyService.NICKDELEGATE)#\(nickTracker.nickGiocatore1),\(nickTracker.nickGiocatore2)")
//            }
//            else if nearbyService.isClient {
//                nearbyService.send(msg: "\(NearbyService.NICKDELEGATE)#\(nickTracker.nickGiocatore1),\(nickTracker.nickGiocatore2)")
//            }
//        }



//        ARViewContainer.s = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
//            
//            print("disco \(arena.dischetto.transform.translation)")
//            print(arena.pavimento.transform.translation)
////            
//        }
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if pointTracker.punteggioGiocatore1 == victory || pointTracker.punteggioGiocatore2 == victory {
            uiView.removeFromSuperview()
        }
    }
        
}


struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
