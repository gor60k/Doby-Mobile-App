import UIKit
import VisionKit

extension PrimaryQRScannerView {
    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let onScan: (String) -> Void
        let onClose: () -> Void
        
        init(
            onScan: @escaping (String) -> Void,
            onClose: @escaping () -> Void
        ) {
            self.onScan = onScan
            self.onClose = onClose
        }
        
        @objc
        func closeTapped() {
            onClose()
        }
        
        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didTapOn item: RecognizedItem) {
            handle(item)
        }
        
        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didAdd addedItems: [RecognizedItem],
            allItems: [RecognizedItem]) {
            guard let item = addedItems.first else { return }
            handle(item)
        }
        
        private func handle(_ item: RecognizedItem) {
            guard case .barcode(let barcode) = item,
                  let value = barcode.payloadStringValue
            else { return }
            
            onScan(value)

        }
    }
}
