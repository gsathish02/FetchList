//
//  FeedManager.swift
//  FetchApp
//
//  Created by Sathish Kumar G on 10/9/20.
//  Copyright © 2020 Sathish Kumar G. All rights reserved.
//

import Foundation
import JGProgressHUD

class FeedManager {
    
    let hud = JGProgressHUD(style: .dark)
    var objectArray = [Objects]()
    
    func getResult(urlString: String, completionHandler: @escaping ([Objects]?) ->()) {
        NetworkManager.shared.alamofireRequest(urlString: urlString, completionHandler:{ isfetchSuccess, receivedModel in
            if isfetchSuccess {
                print("Success")
                guard let models = receivedModel else {
                    completionHandler(nil)
                    return
                }
                
                var sortedModel = [ListItem]()
              
                var tempModel1 = [ListItem]()
                var tempModel2 = [ListItem]()
                var tempModel3 = [ListItem]()
                var tempModel4 = [ListItem]()
                
                //Filter out the nul or black name
                for singleModel in models {
                    if singleModel.name != nil && singleModel.name != "" {
                        sortedModel.append(singleModel)
                    }
                }
                
                //Sort the listId
                let sortedList = sortedModel.sorted {
                    $0.listID < $1.listID
                }
                
                //Separating into groups
                for separatedList in sortedList {
                    if separatedList.listID == 1 {
                        tempModel1.append(separatedList)
                    } else if separatedList.listID == 2 {
                        tempModel2.append(separatedList)
                    } else if separatedList.listID == 3 {
                        tempModel3.append(separatedList)
                    } else if separatedList.listID == 4 {
                         tempModel4.append(separatedList)
                    }
                }
                
                
                self.objectArray.append(Objects(sectionName: 1, sectionObjects: tempModel1))
                self.objectArray.append(Objects(sectionName: 2, sectionObjects: tempModel2))
                self.objectArray.append(Objects(sectionName: 3, sectionObjects: tempModel3))
                self.objectArray.append(Objects(sectionName: 4, sectionObjects: tempModel4))
                completionHandler(self.objectArray)
            } else {
                print("fail")
                self.hideHUD()
                completionHandler(nil)
            }
        })
    }
    
    //Display Loader on View
    func showHUD(thisView :UIView) {
        hud.textLabel.text = Constants.loading
        hud.show(in: thisView)
    }
    
    //Remove the Loader from View
    func hideHUD() {
        hud.dismiss()
    }
}
