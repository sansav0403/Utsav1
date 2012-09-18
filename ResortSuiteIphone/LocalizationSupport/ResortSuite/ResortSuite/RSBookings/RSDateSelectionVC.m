    //
//  RSDateSelectionVC.m
//  ResortSuite
//
//  Created by Cybage on 10/10/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSDateSelectionVC.h"
#import "ResortSuiteAppDelegate.h"
#import "RSBookingTableView.h"
#import "RSBookingTableViewCell.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaServiceBookingMainVC.h"
#import "RSSelectedGolfLocation.h"
#import "DateManager.h"

@implementation RSDateSelectionVC

@synthesize pickerType;
@synthesize dateString;
@synthesize timeString;
@synthesize isGolf;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(id) initWithSection:(int) section dateString:(NSString *) dateStr
{
    if ((self = [super init ])) {
        pickerType = section;
        
        DLog(@"DATE STRING : %@",dateStr);
        if(pickerType == DatePicker )
        {
            self.dateString = dateStr;
        }
        else if(pickerType == TimePicker)
        {
            self.timeString = dateStr;
        }
    }

	
	return self;
}

-(id) initWithSection:(int) section dateString:(NSString *) dateStr timeString:(NSString *) timeStr;
{
     if ((self = [super init ])) {
         pickerType = section;
         
         DLog(@"DATE STRING : %@",dateStr);
         DLog(@"TIME STRING : %@",timeStr);
         if(pickerType == DatePicker )
         {
             self.dateString = dateStr;
         }
         else if(pickerType == TimePicker)
         {
             self.dateString = dateStr;
             self.timeString = timeStr;
         }
     }
	return self;
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];

	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
        mainFieldArray = nil;
	}
	if (pickerType == DatePicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:@"Date",nil];	
	}
	else if (pickerType == TimePicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:@"Time",nil];
	}
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
        subFieldArray = nil;
	}
    dayTimes = [[NSMutableArray alloc]initWithObjects:@"",@"", nil]; //place emty string for start/end time
                                                                    // alloc befre callin addcontrols function
    //Add UI controls to the view
    [self addControlsToView];   
    
	if (pickerType == DatePicker && ![self.dateString isEqualToString:NONE])    //if none set the array with current time
    {
        subFieldArray = [[NSMutableArray alloc] initWithObjects:self.dateString, nil];
	}
	else if (pickerType == TimePicker && ![self.timeString isEqualToString:NONE])
    { 
        subFieldArray = [[NSMutableArray alloc] initWithObjects:self.timeString, nil];
	}
    //if time / date string sent are none then get the date/time from picker and update subarray
	else  if (pickerType == TimePicker )    
    {
		subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, nil];
        //-------------------------
        NSDate *pickerDate = datePicker.date;
        DLog(@"time before: %@",datePicker.date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"hh:mm a"];        
        
        [subFieldArray removeObjectAtIndex:0];
        [subFieldArray insertObject:[DateManager stringFromDate:pickerDate withDateFormat:khh_mm_aFormat] atIndex:0];
        [dateFormatter release];
        //-------------------------
	}	
    else if(pickerType == DatePicker)
    {
        subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, nil];
        //------------------------                
        NSDate *pickerDate = datePicker.date;
        DLog(@"date before: %@",datePicker.date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
        
        [subFieldArray removeObjectAtIndex:0];
        [subFieldArray insertObject:[DateManager stringFromDate:pickerDate withDateFormat:MMMM_dd_yyyyFormat] atIndex:0];
        [dateFormatter release];
        
        [self setMinimumAndMaximumTimeForTheSelectedDate: pickerDate];  //to set the start and end tiem of the day
        //-------------------------------
    }
    
    dayTimes = [[NSMutableArray alloc]initWithObjects:@"",@"", nil]; //place emty string for start/end time
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [subFieldArray release];        //were not released
    [mainFieldArray release];
    
    [dateString release];
    [timeString release];

    [dayTimes release];
    [super dealloc];
}


#pragma mark Add UI controls to the view

