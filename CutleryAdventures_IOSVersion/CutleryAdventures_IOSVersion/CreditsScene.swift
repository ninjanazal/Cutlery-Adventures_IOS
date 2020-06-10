import SpriteKit
import GameKit

class CreditsScene : SKScene{
    //MARK: HardCoded vars
    let textMargin : CGFloat = 30
    let userDefaults = Foundation.UserDefaults.standard
    //MARK: Scene Vars
    var cutleryAdventureLogo, backGroundImage : SKSpriteNode!
    var goBackBtn : SKSpriteNode!
    var makersLabel, euricoLabel, franciscoLabel : SKLabelNode!
    
    override func didMove(to view: SKView) {
        // define a cor do fundo
        backgroundColor = .gray
        
        // inicia a cena
        InitScene()
    }
    
    //MARK: Init CreditsScene
    private func InitScene(){
        //MARK: Logo Load
        // carrega e posiciona o logo
        cutleryAdventureLogo = SKSpriteNode(imageNamed: "CutleryAdventureLogo")
        // define a posiçao do logo, 80% da altura maxima
        cutleryAdventureLogo.position = CGPoint(x: frame.size.width / 2,
            y: frame.size.height * 0.95 - cutleryAdventureLogo.size.height / 2)
        // coloca o logo na frente
        cutleryAdventureLogo.zPosition = 5
        // adiciona o logo á cena
        self.addChild(cutleryAdventureLogo)
        
        let newBackground = userDefaults.string(forKey: "b")
        //MARK: Background Load
        // carrega e posiciona o background
       backGroundImage = SKSpriteNode(imageNamed: newBackground ?? "background")
        //define a posiçao do background, está centrado sobre a vista
        backGroundImage.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        // define o tamanho correcto para a imagem
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
        //MARK: Load Label
        LoadLabels()
        
        //MARK: Load GOBack btn
        // inicia o gobackbtn
        goBackBtn = SKSpriteNode(imageNamed: "play_btn")
        // define o nome do btn
        goBackBtn.name = "goBackBtn"
        // para reciclar a sprite, inverte a escala sobre x
        goBackBtn.xScale = -0.4
        goBackBtn.yScale = 0.8
        goBackBtn.color = .gray
        // define a posiçao do botao
        goBackBtn.position = CGPoint(x: goBackBtn.size.width * 0.25, y: frame.size.height * 0.2)
        // coloca o botao na frente
        goBackBtn.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(goBackBtn)
    }
    
    // carrega as labels
    private func LoadLabels(){
        // define o texto da lable
        makersLabel = SKLabelNode(text: "Made By:")
        // define a posiçao da label
        makersLabel.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.55)
        // define o tamanho da font
        makersLabel.fontSize = 43
        // define a cor do texto
        makersLabel.color = .white
        // coloca a label na frente
        makersLabel.zPosition = 5
        
        // eurico label
        euricoLabel = SKLabelNode(text: "Eurico Martins")
        // define o tamano da font
        euricoLabel.fontSize = 43
        // define a posiçao com base no texto anterior
        euricoLabel.position = CGPoint(x: frame.size.width * 0.5,
                                       y: makersLabel.position.y - makersLabel.frame.height / 2 - euricoLabel.frame.height / 2 - textMargin)
        
        // define a cor do texto
        euricoLabel.color = .white
        //coloca na frente o texto
        euricoLabel.zPosition = 5
        
        // francisco label
        franciscoLabel = SKLabelNode(text: "Francisco Borges")
        // define o tamano da font
        franciscoLabel.fontSize = 43
        // define a posiçao da label
        franciscoLabel.position = CGPoint(x: frame.size.width * 0.5,
                                          y: euricoLabel.position.y - euricoLabel.frame.height / 2 - franciscoLabel.frame.height / 2 - textMargin)
        // define a cor do texto
        franciscoLabel.color = .white
        // coloca na frente o texto
        franciscoLabel.zPosition = 5
        
        
        // adiciona a label á cena
        self.addChild(makersLabel)
        self.addChild(euricoLabel)
        self.addChild(franciscoLabel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guarda o primeiro toque da lista, caso exista
        guard let touch = touches.first else {return}
        // guarda a localizaçao do toque
        let touchLocation = touch.location(in: self)
        // guarda o node em que ocorreu o toque
        let touchedNode = atPoint(touchLocation)
        
        // avalia de acordo com o nome do node em que tocou
        switch touchedNode.name {
        case "goBackBtn":
            // troca de scena para a de jogo
            LoadMenuScene()
        default:
            // caso nao tenha tocado em nenhum node relevante
            return
        }
    }
    
    //MARK: Load MenuScene
    private func LoadMenuScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .right, duration: 0.6)
        // define a scena a carregar
        let scene = MenuScene(size: size)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
}
