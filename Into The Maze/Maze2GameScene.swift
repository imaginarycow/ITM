
import SpriteKit


extension GameScene {
    
    
    func loadMaze2() {
        
        let triangle1 = Triangle.createTriangle(self, scale: 1.0, buffer: 0.0, color: .redColor())
        
        let triangle2 = Triangle.createTriangle(self, scale: 0.7, buffer: -10.0, color: .redColor())
        
        let triangle3 = Triangle.createTriangle(self, scale: 0.4, buffer: -20.0, color: .redColor())
        
        box1.addChild(triangle1)
        //parent2.addChild(triangle2)
        //parent3.addChild(triangle3)
        
    }
    
    
    
}