-(void) addControlsToView
{	
	//Display label to the view
	UILabel *instructionLabel = [[UILabel alloc] initWithFrame:InstructionLabelFrame];
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	//Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	//Add Search Button
	searchButton = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[searchButton setBackgroundColor:[UIColor clearColor]];
	//searchButton.enabled = NO;
    searchButton.enabled = YES;
	
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:Disabled_Select_button];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:Enabled_Select_button];
	
	[searchButton setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
	[searchButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
	
	[self.view addSubview:searchButton];
	[searchButton release];
	
	
	
	//Action for fetching the Spa Classes
	[searchButton addTarget:self action:@selector(selectDateOrTime:) 
		   forControlEvents:UIControlEventTouchUpInside];	
	
	// Initialization code
	datePicker = [[UIDatePicker alloc] initWithFrame:PickerFrame];			
	datePicker.hidden = NO;
    datePicker.datePickerMode = UIDatePickerModeDate;
	
	if (pickerType == DatePicker) {     
		 NSDate *minDate;
		 
		if ([self.dateString isEqualToString:NONE]) {			//put a boolean to check if we dont want the picker  to start from today's date.
			datePicker.date = [NSDate date];    //booking start for today onwards
            DLog(@"Date Picker Date : %@",datePicker.date);	
        }
		else {			
			datePicker.date = [self dateFromString:self.dateString];
            DLog(@"Date Picker Date : %@",datePicker.date);
		}
		
		minDate = [NSDate dateWithTimeInterval:0 sinceDate: [NSDate date]];
		datePicker.minimumDate = minDate;

	}
	else if (pickerType == TimePicker) { //2,1
		NSDate *currentSelectedDate = [self dateFromString:self.dateString];
		
		[self setMinimumAndMaximumTimeForTheSelectedDate: currentSelectedDate];
		
		datePicker.minuteInterval = TIME_INTERVAL;
		datePicker.datePickerMode = UIDatePickerModeTime;
		datePicker.timeZone = [NSTimeZone localTimeZone];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
		
		//set the date using setDate: setMonth: setYear:
		[dateComponents setHour:selectedDateStartTime]; // Lower bound as per 24 hrs Clock  
		NSDate *targetDate = [gregorian dateFromComponents:dateComponents];
		datePicker.minimumDate = targetDate;		
		
        if (![self.timeString isEqualToString:NONE])
        {			
            DLog(@"self time string = %@",self.timeString);
            NSString* forMinute = [self.timeString substringWithRange:NSMakeRange(3, 2)];

            if ([self.timeString hasSuffix:PM_CAPITAL] || [self.timeString hasSuffix:PM])
            {
                [dateComponents setHour:[self convertTimeIn24Hour:[self.timeString intValue] ]];  // Upper bound as per 24 hrs Clock    
            }
            else
            {
                [dateComponents setHour:[self.timeString intValue] ];  // Upper bound as per 24 hrs Clock    
            }
            [dateComponents setMinute:[forMinute intValue] ];  // Upper bound as per 24 hrs Clock    
            targetDate = [gregorian dateFromComponents:dateComponents];
            
            [datePicker setDate:targetDate animated:YES];
		}
        else
        {
            [datePicker setDate:targetDate animated:YES];
        }
		
		//set the date using setDate: setMonth: setYear:
		[dateComponents setHour:selectedDateEndTime];  // Upper bound as per 24 hrs Clock    
		targetDate = [gregorian dateFromComponents:dateComponents];
		datePicker.maximumDate = targetDate;
		
		[gregorian release];
		[dateComponents release];
	}
	
	[datePicker addTarget:self action:@selector(selectValueFromPicker:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:datePicker];
	
	[datePicker release];
}


-(void) selectDateOrTime: (id) sender
{

    //if selected for the first time then take todas date and send the notice. else take from array.
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DatePickerValueChanged" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [mainFieldArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	
	//Store the text content for the cell
	cell.textLabel.text = [mainFieldArray objectAtIndex:indexPath.row];	
    
	cell.detailTextLabel.text = [subFieldArray objectAtIndex:indexPath.row];
	
	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
	
	//Set the accessory view 
	[cell setAccessoryViewImage:NO];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}	

#pragma mark Date Formatting

#pragma mark -  Date and Time picker selection methods

-(void)selectValueFromPicker:(id)sender
{
    UIDatePicker *tempPicker = (UIDatePicker *)sender;
    NSDate *pickerDate = tempPicker.date;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	if (pickerType == DatePicker ) {
        
        //To set the start time for the selected date
		[self setMinimumAndMaximumTimeForTheSelectedDate: pickerDate];

		[dateFormatter setDateFormat:@"MMMM dd, yyyy"];
	}
	else if (pickerType == TimePicker) {
		[dateFormatter setDateFormat:@"hh:mm a"];
	}	
	
	[subFieldArray removeObjectAtIndex:0];
	[subFieldArray insertObject:[dateFormatter stringFromDate:pickerDate] atIndex:0];
	
	[mainTableView reloadData];
	
	[dateFormatter release];
    searchButton.enabled = YES;

}

-(void)setMinimumAndMaximumTimeForTheSelectedDate:(NSDate *)selectedDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:selectedDate];    
    NSInteger weekday = [weekdayComponents weekday];
	[gregorian release];
	
    if(isGolf)
    {
        [self createStartAndEndTimeForGolfWithWeekday:weekday];
    }
    else
    {
        [self createStartAndEndTimeForSpaWithWeekday:weekday];
	}
}

