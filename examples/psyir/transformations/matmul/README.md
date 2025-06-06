# Transforming matrix multiplication

This example demonstrates use of the `LoopTiling2DTrans`, `ChunkLoopTrans`, `LoopSwapTrans`, and `OMPLoopTrans` transformations to optimise the classic matrix-multiplication loop.

Given `matmul.f90` containing the loop

```
! Matrix multiply loop
do y = 1, m
  do x = 1, p
    do k = 1, n
      c(x, y) = c(x, y) + a(k, y) * b(x, k)
    end do
  end do
end do
```

the PSyclone script `omp-tile-reorder.py` produces code containing the loop:

```
!$omp parallel do collapse(2) default(shared), private(k,k_out_var,x,x_out_var,y,y_out_var), schedule(auto)
do y_out_var = 1, m, 8
  do x_out_var = 1, p, 8
    do k_out_var = 1, n, 8
      do y = y_out_var, MIN(y_out_var + (8 - 1), m), 1
        do x = x_out_var, MIN(x_out_var + (8 - 1), p), 1
          do k = k_out_var, MIN(k_out_var + (8 - 1), n), 1
            c(x,y) = c(x,y) + a(k,y) * b(x,k)
          enddo
        enddo
      enddo
    enddo
  enddo
enddo
```

It would be nice if `LoopTiling2DTrans` was generalised to arbitrary dimensions, which would eliminate the need for `ChunkLoopTrans` and `LoopSwapTrans` in this example.

To run the example, simply type `make`. Sample output is as follows.

```
$ make
./matmul
Passed 1.1494s

./matmul_tiled
Passed 0.8962s

./matmul_omp
Passed 0.2410s

./matmul_omp_tiled
Passed 0.1927s

./matmul_omp_tiled_reordered
Passed 0.1050s
```
