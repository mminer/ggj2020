import ARKit

extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("Added node to scene.")
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Why is it possible to set the scale here but doing so when adding to the scene doesn't work?
        node.scale = Constants.modelScale
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let anchor = anchor as? ARImageAnchor else {
            print("Detected anchor is not an image anchor.")
            return nil
        }

        guard
            let lastCharacter = anchor.referenceImage.name?.last,
            let imageNumber = Int(String(lastCharacter))
        else {
            fatalError()
        }

        let model = gameSession.imageModelMap[imageNumber]
        print("Added anchor for image: \(imageNumber); model: \(model)")
        return modelNodes[model]
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("Error:", error)
    }

    func sessionWasInterrupted(_ session: ARSession) {
        print("Session interrupted.")
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session interruption ended.")
    }
}
