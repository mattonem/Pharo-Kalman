Extension { #name : #GAngle }

{ #category : #'*Kalman' }
GAngle >> abs [
	^ (self > 180 degrees) ifTrue: [ self explementary ] ifFalse: [ self ]
]

{ #category : #'*Kalman' }
GAngle >> divideWithAngle: aGAngle [ 
	
	^ aGAngle radians / radians
]
