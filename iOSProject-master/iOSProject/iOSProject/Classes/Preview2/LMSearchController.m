//
//  LMSearchController.m
//  iOSProject
//
//  Created by lgm on 2020/11/25.
//  Copyright © 2020 github.com/njhu. All rights reserved.
// 搜索功能

#import "LMSearchController.h"
#import "PYSearch.h"
#import "PYTempViewController.h"

@interface LMSearchController () <PYSearchViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *tableView;
    PYSearchViewController *searchViewController;
}

@end

@implementation LMSearchController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden=NO;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden=YES;

    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索样式列表";
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    if ([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) { // Adjust for iPad
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@88);
    }];
    
    

    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 5 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (0 == indexPath.section) {
        cell.textLabel.text = @[@"默认搜索样式", @"彩色标签样式", @"搜索标签带边框样式", @"热词标签圆角", @"热词排名样式", @"热词标签矩形样式"][indexPath.row];
    } else {
        cell.textLabel.text = @[@"PYSearchHistoryStyleDefault", @"PYSearchHistoryStyleNormalTag", @"PYSearchHistoryStyleColorfulTag", @"PYSearchHistoryStyleBorderTag", @"PYSearchHistoryStyleARCBorderTag"][indexPath.row];
    }
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    
    [self addSearchBar:hotSeaches];
    
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [self.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
   
      //搜索历史的个数
       searchViewController.searchHistoriesCount=5;
     
    
    // 3. Set style for popular search and search history
    if (0 == indexPath.section) {
        searchViewController.hotSearchStyle = (NSInteger)indexPath.row;
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    } else {
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row;
    }
    // 4. Set delegate
    searchViewController.delegate = self;
    
    
    
    

    
    // 5. Present(Modal) or push search view controller
    // Present(Modal)
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //[self presentViewController:nav animated:YES completion:nil];
    // Push
    // Set mode of show search view controller, default is `PYSearchViewControllerShowModeModal`
    
    
    
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    [self.navigationController pushViewController:searchViewController animated:YES];

}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? NSLocalizedString(@"PYExampleTableSectionZeroTitle", @"选择搜索历史风格（热门搜索为默认风格)") : NSLocalizedString(@"PYExampleTableSectionZeroTitle", @"选择热门搜索风格（搜索历史为默认风格)");
}






#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    
    //输入框进行编辑的时候联想功能
    
//    if (searchText.length) {
//        // Simulate a send request to get a search suggestions
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // Refresh and display the search suggustions
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
//    }
    
    
    
}




#pragma mark - LMJNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - LMJNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}






#pragma mark-创建搜索
-(void)addSearchBar:(NSArray *)arr{
    
    searchViewController =[[PYSearchViewController alloc]init];
    searchViewController.delegate=self;
    [searchViewController setHotSearches:arr];
    
    
//
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:<#(NSArray<NSString *> *)#> searchBarPlaceholder:<#(NSString *)#>
    
}


//- (UIView *)lmjNavigationBarTitleView:(LMJNavigationBar *)navigationBar{
//
//
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,50,22)];
//    view.backgroundColor=[UIColor redColor];
//
//    return view;
//
//}










@end
