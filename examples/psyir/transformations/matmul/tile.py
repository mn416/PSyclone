#!/usr/bin/env python

from psyclone.psyir.transformations import LoopTiling2DTrans
from psyclone.psyir.transformations import OMPLoopTrans
from psyclone.psyir.nodes import Loop

def trans(psyir):

  mm_loop = psyir.walk(Loop)[4]

  tile_opts = {"hoist_loop_bounds": False,
               "tilesize": 8}

  LoopTiling2DTrans().apply(mm_loop, options=tile_opts)
