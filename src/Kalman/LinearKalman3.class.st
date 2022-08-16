Class {
	#name : #LinearKalman3,
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
LinearKalman3 >> errorEstimate [
	^ err_estimate 
]

{ #category : #'as yet unclassified' }
LinearKalman3 >> initWithMeasureUncertainty: aE_mea processVariance: aQ [

	err_measure := aE_mea.
	err_estimate := aE_mea.
	q := aQ
]

{ #category : #'as yet unclassified' }
LinearKalman3 >> measure: arg1 [

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

{ #category : #'as yet unclassified' }
LinearKalman3 >> measure: arg1  realVal: val [

	| gain currentEstimate oldError |
	last_estimate ifNil: [ last_estimate := arg1 - arg1 ].
	gain := err_estimate / (err_estimate + err_measure).
	currentEstimate := last_estimate + (arg1 - last_estimate * gain).
	oldError := err_estimate.
	
	err_estimate := 1 - gain * oldError
	                + ((last_estimate - currentEstimate) abs * q).
	((currentEstimate - val) abs > 100 degrees ) ifTrue: [ 1halt ].
	last_estimate := currentEstimate.
	
	^ currentEstimate
]
