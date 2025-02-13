To fix this, you must ensure that the observer stops observing the object before the object is deallocated.  This can be done by removing the observer in the `-dealloc` method of the observed object or by checking for nil in the `observeValueForKeyPath` method.

```objectivec
@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.observedObject == nil) return;
    NSLog (@"Value changed: %@
", [self.observedObject someProperty]);
}
@end

@implementation MyObservedObject
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"someProperty"];
    [super dealloc];
}
@end
```
Alternatively, use a block-based KVO mechanism which simplifies this handling.