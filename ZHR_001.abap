*&---------------------------------------------------------------------*
*& Report ZHR_KAANILKABAP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zhr_kaanilkabap.

*Variables
DATA: gv_persname TYPE pad_vorna,
      gv_perssurname TYPE pad_nachn,
      gv_genderno TYPE hrpad_gender,
      gv_gender TYPE string,
      gs_pa0002 TYPE pa0002,
      gt_pa0002 TYPE TABLE OF pa0002,
      gv_birthplace TYPE PAD_GBORT,
      Gs_pa0001 type pa0001,
      gt_pa0001 type table of pa0001,
      gv_positionno type plans,
      gv_positiontext type char30,
      gs_t528t type t528t,
      gt_t528t type table of t528t,
      gs_pa0008 type pa0008,
      gt_pa0008 type table of pa0008,
      gv_wagetypeno type LGART,
      gv_wagetypetext type LGTXT,
      gv_wage type PAD_AMT7S,
      gs_t512t TYPE t512t,
      gt_t512t TYPE table of t512t.




*Screen Parametres
PARAMETERS: gv_perno TYPE persno,
           gv_begda TYPE begda,
           gv_endda TYPE endda.

*Getting personel data to my table
SELECT * FROM pa0002
  INTO TABLE gt_pa0002.

SELECT * FROM pa0001 INTO TABLE gt_pa0001.
*  Selecting data to screen
  SELECT SINGLE: vorna FROM pa0002 INTO gv_persname WHERE pernr = gv_perno AND endda EQ '99991231',
                 nachn FROM pa0002  INTO gv_perssurname WHERE pernr = gv_perno AND endda EQ '99991231',
                 gesch FROM pa0002 INTO gv_genderno WHERE pernr = gv_perno AND endda EQ '99991231',
                 gbort FROM pa0002 INTO gv_birthplace WHERE pernr = gv_perno AND endda EQ '99991231',
                 plans FROM pa0001 INTO gv_positionno WHERE pernr = gv_perno AND endda EQ '99991231'.

 SELECT * From t528t INTO table gt_t528t.
   SELECT SINGLE plstx from t528t INTO gv_positiontext Where plans = gv_positionno and SPRSL eq 'TR'.

SELECT * FROM PA0008 INTO TABLE gt_pa0008.

select single LGA01 from pa0008 INTO gv_wagetypeno WHERE pernr = gv_perno AND endda EQ '99991231'.

SELECT * FROM t512t INTO TABLE gt_t512t.
  select single LGTXT from t512t INTO gv_wagetypetext WHERE  LGART = gv_wagetypeno and molga eq 47 and sprsl EQ 'TR'.

SELECT single bet01 from pa0008 INTO gv_wage WHERE pernr = gv_perno AND endda EQ '99991231'.


*Converting Number to String

     IF gv_genderno = 1.
   gv_gender = ' Erkek'.
  ELSEIF gv_genderno = 2.
   gv_gender  = 'Kadın'.
    ELSE.
     gv_gender = 'Diğer'.
  ENDIF.

* Fix for issue about default value
  IF gv_persname EQ ''.
    gv_gender = ''.
    ENDIF.

* Writing variables to screen
    WRITE: 'Bu personelin Adı', Gv_persname  ,
    / 'Soyadı', gv_perssurname,
    / 'Cinsiyeti' , gv_gender,
    / 'Doğum Yeri' , gv_birthplace,
    / 'Pozisyonu ' , gv_positiontext,
    /'ödemeşekli',gv_wagetypetext, gv_wagetypeno,
    /'Ücret', gv_wage.

* Clearing vars and tables.

    CLEAR gv_perno.
    CLEAR gv_persname.
    CLEAR gv_perssurname.
    CLEAR gv_gender.
    CLEAR gs_pa0002.
    CLEAR Gt_pa0002.
    CLEAR gv_birthplace.
    CLEAR gv_positionno.
    CLEAR gv_positiontext.
    CLEAR gv_wagetypeno.
    CLEAR gv_wagetypetext.
    CLEAR gv_wage.
