//
//  OrderViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 13.06.24.
//

import UIKit



class OrderViewController : UIViewController {
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifer)
        tableView.backgroundColor = .mainBackground
        tableView.separatorColor = .mainBackground
        return tableView
    }()
    
    
    let favoriteView : FavoriteView = {
        let fv = FavoriteView()
        fv.headerLabel.text = "Your favorites"
        return fv
    }()
    
    let drinksView : DrinksView = {
        let fv = DrinksView()
        fv.headerLabel.text = "Drinks"
        return fv
    }()
    
    let coffeeBeansView : CoffeeBeansView = {
        let view = CoffeeBeansView()
        view.headerLabel.text = "Coffee Beans"
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        view.addSubview(tableView)
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        
        drinksView.onDrinkSelected = { item in
            let nextVC = OrderCoffeeDetailViewController()
            nextVC.config(item: item)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        coffeeBeansView.onDrinkSelected = { item in
            let nextVC = OrderCoffeeBeansDetailViewController()
            nextVC.config(item: item)
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        }

    }
}


extension OrderViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifer, for: indexPath) as! OrderTableViewCell
        if indexPath.row == 0 {
            cell.config(itemView: favoriteView)
        }
        else if indexPath.row == 1 {
            cell.config(itemView: drinksView)
        } else {
            cell.config(itemView: coffeeBeansView)
        }
        return cell
    }

    
}
