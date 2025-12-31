//
//  UserListViewController.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//

// com.mobarok.MVVMUsersApp
import UIKit

final class UserListViewController: UIViewController {

    private let tableView = UITableView()
    private let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        view.backgroundColor = .white
        setupTable()
        bindViewModel()
        viewModel.fetchUsers()
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in self?.tableView.reloadData() }
        viewModel.onError = { [weak self] message in self?.showError(message) }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UserListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.configure(with: viewModel.user(at: indexPath.row))
        return cell
    }
}
