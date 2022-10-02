//
//  HasNickname.swift
//  FingerDragMultiplayer
//
//  Created by DarioNasti on 29/09/22.
//

import Foundation
import Combine
import RealityKit

struct NickComponent : Component
{
    var nickSubscription : Cancellable?
    var nickTracker : NickViewModel
    var arena : Arena

}

protocol HasNickname { }

extension HasNickname where Self: Entity
{
    var nickname : NickComponent? {
        get {self.components[NickComponent.self]}
        set {self.components[NickComponent.self] = newValue}
    }
}

extension HasNickname where Self: HasNetwork
{
    func addNickname(){
        
        guard let scene = self.scene, let nickname = self.nickname, let network = self.network else {
            return
        }
        
        let nearbyService = network.networkSender
        let nickTracker =  nickname.nickTracker
        
        self.nickname?.nickSubscription = scene.subscribe(to: SceneEvents.Update.self, on: self) { event in
            print("SONO QUI")
            nearbyService.send(msg: "\(NearbyService.NICKDELEGATE)#\(nickTracker.nickGiocatore1),\(nickTracker.nickGiocatore2)")
        }
    }
}
