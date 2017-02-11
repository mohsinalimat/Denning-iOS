//
//  EventCell.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventCell.h"

@interface EventCell()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet QMImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventStartlabel;
@property (weak, nonatomic) IBOutlet UILabel *eventEndLabel;

@end

@implementation EventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithEvent:(EventModel*) event
{
    self.descriptionLabel.text = event.description;
    self.eventStartlabel.text = event.eventStart;
    self.eventEndLabel.text = event.eventEnd;
    self.locationLabel.text = event.location;
    self.reminderLabel.text = event.reminder1;
}

@end
