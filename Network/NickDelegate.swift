//
//  NickDelegate.swift
//  FingerDragMultiplayer
//
//  Created by DarioNasti on 23/09/22.
//

import Foundation
import MultipeerConnectivity


class NickDelegate : NearbyServiceDelegate


{
    var session : MCSession
    var nearbyService : NearbyService
    var nickTracker : NickViewModel
    
    init(session : MCSession, nearbyService : NearbyService, nickTracker : NickViewModel)
    {
        self.session = session
        self.nearbyService = nearbyService
        self.nickTracker = nickTracker
    }
    
    func didReceive(msg: String) {
        print(msg)
        print("Sopra è il messaggio")
        let nomiStringati = msg.split(separator: ",")
        if nearbyService.isHost {
            nickTracker.nickGiocatore2 = String(nomiStringati[1])
            print("\(nickTracker.nickGiocatore1) VS \(nickTracker.nickGiocatore2) ")
        }
        else if nearbyService.isClient {
            nickTracker.nickGiocatore1 = String(nomiStringati[0])
        }

    }
    
}