-(void)createStartAndEndTimeForGolfWithWeekday:(NSInteger )weekday
{   
    RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];
    
    // weekday 1 = Sunday for Gregorian calendar
	switch (weekday)
    {
       	case SUNDAY:
        { 
            [self createSelectedDateTime:location.golfLocation.sundayOpen withEndTime:location.golfLocation.sundayClose];
        }            
            break;
        case MONDAY:
        {
            [self createSelectedDateTime:location.golfLocation.mondayOpen withEndTime:location.golfLocation.mondayClose];
        }
            break;
        case TUESDAY:
        {
            [self createSelectedDateTime:location.golfLocation.tuesdayOpen withEndTime:location.golfLocation.tuesdayClose];
        }
            break;
        case WEDNESDAY:
        {
            [self createSelectedDateTime:location.golfLocation.wednesdayOpen withEndTime:location.golfLocation.wednesdayClose];
        }
            break;
        case THRUSDAY:
        {			
            [self createSelectedDateTime:location.golfLocation.thursdayOpen withEndTime:location.golfLocation.thursdayClose];
            
        }
            break;
        case FRIDAY:
        {
            [self createSelectedDateTime:location.golfLocation.fridayOpen withEndTime:location.golfLocation.fridayClose];
        }
            break;
        case SATURDAY:
        {
            [self createSelectedDateTime:location.golfLocation.saturdayOpen withEndTime:location.golfLocation.saturdayClose];
        }
            break;
        default:
            break;
    }

}
-(void)createStartAndEndTimeForSpaWithWeekday:(NSInteger )weekday
{   
    //Get the selected Spa location from the shared instance
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
	
	// weekday 1 = Sunday for Gregorian calendar
	switch (weekday)
    {
       	case SUNDAY:
        {
            [self createSelectedDateTime:location.spaLocation.sundayStart withEndTime:location.spaLocation.sundayEnd];
        }            
            break;
        case MONDAY:
        {
            [self createSelectedDateTime:location.spaLocation.mondayStart withEndTime:location.spaLocation.mondayEnd];
        }
            break;
        case TUESDAY:
        {
            [self createSelectedDateTime:location.spaLocation.tuesdayStart withEndTime:location.spaLocation.tuesdayEnd];
        }
            break;
        case WEDNESDAY:
        {
            [self createSelectedDateTime:location.spaLocation.wednesdayStart withEndTime:location.spaLocation.wednesdayEnd];
        }
            break;
        case THRUSDAY:
        {			
            [self createSelectedDateTime:location.spaLocation.thrusdayStart withEndTime:location.spaLocation.thrusdayEnd];
			
        }
            break;
        case FRIDAY:
        {
            [self createSelectedDateTime:location.spaLocation.fridayStart withEndTime:location.spaLocation.fridayEnd];
        }
            break;
        case SATURDAY:
        {
            [self createSelectedDateTime:location.spaLocation.saturdayStart withEndTime:location.spaLocation.saturdayEnd];
        }
            break;
        default:
            break;
    }

}

-(void) createSelectedDateTime:(NSString *)startTimeOfDay withEndTime:(NSString *)endTimeOfDay
{
    DLog(@"Start date %@ and EndDate %@",startTimeOfDay, endTimeOfDay );

    [dayTimes replaceObjectAtIndex:0 withObject:startTimeOfDay];
    [dayTimes replaceObjectAtIndex:1 withObject:endTimeOfDay];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DayTimesAccordingToDate" 
														object:dayTimes];
    //[dayTimes release];   //now released in dealloc
    
    selectedDateStartTime = [startTimeOfDay intValue];
    selectedDateEndTime = [endTimeOfDay intValue];
    
    if ([startTimeOfDay hasSuffix:PM_CAPITAL]) {
        selectedDateStartTime = [self convertTimeIn24Hour:selectedDateStartTime];				
    }			
    if ([endTimeOfDay hasSuffix:PM_CAPITAL]) {
        selectedDateEndTime = [self convertTimeIn24Hour:selectedDateEndTime]; 
    }
}

-(NSDate *)dateFromString:(NSString *)stringDate {
    /*DLog(@"DAte string Picker from string %@", stringDate);
    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy"];		

	NSDate *Date = [dateFormatter dateFromString:stringDate];
   
    DLog(@"DAte Picker from string %@", Date);
	[dateFormatter release];
	return Date;*/
    
    //Due to date format change
    NSDate *Date = [DateManager dateFromString:stringDate withDateFormat:MMMM_dd_yyyyFormat];
    DLog(@"DAte Picker from string %@", Date);
	return Date;
	
}

//Convert the time in 24 hr clock time if time > 12 PM
-(int) convertTimeIn24Hour: (int) time
{
	return (time + 12);
}

@end
