//
//  VariableBlur.swift
//  niteclub
//
//  Created by +++ on 11/11/23.
//

import SwiftUI

/// A variable blur view.
public class VariableBlurUIView: UIVisualEffectView {
    public init(
        gradientMask: UIImage,
        maxBlurRadius: CGFloat = 20,
        filterType: String = "variableBlur"
    ) {
        super.init(effect: UIBlurEffect(style: .regular))

        ///
        ///             CAFilter
        let filterClassStringEncoded = "Q0FGaWx0ZXI="

        let filterClassString: String = {
            if
                let data = Data(base64Encoded: filterClassStringEncoded),
                let string = String(data: data, encoding: .utf8)
            {
                return string
            }

            print("[VariableBlurView] couldn't decode the filter class string.")
            return ""
        }()

        /// This is the magic class method that we want to invoke, encoded in base64.
        ///
        ///       filterWithType:
        let filterWithTypeStringEncoded = "ZmlsdGVyV2l0aFR5cGU6"

        /// Decode the base64.
        let filterWithTypeString: String = {
            if
                let data = Data(base64Encoded: filterWithTypeStringEncoded),
                let string = String(data: data, encoding: .utf8)
            {
                return string
            }

            print("[VariableBlurView] couldn't decode the filter method string.")
            return ""
        }()

        /// Create the selector.
        let filterWithTypeSelector = Selector(filterWithTypeString)

        /// Create the class object.
        guard let filterClass = NSClassFromString(filterClassString) as AnyObject as? NSObjectProtocol else {
            print("[VariableBlurView] couldn't create CAFilter class.")
            return
        }

        /// Make sure the filter class responds to the selector.
        guard filterClass.responds(to: filterWithTypeSelector) else {
            print("[VariableBlurView] Doesn't respond to selector \(filterWithTypeSelector)")
            return
        }

        /// Create the blur effect.
        let variableBlur = filterClass
            .perform(filterWithTypeSelector, with: filterType)
            .takeUnretainedValue()

        guard let variableBlur = variableBlur as? NSObject else {
            print("[VariableBlurView] Couldn't cast the blur filter.")
            return
        }

        /// The blur radius at each pixel depends on the alpha value of the corresponding pixel in the gradient mask.
        /// An alpha of 1 results in the max blur radius, while an alpha of 0 is completely unblurred.
        guard let gradientImageRef = gradientMask.cgImage else {
            fatalError("Could not decode gradient image")
        }

        variableBlur.setValue(maxBlurRadius, forKey: "inputRadius")
        variableBlur.setValue(gradientImageRef, forKey: "inputMaskImage")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")

        /// Get rid of the visual effect view's dimming/tint view, so we don't see a hard line.
        if subviews.indices.contains(1) {
            let tintOverlayView = subviews[1]
            tintOverlayView.alpha = 0
        }

        /// We use a `UIVisualEffectView` here purely to get access to its `CABackdropLayer`,
        /// which is able to apply various, real-time CAFilters onto the views underneath.
        let backdropLayer = subviews.first?.layer

        /// Replace the standard filters (i.e. `gaussianBlur`, `colorSaturate`, etc.) with only the variableBlur.
        backdropLayer?.filters = [variableBlur]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// A variable blur view.
public struct VariableBlurView: UIViewRepresentable {
    public var gradientMask: UIImage
    public var maxBlurRadius: CGFloat
    public var filterType: String

    /// A variable blur view.
    public init(
        gradientMask: UIImage = VariableBlurViewConstants.defaultGradientMask,
        maxBlurRadius: CGFloat = 20,
        filterType: String = "variableBlur"
    ) {
        self.gradientMask = gradientMask
        self.maxBlurRadius = maxBlurRadius
        self.filterType = filterType
    }

    public func makeUIView(context: Context) -> VariableBlurUIView {
        let view = VariableBlurUIView(
            gradientMask: gradientMask,
            maxBlurRadius: maxBlurRadius,
            filterType: filterType
        )
        return view
    }

    public func updateUIView(_ uiView: VariableBlurUIView, context: Context) {}
}

public enum VariableBlurViewConstants {

    /// A gradient mask image (top is opaque, bottom is clear). The gradient includes easing.
    public static var defaultGradientMask: UIImage = {
        if let image = UIImage(named: "alpha-gradient") { // Replace "image" with the actual name of your image in the assets
            return image
        } else {
            print("[VariableBlurView] Couldn't load the image from assets.")
            return UIImage(systemName: "xmark")!
        }
    }()
}


