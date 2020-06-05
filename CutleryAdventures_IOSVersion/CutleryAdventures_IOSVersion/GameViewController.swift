//
//  GameViewController.swift
//  CutleryAdventures_IOSVersion
//
//  Created by ninjanazal on 02/06/2020.
//  Copyright © 2020 OldTimers. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // criar uma instancia da gameScene
            let scene = GameScene(size: view.bounds.size)
            // define o tipo de escalamento
            scene.scaleMode = .resizeFill
            // ignora ordem de parentesco
            view.ignoresSiblingOrder = true
            // mostra fps
            view.showsFPS = true
            // mostra node count
            view.showsNodeCount = true
            
            // apresenta a cena
            view.presentScene(scene)
        }
    }

    // indica que nao deve rodar
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}