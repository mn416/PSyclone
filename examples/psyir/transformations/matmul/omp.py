#!/usr/bin/env python

from psyclone.psyir.transformations import LoopTiling2DTrans
from psyclone.psyir.transformations import OMPLoopTrans
from psyclone.psyir.nodes import Loop

def trans(psyir):

  mm_loop = psyir.walk(Loop)[4]

  OMPLoopTrans(omp_directive="paralleldo").apply(mm_loop, collapse=2)
