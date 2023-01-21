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
      gv_birthplace TYPE pad_gbort,
      Gs_pa0001 TYPE pa0001,
      gt_pa0001 TYPE TABLE OF pa0001,
      gv_positionno TYPE plans,
      gv_positiontext TYPE char30,
      gs_t528t TYPE t528t,
      gt_t528t TYPE TABLE OF t528t,
      gs_pa0008 TYPE pa0008,
      gt_pa0008 TYPE TABLE OF pa0008,
      gv_wagetypeno TYPE lgart,
      gv_wagetypetext TYPE lgtxt,
      gv_wage TYPE pad_amt7s,
      gs_t512t TYPE t512t,
      gt_t512t TYPE TABLE OF t512t.




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


*Getting text data for Sap number data.
 SELECT * FROM t528t INTO TABLE gt_t528t.
   SELECT SINGLE plstx FROM t528t INTO gv_positiontext WHERE plans = gv_positionno AND sprsl EQ 'TR'.

SELECT * FROM pa0008 INTO TABLE gt_pa0008.

SELECT SINGLE lga01 FROM pa0008 INTO gv_wagetypeno WHERE pernr = gv_perno AND endda EQ '99991231'.

SELECT * FROM t512t INTO TABLE gt_t512t.
  SELECT SINGLE lgtxt FROM t512t INTO gv_wagetypetext WHERE  lgart = gv_wagetypeno AND molga EQ 47 AND sprsl EQ 'TR'.

SELECT SINGLE bet01 FROM pa0008 INTO gv_wage WHERE pernr = gv_perno AND endda EQ '99991231'.


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
*    /'üCRET', GV_WAGE.
     /'ÜCRETTUTARI', gv_wage.
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
