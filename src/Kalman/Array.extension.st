Extension { #name : #Array }

{ #category : #'*Kalman' }
Array >> kalmaned [
	| res filter |
	res := OrderedCollection new. 
	filter := LinearKalman new. 
	self do: [ :item | res add: (filter newEstimate: item) ].
	^ res asArray
]

{ #category : #'*Kalman' }
Array >> kalmanedWithNoiseCovariance: anInteger [ 
	| res filter |
	res := OrderedCollection new. 
	filter := LinearKalman new.
	filter r: anInteger. 
	self do: [ :item | res add: (filter newEstimate: item) ].
	^ res asArray
]
