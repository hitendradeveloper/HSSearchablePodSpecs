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
public class SearchableWrapper: NSObject ,Searchable {
    
    public var serverArray: [SearchableData]  = []
    public var searchedArray: [SearchableData]  = []
    
    public var isSearching: Bool = false
    public var dataArray: [SearchableData]  {
        return isSearching ? self.searchedArray : self.serverArray
    }
    
    //call back when requied
    public var searchingCallBack: SearchingCallBack?
    
}

//MARK:- UISearchBarDelegate
extension SearchableWrapper: UISearchBarDelegate{
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.searchingCallBack?(self.isSearching, "")
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearching = searchText.characters.count > 0
        self.searchedArray = self.serverArray.filter({( modelObject : SearchableData) -> Bool in
            let range = modelObject.searchValue.range(of: searchText, options: .caseInsensitive)
            return !((range?.isEmpty) ?? true)
        })
        self.searchingCallBack?(self.isSearching, searchText)
    }
}
