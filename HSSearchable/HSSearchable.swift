//
//  HSSearchable.swift
//  HSSearchable
//
//  Created by Hitendra iDev on 21/07/17.
//  Copyright © 2017 myCompany. All rights reserved.
//

import UIKit

public protocol SearchableData {
    /*
     @param: searchValue
     using this value from your dataModal, "searchedArray" will be generated
     */
    var searchValue: String {get}
}

public protocol Searchable {
    
    /*
     @param: serverArray
     this is the origional data array or source array, using this array we search the data
     */
    var serverArray: [SearchableData]  {get set}
    
    /*
     @param: searchedArray
     resulting array, based on the search text
     */
    var searchedArray: [SearchableData]  {get set}
    
    /*
     @param: isSearching
     to identify if user currently searching or not
     */
    var isSearching: Bool {get set}
    
    /*
     @param: dataArray
     this will return array to display the result,
        if      user searching, this will return the "searchedArray"
        else    this will return the "serverArray", main source array
     */
    var dataArray: [SearchableData]  {get}
}

public typealias SearchingCallBack = (_ isSearching: Bool, _ searchText: String)->(Void)

//MARK:- SearchableWrapper: Searchable
open class SearchableWrapper: NSObject ,Searchable {
    
    open var serverArray: [SearchableData]  = []
    open var searchedArray: [SearchableData]  = []
    
    open var isSearching: Bool = false
    open var dataArray: [SearchableData]  {
        return isSearching ? self.searchedArray : self.serverArray
    }
    
    //call back when requied
    open var searchingCallBack: SearchingCallBack?    
}

//MARK:- UISearchResultsUpdating
extension SearchableWrapper: UISearchResultsUpdating {
    open func updateSearchResults(for searchController: UISearchController) {
        self.search(phrase: searchController.searchBar.text ?? "")
    }
}

//MARK:- UISearchBarDelegate
extension SearchableWrapper: UISearchBarDelegate{
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.searchingCallBack?(self.isSearching, "")
    }
    
    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(phrase: searchText)
    }
}

//MARK:- Helper
extension SearchableWrapper {
    open func search(phrase searchText: String){
        self.isSearching = searchText.characters.count > 0
        self.searchedArray = self.serverArray.filter({( modelObject : SearchableData) -> Bool in
            let range = modelObject.searchValue.range(of: searchText, options: .caseInsensitive)
            return !((range?.isEmpty) ?? true)
        })
        self.searchingCallBack?(self.isSearching, searchText)
    }
}

