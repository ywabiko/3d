Building from OpenSCAD source files
===================================

Please refer to [README](https://github.com/ywabiko/3d/blob/master/Speaker/README.md) for instructions to build STL files from OpenScad source file.

OpenScadソースファイルからSTLファイルを生成する手順の詳細については
[README](https://github.com/ywabiko/3d/blob/master/Speaker/README.md)を参照してください。
    


Tiny Bluetooth Speaker
======================

Available at [Thingiverse](http://www.thingiverse.com/thing:1865586)

This is a tiny Bluetooth speaker system designed as a "kitchen speaker".
Assembly requires following parts and a bit of soldering.

  - 1 x Bluetooth Receiver: [TinySine Bluetooth Receiver Board](http://www.tinyosshop.com/index.php?route=product/product&product_id=792)  [@Amazon](https://www.amazon.com/gp/product/B00PXC0CIK/ref=oh_aui_detailpage_o01_s02?ie=UTF8&psc=1).
  - 1 x Amplifier: [Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306](https://www.adafruit.com/product/987) [@Amazon](https://www.amazon.com/Adafruit-Stereo-Class-Audio-Amplifier/dp/B00SLYAK1G).
  - 2 x 1" Speaker drivers [Dayton Audio CE32A](http://www.daytonaudio.com/index.php/dayton-audio-ce32a-4-1-1-4-mini-speaker-4-ohm.html) [@Parts Express](http://www.parts-express.com/dayton-audio-ce-series-ce32a-4-1-1-4-mini-speaker-4-ohm--285-103).
  - (Optional) 2 x Small screws #4 3/8-in [@HomeDepot](http://www.homedepot.com/p/Everbilt-4-x-3-8-in-Zinc-Plated-Steel-Phillips-Pan-Head-Sheet-Metal-Screw-16-per-Pack-812661/204275188).

Note:
  - Depending on printer accuracy or filament types, the lid might be a bit loose. You can screw it in that case.
  - For a kitchen speaker scenario, I would set the gain jumper on Adafruit MAX98306 to 15dB or 18dB to achieve large enough volume.

小さな Bluetoothスピーカーです。キッチンスピーカーとして作りました。
組み立てに必要な部品は以下のとおりです。多少はんだ付けが必要です。

  - 1 x Bluetooth レシーバー [TinySine Bluetooth Receiver Board](http://www.tinyosshop.com/index.php?route=product/product&product_id=792) [@Amazon](https://www.amazon.com/gp/product/B00PXC0CIK/ref=oh_aui_detailpage_o01_s02?ie=UTF8&psc=1).
  - 1 x アンプボード [Adafruit MAX98306](https://www.switch-science.com/catalog/1140/) [@Amazon](https://www.amazon.com/Adafruit-Stereo-Class-Audio-Amplifier/dp/B00SLYAK1G).
  - 2 x 1インチスピーカードライバー [Dayton Audio CE32A](http://www.daytonaudio.com/index.php/dayton-audio-ce32a-4-1-1-4-mini-speaker-4-ohm.html) [@Amazon](https://www.amazon.co.jp/Dayton-Audio-CE32A-8-Speaker-%E4%B8%A6%E8%A1%8C%E8%BC%B8%E5%85%A5%E5%93%81/dp/B012V5HCTI).
  - （オプション）2 x 木ねじ #4 3/8インチ、あるいは M2.2 x 10mm等の下穴直径2mm 深さ10mm前後のもの。

備考：
  - プリンタの精度やフィラメントの特性によりふたがゆるい場合はネジ留めも可能です。
  - キッチンスピーカーとして使うためには、アンプのゲイン設定ジャンパーを 15dB か 18dB にして音量を持ち上げるとよさげです。


TangBand W1-1070SH 1" Speaker Driver Enclosure
=====================================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1849828)

An enclosure for 1" speaker [\[TangBand W1-1070SH\]](http://www.tb-speaker.com/products/w1-1070sh) that can be purchased at online stores like [\[Parts Express\]](http://www.parts-express.com/tang-band-w1-1070sh-1-full-range-driver--264-863)

Depending on your printer and/or filament types, the speaker driver and/or the lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing SHELL_ERROR and/or LID_ERROR to larger values.

1インチスピーカードライバー [\[TangBand W1-1070SH\]](http://www.tb-speaker.com/products/w1-1070sh) 用のケースです。
アメリカでは[\[Parts Express\]](http://www.parts-express.com/tang-band-w1-1070sh-1-full-range-driver--264-863)等から、日本では[コイズミ無線](http://dp00000116.shop-pro.jp/?pid=91691695) 等から入手できます。

プリンタおよびフィラメントに由来する誤差によって、スピーカーやふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR や SHELL_ERROR の値を大きくしてみてください。
 

AuraSound Cougar NSW1-205 1" Speaker Driver Enclosure
=====================================================

(to be) Available at [Thingiverse](http://www.thingiverse.com/)

An enclosure for 1" speaker [\[AuraSound Cougar NSW1-205\]](http://www.parts-express.com/aurasound-cougar-nsw1-205-8a-1-extended-range-driver-8-ohm--296-250) that can be purchased at online stores like [\[Parts Express\]](http://www.parts-express.com/aurasound-cougar-nsw1-205-8a-1-extended-range-driver-8-ohm--296-250)

Depending on your printer and/or filament types, the speaker driver and/or the lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing SHELL_ERROR and/or LID_ERROR to larger values.

1インチスピーカードライバー [\[AuraSound Cougar NSW1-205\]](http://www.parts-express.com/aurasound-cougar-nsw1-205-8a-1-extended-range-driver-8-ohm--296-250) 用のケースです。
アメリカでは[Parts Express](http://www.parts-express.com/aurasound-cougar-nsw1-205-8a-1-extended-range-driver-8-ohm--296-250)等、
日本では[コイズミ無線](http://dp00000116.shop-pro.jp/?pid=2044910)等から入手できます。

プリンタおよびフィラメントに由来する誤差によって、スピーカーやふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR や SHELL_ERROR の値を大きくしてみてください。


Tiny Powered Speaker
====================

Available at [Thingiverse](http://www.thingiverse.com/thing:1850459)

A tiny speaker system that consists of an analog amplifier and two speaker drivers.
There are 2 variants depending on amplifier.

  - Compo_PAM8403.stl // SainSmart PAM8403-based
  - Compo_MAX98306.stl // Adafruit MAX98306-based

Assembly requires following parts.

  - 1 x Amplifier: [Sainsmart](http://www.sainsmart.com/mini-pam8403-5v-digital-amplifier-board-usb-power-supply.html) or [Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306](https://www.adafruit.com/product/987).
  - 2 x 1" Speaker drivers [Dayton Audio CE32A](http://www.daytonaudio.com/index.php/dayton-audio-ce32a-4-1-1-4-mini-speaker-4-ohm.html).
  - 2 x [Small screws #4 3/8-in](http://www.homedepot.com/p/Everbilt-4-x-3-8-in-Zinc-Plated-Steel-Phillips-Pan-Head-Sheet-Metal-Screw-16-per-Pack-812661/204275188).
  - 1 x [Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack](https://www.adafruit.com/product/1699).
  - 1 x [Adafruit USB Micro-B Breakout Board Enclosure](https://www.adafruit.com/product/1833).

This model is a self remix from multiple models as follows.

  - [CE32A 1" Speaker Driver Enclosure](http://www.thingiverse.com/thing:1795831)
  - [PAM8403-based Tiny Audio Amplifier Board](http://www.thingiverse.com/thing:1788138)
  - [Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306 Enclosure](http://www.thingiverse.com/thing:1808187)
  - [Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack Enclosure](http://www.thingiverse.com/thing:1840314)
  - [Adafruit USB Micro-B Breakout Board Enclosure](http://www.thingiverse.com/thing:1840325)

小さなパワードスピーカーのようなものです。アナログアンプとスピーカー、音声入力用の3.5mm端子、電源用のMicro USB端子からなっています。
使用するアンプによって モデルは2種類あります([SainSmart PAM8403 D級ステレオアンプモジュール](http://akizukidenshi.com/catalog/g/gK-09873/) または [Adafruit MAX98306](https://www.switch-science.com/catalog/1140/)。

  - Compo_PAM8403.stl // SainSmart PAM8403版
  - Compo_MAX98306.stl // Adafruit MAX98305版

組み立てに必要な部品は以下のとおりです。

  - 1 x アンプボード。[SainSmart PAM8403 D級ステレオアンプモジュール](http://akizukidenshi.com/catalog/g/gK-09873/) または [Adafruit MAX98306](https://www.switch-science.com/catalog/1140/)
  - 2 x 1インチスピーカードライバー [Dayton Audio CE32A](https://www.amazon.co.jp/Dayton-Audio-CE32A-8-Speaker-%E4%B8%A6%E8%A1%8C%E8%BC%B8%E5%85%A5%E5%93%81/dp/B012V5HCTI).
  - 2 x 木ねじ #4 3/8インチ、あるいは M2.2 x 10mm等の下穴直径2mm 深さ10mm前後のもの。
  - 1 x [Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack](https://www.adafruit.com/product/1699).
  - 1 x [Adafruit USB Micro-B Breakout Board Enclosure](https://www.adafruit.com/product/1833).

このモデルは以下のモデルの自己Remixとなっています。

  - [CE32A 1" Speaker Driver Enclosure](http://www.thingiverse.com/thing:1795831)
  - [PAM8403-based Tiny Audio Amplifier Board](http://www.thingiverse.com/thing:1788138)
  - [Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306 Enclosure](http://www.thingiverse.com/thing:1808187)
  - [Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack Enclosure](http://www.thingiverse.com/thing:1840314)
  - [Adafruit USB Micro-B Breakout Board Enclosure](http://www.thingiverse.com/thing:1840325)


Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack Enclosure
==================================================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1840314)

This is an enclosure for [Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack](https://www.adafruit.com/product/1699).

Depending on your printer and/or filament types, lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing LID_ERROR to larger values.

Adafruit の [ブレッドボードフレンドリー 3.5mm ステレオヘッドフォンジャック](https://www.adafruit.com/product/1699)用のケースです。

プリンタおよびフィラメントに由来する誤差によって、ふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR の値を大きくしてみてください。


Adafruit USB Micro-B Breakout Board Enclosure
=============================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1840325)

This is an enclosure for [Adafruit USB Micro-B Breakout Board Enclosure](https://www.adafruit.com/product/1833).
Currently this enclosure is for direct soldering scenario only, i.e. you cannot use the enclosed header. Cable holes are designed for raw 22 AWG wires.

Depending on your printer and/or filament types, lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing LID_ERROR to larger values.

Adafruitの [USB Micro-B ブレイクアウトボード](https://www.adafruit.com/product/1833) のケースです。
同梱のヘッダピンを使わずに直接はんだ付けする場合を想定しています。
ケーブルの穴は 22 AWG のワイヤー用になっています。

プリンタおよびフィラメントに由来する誤差によって、ふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR の値を大きくしてみてください。


Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306 Enclosure
===============================================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1808187)

An enclosure for [Adafruit Stereo 3.7W Class D Audio Amplifier MAX98306](https://www.adafruit.com/product/987).
Currently this enclosure is for direct soldering scenario only, i.e. you cannot use the enclosed screw terminals and the jumper. Cable holes are designed for raw 22 AWG wires.

Depending on your printer and/or filament types, lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing LID_ERROR to larger values.

Adafruitの MAX98306 ステレオ 3.7W クラスDオーディオアンプモジュール用のケースです。
このボードは日本では[スイッチサイエンス](https://www.switch-science.com/catalog/1140/)や
[マルツ](http://www.marutsu.co.jp/pc/i/574378/)などから購入できます。ケーブルの穴は 22 AWG のワイヤー用になっています。

プリンタおよびフィラメントに由来する誤差によって、ふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR の値を大きくしてみてください。

CE32A 1" Speaker Driver Enclosure Type2
=======================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1795831)

(UPDATE) Added a model with speaker stand as per [a comment](http://www.thingiverse.com/thing:1788158/#comment-1024703).

An enclosure for 1" speaker [Dayton Audio CE32A](http://www.daytonaudio.com/index.php/dayton-audio-ce32a-4-1-1-4-mini-speaker-4-ohm.html) that can be purchased at online stores like [Parts Express](http://www.parts-express.com/dayton-audio-ce-series-ce32a-4-1-1-4-mini-speaker-4-ohm--285-103)

This is single piece type of enclosure that you can just insert the speaker driver to the enclosure from the front. This is more tolerrnt than [my previous version](http://www.thingiverse.com/thing:1788158) of errors resulting from printer accuracy or filament types.

(更新) 頂いた[コメント](http://www.thingiverse.com/thing:1788158/#comment-1024703)に沿ってスピーカースタンドつきモデルを追加しました。

1インチスピーカードライバー [\[Dayton Audio CE32A\]](https://www.amazon.co.jp/Dayton-Audio-CE32A-8-Speaker-%E4%B8%A6%E8%A1%8C%E8%BC%B8%E5%85%A5%E5%93%81/dp/B012V5HCTI) 用のケースです。

前面からスピーカードライバーをはめこむだけの構造になっていて、必要に応じてネジ留めもできるので、初期版よりもプリンタやフィラメントの種類による誤差に対して寛容になっています。


CE32A 1" Speaker Driver Enclosure
=================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1788158)

(UPDATE) Added a model with speaker stand as per [a comment](http://www.thingiverse.com/thing:1788158/#comment-1024703).

An enclosure for 1" speaker [\[Dayton Audio CE32A\]](http://www.daytonaudio.com/index.php/dayton-audio-ce32a-4-1-1-4-mini-speaker-4-ohm.html) that can be purchased at online stores like [\[Parts Express\]](http://www.parts-express.com/dayton-audio-ce-series-ce32a-4-1-1-4-mini-speaker-4-ohm--285-103)

Depending on your printer and/or filament types, the speaker driver and/or the lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing SHELL_ERROR and/or LID_ERROR to larger values.
If you are still experiencing difficulty, please try [Rev.2](http://www.thingiverse.com/thing:1795831) as that one would be much easier.

(更新) 頂いた[コメント](http://www.thingiverse.com/thing:1788158/#comment-1024703)に沿ってスピーカースタンドつきモデルを追加しました。

1インチスピーカードライバー [\[Dayton Audio CE32A\]](https://www.amazon.co.jp/Dayton-Audio-CE32A-8-Speaker-%E4%B8%A6%E8%A1%8C%E8%BC%B8%E5%85%A5%E5%93%81/dp/B012V5HCTI) 用のケースです。

プリンタおよびフィラメントに由来する誤差によって、スピーカーやふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR や SHELL_ERROR の値を大きくしてみてください。
それでもうまく収まらない場合には [Rev.2](http://www.thingiverse.com/thing:1795831) のモデルを試してみてください。


PAM8403-based Tiny Audio Amplifier Board
========================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1788138)

An enclosure for PAM8403-based tiny audio amplifier board that can be purchased from online stores like [\[Sainsmart\]](http://www.sainsmart.com/mini-pam8403-5v-digital-amplifier-board-usb-power-supply.html).
There are two versions with or without vents.

Depending on your printer and/or filament types, lid may not fit your enclosure. In that case, please try models with slightly different dimensions as follows. If you can edit OpenSCAD code, please try changing LID_ERROR and HOLD_ERROR to larger values.

  - PAM8403_lid_e00.stl  // LID_ERROR=0.0;
  - PAM8403_lid_e04.stl  // LID_ERROR=0.4; (a bit loose)
  - PAM8403_lid_e08.stl  // LID_ERROR=0.8; (much loose)
  - PAM8403_body_e00.stl // HOLD_ERORR=0.0
  - PAM8403_body_e04.stl // HOLD_ERORR=0.4 (a bit tight)
  - PAM8403_body_e08.stl // HOLD_ERROR=0.8 (much tight)

秋月電子でも売っている[\[PAM8403 D級ステレオアンプモジュール\]](http://akizukidenshi.com/catalog/g/gK-09873/)用のケースです。換気穴の有無によりモデルが2種類あります。

プリンタおよびフィラメントに由来する誤差によって、ふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR の値を大きくしてみてください。


HiVi B1S 1" Speaker Driver Enclosure
====================================

Available at [Thingiverse](http://www.thingiverse.com/thing:1761134)

(UPDATE) Added a model with speaker stand as per [a comment](http://www.thingiverse.com/thing:1788158/#comment-1024703).

A tiny speaker enclosure designed for HiVi B1S 1" Shielded Aluminum Mid/Tweeter that can be purchased from online stores like [\[Parts Express\]](http://www.parts-express.com/hivi-b1s-1-shielded-aluminum-mid-tweeter--297-411).

Depending on your printer and/or filament types, the speaker driver and/or the lid may not fit your enclosure. In that case, please try models with slightly different dimensions. If you can edit OpenSCAD code, please try changing SHELL_ERROR and/or LID_ERROR to larger values.


(更新) 頂いた[コメント](http://www.thingiverse.com/thing:1788158/#comment-1024703)に沿ってスピーカースタンドつきモデルを追加しました。

HiVi B1S 1" スピーカー用のケースです。[このサイト](http://mx-spk.shop-pro.jp/?pid=22911621)などで売っています。

プリンタおよびフィラメントに由来する誤差によって、スピーカーやふたが入らないかもしれません。寸法を微調整したものを用意してありますので、試してみてください。OpenSCADコードを編集できる場合は LID_ERROR や SHELL_ERROR の値を大きくしてみてください。



Using OpenSCAD Source Files
===========================

## Summary

### How to build all STL files:

    git clone
    cd Build
    make

STL files are copied under Staging folder (production) and StagingTest folder (test).

### How to build STL files for a specific model:
  
    git clone
    cd Build
    make TARGET

... where TARGET is one of followings.
  - ce32a_rev1
  - ce32a_type2_rev1
  - b1s_rev2
  - aura205
  - tb1070sh
  - pam8403
  - max98306
  - microusb
  - audiojack
  - speaker_stand
  - compo
  - btaudio

STL files are copied under Staging folder (production) and StagingTest folder (test).

Also, if you know the STL file name, you can specify it directly.

    git clone
    cd Build
    make ce32a_rev1.stl


## Detail

As a simple method to generate multiple STL files from single source file, model definition and rendering configuration are seperated into different modules (but still in the same source file) as follows.

In foo.scad, the top level module will change rendering according to TARGET.

    TARGET="default";
    module foo_main(target=TARGET) { // rendering definition
        if (target=="default") {
            foo();
        }
        if (target=="with_stand") {
            foo(with_stand=1);
        }
    }
    module foo(with_stand=0, ...) { // model definitinon
    }

In Build/Makefile, a target command line specifies different TARGET definition.

    foo.stl: ../foo.scad
        $(OPENSCAD) -D "TARGET=\"default\";"
    foo_with_stand.stl: ../foo.scad
        $(OPENSCAD) -D "TARGET=\"with_stand\";"

To generate STL files, run "make" in Build directory. This will generate all STL files.
  - If the STL file is for production, it is copied to Staging/ directory.
  - If the STL file is for test, it is copied to StagingTest/ directory.

Also you can generate each target individually by doing something like

    make foo_with_stand.stl


For Windows, [Linux Subsystem for Windows](https://msdn.microsoft.com/ja-jp/commandline/wsl/install_guide) is recommended.
