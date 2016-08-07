//
//  MainTableViewController.m
//  EachBox
//
//  Created by lanou on 16/8/7.
//  Copyright © 2016年 wdx. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSArray *array;
    NSArray *dataArray;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搜索Demo";
    
    array = [NSArray arrayWithObjects:@"Aaa",@"Abb",@"Acc",@"BDC",@"DFF",@"zxx", nil];
    
    // 初始换一个searchBar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"搜索";
    
    // 设置为自身表头
    self.tableView.tableHeaderView = searchBar;
    
    // 显示ScopeBar
    [searchBar setShowsScopeBar:YES];
    [searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"A",@"B",@"C", nil]];
    // 选中索引按钮
    searchBar.selectedScopeButtonIndex = 0;
    // 用searchbar初始化SearchDisplayController
    // 并把searchDisplayController和当前controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 是 UITableViewDataSource
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
}


#pragma mark --- TableViewDataSource ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return array.count;
    }else{
        // 谓词搜索，检查的对象是否保存输入的文本
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
        dataArray = [[NSArray alloc] initWithArray:[array filteredArrayUsingPredicate:predicate]];
        return dataArray.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_ID = @"myCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
    }
    //给cell的text赋值
    if (tableView == self.tableView) {
        cell.textLabel.text = array[indexPath.row];
    }else{
        // 判断当前scope的inde是多少,并可设置显示不同的数据
        if (searchBar.selectedScopeButtonIndex == 1) {
            cell.textLabel.text = @"1~~111";
        }else{
            cell.textLabel.text = dataArray[indexPath.row];
        }
    }
    return cell;
}

#pragma mark -- 点击搜索结果的cell 返回列表页面

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == searchDisplayController.searchResultsTableView) {
        [searchDisplayController setActive:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}
//
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
