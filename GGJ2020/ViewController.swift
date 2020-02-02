import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    var gameSession: GameSession!
    var modelNodes: [Model: SCNNode]!

    override func viewDidLoad() {
        super.viewDidLoad()
//        gameSession = GameSession(playerCount: 2)
        gameSession = GameSession(gameCode: "BA", currentPlayerIndex: 1)
        modelNodes = Model.loadAll()

        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.showsStatistics = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTracking()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func resetTracking() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected reference images.")
        }

        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = referenceImages

        // Apparently 4 is the limit.
        // https://stackoverflow.com/a/56890125
        configuration.maximumNumberOfTrackedImages = 4

        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
}
