object Form1: TForm1
  Left = 280
  Top = 1
  Width = 696
  Height = 717
  Caption = 'File Monitor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 24
    Top = 8
    Width = 625
    Height = 257
    Caption = 'Floder Monitor Options'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 552
      Top = 24
      Width = 23
      Height = 22
      Caption = '..'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 552
      Top = 76
      Width = 23
      Height = 22
      Caption = '..'
      OnClick = SpeedButton2Click
    end
    object edtFolder: TEdit
      Left = 20
      Top = 24
      Width = 525
      Height = 24
      TabOrder = 0
      Text = 'edtFolder'
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 116
      Width = 565
      Height = 105
      Caption = 'Monitor Events'
      TabOrder = 1
      object ckbFilenameChange: TCheckBox
        Left = 32
        Top = 24
        Width = 153
        Height = 17
        Caption = 'Filename Changes'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object ckbDirNameChange: TCheckBox
        Left = 32
        Top = 40
        Width = 185
        Height = 17
        Caption = 'Subfolder Name Changes'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object ckbAttrChange: TCheckBox
        Left = 32
        Top = 56
        Width = 153
        Height = 17
        Caption = 'Attributes Changes'
        TabOrder = 2
      end
      object ckbSizeChange: TCheckBox
        Left = 32
        Top = 72
        Width = 153
        Height = 17
        Caption = 'Size Changes'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object ckbWriteTimeChange: TCheckBox
        Left = 232
        Top = 24
        Width = 153
        Height = 17
        Caption = 'Write Time Changes'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object ckbAccessTimeChange: TCheckBox
        Left = 232
        Top = 40
        Width = 237
        Height = 17
        Caption = 'Access Time Changes'
        TabOrder = 5
      end
      object ckbCreationTimeChange: TCheckBox
        Left = 232
        Top = 55
        Width = 217
        Height = 17
        Caption = 'Creation Time Changes'
        TabOrder = 6
      end
      object ckbSecurityAttrChanges: TCheckBox
        Left = 232
        Top = 72
        Width = 209
        Height = 17
        Caption = 'Security Attribute Changes'
        TabOrder = 7
      end
    end
    object ckbMonitorSubfolders: TCheckBox
      Left = 20
      Top = 52
      Width = 161
      Height = 17
      Caption = 'Also monitor subfolders'
      TabOrder = 2
    end
    object btnActivate: TBitBtn
      Left = 20
      Top = 222
      Width = 113
      Height = 25
      Caption = 'Activate'
      TabOrder = 3
      OnClick = btnActivateClick
    end
    object bkpFolder: TEdit
      Left = 20
      Top = 76
      Width = 525
      Height = 24
      TabOrder = 4
      Text = 'bkpFolder'
    end
  end
  object GroupBox3: TGroupBox
    Left = 24
    Top = 268
    Width = 625
    Height = 89
    Caption = 'Test Actions'
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 20
      Top = 20
      Width = 201
      Height = 25
      Caption = 'Add random text file'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 20
      Top = 51
      Width = 201
      Height = 25
      Caption = 'Delete random text file'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn4: TBitBtn
      Left = 232
      Top = 51
      Width = 241
      Height = 25
      Caption = 'Rename random text file'
      TabOrder = 2
      OnClick = BitBtn4Click
    end
    object BitBtn3: TBitBtn
      Left = 232
      Top = 20
      Width = 241
      Height = 25
      Caption = 'Change content/size of random text file'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
  end
  object mmLogs: TMemo
    Left = 24
    Top = 360
    Width = 625
    Height = 277
    Lines.Strings = (
      'mmLogs')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btnClearLog: TBitBtn
    Left = 24
    Top = 645
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 3
    OnClick = btnClearLogClick
  end
  object Button1: TButton
    Left = 104
    Top = 644
    Width = 75
    Height = 25
    Caption = 'save log'
    TabOrder = 4
    OnClick = Button1Click
  end
end
