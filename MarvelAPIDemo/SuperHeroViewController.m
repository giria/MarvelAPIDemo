//
//  SuperHeroViewController.m
//  MarvelAPIDemo
//
//  Created by Diego Freniche Brito on 07/07/14.
//  Copyright (c) 2014 Diego Freniche Brito. All rights reserved.
//

#import "SuperHeroViewController.h"

#import "SuperHero.h"
#import "SuperHeroParser.h"
#import "MarvelAPIHelper.h"
#import "ImageDownloader.h"


@interface SuperHeroViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgHero;
@property (weak, nonatomic) IBOutlet UILabel *lblHeroName;
@property (strong, nonatomic) IBOutlet UIView *scrollingView;
@property (strong, nonatomic) IBOutlet UITextView *txtHeroDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtHeroName;

@end

@implementation SuperHeroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initScrollingFrame];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downloadHero)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.imgHero addGestureRecognizer:tapGesture];
    [self.txtHeroName resignFirstResponder];
    
}

- (void)initScrollingFrame {
    CGRect rect = CGRectMake(0, 1000, self.scrollingView.frame.size.width, self.scrollingView.frame.size.height);
    
    [self.scrollingView setFrame:rect];
    
    [self.scrollingView.layer setCornerRadius:20];
}

- (void)downloadHero {
    
    MarvelAPIHelper *mah = [[MarvelAPIHelper alloc] init];
    
    [mah setPublicKey:@"bd8f8a972db1c721bb21aaf100f2e707"];
    [mah setSecretKey:@"8a73988fb7552d0013a1c3148739962c2e7c477e"];
    
    [mah dataForSuperheroNamed:self.txtHeroName.text completion:^(NSData *resultData) {
        
        SuperHeroParser *parser = [[SuperHeroParser alloc] init];
        SuperHero *hulk = [parser superHeroWithData:resultData];
        self.lblHeroName.text = hulk.name;
        self.txtHeroDescription.text = hulk.heroDescription;
        
        [ImageDownloader downloadImageUsingUrl:hulk.thumbnail completion:^(UIImage *image) {
            self.imgHero.image = image;

        }];
        
        [self animateDescription];
    }];
    
    
    
}



- (void)hideKeyboard {
    [self.txtHeroName resignFirstResponder];

}

- (void)animateDescription {
    [self.view addSubview:self.scrollingView];
    
    [UIView animateWithDuration:2 animations:^{
        CGRect rect = CGRectMake(0, 100, self.scrollingView.frame.size.width, self.scrollingView.frame.size.height);
        
        [self.scrollingView setFrame:rect];
    }];
    
    [self hideKeyboard];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
