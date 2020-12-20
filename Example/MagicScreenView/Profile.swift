//
//  Profile.swift
//  MagicScreenView_Example
//
//  Created by Serhii Matvieiev on 16.12.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

struct Profile {
    
    enum Action {
        case profileImage, compatibility, natalChart, freeformQuestion, bestTime
        
        var frame: CGRect {
            switch self {
            case .profileImage: return CGRect(x: 141, y: 72, width: 94, height: 94)
            case .compatibility: return CGRect(x: 16, y: 336, width: 343, height: 38)
            case .natalChart: return CGRect(x: 16, y: 390, width: 343, height: 38)
            case .freeformQuestion: return CGRect(x: 16, y: 444, width: 343, height: 38)
            case .bestTime: return CGRect(x: 16, y: 498, width: 343, height: 38)
            }
        }
        
        var name: String {
            switch self {
            case .profileImage: return "Profile image"
            case .compatibility: return "Compatibility"
            case .natalChart: return "Natal chart"
            case .freeformQuestion: return "Freeform question"
            case .bestTime: return "Best time"
            }
        }
    }
    
    let image = UIImage(named: "profileRosalie")
    let actions: [Action] = [.profileImage, .bestTime, .freeformQuestion, .compatibility, .natalChart]
}
