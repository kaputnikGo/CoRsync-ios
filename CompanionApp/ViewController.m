//
//  ViewController.m
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
{
    HomeModel *_homeModel;
    NSArray *_feedItems;
    FeedItem *_selectedFeedItem;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set this view controller object as the delegate and data source for the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.listTableView reloadData];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the listing to be shown
    FeedItem *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text = item.title;
    
    return myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set selected feeditem to var
    _selectedFeedItem = _feedItems[indexPath.row];
    
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    DetailViewController *detailVC = segue.destinationViewController;
    
    // Set the property to the selected listing so when the view for
    // detail view controller loads, it can access that property to get the feeditem obj
    detailVC.selectedFeedItem = _selectedFeedItem;
}

@end
