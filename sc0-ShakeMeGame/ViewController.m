//
//  ViewController.m
//  sc0-ShakeMeGame
//
//  Created by user on 10/2/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int counter;
    int score;
    int random;
    int gameMode; // 1 Game Playing
                  // 2 Game Over
}
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UISlider *sliderTimer;
@property (weak, nonatomic) IBOutlet UILabel *valueOfSlider;
@property (nonatomic) UIDeviceOrientation currentDeviceOrientation;
@property (weak, nonatomic) IBOutlet UILabel *orientationChangeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    score = 0;
    counter = 10;
    self.timerLbl.text = [NSString stringWithFormat:@"%i", counter];
    self.scoreLbl.text = [NSString stringWithFormat:@"%i", score];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startGamePressed:(id)sender {
    if (score == 0)
    {
        gameMode = 1;
        self.timerLbl.text  = [NSString  stringWithFormat:@"%i", counter];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCounter) userInfo:nil repeats:YES];
        self.startBtn.enabled = NO;
        self.sliderTimer.enabled = NO;
        [self randomAction];
        
    }
    
    if (counter == 0)
    {
        score = 0 ;
        counter = 10;
        self.timerLbl.text = [NSString stringWithFormat:@"%i", counter];
        self.scoreLbl.text = [NSString stringWithFormat:@"%i", score];
    }
}

-(void)startCounter {
    counter--;
    self.timerLbl.text = [NSString stringWithFormat:@"%i", counter];
    if  (counter == 0){
        [timer invalidate];
        gameMode = 2;
        [self.startBtn setTitle:@"Restart" forState:UIControlStateNormal];
        self.startBtn.enabled = YES;
        self.sliderTimer.enabled=YES;
    }
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if (random == 1){
        if (gameMode == 1){
            score +=1;
            self.scoreLbl.text = [NSString stringWithFormat:@"%i",score];
        }
    }
    [self randomAction];
}

- (IBAction)sliderChange:(id)sender {
    if(gameMode != 1){
        counter = (int) self.sliderTimer.value;
    }
    self.timerLbl.text = [NSString stringWithFormat:@"%i", counter];
    self.valueOfSlider.text = [NSString stringWithFormat:@"%i", counter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // Initial device orientation
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
    // Do what you want here
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
}

- (void)deviceDidRotate:(NSNotification *)notification
{
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
    // Do what you want here
    if(random == 2){
        if (gameMode == 1){
            score +=1;
            self.scoreLbl.text = [NSString stringWithFormat:@"%i",score];
        }
        
    }
    [self randomAction];
    
    
}
-(void)randomAction{
    if (gameMode == 1){
    NSInteger randomNumber = arc4random() % 2;
    random = (int) randomNumber + 1;
        if (random == 1)
            self.imageView.image = [UIImage imageNamed:@"shake.png"];
        if (random == 2)
            self.imageView.image = [UIImage imageNamed:@"rotate.png"];
    }
}
@end
