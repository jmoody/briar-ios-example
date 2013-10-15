#import "BrController.h"

@interface BrSliderController : BrController

@property (weak, nonatomic) IBOutlet UISlider *sliderEmotion;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewEmotion;
@property (weak, nonatomic) IBOutlet UILabel *labelEmotion;
@property (weak, nonatomic) IBOutlet UILabel *labelEmotionFloat;

- (IBAction)sliderValueDidChange:(UISlider *)sender;

@end
