//
//  SearchTableViewController.swift
//  jobInterview
//
//  Created by Tom Ben Ari on 28/11/2016.
//  Copyright © 2016 Tom Ben Ari. All rights reserved.
//

import UIKit
import CCBottomRefreshControl

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    var term : String?
    var tableArray : [Item] = []
    var page : Int = 1 {
        didSet{
            getData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(SearchTableViewController.getData), for: .valueChanged)

        tableView.bottomRefreshControl = UIRefreshControl()
        tableView.bottomRefreshControl.addTarget(self, action: #selector(SearchTableViewController.nextPage), for: .valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func nextPage(){
        page += 1
    }
    
    func currentType() -> Item.itemType?{
        switch typeSegmentedControl.selectedSegmentIndex {
        case 0:
            return .movie
        case 1:
            return .series
        case 2:
            return .episode
        default:
            return nil
        }
    }
 
    func getData(){
        
        if page == 1{
            term = searchBar.text
        }
        
        guard let term = term, !term.isEmpty
            else {
                refreshControl?.endRefreshing()
            //TODO: - handel error
            tableArray = []
            tableView.reloadData()
            return
        }
        
        APIManager.manager.omdb(search: term, type: currentType(), page: page, completion:{ (arr,err) in
            
             self.refreshControl?.endRefreshing()
            
            guard let arr = arr else {
                return
            }
            
            if self.page == 1{
                // first seatch
                self.tableArray = arr
            }else{
                self.tableArray += arr
            }
            
            self.tableView.reloadData()
        })
        
    }
    
    //MARK: UISearchbar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        page = 1
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
    
    //MARK: - IBActin
    @IBAction func segmentedControlAction(_ sender: Any) {
        page = 1
        
    }
    
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = SearchTableViewCell.idendtifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        
        let item = tableArray[indexPath.row]
        cell.configure(item)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
