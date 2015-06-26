//
//  DetailViewController.h
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) FeedItem *selectedFeedItem;

@end
