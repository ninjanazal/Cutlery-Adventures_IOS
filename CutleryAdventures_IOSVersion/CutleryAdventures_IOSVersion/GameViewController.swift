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

    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = Foundation.UserDefaults.standard
        let newScore = userDefaults.string(forKey: "t")
       
        if(newScore == nil){
            // label.text = "0"
        }else
        {
            // label.text = newScore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // criar uma instancia da gameScene
            //let scene = GameScene(size: view.bounds.size)
            let scene = MenuScene(size: view.bounds.size)
            
            // define o tipo de escalamento
            scene.scaleMode = .resizeFill
            // nao ignora ordem de parentesco
            view.ignoresSiblingOrder = true
            
            //MARK: DEBUG
            // mostra fps
            view.showsFPS = true
            // mostra node count
            view.showsNodeCount = true
            // mostra os rectangulos de colisao
            view.showsPhysics = true
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
