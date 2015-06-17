//
//  ViewController.m
//  RottenFruit
//
//  Created by Allen Chiang on 6/16/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    NSString *posterUrlString = [self.movie valueForKeyPath:@"posters.detailed"];
    posterUrlString = [self convertPosterUrlStringToHighRes:posterUrlString];
    [self.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Helper to workaround Rotten Tomatoes only giving low res images.
- (NSString *)convertPosterUrlStringToHighRes:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

@end
