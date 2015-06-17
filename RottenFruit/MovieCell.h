//
//  MovieCellTableViewCell.h
//  RottenFruit
//
//  Created by Allen Chiang on 6/16/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end
