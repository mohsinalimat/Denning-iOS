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
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

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
    self.subjectLabel.text = event.caseName.uppercaseString;
    NSArray *noName = [DIHelpers separateNameIntoTwo:event.FileNo];
    self.fileNoLabel.text = noName[0];
    self.fileName.text = noName[1];
    self.caseNoLabel.text = event.caseNo;
    self.locationLabel.text = event.location;
    self.eventStartDatelabel.text = [DIHelpers getOnlyDateFromDateTime:event.eventStart];
    self.eventEndDateLabel.text = [DIHelpers getOnlyDateFromDateTime:event.eventEnd];
    self.dayLabel.text = [DIHelpers getDayFromDate:event.eventStart];
    self.eventStartTimeLabel.text = [DIHelpers getTimeFromDate:event.eventStart];
    self.counsel.text = event.counsel;
}

@end
