//
//  QrScanner.swift
//  Airdrop Tool
//
//  Created by lucas fernández on 23/10/2019.
//  Copyright © 2019 lucas fernández. All rights reserved.
//

import SwiftUI

struct QRCodeScan: UIViewControllerRepresentable {
    
    var onCodeScanned: (String) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let vc = ScannerViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: ScannerViewController, context: Context) {
    }

    class Coordinator: NSObject, QRCodeScannerDelegate {
        
        func codeDidFind(_ code: String) {
            parent.onCodeScanned(code)
        }
        
        var parent: QRCodeScan
        
        init(_ parent: QRCodeScan) {
            self.parent = parent
        }
    }
}

#if DEBUG
struct QRCodeScan_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScan() {
            print($0)
        }
    }
}
#endif
