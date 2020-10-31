Function description
====================

The functions of our pipeline

----

List of functions in the ``src`` folder.

.. module:: src

.. autofunction:: initPTB
.. autofunction:: drawFieldOfVIew
.. autofunction:: eyeTracker
.. autofunction:: getExperimentEnd
.. autofunction:: getExperimentStart
.. autofunction:: isOctave
.. autofunction:: readAndFilterLogfile
.. autofunction:: waitForTrigger
.. autofunction:: waitFor

----

List of functions in the ``src/aperture`` folder.

(to add saveAperture)

.. module:: src.aperture

.. autofunction:: apertureTexture
.. autofunction:: eccenLogSpeed
.. autofunction:: getApertureName
.. autofunction:: saveApertures
.. autofunction:: smoothOval
.. autofunction:: smoothRect

----

List of functions in the ``src/dot`` folder.

.. module:: src.dot

.. autofunction:: computeCartCoord
.. autofunction:: computeRadialMotionDirection
.. autofunction:: decomposeMotion
.. autofunction:: dotMotionSimulation
.. autofunction:: dotTexture
.. autofunction:: generateNewDotPositions
.. autofunction:: initDots
.. autofunction:: reseedDots
.. autofunction:: seedDots
.. autofunction:: setDotDirection
.. autofunction:: updateDots

----

List of functions in the ``src/errors`` folder.

.. module:: src.errors

.. autofunction:: errorAbort
.. autofunction:: errorAbortGetReponse
.. autofunction:: errorDistanceToScreen
.. autofunction:: errorRestrictedKeysGetReponse

----

List of functions in the ``src/fixation`` folder.

.. module:: src.fixation

.. autofunction:: drawFixation
.. autofunction:: initFixation

----

List of functions in the ``src/keyboard`` folder.

.. module:: src.keyboard

.. autofunction:: getResponse
.. autofunction:: checkAbort
.. autofunction:: checkAbortGetResponse
.. autofunction:: collectAndSaveResponses
.. autofunction:: pressSpaceForMe
.. autofunction:: testKeyboards

----

List of functions in the ``src/randomization`` folder.

.. module:: src.randomization

.. autofunction:: repeatShuffleConditions
.. autofunction:: setTargetPositionInSequence
.. autofunction:: shuffle

----

List of functions in the ``src/screen`` folder.

.. module:: src.screen

.. autofunction:: farewellScreen
.. autofunction:: standByScreen

----

List of functions in the ``src/utils`` folder.

(to add makeGif)

.. module:: src.utils

.. autofunction:: checkPtbVersion
.. autofunction:: cleanUp
.. autofunction:: computeFOV
.. autofunction:: degToPix
.. autofunction:: pixToDeg
.. autofunction:: printCreditsCppPtb
.. autofunction:: printScreen
.. autofunction:: setDefaults
.. autofunction:: setDefaultsPTB
.. autofunction:: setUpRand
