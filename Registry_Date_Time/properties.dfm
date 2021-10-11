object PropertyDlg: TPropertyDlg
  Left = 282
  Top = 128
  ActiveControl = Cancel
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registry Date/Time'
  ClientHeight = 447
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000777666677666677666000000000000078F8
    EE67F8EE678FEE660000000000007888EE66888E66888E6600000000000077EE
    F866EEF866EEF87600000000000077EE87666E8766EE88660000000000007766
    66666666678FEE660066000000007776666676666677666000660000000078F8
    E66788EE660000000066000000007888EE6688EE6600000000660000000077E8
    F866EEF86600666600660000000077EE8766EEF8660066660006000000007766
    660667F866006E6600000000000077766600668760066E660000000000007888
    E66600000006886600060000000078F8EE6600000006776600660000000077E8
    F86600666666600000660000000076EEF876006666660000006600000000067E
    E887066E886600060066000000000077EE8706EEF86600660066000000000006
    7776668FF866006667006766000000007766678FF87600667700776660000000
    06777788877776000077666E660000000077777777777700007766EE66000000
    0000000000077760000077887000000000000000000077660000778F70000000
    0000000000076666600007787000000000000000007766EE6600007700000000
    0000000000067788600000000000000000000000000077887000000000000000
    0000000000000777000000000000000000000000000000770000000000000000
    0FFF00000FFF000003FF000003FF000000FF000000FF0000003F0000003F0000
    003F0000003F0000003F0000003F0000003F0000003F0000003F0000003F0000
    003F0000003FC000000FC000000FF0000003F0000003FC000C00FC000C00FFFF
    0303FFFF0303FFFC00CFFFFC00CFFFFF03FFFFFF03FFFFFFCFFFFFFFCFFF}
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 8
    Top = 5
    Width = 361
    Height = 404
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General'
      object Bevel1: TBevel
        Left = 10
        Top = 73
        Width = 331
        Height = 12
        Shape = bsTopLine
      end
      object lblNumberOfSubkeys: TLabel
        Left = 332
        Top = 86
        Width = 8
        Height = 17
        Alignment = taRightJustify
        Caption = '0'
      end
      object lblLongestSubkey: TLabel
        Left = 332
        Top = 116
        Width = 8
        Height = 17
        Alignment = taRightJustify
        Caption = '0'
      end
      object lblNumberOfValues: TLabel
        Left = 332
        Top = 146
        Width = 8
        Height = 17
        Alignment = taRightJustify
        Caption = '0'
      end
      object lblLongestDataValueNameLength: TLabel
        Left = 332
        Top = 175
        Width = 8
        Height = 17
        Alignment = taRightJustify
        Caption = '0'
      end
      object lblLongestDataValueLength: TLabel
        Left = 332
        Top = 205
        Width = 8
        Height = 17
        Alignment = taRightJustify
        Caption = '0'
      end
      object lblGMTTime: TLabel
        Left = 311
        Top = 235
        Width = 29
        Height = 17
        Alignment = taRightJustify
        Caption = '0:00'
      end
      object Label1: TLabel
        Left = 10
        Top = 86
        Width = 124
        Height = 17
        Caption = 'Number of subkeys:'
      end
      object Label2: TLabel
        Left = 10
        Top = 116
        Width = 182
        Height = 17
        Caption = 'Longest subkey name length:'
      end
      object Label3: TLabel
        Left = 10
        Top = 146
        Width = 143
        Height = 17
        Caption = 'Number of data values:'
      end
      object Label4: TLabel
        Left = 10
        Top = 175
        Width = 202
        Height = 17
        Caption = 'Longest data-value name length:'
      end
      object Label5: TLabel
        Left = 10
        Top = 205
        Width = 164
        Height = 17
        Caption = 'Longest data-value length:'
      end
      object Label6: TLabel
        Left = 10
        Top = 235
        Width = 215
        Height = 17
        Caption = 'Time of last write to the key (GMT):'
      end
      object Image1: TImage
        Left = 10
        Top = 16
        Width = 32
        Height = 32
        AutoSize = True
        Center = True
        Picture.Data = {
          055449636F6E0000010001002020100001000400E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000833333333333333333333333
          333333308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308F7B7B7B7B7B7B7B7B7B7B7B
          7B7B7B308FB7B7B7B7B7B7B7B7B7B7B7B7B7B7308FFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF308777777777777777888888888888880008FB7B7B7B7B7B7800000000
          00000000008FB7B7B7B7B78000000000000000000008FFFFFFFFF80000000000
          0000000000008888888880000000000000000000000000000000000000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800000010000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000018000FFFFC001FFFFE003FFFFF007FFFF
          FFFFFFFF}
      end
      object lblFolderName: TLabel
        Left = 73
        Top = 31
        Width = 4
        Height = 17
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
      end
      object Label7: TLabel
        Left = 10
        Top = 265
        Width = 215
        Height = 17
        Caption = 'Date of last write to the key (GMT):'
      end
      object lblTime: TLabel
        Left = 10
        Top = 296
        Width = 219
        Height = 17
        Caption = 'Time of last write to the key (Local):'
      end
      object lblDate: TLabel
        Left = 10
        Top = 326
        Width = 219
        Height = 17
        Caption = 'Date of last write to the key (Local):'
      end
      object lblGMTDate: TLabel
        Left = 306
        Top = 265
        Width = 34
        Height = 17
        Alignment = taRightJustify
        Caption = '0/0/0'
      end
      object lblLocalTime: TLabel
        Left = 311
        Top = 296
        Width = 29
        Height = 17
        Alignment = taRightJustify
        Caption = '0:00'
      end
      object lblLocalDate: TLabel
        Left = 306
        Top = 326
        Width = 34
        Height = 17
        Alignment = taRightJustify
        Caption = '0/0/0'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'About...'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      object Image2: TImage
        Left = 10
        Top = 16
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020040000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF00000000000000000000000000000000007EFEF6FEFE6EFEF600000000
          000000007FEFE6EFEF6FEFE660000000000000007EFEF6FEFE6EFEF660000000
          000000007FEFE6EFEF6FEFE6606000000000000076666666660FFFF660600000
          000000007FEFE6EFEF60EFEF60606000000000007EFEF6FEFE66000000606000
          000000007FEFE6EFEF66066666006000000000007EFEF6FEFE660666F6606000
          00000000766660FFFF66066FE6600000000000007EFEF6066EF606FEF6606000
          000000007FEFE66000000FFFF6606000000000007EFEF660666660FEFE606000
          000000007FEFE660666F6600000060F6600000007FFFF66066FE660666660FEF
          6600000007EFEF606FEF660666E6FEFEF660000000766660FFFF66066EF66FEF
          660000000007EFEF6FEFE606EFE660F660000000000076666666660FFFF66077
          70000000000007EFEF6FEFE6EFEF600000000000000000777777777777777700
          0000000000000000000000000000000000700000000000000000000000000000
          07F660000000000000000000076000007FEF6600000000000000000076660007
          FEFEF660000000000000000766F660007FEF660000000000000000076FEF6000
          07F660000000000000000007FEFEF0000077700000000000000000007FEF0000
          00000000000000000000000007F0000000000000000000000000000000700000
          000000000000FFFF00007FFF00003FFF00001FFF00000FFF000007FF000003FF
          000003FF000003FF000003FF000003FF000003FF000003FF0000007F0000003F
          0000001F8000000FC000001FE000003FF000007FF80003FFFC0003FFFFFFFFC7
          FFFFDF83FFFF8F01FFFF0600FFFE0301FFFE0383FFFE03C7FFFF07FFFFFF8FFF
          FFFFDFFF}
        Stretch = True
      end
      object lblAbout: TLabel
        Left = 78
        Top = 21
        Width = 49
        Height = 17
        Caption = 'lblAbout'
      end
      object lblCopyright: TLabel
        Left = 78
        Top = 42
        Width = 217
        Height = 17
        Caption = 'Copyright '#169' 2002 by Object Vision'
      end
      object lblComments: TLabel
        Left = 78
        Top = 84
        Width = 115
        Height = 17
        Caption = 'All rights reserved. '
      end
      object lblUrl: TLabel
        Left = 78
        Top = 105
        Width = 191
        Height = 18
        Cursor = crHandPoint
        Hint = 'Visit Object Vision Home Page'
        Caption = 'http://www.object-vision.com'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblUrlClick
      end
      object Bevel2: TBevel
        Left = 10
        Top = 136
        Width = 326
        Height = 12
        Shape = bsTopLine
      end
      object Image3: TImage
        Left = 31
        Top = 37
        Width = 28
        Height = 27
        Picture.Data = {
          0A544A504547496D61676522030000FFD8FFE000104A46494600010101012C01
          2C0000FFDB0043000503040404030504040405050506070C08070707070F0B0B
          090C110F1212110F111113161C1713141A1511111821181A1D1D1F1F1F131722
          24221E241C1E1F1EFFDB0043010505050706070E08080E1E1411141E1E1E1E1E
          1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E
          1E1E1E1E1E1E1E1E1E1E1E1E1EFFC20011080011001103012200021101031101
          FFC4001800010101010100000000000000000000000005060304FFC400160101
          010100000000000000000000000000000102FFDA000C03010002100310000001
          D9F82A729ACCA5AE6A4B0DD03FFFC4001E100001030403000000000000000000
          00000400020501030635141516FFDA000801010001050200469CC04473E1FBE8
          950B7983D2FF00082A79701653A2C2B54BFFC400141101000000000000000000
          00000000000020FFDA0008010301013F011FFFC4001411010000000000000000
          0000000000000020FFDA0008010201013F011FFFC4002C100002000403030D00
          00000000000000000102030411210012312271D110133233344151738292A3B1
          B2FFDA0008010100063F0249999879E136D2235D0A5E96ADCE8D716B77D4E25A
          72560A88ED054E484022B9A1AD45697B5C0A8DD6C76AF8DB8621C83E457E820D
          0B802CDAED6C8507C375305242565E1C78AA1D61F374CDAE525751437A9DC2F8
          EB667DC386263D3FA1889E71FA1C9FFFC4001C10010100020203000000000000
          00000000011100213151102061FFDA0008010100013F21381A6F5B63C8F54100
          0C1436DB4B690F11412DBF0AA24100027157644054596B2A6130FD04098835D8
          9EAEDEB7FFDA000C0301000200030000001000C700FFC4001911000105000000
          00000000000000000000F011203191A1FFDA0008010301013F104A34867FFFC4
          0014110100000000000000000000000000000020FFDA0008010201013F101FFF
          C400191001010003010000000000000000000000011100202131FFDA00080101
          00013F100708120E49004B36038084ADC7F4F641A534419C05B3D4E7890A2768
          08CBEDD87D886E43EA8634EC49FF00FFD9}
        Stretch = True
        Transparent = True
      end
      object lblObjectVisionAsso: TLabel
        Left = 78
        Top = 63
        Width = 176
        Height = 17
        Caption = 'Object Vision Associates, Inc.'
      end
      object Memo1: TMemo
        Left = 10
        Top = 235
        Width = 326
        Height = 117
        BevelInner = bvNone
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clBtnFace
        Lines.Strings = (
          'Note:'
          ''
          'All length values are in TCHARS or WIDECHARS '
          'rather than ANSI so the character counts '
          'indicated will vary from what is visible to the '
          'user.')
        ReadOnly = True
        TabOrder = 0
      end
      object CanCollapse: TCheckBox
        Left = 16
        Top = 152
        Width = 273
        Height = 22
        Caption = 'Collapse Registry Treeview on Startup'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 1
      end
      object StayOnTop: TCheckBox
        Left = 16
        Top = 188
        Width = 116
        Height = 23
        Caption = 'Stay on Top'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object Cancel: TButton
    Left = 256
    Top = 416
    Width = 113
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelClick
  end
  object Refresh: TTimer
    Enabled = False
    Interval = 200
    OnTimer = RefreshTimer
    Left = 68
    Top = 52
  end
end
