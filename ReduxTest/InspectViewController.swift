//
//  InspectViewController.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 11/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class InspectViewController: UIViewController {
    
    var beer: Beer?
    var beerTableViewController: UIViewController?

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.layer.cornerRadius = 10
        self.popUpView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let beerName = self.beer?.name {
            if let beerPrice = self.beer?.price {
                if let picture = self.beer?.getPicture() {
                    self.name.text = beerName
                    self.price.text = "$\(beerPrice)"
                    self.picture.image = picture
                }
            }
        }
    }

    @IBAction func ok(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func edit(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            if let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "edit") as? EditViewController {
                editViewController.beer = self.beer
                editViewController.modalTransitionStyle = .crossDissolve
                if let destination = self.beerTableViewController {
                    destination.present(editViewController, animated: true, completion: nil)
                }
            }
        })
    }
}
