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

CE32A_REV1_DEPS = ../CE32A_Rev1.scad ../speaker_stand.scad ../prim.scad

CE32A_TYPE2_REV1 =  CE32A_Type2_Rev1.stl \
                    CE32A_Type2_Rev1_with_stand.stl

CE32A_TYPE2_REV1_DEPS = ../CE32A_Type2_Rev1.scad ../speaker_stand.scad ../prim.scad

B1S_REV2 =  B1S_Rev2.stl \
            B1S_Rev2_with_stand.stl \
            B1S_Rev2_lid_only.stl

B1S_REV2_DEPS = ../B1S_Rev2.scad ../speaker_stand.scad ../prim.scad

AURA205 = Aura205.stl \
          Aura205_body_only.stl \
          Aura205_with_stand.stl \
          Aura205_stand_only.stl \
          Aura205_unit_test.stl \
          Aura205_stand_test.stl \
          Aura205_joint_test.stl \
          Aura205_unit_lid_test.stl

AURA205_DEPS = ../Aura205.scad ../speaker_stand.scad ../prim.scad

TB1070SH = TB1070SH.stl \
           TB1070SH_with_stand.stl \
           TB1070SH_stand_only.stl \
           TB1070SH_unit_test.stl \
           TB1070SH_stand_test.stl \
           TB1070SH_joint_test.stl \
           TB1070SH_unit_lid_test.stl

TB1070SH_DEPS = ../TB1070SH.scad ../speaker_stand.scad ../prim.scad

PAM8403  =  PAM8403.stl \
            PAM8403_novent.stl \
            PAM8403_e00.stl \
            PAM8403_e04.stl \
            PAM8403_e08.stl \
            PAM8403_body_only.stl \
            PAM8403_lid_only.stl \
            PAM8403_unit_test.stl \
            PAM8403_unit_lid_test.stl

PAM8403_DEPS = ../PAM8403.scad ../prim.scad

MAX98306 =  MAX98306.stl \
            MAX98306_novent.stl \
            MAX98306_unit_test.stl \
            MAX98306_unit_lid_test.stl \
            MAX98306_body_test.stl \
            MAX98306_body_only.stl \
            MAX98306_lid_only.stl

MAX98306_DEPS = ../MAX98306.scad ../prim.scad

MICROUSB = microusb.stl \
           microusb_unit_test.stl

MICROUSB_DEPS = ../microusb.scad ../prim.scad

AUDIOJACK = audiojack.stl \
            audiojack_unit.stl \
            audiojack_body_test.stl \
            audiojack_lid_test.stl

AUDIOJACK_DEPS = ../audiojack.scad ../prim.scad

SPEAKER_STAND = speaker_stand.stl

SPEAKER_STAND_DEPS = ../speaker_stand.scad ../prim.scad

BTAUDIO = btaudio.stl \
          btaudio_unit_test.stl

BTAUDIO_DEPS = ../btaudio.scad ../prim.scad

COMPO = Compo_PAM8403.stl \
        Compo_MAX98306.stl \
        Compo_btaudio.stl \
        Compo_btaudio_lid_test.stl \
        Compo_lid_test.stl \
        Compo_screw_test.stl \
        Compo_screw_test_amp1.stl \
        Compo_lid_screw_test.stl

COMPO_DEPS = ../Compo.scad ../PAM8403.scad ../MAX98306.scad ../CE32A_Rev1.scad ../microusb.scad ../audiojack.scad ../btaudio.scad ../prim.scad

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
test: $(TEST)
debug: $(DEBUG)

ce32a_rev1: $(CE32A_REV1)
ce32a_type2_rev1: $(CE32A_TYPE2_REV1)
b1s_rev2: $(B1S_REV2)
aura205: $(AURA205)
tb1070sh: $(TB1070SH)
pam8403: $(PAM8403)
max98306: $(MAX98306)
microusb: $(MICROUSB)
audiojack: $(AUDIOJACK)
speaker_stand: $(SPEAKER_STAND)
compo: $(COMPO)
btaudio: $(BTAUDIO)

