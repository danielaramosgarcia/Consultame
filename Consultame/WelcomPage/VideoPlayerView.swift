//
//  VideoPlayerView.swift
//  Consultame
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoName: String
    @State private var player: AVPlayer?

    private func setupPlayer() {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            fatalError("Video file not found")
        }

        let player = AVPlayer(url: url)
        self.player = player

        // Looping the video
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak player] _ in
                player?.seek(to: CMTime.zero)
                player?.play()
            }
    }

    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fit)
            .onAppear {
                if player == nil {
                    setupPlayer()
                }
                player?.play()
            }
            .onDisappear {
                player?.pause()
            }
    }
}
