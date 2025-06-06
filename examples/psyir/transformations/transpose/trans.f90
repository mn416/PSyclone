program trans_example
  use omp_lib

  implicit none

  ! Matrix dimensions 
  integer, parameter :: dim_x = 10000
  integer, parameter :: dim_y = 10000

  ! Input and output (transposed) matrices
  integer, dimension(:, :), allocatable :: m, m_t

  ! Loop variables
  integer :: x, y

  ! Timing
  real(kind=8) :: start, fin

  ! Check correctness
  logical :: ok

  allocate(m(dim_x, dim_y))
  allocate(m_t(dim_y, dim_x))

  ! Initialise input matrix
  do y = 1, dim_y
    do x = 1, dim_x
      m(x, y) = x
    end do
  end do

  start = omp_get_wtime()
  
  ! Matrix transpose code
  do y = 1, dim_y
    do x = 1, dim_x
      m_t(y, x) = m(x, y)
    end do
  end do

  fin = omp_get_wtime()

  ! Check result
  ok = .true.
  do y = 1, dim_y
    do x = 1, dim_x
      ok = ok .and. m_t(x, y) == y
    end do
  end do

  ! Report success/fail and run time
  if (ok) then
    print "('Passed', f7.4, 's')", fin - start
  else
    print *, "Failed"
  end if
end program trans_example
