import SwiftUI
import UIKit
import VisionKit
internal import Vision

//TODO: - добавить обработку урлов через менеджер
struct PrimaryQRScannerView: UIViewControllerRepresentable {
    let onScan: (String) -> Void
    let onClose: () -> Void

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )

        controller.delegate = context.coordinator

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Назад", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 10
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        closeButton.addTarget(
            context.coordinator,
            action: #selector(Coordinator.closeTapped),
            for: .touchUpInside
        )

        controller.view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -16)
        ])

        try? controller.startScanning()

        return controller
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onScan: onScan, onClose: onClose)
    }

    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let onScan: (String) -> Void
        let onClose: () -> Void

        init(onScan: @escaping (String) -> Void, onClose: @escaping () -> Void) {
            self.onScan = onScan
            self.onClose = onClose
        }

        @objc
        func closeTapped() {
            onClose()
        }

        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didTapOn item: RecognizedItem
        ) {
            if case .barcode(let barcode) = item,
               let value = barcode.payloadStringValue {
                onScan(value)
            }
        }

        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didAdd addedItems: [RecognizedItem],
            allItems: [RecognizedItem]
        ) {
            guard let item = addedItems.first,
                  case .barcode(let barcode) = item,
                  let value = barcode.payloadStringValue else {
                return
            }

            onScan(value)
        }
    }
}
