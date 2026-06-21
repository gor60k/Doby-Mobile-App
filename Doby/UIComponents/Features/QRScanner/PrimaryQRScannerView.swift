import SwiftUI
import UIKit
import VisionKit
internal import Vision

//TODO: - добавить обработку урлов через менеджер
struct PrimaryQRScannerView: UIViewControllerRepresentable {
    let onScan: (String) -> Void
    let onClose: () -> Void

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController.makeQRScanner(
            delegate: context.coordinator,
            closeTarget: context.coordinator,
            closeAction: #selector(Coordinator.closeTapped)
        )
        
        try? controller.startScanning()
        return controller
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(
            onScan: onScan,
            onClose: onClose
        )
    }
}


