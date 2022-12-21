REPORT zhr_kaanilkabap.

*Variables
DATA: gv_persname TYPE pad_vorna,
      gv_perssurname TYPE pad_nachn,
      gv_genderno TYPE hrpad_gender,
      gv_gender TYPE string,
      gs_pa0002 TYPE pa0002,
      gt_pa0002 TYPE TABLE OF pa0002.


*Screen Parametres
PARAMETERS: gv_perno TYPE persno,
           gv_begda TYPE begda,
           gv_endda TYPE endda.

*Getting personel data to my table
SELECT * FROM pa0002
  INTO TABLE gt_pa0002.

*  Selecting data to screen
  SELECT SINGLE: vorna FROM pa0002 INTO gv_persname WHERE pernr = gv_perno AND endda EQ '99991231',
                 nachn FROM pa0002  INTO gv_perssurname WHERE pernr = gv_perno AND endda EQ '99991231',
                 gesch FROM pa0002 INTO gv_genderno WHERE pernr = gv_perno AND endda EQ '99991231'.



*Converting Number to String

     IF gv_genderno = 1.
   gv_gender = ' Erkek'.
  ELSEIF gv_genderno = 2.
   gv_gender  = 'Kadın'.
    ELSE.
     gv_gender = 'Diger'.
  ENDIF.

* Fix for issue about default value
  IF gv_persname EQ ''.
    gv_gender = ''.
    ENDIF.

* Writing variables to screen
    WRITE: 'Bu personelin Adı', Gv_persname  ,
    / 'Soyadı', gv_perssurname,
    / 'Cinsiyeti' , gv_gender.
* Clearing vars and tables.

    CLEAR gv_perno.
    CLEAR gv_persname.
    CLEAR gv_perssurname.
    CLEAR gv_gender.
    CLEAR gs_pa0002.
    CLEAR Gt_pa0002.
