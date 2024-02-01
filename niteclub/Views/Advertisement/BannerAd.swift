//
//  BannerAd.swift
//  niteclub
//
//  Created by +++ on 1/29/24.
//

import SwiftUI

struct BannerAd: View {
    @ObservedObject var adViewModel: AdViewModel

    var body: some View {
        if let ad = adViewModel.currentAd {
            VStack {
                Button(action: {adViewModel.recordClick()}) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(ad.mediaURL) // Load the image using its name
                            .resizable()
                        //                .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width)
                            .frame(height: 180)
                            .clipped()
                            .transition(.opacity) // Fade transition for the ad
                        

                        HStack {
                            Text(ad.businessName)

                            Spacer()
                            Text("tap to visit".uppercased())
                                .bold()
                                .fontDesign(.monospaced)
                                .font(.system(size: 10))
                            Image(systemName: "globe")
                                .font(.system(size: 12))

                        }
                        .foregroundStyle(.white.opacity(0.75))
                        .padding(6)
                    }
                    .onAppear {
                        adViewModel.recordImpression()
                    }

                }
                Spacer()

            }
        }
    }
}

#Preview {
    BannerAd(adViewModel: AdViewModel())
}

extension AdViewModel {
    static func withSampleData() -> AdViewModel {
        let sampleViewModel = AdViewModel()
        let sampleAd = AdModel(id: "1", type: .banner, mediaURL: "margiela", businessName: "aesop", websiteLink: URL(string: "https://example.com")!)
        sampleViewModel.currentAd = sampleAd
        return sampleViewModel
    }
}
