    //
//  RSSpaClassCategoryVC.m
//  ResortSuite
//
//  Created by Cybage on 04/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaClassCategoryVC.h"
#import "RSSpaClass.h"
#import "RSSelectedSpaLocation.h"

#import "RSSpaClassTableViewController.h"

@implementation RSSpaClassCategoryVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithClassDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        
    }
    return  self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	//in sub
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
   	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",location.spaLocation.locationName] fontSize:nil];
    //
    NSString *titeString = [NSString stringWithFormat:@"Select the %@ category",location.spaLocation.locationName];
    
	[self createTitleHeader:titeString yPosition:TitleHeaderYcord]; //funtin base call in sub
    
    
    [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)selectAction:(id)sender
{
   
    UIButton *selectedButton = (UIButton *)sender;
    RSSpaClassTableViewController *spaClassTableVC;
    
    spaClassTableVC = [[RSSpaClassTableViewController alloc] initWithSpaClassArray:
                       [self.categoryDictionary objectForKey:[self.keyArray objectAtIndex:selectedButton.tag]] ];      
    
    [self.navigationController pushViewController:spaClassTableVC animated:YES];
    [spaClassTableVC release];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
