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
f := LinearKalman new initWithMeasureUncertainty: (noise variance @ noise variance)*5  processVariance: 0.02; yourself.
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
	#name : #LinearKalman,
	#superclass : #Object,
	#instVars : [
		'q',
		'err_measure',
		'err_estimate',
		'last_estimate'
	],
	#category : #Kalman
}

{ #category : #'as yet unclassified' }
LinearKalman >> errorEstimate [
	^ err_estimate 
]

{ #category : #'as yet unclassified' }
LinearKalman >> initWithMeasureUncertainty: aE_mea processVariance: aQ [

	err_measure := aE_mea.
	err_estimate := aE_mea.
	q := aQ
]

{ #category : #'as yet unclassified' }
LinearKalman >> measure: arg1 [

	| gain currentEstimate oldError |
	last_estimate ifNil: [ last_estimate := arg1 - arg1 ].
	gain := err_estimate / (err_estimate + err_measure).
	currentEstimate := last_estimate + (arg1 - last_estimate * gain).
	oldError := err_estimate.
	
	err_estimate := 1 - gain * oldError
	                + ((last_estimate - currentEstimate) abs * q).
	last_estimate := currentEstimate.
	^ currentEstimate
]
