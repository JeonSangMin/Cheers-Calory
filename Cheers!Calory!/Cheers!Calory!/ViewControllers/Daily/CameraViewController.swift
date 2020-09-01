//
//  CameraViewController.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var delegate: BarcodeDataDelegate?
    let barcodeGuide = UIImageView()
    let navigationView = UIView()
    let naviTitle = UILabel()
    let naviBackButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "바코드 스캔"
        captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return print("카메라를 가져오는데 실패") }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            print(error.localizedDescription)
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
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.frame
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
        
        barcodeGuide.image = UIImage(named: "barcode")
        barcodeGuide.alpha = 0.7
        barcodeGuide.contentMode = .scaleAspectFit
        
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(barcodeGuide)
        view.bringSubviewToFront(barcodeGuide)
        setNaviView()
        
        barcodeGuide.snp.makeConstraints {
            $0.centerX.centerY.equalTo(guide)
            $0.width.equalTo(guide.snp.width).multipliedBy(0.5)
            $0.height.equalTo(guide.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setNaviView() {
        navigationView.backgroundColor = .black
        view.addSubview(navigationView)
        view.bringSubviewToFront(navigationView)
        
        naviTitle.text = "Barcode"
        naviTitle.textColor = .white
        naviTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        naviTitle.textAlignment = .center
        
        naviBackButton.setTitle("Cancel", for: .normal)
        naviBackButton.setBackgroundColor(UIColor.clear, for: .normal)
        naviBackButton.setTitleColor(.white, for: .normal)
        naviBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        naviBackButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        
        
        navigationView.addSubview(naviTitle)
        navigationView.addSubview(naviBackButton)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        naviTitle.translatesAutoresizingMaskIntoConstraints = false
        naviBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView.snp.makeConstraints {
            $0.top.width.centerX.equalTo(view)
            $0.height.equalTo(view.snp.height).multipliedBy(0.08)
        }
        
        naviTitle.snp.makeConstraints {
            $0.centerX.centerY.height.equalTo(navigationView)
            $0.width.equalTo(CGFloat.dynamicXMargin(margin: 100))
        }
        
        naviBackButton.snp.makeConstraints {
            $0.leading.centerY.height.equalTo(navigationView)
            $0.width.equalTo(CGFloat.dynamicXMargin(margin: 80))
        }
    }
    
    @objc private func goBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    // MARK: - 캡쳐 실패시 동작
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 뷰가 뜰 때 captureSession이 동작중이지 않으면 실행
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let tabbar = self.presentingViewController as? UITabBarController else { return print("0000") }
        guard let navi = tabbar.viewControllers?[2] as? UINavigationController else {return print("1111")}
        guard let dailyVC = navi.viewControllers.first as? DailyViewController else { return print("222")}
        
        dailyVC.tableView.reloadData()
        // 뷰가 사라질 때 captureSession이 동작중이면 종료
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: - 카메라로 캡쳐한 object의 메타데이터 output
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            delegate?.sendBarcodeData(barcode: stringValue)
            self.presentingViewController?.presentingViewController?.dismiss(animated: true)
        }
        
        
    }
}

