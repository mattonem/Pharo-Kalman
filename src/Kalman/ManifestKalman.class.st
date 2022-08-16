"
c := RSChart new.
p := RSLinePlot new.
c addDecoration: RSYMarkerDecoration new max.
c addDecoration: RSVerticalTick new asFloat.

noise := PMNormalDistribution new: 0 sigma: 0.15.

x := (0 to: 700).

tcourse := x collect: [:xi | (((xi/2) degrees cos + (xi)  degrees sin) * 10)  + 90  ].
rcourse := tcourse collect: [:xi | Point r: 1 theta: xi degreesToRadians  ].

course := rcourse collect: [:xi | (xi + (noise random @ noise random))normalized  ].

y := course collect: [:xi |  xi].
f := LinearKalman3 new initWithMeasureUncertainty: (noise variance @ noise variance)*5  processVariance: 0.02; yourself.
y2 := y collect: [ :xi | f measure: xi ].
y3 := rcourse withIndexCollect: [ :xi :i | (xi - (course at: i))  ].
y4 := rcourse withIndexCollect: [ :xi :i | (xi - (y2 at: i)) ].

p := RSLinePlot new.
p x: x y: (y collect: [:xi |xi theta radiansToDegrees ]).
c addPlot: p. 

p := RSLinePlot new.
p x: x y: (y2 collect: [:xi |xi theta radiansToDegrees]).
c addPlot: p. 

""p := RSLinePlot new.
p x: x y: (y3 collect: [:xi |xi r]).
c addPlot: p. ""

p := RSLinePlot new.
p x: x y: (y4 collect: [:xi |xi r]).
c addPlot: p. 


c.

"
Class {
	#name : #ManifestKalman,
	#superclass : #PackageManifest,
	#category : #'Kalman-Manifest'
}
