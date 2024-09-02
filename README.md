I created a simple UI where LazyVStack embedded in ScrollView is in NavigationStack. Each of the item view has onAppear view modifier. In a real app I use onAppear for detecting which views are currently visible or become visible. Based on this, I mark these messages for these item views as read (it is a chat app). I noticed that when LazyStackView is pushed to the navigation stack, then it has larger height, item views are added, and then it resizes to the expected height. Because views are added before resize, item view's onAppear is incorrectly called.

Note: If I use List, then onAppear for item views is correct and only called for item views what are the one what should be visible (I can observe that List resizes to the correct size just before adding item views).
Note 2: If I present the same LazyVStack in a full screen sheet, then item view's onAppear is correctly called for item views what should be visible.

I can reproduce this with Xcode 16 beta 6 and Xcode 15.

On launch, it logs something like this to the console:
```
(0.0, 0.0)
(393.0, 668.3333333333334)
Item 2
Item 9
Item 6
Item 10
Item 5
Item 0
Item 7
Item 1
Item 8
Item 3
Item 4
Item 11
```
Tapping on one of the items pushes the same list view to the navigation stack:
```
(0.0, 0.0)
(393.0, 852.0)
Item 4
Item 10
Item 11
Item 5
Item 0
Item 13
Item 1
Item 3
Item 9
Item 12
Item 8
Item 7
Item 6
Item 2
(393.0, 668.3333333333334)
```

Note how the view gets a height of 852, then adds item views for that height, then resizes.

Expected: 
View is resized to final 668.3333333333334, then item views are added (the same way as List is behaving).
