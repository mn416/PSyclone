program matmul_example
  use omp_lib

  implicit none

  ! Matrix dimensions 
  ! Note exact power-of-2 is slow (cache line aliasing?)
  integer, parameter :: n = 1025
  integer, parameter :: m = 1025
  integer, parameter :: p = 1025

  ! Input and output (transposed) matrices
  integer, dimension(:, :), allocatable :: a, b, c, gold

  ! Loop variables
  integer :: x, y, k, acc

  ! Timing
  real(kind=8) :: start, fin

  ! Check correctness
  logical :: ok

  allocate(a(n, m))
  allocate(b(p, n))
  allocate(c(p, m))
  allocate(gold(p, m))

  ! Initialise first input matrix
  do y = 1, m
    do x = 1, n
      a(x, y) = x
    end do
  end do

  ! Initialise second input matrix
  do y = 1, n
    do x = 1, p
      b(x, y) = x
    end do
  end do

  ! Initialise result matrix
  c(:, :) = 0

  start = omp_get_wtime()

  ! Matrix multiply code
  do y = 1, m
    do x = 1, p
      do k = 1, n
        c(x, y) = c(x, y) + a(k, y) * b(x, k)
      end do
    end do
  end do

  fin = omp_get_wtime()

  ! Check result
  ok = .true.
  gold = matmul(a, b)
  do y = 1, m
    do x = 1, p
      ok = ok .and. c(x, y) == gold(x, y)
    end do
  end do

  ! Report success/fail and run time
  if (ok) then
    print "('Passed', f7.4, 's')", fin - start
  else
    print *, "Failed"
  end if
end program matmul_example
