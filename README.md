# privately_FunctC_116
self_use of Functional connectivity for Atlas116
This is the self-use MATLAB code,
for the Atlas116-based time-series data produced by REST_V1.8_130615 toolkit(Matlab).

====!!ATTENTION!!====
to conduct import2xlsONEstateV05.m,

the step3 needs pre-load next following add-path in MATLAB:

*A. nonfractal code, by "Wonsang You".
(https://www.researchgate.net/project/Fractal-based-analysis-of-resting-state-fMRI)

*B. wmtsa-matlab-0.2.6, by officially MATLAB web.

======
import2xlsONEstateV05.m
======
This file process the following 4 jobs:

1.
load Atlas116 times series data,
compute the Pearson's coefficient (r) -based Functionnal connectivity Matrix.

2.
Fisher's r-to-z transformation

3.
use "Wonsang You"s theory, 
to Estimation of nonfractal connectivity from fMRI signals

4.
export subjectdata.xls
export pictures.



======
test08.m
======
This file process the following 4 jobs:
1.
load subjectdata.xls produced by import2xlsONEstateV05.m


