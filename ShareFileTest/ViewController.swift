//
//  ViewController.swift
//  ShareFileTest
//
//  Created by 申潤五 on 2021/3/12.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        // define your metadata here
        metadata.originalURL = URL(string: "https://shop.r10s.jp/aikimania/cabinet/new/sw-1758_sp.jpg")
        return metadata
    }

    @IBAction func share(_ sender: Any) {

        let url = URL(string: "https://shop.r10s.jp/aikimania/cabinet/new/sw-1758_sp.jpg")!
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let file = dir.appendingPathComponent("sw-1758_sp.jpg")
        print(file.absoluteURL)
        do {
            let data = try Data(contentsOf: url)
            try data.write(to: file)
        } catch  {
            print(error.localizedDescription)
        }
        
        let controller = UIDocumentInteractionController(url: file)
        controller.delegate = self
        controller.presentPreview(animated: true)
        
    }
    
    @IBAction func shareLink(_ sender: Any) {

        let url = URL(string: "https://shop.r10s.jp/aikimania/cabinet/new/sw-1758_sp.jpg")!
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = (sender as! UIButton)//for iPad
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
        
    }
    
    
    @IBAction func sharePDF(_ sender: Any) {
        guard let url = Bundle.main.url(forResource: "pcl", withExtension: "pdf") else { return }
        let controller = UIDocumentInteractionController(url: url)
        controller.delegate = self
        controller.presentPreview(animated: true)
    }
    
    @IBAction func shareDOCX(_ sender: Any) {
        guard let url = Bundle.main.url(forResource: "test2", withExtension:"docx") else { return }
        let controller = UIDocumentInteractionController(url: url)
        controller.delegate = self
        controller.presentPreview(animated: true)
        
    }
    
    @IBAction func shareXlsx(_ sender: Any) {
        guard let url = Bundle.main.url(forResource: "xxx", withExtension:"xlsx") else { return }
        let controller = UIDocumentInteractionController(url: url)
        controller.delegate = self
        controller.presentPreview(animated: true)
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

