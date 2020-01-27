import SceneKit

enum Model: String, CaseIterable {
    
    case bread
    case burger
    case chinese
    case chocolate
    case croissant
    case donut
    case fries
    case pineapple
    case taco
    case turkey

    static func load(_ model: Model) -> SCNNode {
        let sceneName = "art.scnassets/\(model.rawValue).scn"

        guard
            let scene = SCNScene(named: sceneName),
            let node = scene.rootNode.childNode(withName: "base", recursively: true)
        else {
            fatalError("Unable to load scene: \(sceneName)")
        }

        return node
    }

    static func loadAll() -> [Model: SCNNode] {
        return Dictionary(uniqueKeysWithValues: Model.allCases.map { ($0, load($0)) })
    }
}
