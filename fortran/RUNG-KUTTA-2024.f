CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE SOLVER OF THE MEMS MASS BLOCK MOVEMENT EQUATION         CCCC
CCCCCC INPUT:  ACCELERATION ACTIVATED ON MEMS DIE                  CCCC
CCCCCC OUTPUT: DISPLACEMENT OF MASS BLOCK                          CCCC
CCCCCC THE RELATIONSHIP BETWEEN INPUT AND OUTPUT IS GOVERNED       CCCC
CCCCCC BY SECOND ORDER DIFFERENTIAL EQUATION OF SPRING-DAMPING     CCCC
CCCCCC SYSTEM.                                                     CCCC
CCCCCC THE EQUATION IS SOLVED NUMERICALLY BY 4TH RUNGE-KUTTA       CCCC
CCCCCC METHODS.                                                    CCCC
CCCCCC DATE: 2024.04.26                                            CCCC
CCCCCC AUTHER: XIAOYUAN YU, ZEYU WANG, CHANGCHUN YANG              CCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      PARAMETER (N_LENTH=2000000)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC INPUT ACCELERATION IS DEFINED BY THE ARRAY ACCEL(*)         CCCC
CCCCCC OUTPUT DISPLACEMENT IS DEFINED BY THE ARRAY DISP(*)         CCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 ACCEL(N_LENTH)
      REAL*8 DISP(N_LENTH)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE PARAMTERS OF THE MEMS DIES                               CCC
CCCCCC THE MASS OF THE MASS BLOCK IS DEFINED BY Amass               CCC
CCCCCC THE SPRING COEFICIENT IS DEFINED BY CoefSpr                  CCC
CCCCCC THE DUMPING COEFICIENT IS DEFINED BY CoefDmp                 CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 Amass
      REAL*8 CoefSpr
      REAL*8 CoefDmp
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC RUNGE-KUTTA COEFICIENTS ARE DEFINED BY                      CCCC
CCCCCC (Disp_k1,Disp_k2,Disp_k3,Disp_k4)                           CCCC
CCCCCC FOR RUNGE-KUTTA (K1,K2,K3,K4) OF DISPLACEMENT,              CCCC
CCCCCC (Velo_k1,Velo_k2,Velo_k3,Velo_k4)                           CCCC
CCCCCC FOR RUNGE-KUTTA (K1,K2,K3,K4) OF VELOCITY.                  CCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 Disp_k1
      REAL*8 Disp_k2
      REAL*8 Disp_k3
      REAL*8 Disp_k4
      REAL*8 Velo_k1
      REAL*8 Velo_k2
      REAL*8 Velo_k3
      REAL*8 Velo_k4
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC DEFINE PARAMETERS NEED FOR SIMULATION CALCULATION          CCCCC
CCCCCC THE SIMULATION TIME INTERVAL: DT_time                      CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 DT_time
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE ITERATIVE DISPLACEMENT IS DEFINED BY DispIter          CCCCC
CCCCCC THE ITERATIVE VELOCITY IS DEFINED BY VeloIter              CCCCC
CCCCCC THE TEMPORARY DISPLACEMENT IS DEFINED BY DispTmp           CCCCC
CCCCCC THE TEMPORARY VELOCITY IS DEFINED BY VeloTmp               CCCCC
CCCCCC THE TRMPORARY ACCELERATION IS DEFINED BY AccelTmp          CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 DispIter
      REAL*8 VeloIter
      REAL*8 DispTmp
      REAL*8 VeloTmp
      REAL*8 AccelTmp
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC CONSTANT PI                                                CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 PI
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC MEMS DIE SYSTEM PARAMETER ASSIGNMENT                         CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      Amass=7.45/10000000.
      CoefSPr=5.623
      CoefDmp=4.95/1000000.
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE PARAMETERS FOR SIMULATION CALCUL                         CCC
CCCCCC DT_time IS TAKEN AS 1 us                                     CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DT_time=1.0/1000000.
      PI=4.*atan(1.0)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE ACCELERATION FORCED TO THE MEMS DIE                      CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
!       DO 100 K=1,N_LENTH
!           Time0=(k-1.)*DT_time
!           ACCEL(K)=0.00004*SIN(2.0*PI*50*Time0)
!       !     ACCEL(K)=40.*SIN(2.0*PI*50*Time0)
! 100   continue
      ! open(13,file="fortran-sin.dat")
      ! do i=1,N_LENTH
      !     write(13,*) ACCEL(i)
      ! enddo
      ! close(13)
      open(10,file="standard_input.dat", status="old", action="read")
      do i=1,N_LENTH
            read(10,*,IOSTAT=io_stat) ACCEL(i)
      enddo
      close(10)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SPRING COEFFICIENT(CoefSpr) AND DUMPING COEFFICITNE(CoefDmp) CCC
CCCCCC ARE NORMALIZED BY MASS OF MASS BLOCK.                        CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CoefSpr=CoefSpr/Amass
      CoefDmp=CoefDmp/Amass
      ! CoefSpr=7540516.00
      ! CoefSpr=75405160.00
      ! CoefDmp=6.63285017
!     CoefSpr1=2.746*1000.0
!     CoefSpr1=CoefSpr1*CoefSpr1
!     CoefDmp1=2.746*1000.0/414.0
!     write(*,*) CoefSpr, CoefSpr1, CoefDmp, CoefDmp1
!     stop
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE INITIAL CONDITIONS                                       CCC
CCCCCC WHEN TIME IS 0, SUPPOSE DISPLACEMENT IS 0 AND VELOCITY IS 0  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DispIter=0.0
      VeloIter=0.0
      DISP(1)=DispIter
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SIMULATION COMPUTATION                                     CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DO 200 K=1,N_LENTH-1
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC DISPLAY CALCULATION PROGRESS EVERY 1000 STEPS              CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          if(k/1000*1000.eq.k) then
              write(*,*) k
          endif
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC CALCULATE ACCELERATION ON THE TIME OF (t+DT_time/2)        CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          AccelTmp=(ACCEL(k)+ACCEL(k+1))*0.5
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE FIRST STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          Disp_k1=VeloIter
          Velo_k1=-CoefSpr*DispIter-CoefDmp*VeloIter
     &            +ACCEL(k)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE SECOND STEP OF THE 4TH ORDER RUNGE-KUTTA                 CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k1*DT_time/2.0
          VeloTmp=VeloIter+Velo_k1*DT_time/2.0
          Disp_k2=VeloTmp
          Velo_k2=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +AccelTmp
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE THIRD STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k2*DT_time/2.0
          VeloTmp=VeloIter+Velo_k2*DT_time/2.0
          Disp_k3=VeloTmp
          Velo_k3=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +AccelTmp
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC   THE 4TH STEP OF THE 4TH ORDER RUNGE-KUTTA                   CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k3*DT_time
          VeloTmp=VeloIter+Velo_k3*DT_time
          Disp_k4=VeloTmp
          Velo_k4=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +ACCEl(K+1)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC  THE SIMULATION OF DISPLACE AND VEOCITY OF THE MASS OF MEMS  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispIter=DispIter+(Disp_k1+2.*Disp_k2+2.*Disk_k3+Disp_k4)
     &                      /6.0*DT_time
          VeloIter=VeloIter+(Velo_k1+2.*Velo_k2+2.*Velo_k3+Velo_k4)
     &                      /6.0*DT_time
          DISP(K+1)=DispIter
200   CONTINUE
      open(14,file="disp_for.dat")
      do i=1,N_LENTH
          write(14,*) i,DISP(i)
      enddo
      close(14)
      end
