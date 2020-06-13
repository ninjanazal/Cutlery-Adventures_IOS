import SpriteKit
import GameKit

// scena de menu
class BackgroundScene : SKScene{
    //MARK: HardCodedValues
    var uiMargin : CGFloat = 0.02       // margem entre elementos de Ui
    var verticalPlacing : CGFloat = 0.1 // deslocamento vertical
    
    //MARK: SceneVars
    var cutleryAdventureLogo, backGroundImage : SKSpriteNode!
    var menuBtn : SKSpriteNode!
    var backgroundChoice1, backgroundChoice2, backgroundChoice3, backgroundChoice4 : SKSpriteNode!
    let userDefaults = Foundation.UserDefaults.standard
    
    override func didMove(to view: SKView) {
        // define a cor do fundo base
        backgroundColor = SKColor.white
        
        // inicia o menu
        InitMenu()
    }
    
    //MARK: Init MenuScene
    private func InitMenu(){
        // carrega elementos nao interactivos
        LoadNonInteractables()
        // carrega elementos interactivos
        LoadInteractables()
        LoadBackground()
    }
    
    //MARK: Init NonInteractables
    private func LoadNonInteractables(){
         let newBackground = userDefaults.string(forKey: "b")
        //MARK: Background Load
        // carrega e posiciona o background
        backGroundImage = SKSpriteNode(imageNamed: newBackground ?? "background")
        backGroundImage.name = "background"
        //define a posiçao do background, está centrado sobre a vista
        backGroundImage.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        // define o tamanho correcto para a imagem
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
        //MARK: Logo load
        // carrega e posiciona o logo
        cutleryAdventureLogo = SKSpriteNode(imageNamed: "CutleryAdventureLogo")
        // define a posiçao do logo, 80% da altura maxima
        cutleryAdventureLogo.position = CGPoint(x: frame.size.width / 2,
            y: frame.size.height * 0.95 - cutleryAdventureLogo.size.height / 2)
        // coloca o logo na frente
        cutleryAdventureLogo.zPosition = 5
        // adiciona o logo á cena
        self.addChild(cutleryAdventureLogo)
    }
        
    
    //MARK: Init Intectables
    private func LoadInteractables(){
        // determina a marger vertical
        self.uiMargin *= frame.size.height
        // determina o deslocamento vertical
        self.verticalPlacing *= frame.size.height
        
        // MARK: CreditsBtn
        // carrega a imagem do botao de play
        menuBtn = SKSpriteNode(imageNamed: "play_btn")
        // atribui um nome ao node
        menuBtn.name = "menuBtn"
        // define a escala do botao
        menuBtn.xScale = 0.4
        menuBtn.yScale = 0.8
        // define a posiçao do botao
        menuBtn.position = CGPoint(x: frame.size.width - menuBtn.size.width * 0.25,
                                      y: frame.size.height * 0.2)
        // coloca o botao na frente
        menuBtn.zPosition = 6
        
        // adiciona o botao á cena
        self.addChild(menuBtn)
        
        // MARK: bkg1
        // carrega a imagem do botao do bkg1
        backgroundChoice1 = SKSpriteNode(imageNamed: "background")
        // atribui um nome ao node
        backgroundChoice1.name = "background1"
        // define a escala do botao
        backgroundChoice1.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        // define a posiçao do botao
        backgroundChoice1.position =
            CGPoint(
                x: frame.size.width * 0.5 - backgroundChoice1.size.width * 0.5 - self.uiMargin,
                y: frame.size.height * 0.5 + backgroundChoice1.size.height * 0.5 + self.uiMargin - self.verticalPlacing)
        
        // coloca o botao na frente
        backgroundChoice1.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(backgroundChoice1)
        
        
        // MARK: bkg2
        // carrega a imagem do botao do bkg2
        backgroundChoice2 = SKSpriteNode(imageNamed: "background2")
        // atribui um nome ao node
        backgroundChoice2.name = "background2"
        // define a escala do botao
        backgroundChoice2.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        // define a posiçao do botao
        backgroundChoice2.position =
            CGPoint(x: frame.size.width * 0.5 + backgroundChoice2.size.width * 0.5 + self.uiMargin,
                    y: frame.size.height * 0.5 + backgroundChoice2.size.height * 0.5 + self.uiMargin - self.verticalPlacing)
        
        // coloca o botao na frente
        backgroundChoice2.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(backgroundChoice2)
        
        // MARK: bkg3
        // carrega a imagem do botao do bkg3
        backgroundChoice3 = SKSpriteNode(imageNamed: "background3")
        // atribui um nome ao node
        backgroundChoice3.name = "background3"
        // define a escala do botao
        backgroundChoice3.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        // define a posiçao do botao
        backgroundChoice3.position =
            CGPoint(
                x: frame.size.width * 0.5 - backgroundChoice3.size.width * 0.5 - self.uiMargin,
                y: frame.size.height * 0.5 - backgroundChoice3.size.height * 0.5 - self.uiMargin - self.verticalPlacing)
        
        // coloca o botao na frente
        backgroundChoice3.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(backgroundChoice3)
        
        
        
        // MARK: bkg4
        // carrega a imagem do botao do bkg4
        backgroundChoice4 = SKSpriteNode(imageNamed: "background4")
        // atribui um nome ao node
        backgroundChoice4.name = "background4"
        // define a escala do botao
        backgroundChoice4.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        // define a posiçao do botao
        backgroundChoice4.position =
            CGPoint(
                x: frame.size.width * 0.5 + backgroundChoice4.size.width * 0.5 + self.uiMargin,
                y: frame.size.height * 0.5 - backgroundChoice4.size.height * 0.5 - self.uiMargin - self.verticalPlacing)
        // coloca o botao na frente
        backgroundChoice4.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(backgroundChoice4)
    }
    
    
    //MARK: Touch response
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guarda o primeiro toque da lista, caso exista
        guard let touch = touches.first else {return}
        // guarda a localizaçao do toque
        let touchLocation = touch.location(in: self)
        // guarda o node em que ocorreu o toque
        let touchedNode = atPoint(touchLocation)
        
        // avalia de acordo com o nome do node em que tocou
        switch touchedNode.name {
        case "playButton":
            return
        case "menuBtn":
            // troca para a scena de creditos
            SwitchToMainMenu()
        case "background1":
            SaveBackground(background: "background")
            LoadBackground()
        case "background2":
            SaveBackground(background: "background2")
            LoadBackground()
        case "background3":
            SaveBackground(background: "background3")
            LoadBackground()
        case "background4":
            SaveBackground(background: "background4")
            LoadBackground()
        default:
            // caso nao tenha tocado em nenhum node relevante
            return
        }
    }
    
    
    // metodo para trocar para creditos
    private func SwitchToMainMenu(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a scena a carregar
        let scene = MenuScene(size: size)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene,transition: transition)
    }
    
    
    
    func SaveBackground(background: String){
        //let newBackground = background
        userDefaults.set((background), forKey: "b")
    }
    
    func LoadBackground(){
        backGroundImage.removeFromParent()
        
        let newBackground = userDefaults.string(forKey: "b")
        //MARK: Background Load
        // carrega e posiciona o background
        backGroundImage = SKSpriteNode(imageNamed: newBackground ?? "background")
        backGroundImage.name = "background"
        //define a posiçao do background, está centrado sobre a vista
        backGroundImage.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        // define o tamanho correcto para a imagem
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
    }
}
