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
      PARAMETER (N_LENTH=2100000)
      PARAMETER (N_PERIOD=128000)
      ! PARAMETER (N_PERIOD=100000)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC OUTPUT DISPLACEMENT IS DEFINED BY THE ARRAY DISP(*)         CCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 ACCEL(N_LENTH)
      REAL*8 DISP(N_LENTH)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC END OF PID COMPUTATION                                       CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      INTEGER BIT(N_PERIOD)
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
CCCCCC THE PARAMETERS OF THE MEMS DIES                              CCC
CCCCCC THE AREA OF THE AREA IS DEFINED BY AREA                      CCC
CCCCCC THE GAP OF MEMS IS DEFINED BY GAP                            CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 Area
      REAL*8 Gap
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
CCCCCC DIELECTRIC CONSTANT                                          CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      REAL*8 E0
      REAL*8 Capaci
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC MEMS DIE SYSTEM PARAMETER ASSIGNMENT                         CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      Amass=7.45/10000000.
      CoefSPr=5.623
      CoefDmp=4.95/1000000.
      Area=1.7388/1000000.
      Gap=3/1000000.
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE PARAMETERS FOR SIMULATION CALCUL                         CCC
CCCCCC DT_time IS TAKEN AS 1 us                                     CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DT_time=1.0/1000000.
      PI=4.*atan(1.0)
      E0=8.85/1000000000000.
      Capaci=E0*Area/Gap
      ! write(*,*) Capaci
      V_ref=2.5
      F_elec=.5*E0*Area/Gap/Gap*4*V_ref*V_ref*20/63
      ! write(*,*) F_elec/Amass/9.8*0.75
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE ACCELERATION FORCED TO THE MEMS DIE                      CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DO 100 K=1,N_LENTH
          Time0=(k-1)*DT_time
          ACCEL(K)=0.1*SIN(2.0*PI*50*Time0)
          ! ACCEL(K)=0.
100   continue
      ! open(13,file="test_input.dat")
      ! do i=1,N_LENTH
      !     write(13,*) i,ACCEL(i)
      ! enddo
      ! close(13)
      open(15,file="test_value.dat")
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SPRING COEFFICIENT(CoefSpr) AND DUMPING COEFFICITNE(CoefDmp) CCC
CCCCCC ARE NORMALIZED BY MASS OF MASS BLOCK.                        CCC
CCCCCC THE ELECTRICAL FORCE COEFICIENT IS DEFINED BY CoefFel        CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CoefSpr=CoefSpr/Amass
      CoefDmp=CoefDmp/Amass
      CoefFel=.5*E0*Area*4*V_ref*V_ref/Amass/10
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE INITIAL CONDITIONS                                       CCC
CCCCCC WHEN TIME IS 0, SUPPOSE DISPLACEMENT IS 0 AND VELOCITY IS 0  CCC
CCCCCC THE FIRST INTEGRAL       V_in10=0                            CCC
CCCCCC AND THE SECOND INTERGRAL V_in20=0                            CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DispIter=0.0
      VeloIter=0.0
      DISP(1)=DispIter
      ! BIT(1)=0
      V_in10=0.0
      V_in20=0.0
      ! AccelFel=0.0
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SIMULATION COMPUTATION                                     CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DO 200 K=1,N_PERIOD
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC DISPLAY CALCULATION PROGRESS EVERY 1000 STEPS              CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          if(k/1000*1000.eq.k) then
              write(*,*) k
          endif
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          if(k.eq.1) then
      DO 310 K1=1,16
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC CALCULATE ACCELERATION ON THE TIME OF (t+DT_time/2)        CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          k2=(k-1)*16+k1
          AccelTmp=(ACCEL(k2)+ACCEL(k2+1))*0.5
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE FIRST STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          Disp_k1=VeloIter
          Velo_k1=-CoefSpr*DispIter-CoefDmp*VeloIter
     &            +ACCEL(k2)
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
     &            +ACCEl(k2+1)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC  THE SIMULATION OF DISPLACE AND VEOCITY OF THE MASS OF MEMS  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispIter=DispIter+(Disp_k1+2.*Disp_k2+2.*Disk_k3+Disp_k4)
     &                      /6.0*DT_time
          VeloIter=VeloIter+(Velo_k1+2.*Velo_k2+2.*Velo_k3+Velo_k4)
     &                      /6.0*DT_time
          DISP(K2+1)=DispIter
310    continue
      endif
      if(k.gt.1) then


CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC DETECTION STAGE                                              CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DO 320 K1=1,8
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC CALCULATE ACCELERATION ON THE TIME OF (t+DT_time/2)        CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          k2=(k-1)*16+k1
          AccelTmp=(ACCEL(k2)+ACCEL(k2+1))*0.5
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE FIRST STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          Disp_k1=VeloIter
          Velo_k1=-CoefSpr*DispIter-CoefDmp*VeloIter
     &            +ACCEL(k2)
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
     &            +ACCEl(K2+1)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC  THE SIMULATION OF DISPLACE AND VEOCITY OF THE MASS OF MEMS  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispIter=DispIter+(Disp_k1+2.*Disp_k2+2.*Disk_k3+Disp_k4)
     &                      /6.0*DT_time
          VeloIter=VeloIter+(Velo_k1+2.*Velo_k2+2.*Velo_k3+Velo_k4)
     &                      /6.0*DT_time
          DISP(K2+1)=DispIter
