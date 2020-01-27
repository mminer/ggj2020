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

        guard let imageName = anchor.referenceImage.name else {
            print("Received reference image without a name.")
            return nil
        }

        print("Added anchor for image:", imageName)

        guard let model = imageModelMap[imageName] else {
            fatalError("No model corresponding to image: \(imageName)")
        }

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
