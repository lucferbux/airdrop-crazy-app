//
//  ScannerViewController.swift
//  Airdrop Tool
//  Copied from the spectacular Hacking With Swift by @twostraws ;)
//
//  Created by @twostraws.
//

import AVFoundation
import UIKit
import Lottie

protocol QRCodeScannerDelegate {
    func codeDidFind(_ code: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: QRCodeScannerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = .zero
//        blurEffectView.layer.cornerRadius = 10
//        blurEffectView.clipsToBounds = true
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//
//        let titleText = UILabel()
//        titleText.textColor = .white
//        titleText.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        titleText.layer.cornerRadius = 10
//        titleText.translatesAutoresizingMaskIntoConstraints = false
//        titleText.text = "QR Scanner"
        
        
        let closeButton  = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.frame = .zero
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let loadingAnimation = Animation.named("scanner")
        let lottieView = AnimationView(animation: loadingAnimation)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play(toFrame: .infinity)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.addSublayer(previewLayer)
//        view.addSubview(blurEffectView)
//        view.addSubview(titleText)
        view.addSubview(closeButton)
        view.addSubview(lottieView)
        


        //constraints
        NSLayoutConstraint.activate([
//            blurEffectView.heightAnchor.constraint(equalToConstant: 60.0),
//            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
//            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
//            blurEffectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleText.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
//            titleText.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            lottieView.heightAnchor.constraint(equalTo: lottieView.widthAnchor, multiplier: 1.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            closeButton.widthAnchor.constraint(equalToConstant: 60.0),
            closeButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
//        titleText.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor, constant: 0).isActive = true
//        titleText.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor, constant: 0).isActive = true
//
        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    @objc func closeAction(sender: UIButton!) {
        dismiss(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        self.delegate?.codeDidFind(code)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
