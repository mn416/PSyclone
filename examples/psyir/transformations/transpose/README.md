# Transforming matrix transpose

This example demonstrates use of the `LoopTiling2DTrans` and `OMPLoopTrans` transformations to optimise the classic matrix-transpose loop.

Given `trans.f90` containing the loop

```
! Matrix transpose loop
do y = 1, dim_y
  do x = 1, dim_x
    m_t(y, x) = m(x, y)
  end do
end do
```

the PSyclone script `omp-tile.py` produces code containing the loop:

```
!$omp parallel do collapse(2) default(shared), private(x,x_out_var,y,y_out_var), schedule(auto)
do y_out_var = 1, dim_y, 32
  do x_out_var = 1, dim_x, 32
    do y = y_out_var, MIN(y_out_var + (32 - 1), dim_y), 1
      do x = x_out_var, MIN(x_out_var + (32 - 1), dim_x), 1
        m_t(y,x) = m(x,y)
      enddo
    enddo
  enddo
enddo
```

To run the example, simply type `make`. Sample output is as follows.

```
$ make
./trans
Passed 0.8120s

./trans_tiled
Passed 0.2701s

./trans_omp
Passed 0.3059s

./trans_omp_tiled
Passed 0.0543s
```
