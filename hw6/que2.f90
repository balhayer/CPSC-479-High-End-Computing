! Run using commands below:

! gfortran -o que2 que2.f90
! ./que2



! DECLARED VARIABLES 
PROGRAM main
    implicit none
    integer :: A(4, 4), B(4, 4), C(4, 4), temp, i, j  ! Declared a 4x4 matrix A & B.

    do i=1,4
        do j=1,4
            A(i, j) = 5     ! Declared A to 5.
            B(i, j) = i + j
            temp = 5 + i + j
            
            if (temp == 10) then   ! Replace in C the element with value 10 with value 18.
                temp = 18        ! Replace value with 18
            end if

            C(i, j) = temp
        end do
    end do

    do i=1,4
        do j=1,4
            print *, "A(", i, ", ", j, ") = ", A(i, j) ! prints the statement
            print *, "B(", i, ", ", j, ") = ", B(i, j) ! prints the statement
            print *, "C(", i, ", ", j, ") = ", C(i, j) ! prints the statement
            print *, "************"
        end do
    end do


END PROGRAM main !program ends
