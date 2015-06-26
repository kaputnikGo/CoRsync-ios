//
//  HomeModel.h
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"
#import "FeedItem.h"

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject<MWFeedParserDelegate>

@property (nonatomic, weak) id<HomeModelProtocol> delegate;
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, strong) NSMutableArray *feedItems;

- (void)downloadItems;

@end
