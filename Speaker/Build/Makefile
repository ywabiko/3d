#
# experimental Makefile...
#
OPENSCAD        = openscad -o $@ $<
PUBLISH         = cp $@ ../Staging/
PUBLISH_TEST    = cp $@ ../StagingTest/

CE32A_REV1 =    CE32A_Rev1.stl \
                CE32A_Rev1_with_stand.stl \
                CE32A_Rev1_stand_only.stl \
                CE32A_Rev1_unit_test.stl \
                CE32A_Rev1_stand_test.stl \
                CE32A_Rev1_joint_test.stl \
                CE32A_Rev1_unit_lid_test.stl

CE32A_TYPE2_REV1 =  CE32A_Type2_Rev1.stl \
                    CE32A_Type2_Rev1_with_stand.stl

B1S_REV2 =  B1S_Rev2.stl \
            B1S_Rev2_with_stand.stl \
            B1S_Rev2_lid_only.stl

AURA205 = Aura205.stl \
          Aura205_body_only.stl \
          Aura205_with_stand.stl \
          Aura205_stand_only.stl \
          Aura205_unit_test.stl \
          Aura205_stand_test.stl \
          Aura205_joint_test.stl \
          Aura205_unit_lid_test.stl

TB1070SH = TB1070SH.stl \
           TB1070SH_with_stand.stl \
           TB1070SH_stand_only.stl \
           TB1070SH_unit_test.stl \
           TB1070SH_stand_test.stl \
           TB1070SH_joint_test.stl \
           TB1070SH_unit_lid_test.stl

PAM8403  =  PAM8403.stl \
            PAM8403_novent.stl \
            PAM8403_e00.stl \
            PAM8403_e04.stl \
            PAM8403_e08.stl \
            PAM8403_body_only.stl \
            PAM8403_lid_only.stl \
            PAM8403_unit_test.stl \
            PAM8403_unit_lid_test.stl

MAX98306 =  MAX98306.stl \
            MAX98306_novent.stl \
            MAX98306_unit_test.stl \
            MAX98306_unit_lid_test.stl \
            MAX98306_body_test.stl \
            MAX98306_body_only.stl \
            MAX98306_lid_only.stl

MICROUSB = microusb.stl \
           microusb_unit_test.stl

AUDIOJACK = audiojack.stl \
            audiojack_unit.stl \
            audiojack_body_test.stl \
            audiojack_lid_test.stl

SPEAKER_STAND = speaker_stand.stl

BTAUDIO = btaudio.stl \
          btaudio_unit_test.stl

COMPO = Compo_PAM8403.stl \
        Compo_MAX98306.stl \
        Compo_btaudio.stl \
        Compo_btaudio_lid_test.stl \
        Compo_lid_test.stl \
        Compo_screw_test.stl \
        Compo_screw_test_amp1.stl \
        Compo_lid_screw_test.stl

RELEASE = $(CE32A_REV1) \
          $(CE32A_TYPE2_REV1) \
          $(B1S_REV2) \
          $(AURA205) \
          $(TB1070SH) \
          $(PAM8403) \
          $(MAX98306) \
          $(MICROUSB) \
          $(AUDIOJACK) \
          $(SPEAKER_STAND) \
          $(COMPO) \
          $(BTAUDIO)

TEST =
DEBUG =

all: $(RELEASE) $(TEST)
microusb: $(MICROUSB)
audiojack: $(AUDIOJACK)
btaudio: $(BTAUDIO)
test: $(TEST)
debug: $(DEBUG)

microusb.stl: ../microusb.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

microusb_unit_test.stl: ../microusb.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

audiojack.stl: ../audiojack.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

audiojack_unit.stl: ../audiojack.scad 
	$(OPENSCAD) -D "TARGET=\"unit\";"
	$(PUBLISH_TEST)

audiojack_lid_test.stl: ../audiojack.scad 
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)

audiojack_body_test.stl: ../audiojack.scad 
	$(OPENSCAD) -D "TARGET=\"body_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1.stl:  ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

CE32A_Rev1_with_stand.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

CE32A_Rev1_stand_only.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

CE32A_Rev1_unit_test.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_unit_lid_test.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_stand_test.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_joint_test.stl: ../CE32A_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

CE32A_Type2_Rev1.stl: ../CE32A_Type2_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

CE32A_Type2_Rev1_with_stand.stl: ../CE32A_Type2_Rev1.scad
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

B1S_Rev2.stl: ../B1S_Rev2.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

B1S_Rev2_with_stand.stl: ../B1S_Rev2.scad
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

B1S_Rev2_lid_only.stl: ../B1S_Rev2.scad
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH)

Aura205.stl:  ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Aura205_with_stand.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

Aura205_body_only.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH)

Aura205_stand_only.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

Aura205_unit_test.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

Aura205_unit_lid_test.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

Aura205_stand_test.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

Aura205_joint_test.stl: ../Aura205.scad
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

TB1070SH.stl:  ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

TB1070SH_with_stand.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

TB1070SH_stand_only.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

TB1070SH_unit_test.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

TB1070SH_unit_lid_test.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

TB1070SH_stand_test.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

TB1070SH_joint_test.stl: ../TB1070SH.scad
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

PAM8403.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

PAM8403_novent.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"novent\";"
	$(PUBLISH)

PAM8403_e00.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.0; LID_ERROR=0.0;"
	$(PUBLISH)

PAM8403_e04.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.4; LID_ERROR=0.4;"
	$(PUBLISH)

PAM8403_e08.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.8; LID_ERROR=0.8;"
	$(PUBLISH)

PAM8403_body_only.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH_TEST)

PAM8403_lid_only.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH_TEST)

PAM8403_unit_test.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

PAM8403_unit_lid_test.stl: ../PAM8403.scad
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

MAX98306.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

MAX98306_novent.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"novent\";"
	$(PUBLISH)

MAX98306_unit_test.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

MAX98306_unit_lid_test.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

MAX98306_body_only.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH_TEST)

MAX98306_body_test.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"body_test\";"
	$(PUBLISH_TEST)

MAX98306_lid_only.stl: ../MAX98306.scad
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH_TEST)

speaker_stand.stl: ../speaker_stand.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Compo_PAM8403.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl 
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Compo_MAX98306.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl 
	$(OPENSCAD) -D "TARGET=\"max98306\";"
	$(PUBLISH)

Compo_btaudio.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl btaudio.stl
	$(OPENSCAD) -D "TARGET=\"btaudio\";"
	$(PUBLISH)

Compo_btaudio_lid_test.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl btaudio.stl
	$(OPENSCAD) -D "TARGET=\"btaudio_lid_test\";"
	$(PUBLISH_TEST)

Compo_lid_test.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)

Compo_screw_test.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl
	$(OPENSCAD) -D "TARGET=\"screw_test\";"
	$(PUBLISH_TEST)

Compo_screw_test_amp1.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl
	$(OPENSCAD) -D "TARGET=\"screw_test_amp1\";"
	$(PUBLISH_TEST)

Compo_lid_screw_test.stl: ../Compo.scad PAM8403.stl MAX98306.stl CE32A_Rev1.stl microusb.stl audiojack.stl
	$(OPENSCAD) -D "TARGET=\"lid_screw_test\";"
	$(PUBLISH_TEST)

btaudio.stl:  ../btaudio.scad
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

btaudio_unit_test.stl:  ../btaudio.scad
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

btaudio_lid_test.stl:  ../btaudio.scad
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)

clean:
	rm -f *.stl
