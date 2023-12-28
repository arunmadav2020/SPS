//
//  CocktailViewController.swift
//  CocktailBook
//
//  Created by Arun Kumar on 09/12/2023.
//

import UIKit

class CocktailViewController: UIViewController {
    
    @IBOutlet weak var filterSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let loadingViewController = LoadingViewController()

//    lazy var viewModel: CocktailsViewModel = {
//        CocktailsViewModel()
//    }
    var viewModel = CocktailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
        add(loadingViewController)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    func initView(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "All Cocktails"
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 24)]
        
        filterSegment.selectedSegmentIndex = 0
        filterSegment.isUserInteractionEnabled = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.register(CocktailCell.nib, forCellReuseIdentifier: CocktailCell.identifier)
        
    }
    
    func initViewModel(){
        viewModel.getCocktails()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                self?.tableView.reloadData()
                self?.view.layoutIfNeeded()
                
                if (self?.filterSegment.isUserInteractionEnabled == false){
                    self?.filterSegment.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @IBAction func filterCocktails(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            viewModel.filterByType(type: .alcoholic)
        case 2:
            viewModel.filterByType(type: .nonAlcoholic)
        default:
            viewModel.filterByType()
        }
    }
    
    func showDetailsPage(cocktailDetailViewModel: CocktailDetailsViewModel){
        let detailsPage = DetailViewController(viewModel: cocktailDetailViewModel)
//        detailsPage.viewModel = cocktailDetailViewModel
        detailsPage.title = cocktailDetailViewModel.name
        detailsPage.backButtonTap = { [weak self] identifier, isFav in
            if let loadingVC = self?.loadingViewController{
                self?.add(loadingVC)
            }
            if (isFav){
                self?.viewModel.addToFavourites(identifier: identifier)
            }
            else{
                self?.viewModel.removeFromFavourites(identifier: identifier)
            }
        }
        self.navigationController?.pushViewController (detailsPage, animated: true)
    }

}

extension CocktailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVM = viewModel.getDetDetailViewModel(at: indexPath)
        showDetailsPage(cocktailDetailViewModel: detailVM)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CocktailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cocktailCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CocktailCell.identifier, for: indexPath) as? CocktailCell else{ fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
}
