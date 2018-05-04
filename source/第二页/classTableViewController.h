//
//  classTableViewController.h
//  作业派-学生端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classTableViewCell.h"

@protocol pro_searchBar//协议
@optional
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar;
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope;
@end

@interface classTableViewController : UITableViewController
//搜索栏
@property (strong, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (nonatomic,weak) id<pro_searchBar> delegate_searchBar;
@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;
@property NSString *search_putin;

@end
