"
| x c p p2|
	x := 0 to: 20 by: 0.01.
	xe := (x collect: [ :i | (2 * i sin) + Random new next ]).
	c := RSChart new.
	p := RSLinePlot new.
	p x: x y: xe.
	p2 := RSLinePlot new.
	p2 x: x y: (xe kalmanedWithNoiseCovariance: 500).
	c addPlot: p.
	c addPlot: p2.
	c addDecoration: RSHorizontalTick new.
	c addDecoration: RSVerticalTick new asFloat.
	c addDecoration: RSYMarkerDecoration new average.
	c addDecoration: RSYMarkerDecoration new min.
	c addDecoration: RSYMarkerDecoration new max.
	c addDecoration: RSXMarkerDecoration new max.
	c addDecoration: RSXMarkerDecoration new min.
	c addDecoration: (RSXMarkerDecoration new value: 0).
	^ c
"
Class {
	#name : #LinearKalman,
	#superclass : #Object,
	#instVars : [
		'r',
		'h',
		'q',
		'u_hat',
		'k',
		'p'
	],
	#category : #Kalman
}

{ #category : #initialization }
LinearKalman >> initialize [ 	
	super initialize.
	r := 40. 
	h := 1.
	q := 10.
	p := 0.
	k := 0.

]

{ #category : #'instance creation' }
LinearKalman >> newEstimate: u [
	u_hat ifNil: [ u_hat := u ].
	k := p * h / (h * p * h + r).
	u_hat := u_hat + (k * (u - (h * u_hat))).
	p := (1 - (k * h) * p) + q.
	^ u_hat
]

{ #category : #'instance creation' }
LinearKalman >> r: aNumber [

	r := aNumber
]
