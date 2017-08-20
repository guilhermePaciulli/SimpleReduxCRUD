//
//  BeerTableViewController.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 10/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {
    
    @IBOutlet weak var search: UISearchBar!
    
    var beers: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        search.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.exitSearchBar))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var contentOffset = self.tableView.contentOffset
        contentOffset.y += self.search.frame.height
        self.tableView.contentOffset = contentOffset
        
        store.dispatch(FetchAllAction())
        beers = store.state.readingState.beers
        self.tableView.reloadData()
    }
    
    @IBAction func addBeer(_ sender: UIBarButtonItem) {
        if let createViewController = self.storyboard?.instantiateViewController(withIdentifier: "create") as? CreateViewController {
            createViewController.modalTransitionStyle = .crossDissolve
            self.present(createViewController, animated: true, completion: nil)
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        
        let beer = beers[indexPath.row]
        cell.textLabel?.text = beer.name
        cell.imageView?.image = beer.getPicture()
        cell.detailTextLabel?.text = "$" + String(describing: beer.price)
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let beerDeleted = beers[indexPath.row]
            self.beers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            store.dispatch(DeleteAction(beer: beerDeleted))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let inspectViewController = self.storyboard?.instantiateViewController(withIdentifier: "inspect") as? InspectViewController {
            let selectedBeer = self.beers[indexPath.row]
            inspectViewController.beer = selectedBeer
            inspectViewController.beerTableViewController = self
            inspectViewController.modalTransitionStyle = .crossDissolve
            self.present(inspectViewController, animated: true, completion: nil)
        }
    }
    
}

extension BeerTableViewController: UISearchBarDelegate {
    
    func exitSearchBar() {
        self.search.endEditing(true)
    }
    
    func searchBy(name: String) {
        store.dispatch(FetchByNameAction(name: name))
        beers = store.state.readingState.beers
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBy(name: searchText)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = search.text {
            searchBy(name: searchText)
        }
    }
    
}
