//
//  ViewController.swift
//  SPHAssignment
//
//  Created by Optimum  on 11/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var homeViewModal : HomeViewModel!
    var listDataSource : ListDataSource<Any>!
    let activityView = UIActivityIndicatorView(style: .medium)
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModal = HomeViewModel()
        self.fetchRecords()
       
    }
    //Function to update UI with Response
    func updateUIwithResult()
    {
        listDataSource = ListDataSource(
            models:(homeViewModal.records),
            reuseIdentifier: "YearInfoCell"
        ) { message, cell , row in
            let recordCell = cell as! YearInfoCell
            let modal = message as! VolumeDataModal
            recordCell.titleLbl.text = modal.year + " Mobile Data Volume"
            recordCell.lblYear.text = String(format: "Total %.2f", modal.totalVolume)
            recordCell.lblQ1.text = "Q1 - " + "\(modal.q1Data)"
            recordCell.lblQ2.text = "Q2 - " + "\(modal.q2Data)"
            recordCell.lblQ3.text = "Q3 - " + "\(modal.q3Data)"
            recordCell.lblQ4.text = "Q4 - " + "\(modal.q4Data)"
            recordCell.dropImgVw.isHidden = modal.isDrop ? false : true
            if modal.isDrop
            {
                let gestureRecognizerOne = UITapGestureRecognizer(target: self, action: #selector(self.dropImageTapped))
                recordCell.dropImgVw.isUserInteractionEnabled = true
                gestureRecognizerOne.numberOfTapsRequired = 1
                recordCell.dropImgVw.addGestureRecognizer(gestureRecognizerOne)
            }
            recordCell.selectionStyle = .none
            recordCell.dropShadow()
        }
        self.hideActivityIndicator(activityView: activityView)
        self.tableView.dataSource = self.listDataSource
        self.tableView.reloadData()
        self.tableView.isHidden = false
        
    }
    //Function to Fetch Data from DB or Server 
    func fetchRecords ()
    {
        homeViewModal.records.removeAll()
        self.tableView.isHidden = true
        self.showActivityIndicator(activityView: activityView)
        homeViewModal.getRecords { (success, error) in
            if success
            {
                DispatchQueue.main.async
                    {
                        self.updateUIwithResult()
                }
            }
            else
            {
                if self.homeViewModal.fetchRecordsFromDatabase()
                {
                    DispatchQueue.main.async
                        {
                            self.updateUIwithResult()
                    }
                    return
                }
                self.hideActivityIndicator(activityView: self.activityView)
                switch error {
                case .noInternetConnection:
                    self.showErrorAlert(with: "The internet connection is lost", titile: "Error")
                    break
                case .other:
                    self.showErrorAlert(with: "Somethig went wrong. Please try again Later", titile: "Oops!")
                    break
                case .custom(let errorDesc):
                    print(errorDesc.localizedDescription)
                    self.showErrorAlert(with: errorDesc.localizedDescription, titile: "Error")
                    break
                default:
                    print(error!)
                }
            }
            
        }
    }
    
    
}
extension HomeViewController
{
    @objc func  dropImageTapped (sender : AnyObject)
    {
        self.showErrorAlert(with: "Drop Image Tapped", titile: "Message")
    }
    
}

