//
//  HomeModel.m
//

#import "HomeModel.h"

@implementation HomeModel

- (void)downloadItems
{
    // Create feed parser and pass the URL of the feed
    NSURL *feedURL = [NSURL URLWithString:@"http://coradviser.com.au/feed/rss/"];
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    
    // Delegate must conform to 'MWFeedParserDelegate'
    self.feedParser.delegate = self;
    
    // Parse the feeds info (title, link) and all feed items
    self.feedParser.feedParseType = ParseTypeFull;
    
    // Connection type
    self.feedParser.connectionType = ConnectionTypeAsynchronously;
    
    // Begin parsing
    [self.feedParser parse];
}

// Called when data has downloaded and parsing has begun
- (void)feedParserDidStart:(MWFeedParser *)parser
{
    self.feedItems = [[NSMutableArray alloc] init];
}

// Provides info about a feed item
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    FeedItem *feedItem = [[FeedItem alloc] init];
    feedItem.title = item.title;
    feedItem.url = item.link;
    
    [self.feedItems addObject:feedItem];
}

// Parsing complete or stopped at any time by 'stopParsing'
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:self.feedItems];
    }
}

// Parsing failed
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    
}

@end
