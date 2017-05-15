//
//  EventCell.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventCell.h"

@interface EventCell()
@property (weak, nonatomic) IBOutlet UILabel *counsel;

@property (weak, nonatomic) IBOutlet UILabel *caseNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet QMImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventStartDatelabel;
@property (weak, nonatomic) IBOutlet UILabel *eventEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventStartTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fileNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

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
    self.subjectLabel.text = event.subject;
    self.fileNoLabel.text = event.FileNo;
    self.caseNoLabel.text = event.caseNo;
    self.locationLabel.text = event.location;
    self.eventStartDatelabel.text = [DIHelpers getDateInLongForm:event.eventStart];
    self.eventEndDateLabel.text = [DIHelpers getDateInLongForm:event.eventEnd];
    self.eventStartTimeLabel.text = [DIHelpers getTimeFromDate:event.eventStart];
    self.counsel.text = event.counsel;
}

@end
