# PDNSWDXFXL
##下面是展示图片
![image](https://github.com/5174773/UITabBar-animation/blob/master/tabbar.gif)


需要把 LJGNB.h  LJGNB.M 放入自己的项目即可


/添加动画
-(void)tabBarBtnDidClick:(UIControl *)tabBarButton
{
//遍历出tabbar上的图片
for (UIView *imageView in tabBarButton.subviews)
{
//判断图片是否是
if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
{
imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);

//动画
[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:9 options:0 animations:^{

imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);

} completion:^(BOOL finished) {

}];
}
}
}
