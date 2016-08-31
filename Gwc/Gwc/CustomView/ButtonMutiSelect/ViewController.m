

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray * btnArr;
    NSMutableArray * btnSeArr;//将选择状态的按钮放入该数组中
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btnArr = [[NSMutableArray alloc] init];
    
    [self createButtons];
}

-(void)createButtons{
    for (int i = 0; i < 6; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100 + 45 * i, 200, 30)];
        //btn.backgroundColor =[UIColor yellowColor];
        [btn setTitle:[NSString stringWithFormat:@"我是第%d个button", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //设置button字体对齐形式，在开发中可以用的到
        btn.tag =100+i;
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [btnArr addObject:btn];//将button放入数组中
    }
    
    //提交按钮
    UIButton * comiBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 175, 40)];
    comiBtn.backgroundColor = [UIColor yellowColor];
    [comiBtn setTitle:@"提交" forState:UIControlStateNormal];
    [comiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [comiBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [comiBtn addTarget:self action:@selector(comiBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comiBtn];
}

//button点击事件
-(void)btnClicked:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    
    btnSeArr = [[NSMutableArray alloc] init];
    
    int sum = 0;
    for (int i = 0; i < btnArr.count; i++) {
        UIButton * button = btnArr[i];
        if (button.selected == 1) {
            sum = sum + 1;
        }
    }
    
    //假设最多可以选三个
    if (sum > 3){
        btn.selected = NO;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已达到选择上限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (btn.isSelected == 1) {
        NSLog(@"按钮被选中");
    }
    else{
        NSLog(@"按钮没有被选中");
    }
    
    for (int i = 0; i < btnArr.count; i++) {
        UIButton * button = btnArr[i];
        if (button.selected == 1) {
            //将选择的按钮加入该数组中
            [btnSeArr addObject:[NSNumber numberWithFloat:button.tag]];
        }
    }
}

//提交按钮点击事件
-(void)comiBtnClicked{
    NSLog(@"::::%@", btnSeArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
