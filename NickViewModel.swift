//
//  NickViewModel.swift
//  FingerDragMultiplayer
//
//  Created by DarioNasti on 23/09/22.
//

import Foundation

class NickViewModel : ObservableObject
{
    @Published var nickGiocatore1 : String = "Avversario"
    @Published var nickGiocatore2 : String = "Avversario"
}
