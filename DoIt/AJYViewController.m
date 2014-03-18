//
//  AJYViewController.m
//  DoIt
//
//  Created by Jian Yao Ang on 3/17/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "AJYViewController.h"

@interface AJYViewController () <UITableViewDataSource , UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray *items;
    BOOL isEditModeEnabled;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation AJYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [[NSMutableArray alloc] initWithObjects:@"One",@"Two",@"Three", nil];
    isEditModeEnabled = YES;

}

- (IBAction)onAddButtonPressed:(id)sender
{
    NSString *textFromMyTextField = self.myTextField.text;
    [items addObject:textFromMyTextField];
    [self.myTableView reloadData];
    self.myTextField.text = @"";
    NSLog(@"%@",items);
    [self.myTableView endEditing:YES];
}

- (IBAction)onEditButtonPressed:(UIButton *)sender
{
    if (isEditModeEnabled == YES) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        isEditModeEnabled = NO;
    }
    else {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        isEditModeEnabled = YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    cell.textLabel.text = [NSString stringWithFormat:@"string row = %i", indexPath.row];
    cell.textLabel.text = items[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
    
    if (isEditModeEnabled == NO) {
        [items removeObjectAtIndex:indexPath.row];
        [self.myTableView reloadData];
    }
}

#pragma mark - swipe to delete

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - swipe gesture
- (IBAction)swipeGesture:(UISwipeGestureRecognizer*)swipeGesture
{
    CGPoint point = [swipeGesture locationInView:self.myTableView];
    
}



@end
