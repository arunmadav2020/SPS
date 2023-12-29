//
//  DetailViewController.swift
//  CocktailBook
//
//  Created by Arun Kumar on 11/12/2023.
//

import UIKit

typealias needsToUpdate = ((String, Bool) -> Void)
class DetailViewController: UIViewController {

    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel :CocktailDetailsViewModel?
    var isFavouriteChanged = false
    var backButtonTap: needsToUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        // Do any additional setup after loading the view.
        
    }
    init(viewModel: CocktailDetailsViewModelProtocol){
        self.viewModel = viewModel as? CocktailDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        setupNavigationBar()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            tableView?.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
        tableView.register(IngredientsTableViewCell.nib, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
    }
    
    func initViewModel(){
        guard let viewModel = viewModel else { return }
        if #available(iOS 15, *) {
            prepTimeLabel.text = String(localized: "\(viewModel.preparationTime) minutes")
        } else {
            prepTimeLabel.text = NSLocalizedString("\(viewModel.preparationTime) minutes", comment: "")
        } 
        setFavouriteButtonImage(isFavourite: viewModel.favourite)
        cocktailImageView.image = UIImage(named: viewModel.imageName)
        longDescriptionLabel.text = viewModel.longDescription
    }
    func setFavouriteButtonImage(isFavourite: Bool){
        if isFavourite{
            navigationItem.rightBarButtonItem?.image = UserReaction().favourite
        }
        else{
            navigationItem.rightBarButtonItem?.image = UserReaction().not_favourite
        }
    }
    func setupNavigationBar(){
        navigationController?.navigationItem.backButtonTitle = NSLocalizedString("All Cocktails", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UserReaction().not_favourite, style: .plain, target: self, action: #selector(didTapFavouritesButton))
    }
    
    @objc public func didTapFavouritesButton() {
        print("Favourited")
        isFavouriteChanged = true
        guard let viewModel = viewModel else { return }
        setFavouriteButtonImage(isFavourite: !viewModel.favourite)
    }
    
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            if(isFavouriteChanged){
                guard let viewModel = viewModel else { return }
                backButtonTap?(viewModel.identifier, !viewModel.favourite)
            }
        }
    }
}
extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else{ fatalError("xib does not exists") }
        let cellVM = viewModel?.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
}