320    continue

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC PID COMPUTATION                                              CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC INPUT STAGE                                                  CCC
CCCCCC TODO: COEFICIENT                                             CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      V_input=-DispIter
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SECOND INTERGRATOR STAGE                                     CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      V_int2=V_int20+0.038*V_int10
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC FEEDBACK STAGE                                               CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      V_feedb=-0.01139*V_int2
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC FIRST  INTERGRATOR STAGE                                     CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      V_int1=V_int10+0.06*V_feedb+1.55*V_input
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC SUM STAGE                                                    CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      V_sum = -5.*V_input - .516*V_int1 - .5*V_int2
      ! V_sum = -V_sum
      ! V_sum = -5*V_input

      V_int10=V_int1
      V_int20=V_int2
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC QUANTIZER                                                    CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      if(V_sum.ge.0) then
        ! pull DOWN
          N_bit=-1
      endif
      if(V_sum.lt.0) then
        ! pull UP
          N_bit=1
      endif
      write(15,*) V_sum,N_bit
      BIT(K-1)=N_bit
      write(15,*) K,V_input
      if(k/5*5.eq.k) then
      !  pause
      endif


CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC END OF PID COMPUTATION                                       CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC



CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC FEEDBACK STAGE                                               CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      DO 330 K1=9,16
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC CALCULATE ACCELERATION ON THE TIME OF (t+DT_time/2)        CCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          k2=(k-1)*16+k1
          AccelTmp=(ACCEL(k2)+ACCEL(k2+1))*0.5
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC PID FEEDBACK STAGE                                           CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      if(N_bit.eq.1) then
        ! pull UP
          AccelFel= CoefFel/((Gap-DispIter)*(Gap-DispIter))
      endif
      if(N_bit.eq.(-1)) then
        ! pull DOWN
          AccelFel=-CoefFel/((Gap+DispIter)*(Gap+DispIter))
      endif
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE FIRST STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          Disp_k1=VeloIter
          Velo_k1=-CoefSpr*DispIter-CoefDmp*VeloIter
     &            +ACCEL(k2)+AccelFel
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE SECOND STEP OF THE 4TH ORDER RUNGE-KUTTA                 CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k1*DT_time/2.0
          VeloTmp=VeloIter+Velo_k1*DT_time/2.0
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC PID FEEDBACK STAGE                                           CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      if(N_bit.eq.1) then
        ! pull UP
          AccelFel= CoefFel/((Gap-DispTmp)*(Gap-DispTmp))
      endif
      if(N_bit.eq.(-1)) then
        ! pull DOWN
          AccelFel=-CoefFel/((Gap+DispTmp)*(Gap+DispTmp))
      endif

          Disp_k2=VeloTmp
          Velo_k2=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +AccelTmp+AccelFel
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC THE THIRD STEP OF THE 4TH ORDER RUNGE-KUTTA                  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k2*DT_time/2.0
          VeloTmp=VeloIter+Velo_k2*DT_time/2.0
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC PID FEEDBACK STAGE                                           CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      if(N_bit.eq.1) then
        ! pull UP
          AccelFel= CoefFel/((Gap-DispTmp)*(Gap-DispTmp))
      endif
      if(N_bit.eq.(-1)) then
        ! pull DOWN
          AccelFel=-CoefFel/((Gap+DispTmp)*(Gap+DispTmp))
      endif
          Disp_k3=VeloTmp
          Velo_k3=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +AccelTmp+AccelFel
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC   THE 4TH STEP OF THE 4TH ORDER RUNGE-KUTTA                   CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispTmp=DispIter+Disp_k3*DT_time
          VeloTmp=VeloIter+Velo_k3*DT_time
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC PID FEEDBACK STAGE                                           CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      if(N_bit.eq.1) then
        ! pull UP
          AccelFel= CoefFel/((Gap-DispTmp)*(Gap-DispTmp))
      endif
      if(N_bit.eq.(-1)) then
        ! pull DOWN
          AccelFel=-CoefFel/((Gap+DispTmp)*(Gap+DispTmp))
      endif
          write(15,*) AccelFel,Gap,DispIter
          Disp_k4=VeloTmp
          Velo_k4=-CoefSpr*DispTmp-CoefDmp*VeloTmp
     &            +ACCEl(K2+1)+AccelFel
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCC  THE SIMULATION OF DISPLACE AND VEOCITY OF THE MASS OF MEMS  CCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          DispIter=DispIter+(Disp_k1+2.*Disp_k2+2.*Disk_k3+Disp_k4)
     &                      /6.0*DT_time
          VeloIter=VeloIter+(Velo_k1+2.*Velo_k2+2.*Velo_k3+Velo_k4)
     &                      /6.0*DT_time
          DISP(K2+1)=DispIter

330    continue
      endif


      

200   CONTINUE
      open(14,file="disp_9.dat")
      do i=1,N_LENTH
          write(14,*) i,DISP(i)
      enddo
      close(14)
      open(19,file="bit.dat")
      do i=1,N_PERIOD
        write(19,*) i,BIT(i)
      enddo
      close(19)
      end
