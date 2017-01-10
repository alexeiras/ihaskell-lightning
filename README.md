IHaskell-Lightning
=======================

Basic integration of [lightning-haskell](http://hackage.haskell.org/package/lightning-haskell) into [IHaskell](http://hackage.haskell.org/package/ihaskell).

A convenience type and its `IHaskellDisplay` instance is provided to run and display [Lightning](http://lightning-viz.org/) visualizations in just one line:
```haskell
Lgn defaultLightningOptions $ scatterPlot def { spX = [1,2,3], spY = [4,1,2] }
```

