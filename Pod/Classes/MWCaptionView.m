//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"

static const CGFloat labelPadding = 10;
static const CGFloat labelHeight = 21;

// Private
@interface MWCaptionView () {
    id <MWPhoto> _photo;
    UILabel *_counter;
    UILabel *_label;    
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
        self.barStyle = UIBarStyleBlackOpaque;
        self.tintColor = [UIColor colorWithWhite:237.0f/255.0f alpha:1.0f];
        self.barTintColor = [UIColor colorWithWhite:237.0f/255.0f alpha:1.0f];
        self.barStyle = UIBarStyleBlackOpaque;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_label.font}
                                                context:nil].size;
    return CGSizeMake(size.width, textSize.height + labelPadding * 3 + labelHeight);
}

- (void) setupCounter {
    _counter = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, labelPadding,
                                                                        self.bounds.size.width-labelPadding*2,
                                                                        labelHeight))];
    _counter.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _counter.opaque = NO;
    _counter.backgroundColor = [UIColor clearColor];
    _counter.textAlignment = NSTextAlignmentLeft;
    _counter.lineBreakMode = NSLineBreakByWordWrapping;
    
    _counter.numberOfLines = 0;
    _counter.textColor = [UIColor blackColor];
    _counter.font = [UIFont systemFontOfSize:17];
    NSString *text = @" ";
    if ([_photo respondsToSelector:@selector(indexString)]) {
        text = [_photo indexString] ? [_photo indexString] : @" ";
    }
    _counter.text = text;
    [_counter sizeToFit];
    [self addSubview:_counter];
}

- (void)setupCaption {
    [self setupCounter];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.font = [UIFont systemFontOfSize:17];
    
    NSString *text = @" ";
    if ([_photo respondsToSelector:@selector(caption)]) {
        text = [_photo caption] ? [_photo caption] : @" ";
    }
    CGSize textSize = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-labelPadding*2, 300)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_label.font}
                                                context:nil].size;

    _label.numberOfLines = 0;
    _label.textColor = [UIColor colorWithWhite:106.0/255.0f alpha:1.0f];
    
    
    [_label setFrame: CGRectIntegral(CGRectMake(labelPadding, (2 * labelPadding) + _counter.frame.size.height,textSize.width,textSize.height))];
    [_label setText:text];
    if ([_photo respondsToSelector:@selector(caption)]) {
        
    }
    [self addSubview:_label];
}


@end
