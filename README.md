# TargetQuitViewController
Back to target quit vc animatable.


UIViewController *tmpVC = [what vc you want to back to]; 
Then self.targetQuitViewController = tmpVC; 
[self backToTargetQuitViewController]; 

And it will back to tmpVC from self animatable, ignore self's parentVC or presentingVC.
