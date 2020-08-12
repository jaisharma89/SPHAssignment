//
//  HomeViewModel.swift
//  CAssignment
//
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit
import CoreData


class HomeViewModel: NSObject {
    
    var records : [VolumeDataModal] = []
    var webHandlerInstance = WebAPIHandler.getInstance()
    var persistentContainer = AppDelegate.getSharedInstance().persistentContainer
    //Function get Response from API and update the UI based on Data
    func getRecords (completionHandler: @escaping (Bool, WebError?) -> Void){
        let requestUrl = URL(string: Constants.networkHostURL)!
        
        webHandlerInstance.makeRequestWithServer(requestUrl, session: webHandlerInstance.session) { (result) in
            
            switch result
            {
            case .Success(let data):
                if  let response = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String :AnyObject]
                {
                    if let recordsArr = response["result"]!["records"] as? [AnyObject]
                    {
                        
                        for record in recordsArr
                        {
                            let time = record["quarter"] as! String
                            
                            let year = time.components(separatedBy: "-")[0]
                            
                            if self.records.filter({$0.year == year}).count <= 0
                            {
                                
                                if let yearDataModal = self.getVolumeDataYearly(recordsArr: recordsArr ,record: record )
                                {
                                    self.records.append(yearDataModal)
                                }
                            }
                            
                        }
                    }
                }
                
                if self.records.count > 0
                {
                    DispatchQueue.main.async {
                        let itemsFetchRequest = YearDataVolume.fetchRequest() as! NSFetchRequest
                        let fetchedItems = try! self.persistentContainer.viewContext.fetch(itemsFetchRequest) as! [YearDataVolume]
                        if fetchedItems.count == 0
                        {
                            self.saveRecordinDatabase()
                        }
                    }
                    completionHandler(true ,nil)
                }
                else
                {
                    completionHandler(false, .other)
                }
                
                break
            case .Failure(let error):
                completionHandler(false,error)
                break
            case .none:
                completionHandler(false, .other)
            }
            
        }
    }
    
    //Function get Parse data yearly data basis
    func getVolumeDataYearly (recordsArr : [AnyObject] , record : AnyObject) -> VolumeDataModal?
    {
        if let VolData = record as? [String : AnyObject]
        {
            let time = VolData["quarter"] as! String
            let year = time.components(separatedBy: "-")[0]
            let arrSameYear = recordsArr.filter{($0["quarter"] as! String).contains(year)}
            var q1Value = ""
            var q2Value = ""
            var q3Value = ""
            var q4Value = ""
            
            for object in arrSameYear {
                let quarterData = object as! [String: AnyObject]
                let quarter = (quarterData["quarter"] as! String).components(separatedBy: "-")[1]
                let mobileDataKey = "volume_of_mobile_data"
                switch quarter {
                case "Q1":
                    q1Value = quarterData[mobileDataKey] as? String ?? ""
                    break
                case "Q2":
                    q2Value = quarterData[mobileDataKey] as? String ?? ""
                    break
                case "Q3":
                    q3Value = quarterData[mobileDataKey] as? String ?? ""
                    break
                case "Q4":
                    q4Value = quarterData[mobileDataKey] as? String ?? ""
                    break
                default:
                    print("")
                }
                
            }
            
            return VolumeDataModal( year: year,  q1Data: q1Value, q2Data: q2Value, q3Data: q3Value, q4Data: q4Value)
            
        }
        
        
        return nil
    }
    //Function to store data in DB
    
    func saveRecordinDatabase ()
    {
        let context = persistentContainer.viewContext
        
        for modal in self.records
        {
            let item = NSEntityDescription.insertNewObject(forEntityName: "YearDataVolume", into: context) as! YearDataVolume
            item.year = modal.year
            item.q1Value = modal.q1Data
            item.q2Value = modal.q2Data
            item.q3Value = modal.q3Data
            item.q4Value = modal.q4Data
            item.q4Value = modal.q4Data
            item.total =   modal.totalVolume
            
        }
        
        AppDelegate.getSharedInstance().saveContext()
        
        
    }
    //Function to fetch data in DB
    func fetchRecordsFromDatabase() -> Bool
    {
        let context = persistentContainer.viewContext
        let itemsFetchRequest = YearDataVolume.fetchRequest() as! NSFetchRequest
        let fetchedItems = try! context.fetch(itemsFetchRequest) as! [YearDataVolume]
        
        self.records.removeAll()
        for record in fetchedItems
        {
            if let modal =  VolumeDataModal( year: record.year!,  q1Data: String(record.q1Value), q2Data: String(record.q2Value), q3Data: String(record.q3Value), q4Data: String(record.q4Value))
            {
                self.records.append(modal)
            }
            
            
        }
        if self.records.count > 0
        {
            self.records.sort { $0.year < $1.year }
            return true
        }
        else
        {
            return false
        }
        
    }
}
