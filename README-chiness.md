# SJLineRefresh

- **介绍**
***
高度自定义的线性下拉刷新控件

- **使用**
***
 ` 1.基础用法`
```swift
let aPath = Bundle.main.path(forResource: "HHMedic", ofType: "plist")!
let aConfig = SJRefreshConfig(plist: aPath)
tableView.sj_header = SJRefreshView(config: aConfig) { [weak self] in
  // do your refresh
}
```
` 2.全局使用`
```swift
let aPath = getCurrentBundle().path(forResource: "HHMedic", ofType: "plist") ?? ""
SJRefreshManager.default.defaultConfig = SJRefreshConfig(plist: aPath) // 设置全局config
tableView.sj_header = SJRefreshView.default { [weak self] in
	// 刷新回调
	// 结束刷新
	self?.tableView.endRefresh()
}
// plist只加载一次
```
` 3.手动刷新/结束`
```swift
tableView.beginRefresh() // 手动开始刷新
tableView.endRefresh()   // 结束刷新
```

` 4.动画参数`
```swift
startRatio // 开始动画的起始点与整个高度的比例
endRatio   // 结束动画的起始点与整个高度的比例
stepLength // 每个line"闪烁"所用时间
stepDuration // "闪烁"的动画时长
style  // 动画类型
	normal // 默认
	stay   // "闪烁"完成后保持闪烁状态
	step   // 下拉时,一个line绘制完成后才继续下一个绘制
	reverse //从最后一个line往前"闪烁
```
![debug](./images/debug.gif)

- **创建形状**
***

```descript
- 使用PaintCode画线, 在plist中写入对应的所有线条的起始点和终点(数量要保持一致)
- 下拉刷新视图的宽高等于起点和终点的最大距离, 居中对齐
```

- **安装**
***
**CocoaPods**

```ruby
pod 'SJLineRefresh', '~> 1.1.1'
```
**Carthage**
```
github "515783034/SJLIineRefresh" ~> 1.1.1
```

- **参考**
***
[MJRefresh](https://github.com/CoderMJLee/MJRefresh)

[CBStoreHouseRefreshControl](https://github.com/coolbeet/CBStoreHouseRefreshControl)
