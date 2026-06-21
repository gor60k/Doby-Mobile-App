import UIKit
import SwiftUI
import VisionKit
internal import Vision

extension DataScannerViewController {
    static func makeQRScanner(
        delegate: DataScannerViewControllerDelegate,
        closeTarget: Any,
        closeAction: Selector
    ) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        controller.delegate = delegate
        return controller
    }
    
    private func addCloseButton(
        target: Any,
        action: Selector
    ) {
        let button = UIButton(type: .system)
        
        button.setTitle("Назад", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black.withAlphaComponent(0.6)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = .init(
            top: 10,
            left: 14,
            bottom: 10,
            right: 14
        )
        
        button.addTarget(
            target,
            action: action,
            for: .touchUpInside
        )
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            button.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            )
        ])
    }
}
