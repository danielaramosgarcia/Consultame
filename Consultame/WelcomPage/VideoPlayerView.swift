//
//  VideoPlayerView.swift
//  Consultame
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI
import AVKit

//struct VideoPlayerView: UIViewRepresentable {
//    var videoName: String
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: .zero)
//
//        print("Cargando video:", videoName)
//
//        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
//            fatalError("Video file not found")
//        }
//
//        print("Ruta del video encontrado:", path)
//
//
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let layer = AVPlayerLayer(player: player)
//        layer.frame = view.bounds
//        layer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(layer)
//
//        player.play()
//
//        print("Reproduciendo video:", videoName)
//
//
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        if let layer = uiView.layer.sublayers?.first as? AVPlayerLayer {
//            layer.frame = uiView.bounds
//        }
//    }
//
//}

struct VideoPlayerView: View {
    var videoName: String
    
    var player: AVPlayer {
        let player = AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "mp4")!)
        player.play()
        return player
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fit)
    }
}
