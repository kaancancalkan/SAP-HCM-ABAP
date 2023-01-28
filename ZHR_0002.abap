REPORT ZHR_0002.
DATA: gv_name TYPE ZHR_KAAN_SCREEN1NAME,
      gv_surname TYPE ZHR_KAAN_SCREEN1SURNAME.
DATA: gv_radwoman TYPE char1,
      gv_radman TYPE xfeld.
DATA  gv_checkbox TYPE ZHR_KAAN_SCREEN1CHECKBOX.

DATA gv_age TYPE ZHR_KAAN_SCREEN1AGE.

 DATA: gv_id TYPE vrm_id,
     gt_values TYPE vrm_values,
     gs_value TYPE vrm_value.
DATA gv_index TYPE i .

DATA gv_date type ZHR_KAAN_SCREEN1DATE.

DATA: gt_personal type table of ZHR_KAAN_SCREEN1,
      gs_personal type ZHR_KAAN_SCREEN1.





DATA ok_code type sy-ucomm.
START-OF-SELECTION.
gv_index = 9.

DO 100 TIMES.
  gs_value-key = gv_index.
gs_value-text = gv_index.
APPEND gs_value TO gt_values.
gv_index = gv_index + 1.

ENDDO.
gv_checkbox = abap_true.
CALL  SCREEN 0100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS '0100'.


* SET TITLEBAR 'xxx'.

gv_id = 'GV_AGE'.
*
*gs_value-key = '2'.
*gs_value-text =' 18-25 Age '.
*APPEND gs_value to gt_values.
*
*gs_value-key = '3'.
*gs_value-text =' 25-34 Age '.
*APPEND gs_value to gt_values.
*
*gs_value-key = '4'.
*gs_value-text =' 34-41 Age '.
*APPEND gs_value to gt_values.
*
*gs_value-key = '5'.
*gs_value-text =' 44-51 Age '.
*APPEND gs_value to gt_values.


 CALL FUNCTION 'VRM_SET_VALUES'
   EXPORTING
     id                    = gv_id
     values                = gt_values
*  EXCEPTIONS
*    ID_ILLEGAL_NAME       = 1
*    OTHERS                = 2
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
*  CASE sy-ucomm.
  case ok_code.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
      WHEN '&CLEAR'.
        PERFORM ClearData.


       WHEN '&SAVE'.
         PERFORM SaveData.



*      IF gv_radwoman eq 'X'.
*         MESSAGE 'Your Gender is Woman' TYPE 'I' DISPLAY LIKE 'E'.
*         ELSE.
*          MESSAGE 'Your Gender is Man' TYPE 'I' DISPLAY LIKE 'S'.

*      IF gv_checkbox eq abap_true.
*        MESSAGE 'You Agreed' TYPE 'I' DISPLAY LIKE 'S'.
*        ELSE.
*          MESSAGE 'You Dont Agreed ' TYPE  'I' DISPLAY LIKE 'E'.
*     DATA : lv_age TYPE char5.
*     lv_age = gv_age .
*
*     MESSAGE lv_age TYPE 'I' DISPLAY LIKE 'W'.


*      MESSAGE gv_name TYPE 'I' DISPLAY LIKE 'S'.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form ClearData
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM ClearData .
CLEAR: gv_name ,
               gv_surname,
               gv_age,
               gv_date,
               gv_checkbox,
               gv_radwoman.
       gv_radman = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SaveData
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SaveData .
gs_personal-name = gv_name.
         gs_personal-surname = gv_Surname.
         gs_personal-age = gv_age.
         gs_personal-zdate = gv_date.
         gs_personal-cbox = gv_checkbox.
         IF gv_radwoman eq abap_true.
              gs_personal-gender = 'W'.
             ELSE.
               gs_personal-gender = 'M'.
               ENDIF.
               INSERT ZHR_KAAN_SCREEN1 FROM gs_personal.
               COMMIT WORK AND WAIT.
               MESSAGE 'Data succesfully saved.' TYPE 'I' DISPLAY LIKE 'S'.
ENDFORM.
