import SpriteKit
import GameplayKit

// dependendia da
var recordData:String!
var right:Bool = false
var left:Bool = false

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all  : UInt32 = UInt32.max
    static let grandpa : UInt32 = 0b1 // 1
    static let floor : UInt32 = 0b10 // 2
}

// dependendia da
class GameScene: SKScene, SKPhysicsContactDelegate {
    //MARK: HardCoded Vars
    var scrollSpeed : CGFloat = 100 // velocidade de scroll das plataformas
    
    //MARK: Scene Vars
    var backGroundImage : SKSpriteNode!
    var platformTexture : SKTexture!        // textura das plataformas
    var platformsDistance : CGFloat = 0.3   // distancia entre as plataformas
    var platforms = [Obstacle]()            // array vazio de plataformas
    var justTaplabel : SKLabelNode!         // label que indica para o jogador carregar
    //MARK: Logic Vars
    private var lastUpdateTime : CGFloat = 0    // tempo do ultimo update
    private var startPlaying : Bool = false     // indica se o jogo começou
    
    //MARK: ONLoad
    override func didMove(to view: SKView) {
        // define a cor do fundo base
        backgroundColor = SKColor.gray
        // inicia elementos da cena
        InitScene()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // determina o tempo do frame
        let deltaTime = CGFloat(currentTime) - lastUpdateTime
        
        if(startPlaying){
            // actualiza as plataformas
            UpdateObstacles(deltaTime: deltaTime)
        }
        // atualiza o tempo do fram
        lastUpdateTime = CGFloat(currentTime)
    }
    //MARK: Late update
    // no final do ciclo, verifica se as plataformas estao posicionadas correctamente
    override func didFinishUpdate() {
        // verifica se o primeiro elemento está dentro dos limites
        if(!platforms[0].IsInsideScreen(frame: frame)){
            // se nao estiver este
            platforms[0].RemoveFromScene(scene: self)
            // remove do array
            platforms.removeFirst()
            // adiciona uma nova plataforma no final
            CreateNewObstacle()
        }
    }
    
    //MARK: Init
    private func InitScene(){
        // inicia o background da cena
        backGroundImage = SKSpriteNode(imageNamed: "background")
        // define a posiçao da imagem
        backGroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        // define o tamanho do fundo para se adaptar ao ecra
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        backGroundImage.zPosition = 1
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
        // gera a label para mostrar ao jogador para iniciar
        justTaplabel = SKLabelNode(text: "Just Tap!")
        // define o tamanho da fonte
        justTaplabel.fontSize = 45
        // define a posiçao da label
        justTaplabel.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        // defina a cor da label
        justTaplabel.color = .white
        // coloca na frente
        justTaplabel.zPosition = 10
        
        // adiciona a label á cena
        self.addChild(justTaplabel)
        
        // gera plataformas
        GeneratePlatforms()
    }
    
    //MARK: Iniciador de plataformas
    // metodo que inicia as plataformas
    private func GeneratePlatforms(){
        // define a distancia em pixels entre plataformas de acordo com o tamanho do ecra
        platformsDistance *= frame.height
        // determina quantas plataformas devem ser geradas de acordo com o tamanho do ecra
        // é adicionado um buffer para plataformas que se encontrem fora de vista
        let platformCount : Int = Int(floor(frame.height / platformsDistance)) + 1
        // carrega a textura
        platformTexture = SKTexture(imageNamed: "segment")
        
        // para a quantidade de plataformas determinadas, criar um obstaculo
        for i in 0 ..< platformCount{
            // cria um obj
            // caso seja a primeira plataforma, define a posiçao inicial
            platforms.append(
                Obstacle(lastPlatformHeight: (i == 0) ?
                    frame.height - platformsDistance * 0.15 : platforms[i-1].obstaclePosition.y, texture: platformTexture, distanceFrom: platformsDistance, frame: frame))
            // adiciona o obstaculo criado á cena
            platforms[i].AddToScene(scene: self)
        }
        // indica o numero de segmentos criados
        print("Generated \(platforms.count) segments")
    }
    // metodo que actualiza as plataformas
    private func UpdateObstacles(deltaTime : CGFloat){
        // desloca os obstaculos
        // para cada plataforma instanciada
        for i in 0 ..< platforms.count{
            // desloca
            platforms[i].Move(amount: scrollSpeed * deltaTime)
        }
    }
    
    // metodo que cria novos obstaculos
    private func CreateNewObstacle(){
        // adiciona um novo obstaculo á lista
        platforms.append(Obstacle(lastPlatformHeight: platforms[platforms.count - 1].obstaclePosition.y, texture: platformTexture,
            distanceFrom: platformsDistance, frame: frame))
        // adiciona o elemento á scena
        platforms[platforms.count - 1].AddToScene(scene: self)
    }
    
    //MARK: Input
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guarda o primeiro toque da lista, caso exista
        guard let touch = touches.first else {return}
        
        // verifica se nao é o toque de inicio
        if(!startPlaying){
            // sendo o primeiro toque
            // desativa a label
            justTaplabel.removeFromParent()
            // inicia a partida
            startPlaying = true
            
        }

         let location = touch.location(in: self)

        if(location.x < frame.midX)
        {
         right = false
         left = true
        }
        else{
            right = true
            left = false
        }
    }

    func saveScore(){
    if(recordData == nil)
    {
        let savedString = "place holder"
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(savedString, forKey: "BestScore")

    }
    else
    {
        //let score:Int? = Int(scorelable.text!)
        //let record:Int? = Int(recordData)
        //if(score! > record!){
          //  let savedString = "place holder"
            //let userDefaults = Foundation.UserDefaults.standard
            //userDefaults.set(savedString, forKey: "BestScore")        }
        
    }
}
