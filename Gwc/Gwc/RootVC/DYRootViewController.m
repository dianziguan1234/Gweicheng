//
//  DYRootViewController.m
//  Gwc
//
//  Created by apple on 8/26/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "DYRootViewController.h"
#import "Person.h"
@interface DYRootViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation DYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.NavTitle = @"首页";
    Person *p =[[Person alloc] init];
    [p setValue:@"zhansan" forKey:@"name"];
    NSLog(@"%@",[p description]);
    [self setNavRightButtonWithText:@"点击" action:@selector(click)];
    
    //确定是水平滚动，还是垂直滚动
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    
//    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 320, 400) collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor =[UIColor yellowColor];
//    self.collectionView.dataSource=self;
//    self.collectionView.delegate=self;
//    //[self.collectionView setBackgroundColor:[UIColor clearColor]];
//    
//    //注册Cell，必须要有
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
//    [self.view addSubview:self.collectionView];
//    NSString *str1 = @"lnj";
//    NSString *str2 = [NSString stringWithFormat:@"lnj"];
//    if ([str1 isEqualToString:str2]) {
//        NSLog(@"字符串内容一样");
//    }
//    
//    if (str1 == str2) {
//        NSLog(@"字符串地址一样");
//    }
//    NSString *str = @"<head>小码哥</head>";
//    //str = [str substringFromIndex:7];
//    NSLog(@"str = %c", [str characterAtIndex:0]);
    
}

- (void)click {
    [UIView animateWithDuration:10 animations:^{
        self.collectionView.backgroundColor =[UIColor clearColor];
    } completion:^(BOOL finished) {
        //[self.collectionView removeFromSuperview];
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%d",indexPath.item);
    NSLog(@"row=======%d",indexPath.row);
    NSLog(@"section===%d",indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
