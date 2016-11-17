//
//  ImportFeature.swift
//  MMiOS
//
//  Created by William on 16/11/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import Photos
import AVKit

class StreamingFeature : NSObject {
    let mViewContreoller : UIViewController
    
    init(viewController : UIViewController) {
        mViewContreoller = viewController
    }
    func importFunc() {
        let alertController = UIAlertController(title: "Informe a URL da streaming", message: "", preferredStyle: .alert)
        //cancel action
        let cancelAction = UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        //Playaction
        let streamURLaction = UIAlertAction(title:"Play", style: .default) { (_) in
            let urlTextField = alertController.textFields![0] as UITextField
            let mUrl = URL.init(string: urlTextField.text!)
            //            let mUrl = URL.init(string: "https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8")
            if(mUrl != nil) {
                
                let playerViewController = CustomPlayerVC.init(mUrl: mUrl!)
                self.mViewContreoller.present(playerViewController, animated: true, completion: nil)
            }
        }
        streamURLaction.isEnabled = false
        
        //adding textfield
        alertController.addTextField { (textfield : UITextField) in
            textfield.placeholder = "http//...."
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textfield, queue: OperationQueue.main) { (notification) in
                //habilitando o streaming action
                streamURLaction.isEnabled = textfield.text != ""
            }
        }
        
        alertController.addAction(streamURLaction)
        self.mViewContreoller.present(alertController, animated: true, completion: nil)

    }
    

}
