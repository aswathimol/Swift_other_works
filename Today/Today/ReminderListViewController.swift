//
//  ViewController.swift
//  Today
//
//  Created by Aswathimol S(UST,IN) on 22/09/23.
//

import UIKit

class ReminderListViewController: UICollectionViewController {       // sub class og UIViewController

    override func viewDidLoad() {                     // viewDidLoad: initialising UI , loading data
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath ,itemIdentifier: String ) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()   //it create a content configuration with predefined style
        }
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    
    
    
}

