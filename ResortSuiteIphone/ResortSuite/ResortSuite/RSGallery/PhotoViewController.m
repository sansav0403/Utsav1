#import "PhotoViewController.h"
#import "ImageScrollView.h"
#import "StoreImageObj.h"

#define ImageBoundsHightOffset		100
@implementation PhotoViewController

#pragma mark -
#pragma mark View loading and unloading

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageArray : (NSArray*)imageLibrary index :(int)aIndex{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		__imageData = [[NSMutableArray alloc] initWithArray:imageLibrary];
		currentImageIndex = aIndex;
	}
	
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	[__imageData release];
    [pagingScrollView release];
    pagingScrollView = nil;
    [recycledPages release];
    recycledPages = nil;
    [visiblePages release];
    visiblePages = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return YES;
//}
- (void)dealloc
{
    [pagingScrollView release];
    [super dealloc];
}


- (UIImage *)imageAtIndex:(NSUInteger)index {
    NSString *imageName = [self imageNameAtIndex:index];

	UIImage *img = [UIImage imageNamed:imageName];

    return img;    
}

- (NSString *)imageNameAtIndex:(NSUInteger)index {
    NSString *name = nil;
    if (index < [__imageData count]) {
        StoreImageObj *imageObj = [__imageData objectAtIndex:index];
        name = imageObj.imageName;
    }
    return name;
}


-(NSDate *)stringToDate:(NSString *)stringDate{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];		
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
	
}

/*
 - (void)loadView 
 If you create your views manually, you must override this method and use it to create your views.
 If you use Interface Builder to create your views and initialize the view controller—that is, you 
 initialize the view using the initWithNibName:bundle: method, set the nibName and nibBundle properties directly,
 or create both your views and view controller in Interface Builder—then you must not override this method
 */
- (void)loadView 
{
    self.wantsFullScreenLayout = YES;
	
    // Configure the scrollView
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
    pagingScrollView.pagingEnabled = YES;
    pagingScrollView.backgroundColor = [UIColor blackColor];
    pagingScrollView.showsVerticalScrollIndicator = NO;
    pagingScrollView.showsHorizontalScrollIndicator = NO;
    pagingScrollView.contentSize = CGSizeMake(pagingScrollViewFrame.size.width * [__imageData count],
                                              pagingScrollViewFrame.size.height);
	pagingScrollView.bounces = NO;

    pagingScrollView.delegate = self;
    self.view = pagingScrollView;
	pagingScrollView.bounds = CGRectMake(0, 0, Screen_Width, Screen_Height);
    recycledPages = [[NSMutableSet alloc] init];
    visiblePages  = [[NSMutableSet alloc] init];
    [self processPages];	
}

- (void)viewDidLoad {
    [super viewDidLoad];	
	
	[self setTitle:[NSString stringWithFormat:@"%d of %d", currentImageIndex + 1, [__imageData count]]];
	
    //CGFloat topOffset = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    pagingScrollView.contentInset = UIEdgeInsetsMake(-ImageBoundsHightOffset, 0.0, 0.0, 0.0);

	[pagingScrollView setContentOffset:CGPointMake(currentImageIndex * Screen_Width, 0)];
}



- (void)processPages {
	
    // Calculate which pages are visible
    CGRect visibleBounds = pagingScrollView.bounds;

    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [__imageData count] - 1);
	
    if (lastNeededPageIndex >= 0) {
		
        // Recycle no-longer-visible pages 
        for (ImageScrollView *page in visiblePages) {
            if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
                [recycledPages addObject:page];
                [page removeFromSuperview];
            }
        }
        [visiblePages minusSet:recycledPages];
		
        // add missing pages
        for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
            if (![self isDisplayingPageForIndex:index]) {
                ImageScrollView *page = [self dequeueRecycledPage];
                if (page == nil) {
                    page = [[[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-100)] autorelease];
                }
                [self configurePage:page forIndex:index];
                [pagingScrollView addSubview:page];
                [visiblePages addObject:page];
            }
        }
    }
}

- (ImageScrollView *)dequeueRecycledPage {
    ImageScrollView *page = [recycledPages anyObject];
    if (page) {
        [[page retain] autorelease];
        [recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
    BOOL foundPage = NO;
    for (ImageScrollView *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index {
    page.index = index;
    page.frame = [self frameForPageAtIndex:index];
	
    [page displayImage:[self imageAtIndex:index]];
}


#pragma mark -
#pragma mark ScrollView delegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	[scrollView setDirectionalLockEnabled:YES];
	
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[scrollView setDirectionalLockEnabled:YES];
	int index = scrollView.contentOffset.x / Screen_Width;
	index = index+1;
	[self setTitle:[NSString stringWithFormat:@"%d of %d", index, [__imageData count]]];
	
    [self processPages];
}


#pragma mark -
#pragma mark  Frame calculations
#define PADDING  1

- (CGRect)frameForPagingScrollView {
    CGRect frame = CGRectMake(0, 0, Screen_Width, Screen_Height -ImageBoundsHightOffset);
    frame.origin.x -= PADDING;
    frame.size.width += (2*PADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect bounds = CGRectMake(0, 0, Screen_Width, Screen_Height);//pagingScrollView.bounds; 
    CGRect pageFrame = bounds;
	
    pageFrame.size.width -= (2 * (PADDING));
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}



@end
