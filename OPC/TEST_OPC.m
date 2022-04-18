%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Chapter 5 and 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GPSM_wa (Generalized PSM optimization with discretization penalty and wavelet penalty in coherent imaging system.)
GPSM_wa(80,pz_f,ra_f,2,2,0.01,80,0.5,0.5,0,0,0,0,scale1,28,120);% The result is shown in Fig. 5.16.
GPSM_wa(80,pz_f,ra_f,2,2,0.01,80,0.5,0.5,0.001,0.0001,0,0,scale1, 32,100);% The result is shown in Fig. 6.10.
GPSM_wa(80,pz_u,ra_u,4,2,0.01,80,0.5,0.5,0.01,0.001,0.2,0.001, scale1,44,200);% The result is shown in Fig. 6.15.
GPSM_wa(80,pz_f,ra_f,2,2,0.01,80,0.5,0.5,0.001,0.0001,0.03,0.001, scale1,36,230);% The result is shown in Fig. 6.16.
GPSM_wa(80,pz_u,ra_u,4,2,0.01,80,0.5,0.5,0.01,0.001,0.2,0.001, scale2,38,200);% The result is shown in Fig. 6.17.
%The algorithms are described in Sections 5.4.1, 6.1.3, 6.2.2, and 6.2.3.
%% GPSM_tv(Generalized PSM optimization with discretization penalty and total variation penalty in coherent imaging system.)
GPSM_tv(80,pz_u,ra_u,4,2,0.01,80,0.5,0.5,0,0,0,0,18,25); %The result is shown in Fig. 5.13.
GPSM_tv(80,pz_u,ra_u,4,2,0.01,80,0.5,0.5,0.045,0.001,0,0,29,18);% The result is shown in Fig. 6.9.
GPSM_tv(80,pz_u,ra_u,4,2,0.01,80,0.5,0.5,0.01,0.001,0.1,0.001, 44,27);% The result is shown in Fig. 6.13.
%The algorithms are described in Sections 5.4.1, 6.1.3, and 6.2.1.
%% OPC_tv(OPC optimization with discretization penalty and total variation penalty in coherent imaging system.)
OPC_tv(50,15,5,pz_t,0.2,90,0.5,0.5,0,0,4,350);% The result is shown in Fig. 5.3.
OPC_tv(80,11,14,pz_f,0.5,80,0.5,0.5,0,0,4,90); %The result is shown in Fig. 5.5.
OPC_tv(50,15,5,pz_t,0.2,90,0.5,0.5,0.025,0,4,350);% The result is shown in Fig. 6.2.
OPC_tv(80,11,14,pz_f,0.5,80,0.5,0.5,0.01,0,0,70);% The result is shown in Fig. 6.3.
OPC_tv(80,11,14,pz_f,0.5,80,0.5,0.5,0.01,0.025,6,70); %The result is shown in Fig. 6.11.
%The algorithms are described in Sections 5.2.1, 6.1.1, and 6.2.1.
%% PSM_tv(Two-phase PSM optimization with discretization penalty and total variation penalty in coherent imaging system.)
PSM_tv(50,15,5,pz_t,r_t,1,90,0.5,0.5,0,0,10,160); %The result is shown in Fig. 5.7.
PSM_tv(80,11,14,pz_f,r_f,0.5,80,0.5,0.5,0,0,10,230);% The result is shown in Fig. 5.9.
PSM_tv(50,15,5,pz_t,r_t,1,90,0.5,0.5,0.0175,0,12,150); %The result is shown in Fig. 6.5.
PSM_tv(80,11,14,pz_f,r_f,0.5,80,0.5,0.5,0.0025,0,12,1200);% The result is shown in Fig. 6.6.
PSM_tv(80,11,14,pz_f,r_f,0.5,80,0.5,0.5,0.0025,0.008,0,59);% The result is shown in Fig. 6.12.
%The algorithms are described in Sections 5.3.1, 6.1.2, and 6.2.1.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Chapter 7%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OPC_acaa(OPC optimization using the average coherent approximation model in par-tially coherent imaging system.)
OPC_acaa(184,pz_90,21,5.625,0.29,1.25,193,1,0.8, 0.975,0.5,25,0.19,0.09,0.5,0.025,0.025,0,200); %The result is shown in the ﬁrst row in Fig. 7.8.
OPC_acaa(184,pz_90,21,5.625,0.29,1.25,193,1,0.5,0.6,0.5,25,0.19,0.095,0.5,0.025,0.025,0,200);% The result is shown in the second row in Fig. 7.8.
OPC_acaa(184,pz_90,21,5.625,0.29,1.25,193,1,0.3, 0.4,0.5,25,0.19,0.17,0.5,0.025,0.025,0,200);% The result is shown in the third row in Fig. 7.8.
%The algorithms are described in Section 7.1.3.
%% OPC_fse(OPC optimization using the Fourier series expansion model in partially co-herent imaging system.)
OPC_fse(184,pz_90,21,5.625,0.29,1.25,193,1,0.8, 0.975,2,25,0.19,0.5,0.025,0.025,1426,43); %The result is shown in the ﬁrst row in Fig. 7.3.
OPC_fse(184,pz_90,21,5.625,0.29,1.25,193,1,0.5,0.6, 2,25,0.19,0.5,0.025,0.025,1582,60);% The result is shown in the second row in Fig. 7.3.
OPC_fse(184,pz_90,21,5.625,0.29,1.25,193,1,0.3,0.4, 2,25,0.19,0.5,0.025,0.025,1512,120);% The result is shown in the third row in Fig. 7.3.
%The algorithms are described in Section 7.1.1.
%% PSM_svd(Two-phase PSM optimization using the singular value decomposition model in partially coherent imaging system.)
PSM_svd(51,pz_t2,r_t2,11,0.29,1.35,193,0.3,1,0.2,200,0.003,0.33, 0.1,9,300);% The result is shown in Fig. 7.13.
PSM_svd(51,pz_t2,r_t2,11,0.29,1.35,193,0.6,1,0.2,200,0.003,0.33, 0.1,9,300);% The result is shown in Fig. 7.15.
%The algorithms are described in Sections 7.2.1 and 7.2.2.
%% SOCS(Calculate the transmission cross-coefficient.)
SOCS(51,11,0.29,1.35,193,26,0.3,1); %This example is used in Section 7.2.3.
%The algorithms are described in Section 2.1.2.



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Chapter 8%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% double_pattern(Double patterning optimization using two generalized PSMs in coherent imaging system.)
double_pattern(4,0.01,4,0.01,80,0.5,0.5,0.015,0.001, 0.5,0.003,0.015,0.001,0.5,0.003,10,100); %The result is shown in Fig. 8.4.
%The algorithms are described in Section 8.1.
%% proc_dct(Post-processing based on the two-dimensional discrete cosine transform.)
proc_dct(51,pz_t2,m,0.003,t_r_real,0.33,TCC,18);% The result is shown in Fig. 8.9.
%The algorithms are described in Section 8.2.
%% PSM_dct(Two-phase PSM optimization with the 2D DCT post-processing in partially coherent imaging system.)
PSM_dct(51,pz_t2,r_t2,11,0.29,1.35,193,0.3,1,18,0.2,200,0.003,0.33, 0.1,9,300);% The result is shown in Fig. 8.9.
PSM_dct(51,pz_t2,r_t2,11,0.29,1.35,193,0.6,1,38,0.2,200,0.003,0.33, 0.1,9,300);% The result is shown in Fig. 8.10.
%The algorithms are described in Section 8.2.
%% resisttone(hotoresist tone reversing method in partially coherent imaging system.)
resisttone(51,pz_f2,distribution1,11,0.29,1.35,193,0.3,1,15,0,2,200, 0.01,0.33,0.1,0.1,9,100);% The result is shown in Fig. 8.12.
resisttone(51,pz_f2,distribution1,11,0.29,1.35,193,0.3,1,15,1,2,200, 0.01,0.33,0.1,0.1,9,300);% The result is shown in Fig. 8.13.
resisttone(51,pz_r,distribution2,11,0.29,1.35,193,0.3,1,49,0,0.2,200, 0.01,0.33,0.1,0,8,100);% The result is shown in Fig. 8.15.
resisttone(51,pz_r,distribution2,11,0.29,1.35,193,0.3,1,49,1,0.2,200, 0.01,0.33,0.1,0,8,100);% The result is shown in Fig. 8.16.
%The algorithms are described in Section 8.3.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Chapter 9%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% smo_OPC(Simultaneous source and binary mask optimization.)
smo_OPC(80,pz_smo1,21,15,0.29,1.25,193,1,0.4,0.5); %The result is shown in the third row of Fig. 9.2.
%The algorithms are described in Section 9.3.
%% smo_OPC_mask(Binary mask optimization based on the SMO algorithm without source optimization.)
smo_OPC_mask(80,pz_smo1,21,15,0.29,1.25,193,1,0.4,0.5);% The re-sult is shown in the second row of Fig. 9.2.
%The algorithms are described in Section 9.3.
%% smo_PSM(Simultaneous source and phase-shifting mask optimization.)
smo_PSM(80,pz_smo2,21,15,0.29,1.25,193,1,0.4);% The result is shown in the third row of Fig. 9.3.
%The algorithms are described in Section 9.3.
%% smo_PSM_mask(Phase-shifting mask optimization based on the SMO algorithm without source optimization.)
smo_PSM_mask(80,pz_smo2,21,15,0.29,1.25,193,1,0.4); %The result is shown in the second row of Fig. 9.3.
%The algorithms are described in Section 9.3.



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Chapter 10%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% check_OPC(Check whether the topology of the binary mask pattern satisﬁes the topo-logical constraint.)
check%OPC(m dummy,90,8,3); %This example is used in Section 10.4.3.
%The algorithms are described in Section 10.4.1.
%% check_PSM(Check whether the topology of the phase-shifting mask pattern satisﬁes the topological constraint.)
check_PSM(m_dummy,80,9,1,2);% This example is used in Section 10.5.3.
%The algorithms are described in Section 10.5.1.
%% OPC_3D1(OPC optimization based on the boundary layer model in the ﬁrst kind of coherent imaging system.)
OPC_3D1(90,pz_3D1,121,1);% The result is shown in Fig. 10.8.
%The algorithms are described in Section 10.4.2.
%% OPC_3D2(OPC optimization based on the boundary layer model in the second kind of coherent imaging system.)
OPC_3D2(95,pz_3D2,139,1);% The result is shown in Fig. 10.10.
%The algorithms are described in Section 10.4.2.
%% PSM_3D1(PSM optimization based on the boundary layer model in the ﬁrst kind of coherent imaging system.)
PSM_3D1(80,pz_3D3,109,1);% The result is shown in Fig. 10.12.
%The algorithms are described in Section 10.5.2.
%% PSM_3D2(PSM optimization based on the boundary layer model in the second kind of coherent imaging system.)
PSM_3D2(151,pz_3D4,139,1);% The result is shown in Fig. 10.14.
%The algorithms are described in Section 10.5.2.