microusb.stl: $(MICROUSB_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

microusb_unit_test.stl: $(MICROUSB_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

audiojack.stl: $(AUDIOJACK_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

audiojack_unit.stl: $(AUDIOJACK_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit\";"
	$(PUBLISH_TEST)

audiojack_lid_test.stl: $(AUDIOJACK_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)

audiojack_body_test.stl: $(AUDIOJACK_DEPS)
	$(OPENSCAD) -D "TARGET=\"body_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

CE32A_Rev1_with_stand.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

CE32A_Rev1_stand_only.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

CE32A_Rev1_unit_test.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_unit_lid_test.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_stand_test.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

CE32A_Rev1_joint_test.stl: $(CE32A_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

CE32A_Type2_Rev1.stl: $(CE32A_TYPE2_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

CE32A_Type2_Rev1_with_stand.stl: $(CE32A_TYPE2_REV1_DEPS)
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

B1S_Rev2.stl: $(B1S_REV2_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

B1S_Rev2_with_stand.stl: $(B1S_REV2_DEPS)
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

B1S_Rev2_lid_only.stl: $(B1S_REV2_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH)

Aura205.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Aura205_with_stand.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

Aura205_body_only.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH)

Aura205_stand_only.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

Aura205_unit_test.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

Aura205_unit_lid_test.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

Aura205_stand_test.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

Aura205_joint_test.stl: $(AURA205_DEPS)
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

TB1070SH.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

TB1070SH_with_stand.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"with_stand\";"
	$(PUBLISH)

TB1070SH_stand_only.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_only\";"
	$(PUBLISH_TEST)

TB1070SH_unit_test.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

TB1070SH_unit_lid_test.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

TB1070SH_stand_test.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"stand_test\";"
	$(PUBLISH_TEST)

TB1070SH_joint_test.stl: $(TB1070SH_DEPS)
	$(OPENSCAD) -D "TARGET=\"joint_test\";"
	$(PUBLISH_TEST)

PAM8403.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

PAM8403_novent.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"novent\";"
	$(PUBLISH)

PAM8403_e00.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.0; LID_ERROR=0.0;"
	$(PUBLISH)

PAM8403_e04.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.4; LID_ERROR=0.4;"
	$(PUBLISH)

PAM8403_e08.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\"; HOLD_ERROR=0.8; LID_ERROR=0.8;"
	$(PUBLISH)

PAM8403_body_only.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH_TEST)

PAM8403_lid_only.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH_TEST)

PAM8403_unit_test.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

PAM8403_unit_lid_test.stl: $(PAM8403_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

MAX98306.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

MAX98306_novent.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"novent\";"
	$(PUBLISH)

MAX98306_unit_test.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

MAX98306_unit_lid_test.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_lid_test\";"
	$(PUBLISH_TEST)

MAX98306_body_only.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"body_only\";"
	$(PUBLISH_TEST)

MAX98306_body_test.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"body_test\";"
	$(PUBLISH_TEST)

MAX98306_lid_only.stl: $(MAX98306_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_only\";"
	$(PUBLISH_TEST)

speaker_stand.stl: $(SPEAKER_STAND_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Compo_PAM8403.stl:  $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

Compo_MAX98306.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"max98306\";"
	$(PUBLISH)

Compo_btaudio.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"btaudio\";"
	$(PUBLISH)

Compo_btaudio_lid_test.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"btaudio_lid_test\";"
	$(PUBLISH_TEST)

Compo_btaudio_maketest.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"btaudio\";"
	$(PUBLISH)

Compo_lid_test.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)

Compo_screw_test.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"screw_test\";"
	$(PUBLISH_TEST)

Compo_screw_test_amp1.stl: $(COMPO_DEPS)

Compo_lid_screw_test.stl: $(COMPO_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_screw_test\";"
	$(PUBLISH_TEST)

btaudio.stl: $(BTAUDIO_DEPS)
	$(OPENSCAD) -D "TARGET=\"default\";"
	$(PUBLISH)

btaudio_unit_test.stl: $(BTAUDIO_DEPS)
	$(OPENSCAD) -D "TARGET=\"unit_test\";"
	$(PUBLISH_TEST)

btaudio_lid_test.stl: $(BTAUDIO_DEPS)
	$(OPENSCAD) -D "TARGET=\"lid_test\";"
	$(PUBLISH_TEST)


clean:
	rm -f *.stl
