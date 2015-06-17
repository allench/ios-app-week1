//
//  MovieViewController.m
//  RottenFruit
//
//  Created by Allen Chiang on 6/16/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyMovieCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Do any additional setup after loading the view.
    
    NSString *apiURLString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiURLString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = dict[@"movies"];
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *posterUrlString = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
    
    //NSLog(@"Row %ld", (long)indexPath.row);
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MovieCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    ViewController *destinationVC = segue.destinationViewController;
    destinationVC.movie = movie;
}

@end
