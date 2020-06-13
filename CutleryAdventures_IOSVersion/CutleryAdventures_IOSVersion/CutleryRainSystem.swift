import SpriteKit
import GameKit

class CutleryRainSystem {
    // sistema de spawn de talheres
    //MARK: Logic Vars
    var spawnRate : Double   // velocidade de spawn do talher
    var speedReductionBonus : Double  // reduçao da velocidade
    
    //MARK: Internal vars
    private var cutlerySprites = [SKTexture]()      // array com as texturas
    private var spawnedObjs = [SKSpriteNode]()      // array de objs em cena
    private var currentScene : SKScene              // cena actual
    private var timer : Double                      // timer para contagem de tempo
    
    //MARK: Init
    init(scene : SKScene, spawnRate: Double, reductionBonus : Double, textures : [SKTexture]) {
        // inicia o spawner
        // guarda referencias para os valores recebidos
        self.spawnRate = spawnRate
        self.speedReductionBonus = reductionBonus
        self.currentScene = scene
        self.cutlerySprites = textures
        self.timer = 0
    }
    
    //MARK: Update Spawners
    public func Update(deltaTime : Double){
        // incrementa o valor do tempo ao timer
        self.timer += deltaTime
        // avalia se passou o tempo para um novo spawn
        if self.timer >= self.spawnRate {
            //reenicia o timer
            self.timer = 0
            
            // caso tenha alcansado o tempo de rate
            // inicia um novo spawn, com uma textura aleatoria
            let newSpawn = SKSpriteNode(texture: cutlerySprites[
                Int.random(in: 0...cutlerySprites.count - 1)])
            // define a escala do objeto
            newSpawn.xScale = 3
            newSpawn.yScale = 3
            // define a posiçao inicial
            newSpawn.position = CGPoint(x: CGFloat.random(in: newSpawn.size.width * 0.5...self.currentScene.size.width - newSpawn.size.width * 0.5),
                                        y: self.currentScene.size.height + newSpawn.size.height * 0.5)
            // define a posiçao de profundidade
            newSpawn.zPosition = 6
            
            //MARK: Corpo fisico
            // define o corpo fisico do objeto
            newSpawn.physicsBody = SKPhysicsBody(rectangleOf: newSpawn.size)
            // inicia o corpo como nao dinamico
            newSpawn.physicsBody?.isDynamic = false
            // define a categoria do corpo
            newSpawn.physicsBody?.categoryBitMask = PhysicsCategory.cutlery
            // define as categorias de contacto
            newSpawn.physicsBody?.collisionBitMask = PhysicsCategory.none
            // define que categorias dispertam uma call logica
            newSpawn.physicsBody?.contactTestBitMask = PhysicsCategory.grandpa
            // adiciona impulso angular
            newSpawn.physicsBody?.density = 0.1
            // define a massa do objecto
            newSpawn.physicsBody?.mass = 0.5
            
            
            // adiciona o novo corpo á cena
            self.currentScene.addChild(newSpawn)
            // adiciona o novo spawn á lista de objetos
            self.spawnedObjs.append(newSpawn)
            
            // define o corpo como dinamico
            newSpawn.physicsBody?.isDynamic = true
        }
    }
    
    //MARK:Late Update
    public func LateUpdate(){
        // verifica se existem objectos em cena
        if(self.spawnedObjs.count == 0){return}
        
        // avalia se os objetos abandonaram o limite do ecra
        for i in (0...self.spawnedObjs.count - 1).reversed() {
            // verifica se o objeto continua visivel na cena, validaçao vertical
            if(self.spawnedObjs[i].position.y + self.spawnedObjs[i].size.height * 0.5 < 0){
                // caso ocorra o objecto já nao se encontra em vista
                // remove da scena
                spawnedObjs[i].removeFromParent()
                // deve ser removido
                self.spawnedObjs.remove(at: i)
            }
            else{
                // roda o objecto
                self.spawnedObjs[i].zRotation += 0.5
            }
        }
    }
    
    //MARK: Contact Callback
    public func ContactCallBack(element : SKSpriteNode){
        // ao entrar em contacto este corpo deve ser destruido
        // remove o objecto de scena
        guard let elementIndex = self.spawnedObjs.index(of: element) else {return}
        // com base no index determinado, remove de cena
        self.spawnedObjs[elementIndex].removeFromParent()
        // elimina o objecto
        self.spawnedObjs.remove(at: elementIndex)
    }
}
