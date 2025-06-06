#!/usr/bin/env python

from psyclone.psyir.transformations import LoopTiling2DTrans
from psyclone.psyir.transformations import OMPLoopTrans
from psyclone.psyir.nodes import Loop

def trans(psyir):

  trans_loop = psyir.walk(Loop)[2]

  OMPLoopTrans(omp_directive="paralleldo").apply(trans_loop, collapse=2)

  tile_opts = {"hoist_loop_bounds": False,
               "tilesize": 32}
  LoopTiling2DTrans().apply(trans_loop, options=tile_opts)
