object frameParameters: TframeParameters
  Left = 0
  Top = 0
  Width = 222
  Height = 528
  TabOrder = 0
  object ACLSidebar: TACLPanel
    Left = 0
    Top = 0
    Width = 222
    Height = 528
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 217
    ExplicitHeight = 521
    object ACLLabel1: TACLLabel
      Left = 6
      Top = 91
      Width = 105
      Height = 15
      Caption = 'Sampling method'
    end
    object ACLLabel2: TACLLabel
      Left = 125
      Top = 91
      Width = 105
      Height = 15
      Caption = 'Schedule'
    end
    object ACLComboBox1: TACLComboBox
      Left = 2
      Top = 106
      Width = 218
      Height = 23
      Align = alTop
      TabOrder = 0
      Buttons = <>
      Items.Strings = (
        'Euler A'
        'Euler'
        'Heun'
        'DPM2'
        'DPM++ 2M'
        'DPM++ 2M v2'
        'DPM++ 2S a'
        'IPNDM'
        'IPNDM V'
        'LCM')
      ItemIndex = 0
      Mode = cbmList
      Text = 'Euler A'
      ExplicitWidth = 176
    end
    object ACLComboBox2: TACLComboBox
      Left = 2
      Top = 129
      Width = 218
      Height = 23
      Align = alTop
      TabOrder = 1
      Buttons = <>
      Items.Strings = (
        'Default'
        'Discrete'
        'Karras'
        'Exponential'
        'Ays'
        'Gits')
      ItemIndex = 0
      Mode = cbmList
      Text = 'Default'
      ExplicitWidth = 176
    end
    object ACLSlider1: TACLSlider
      Left = 2
      Top = 152
      Width = 218
      Height = 45
      Align = alTop
      TabOrder = 2
      Orientation = oHorizontal
      OptionsLabels.CurrentValue = 'Sampling Steps'
      OptionsLabels.MaxValue = '150'
      OptionsLabels.MinValue = '1'
      OptionsLabels.Layout = sllBeforeTrackBar
      OptionsValue.Default = 20.000000000000000000
      OptionsValue.Max = 150.000000000000000000
      OptionsValue.Min = 1.000000000000000000
      Position = 20.000000000000000000
      ExplicitWidth = 176
    end
    object ACLGroupBox2: TACLGroupBox
      Left = 2
      Top = 25
      Width = 218
      Height = 81
      Align = alTop
      TabOrder = 3
      Caption = 'VAE'
      StyleCaption.ColorText.Value = xFF0078D7
      StyleCaption.ColorText.ID = 'Groups.Colors.HeaderText - FF0078D7'
      ExplicitWidth = 176
      object ACLImageComboBox2: TACLImageComboBox
        Left = 7
        Top = 16
        Width = 204
        Height = 23
        Hint = 'Stable Diffusion Model'
        Align = alTop
        TabOrder = 0
        Buttons = <
          item
            Caption = #55357#56580#65039
            Hint = 'Refresh'
            Width = 24
          end>
        Items = <
          item
            ImageIndex = 1
            Text = '[none]'
          end
          item
            ImageIndex = 3
            Text = 'fdfdf'
          end
          item
            ImageIndex = 4
            Text = 'gggd'
          end>
        ItemIndex = 0
        ExplicitWidth = 162
      end
      object ACLCheckBox1: TACLCheckBox
        Left = 7
        Top = 48
        Width = 72
        Height = 17
        TabOrder = 1
        Caption = 'VAE tiling'
      end
      object ACLCheckBox2: TACLCheckBox
        Left = 85
        Top = 48
        Width = 110
        Height = 17
        TabOrder = 2
        Caption = 'VAE decode only'
      end
    end
    object ACLSlider4: TACLSlider
      Left = 2
      Top = 408
      Width = 218
      Height = 45
      Align = alTop
      TabOrder = 4
      Orientation = oHorizontal
      OptionsLabels.CurrentValue = 'CFG'
      OptionsLabels.MaxValue = '15.0'
      OptionsLabels.MinValue = '0.0'
      OptionsLabels.Layout = sllBeforeTrackBar
      OptionsValue.Default = 7.000000000000000000
      OptionsValue.Max = 15.000000000000000000
      OptionsValue.Page = 0.100000001490116100
      OptionsValue.Paginate = True
      Position = 15.000000000000000000
      ExplicitWidth = 176
    end
    object gbImageSize: TACLGroupBox
      Left = 2
      Top = 197
      Width = 218
      Height = 125
      Align = alTop
      TabOrder = 5
      Caption = 'Image Size'
      StyleCaption.ColorText.Value = xFF0078D7
      StyleCaption.ColorText.ID = 'Groups.Colors.HeaderText - FF0078D7'
      ExplicitWidth = 176
      object aclsliderHeight: TACLSlider
        Left = 7
        Top = 84
        Width = 204
        Height = 39
        Align = alTop
        TabOrder = 0
        Orientation = oHorizontal
        Options.MarkVisible = False
        OptionsLabels.CurrentValue = 'Height'
        OptionsLabels.MaxValue = '2048'
        OptionsLabels.MinValue = '64'
        OptionsLabels.Layout = sllBeforeTrackBar
        OptionsValue.Default = 512.000000000000000000
        OptionsValue.Max = 2048.000000000000000000
        OptionsValue.Min = 64.000000000000000000
        OptionsValue.Page = 64.000000000000000000
        OptionsValue.Paginate = True
        Position = 512.000000000000000000
        ExplicitWidth = 162
      end
      object aclsliderWidth: TACLSlider
        Left = 7
        Top = 39
        Width = 204
        Height = 45
        Align = alTop
        TabOrder = 1
        Orientation = oHorizontal
        OptionsLabels.CurrentValue = 'Width'
        OptionsLabels.MaxValue = '2048'
        OptionsLabels.MinValue = '64'
        OptionsLabels.Layout = sllBeforeTrackBar
        OptionsValue.Default = 512.000000000000000000
        OptionsValue.Max = 2048.000000000000000000
        OptionsValue.Min = 64.000000000000000000
        OptionsValue.Page = 64.000000000000000000
        OptionsValue.Paginate = True
        Position = 512.000000000000000000
        ExplicitWidth = 162
      end
      object aclComboAspectRatio: TACLImageComboBox
        Left = 7
        Top = 16
        Width = 204
        Height = 23
        Align = alTop
        TabOrder = 2
        Buttons = <
          item
            Caption = #8693
          end>
        Images = SVGIconImageList1
        Items = <
          item
            ImageIndex = 12
            Tag = -1
            Text = 'No Aspect Ratio'
          end
          item
            ImageIndex = 2
            Tag = -1
            Text = 'Square Format (1:1)'
          end
          item
            ImageIndex = 3
            Tag = 5
            Text = 'Widescreen (16:9)'
          end
          item
            ImageIndex = 13
            Tag = 8
            Text = 'Portrait (2:3)'
          end
          item
            ImageIndex = 7
            Tag = 1
            Text = 'Instagram Portrait (4:5)'
          end
          item
            ImageIndex = 0
            Tag = 9
            Text = 'Classic (3:2)'
          end
          item
            ImageIndex = 9
            Tag = 4
            Text = 'Vertical Widescreen (9:16)'
          end
          item
            ImageIndex = 1
            Tag = 3
            Text = 'Standard (4:3)'
          end
          item
            ImageIndex = 8
            Tag = 2
            Text = 'Vertical Standard (3:4)'
          end
          item
            ImageIndex = 4
            Text = 'Photographic (5:4)'
          end
          item
            ImageIndex = 10
            Tag = 32
            Text = 'Classic Print Portrait (5:7)'
          end
          item
            ImageIndex = 6
            Tag = 16
            Text = 'Vertical Print (6:7)'
          end
          item
            ImageIndex = 5
            Tag = 33
            Text = 'Near 4:3 (7:5)'
          end
          item
            ImageIndex = 11
            Tag = 17
            Text = 'Classic Print (7:6)'
          end>
        ItemIndex = 0
        ExplicitLeft = 11
        ExplicitTop = 10
      end
    end
    object ACLImageComboBox4: TACLImageComboBox
      Left = 2
      Top = 2
      Width = 218
      Height = 23
      Hint = 'Stable Diffusion Model'
      Align = alTop
      TabOrder = 6
      Buttons = <
        item
          Caption = #55357#56580#65039
          Hint = 'Refresh'
          Width = 24
        end>
      Items = <
        item
          ImageIndex = 1
          Text = 'Default'
        end
        item
          ImageIndex = 3
          Text = '1'
        end
        item
          ImageIndex = 4
          Text = '2'
        end>
      ItemIndex = 0
      Style.ColorBorderFocused.ID = 'Category.Colors.Border2'
      ExplicitLeft = 26
      ExplicitTop = 3
    end
    object ACLGroupBox3: TACLGroupBox
      Left = 2
      Top = 345
      Width = 218
      Height = 63
      Align = alTop
      TabOrder = 7
      Caption = 'TAESD'
      ExplicitWidth = 176
      object ACLImageComboBox3: TACLImageComboBox
        Left = 7
        Top = 16
        Width = 204
        Height = 23
        Hint = 'Stable Diffusion Model'
        Align = alTop
        TabOrder = 0
        Buttons = <
          item
            Caption = #55357#56580#65039
            Hint = 'Refresh'
            Width = 24
          end>
        Items = <
          item
            ImageIndex = 1
            Text = 'Asds'
          end
          item
            ImageIndex = 3
            Text = 'fdfdf'
          end
          item
            ImageIndex = 4
            Text = 'gggd'
          end>
        ItemIndex = 0
        ExplicitWidth = 162
      end
    end
    object ACLEdit1: TACLEdit
      Left = 2
      Top = 322
      Width = 218
      Height = 23
      Align = alTop
      TabOrder = 8
      Buttons = <
        item
          Caption = #55356#57266
          Hint = 'Random'
        end
        item
          Caption = #9851
          Hint = 'Previous'
        end>
      InputMask = eimInteger
      Text = '0'
      ExplicitWidth = 176
    end
  end
  object ACLResourceCollection1: TACLResourceCollection
    Items = <
      item
        ID = '_BLUE'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF0078D7
      end
      item
        ID = '_DBLUE'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF004175
      end
      item
        ID = 'EditBox.Colors.BorderFocused'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF0078D7
      end
      item
        ID = 'TreeList.Colors.RowHovered'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF0078D7
      end
      item
        ID = 'Groups.Colors.HeaderText'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF0078D7
      end
      item
        ID = 'Common.Colors.Activity2'
        ResourceClassName = 'TACLResourceColor'
        Resource.ID = '_BLUEMENU'
      end
      item
        ID = '_BLUEMENU'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF0377D0
      end
      item
        ID = 'TreeList.Colors.IncSearch'
        ResourceClassName = 'TACLResourceColor'
        Resource.ID = '_BLUE'
      end
      item
        ID = 'EditBox.Textures.Button'
        ResourceClassName = 'TACLResourceTexture'
        Resource.Data = {
          41434C494D47333201000000050000006269747AE50000000200000011000000
          AA000000D50000007801ED98310A043108452FB36DDADC619B1C60CEB2279963
          E5420E161FC2945AC8E22B449B67C03C4270CE69936006388003450EDCD73082
          19E0000E5439F0FB7E8C6006388003550E8C318C60063880033880033880031D
          1D601FDD6F27BFF7B677443C387B447831DE4735B99F8F557B28CEADDB819E6F
          87EAC87D88F51CE1C56479F521D73995997DD51E8A73EB76A0E7DBA13A721F62
          3D477831595E7DC8754E6566CFDFB7DFDF77AD65EF887870F688F062BC8F6A72
          3F1FB9F37E777EFE5F54473C10EB39C28BC9F2EA43FE4F971F375A242F647261
          770500000001000000006C61797436000000010A000000030000000200000003
          0000000300000000000000000000000000000000000000000000000000000000
          00000000000000006966616D550000000100000000363636FF02000000020000
          0002000000020000000200000002000000020000000200000002000000363636
          FF02000000020000000200000002000000020000000200000002000000020000
          0002000000584450490200000060004E45585441434C494D4733320100000005
          0000006269747A410100000200000016000000DC000000310100007801ED9AB1
          0DC320104597494BCB0E691820B364928CC5424414279D905D58F765847905C2
          46E289FC7B8E65E39C73CB3432C0011CC0011CC081A90EFC3EA9D1C800077000
          07700007E63AF07DBF1A8D0C7000077000077060AE0329A54623031CC0011CC0
          011CC0011CC0011CC0011CC081DD1DE05B2EBE67C3816B0ED45ADB598B6679C4
          8D326DBE67DB98AAEF6C150BCE351FC9EB3979B17F3F77FF9EFCD7CBDFDFD7C6
          E3683D475E3F8F326DBE67DB98AA57AE53B52638EB5D5BBBD78CFDFBB9FBF7E4
          BF5EFEFEBE361E47EB39F2FA799469F33DDBC654BD729DAA35C159EFDADABD66
          BCEB78CEBB0E6A794F2D4B29EDAC456B70C48D326DBE67DB98AAEF6C150BCE3D
          1E933339E3000EACEE807FCE1C8FA3BF6DE4F5F328D3E67BB68DA97AE53A556B
          82C37FCD6A0EFC01EF5DC190647261770500000001000000006C617974360000
          00010A0000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000006966616D5500000000
          00000000363636FF020000000200000002000000020000000200000002000000
          020000000200000002000000363636FF02000000020000000200000002000000
          0200000002000000020000000200000002000000584450490200000078004E45
          585441434C494D47333201000000050000006269747AE0010000020000001900
          0000FA000000D00100007801ED9B416E83301045EFD2761976C015DA6ED8B757
          492E92DC0B84B88C93893495553910C9330893B7181941F87FEC79B12CCBB46D
          1B5A82318001188001188001188081A218B8FC5681600C600006600006600006
          60A02C064EDF1F81600C60000660000660000660A02C06AAAA0A046300033000
          03300003300003300003300003300003300003300003BE0C344D13BC836F26F8
          6E0406B6CDC0300C61292C6AA81EE338DEFDA669FAF3B5D0570DF5E9FBDE45FF
          BF8FF8E93D8FD65BDF236734B7FD9FA73EFBA8CF3AE7170FB7EF26BCA3AC7388
          EB8C3B6352FA389F7F0EE199C8EDA7AE79E65AC9C3CA27B586136D0B0FD1D17E
          C46BB8DCDC53EFAB8FB4A9E756F73CF5E3318FAFAD724787791806FC18E0FC62
          59E717A9D76BD5EBF8F51E8E9F6FF371FB4D2E17F15AE4D1B5E462E5935AC389
          B68587E8681FE2355C6EEEA9F7D547DAD473AB7BDEFA5679A2F35AF353D1F596
          F9CC3B56F86694FDD47DECA752C77DD6F1D9730EB9F5EFBA2E2C85E4E2E923DA
          161EA293EA4B6EEEA9F7639FD473AB7BE263A585CE3EE70AEA4A5D6100066060
          5B0CC89AA6AEEBD9B058F7C4FB498FAE2D7D52FB70C29E8587E8681FE27D380F
          B6D5475A0F7DD5F4D6571FDA6DFDFFA907F55862E00AFF6FB840647261770500
          000001000000006C61797436000000010A000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000006966616D550000000000000000363636FF02000000020000000200
          0000020000000200000002000000020000000200000002000000363636FF0200
          0000020000000200000002000000020000000200000002000000020000000200
          0000584450490200000090004E45585441434C494D4733320100000005000000
          6269747AF9010000020000002200000054010000E90100007801EDDCB189C430
          1005D0662E75EA1E2E710157CB55B265B9211D0A2631083991343EBF400C6B2F
          9E8FE6615858B4EF7BD92D7BC000030C30C000030C30C000030C30C000030CBC
          C6C0E7672B963D60800106186080010618608001061860800106DE63E0F7FBAB
          58F680010618608001061860800106186080010618788F816DDB8A650F186080
          0106186080010618608001061860800106186080010618608001061860800106
          186080010618F89F069C25ED3C6D061860800106F21938CFB3DC59A367772743
          FDCEE81CF5F9BD2C3332448F5696B83FB35EB3CCEC7DED1559AED77DCEF78E31
          133361800106187056D47BCE8A326BB3668001069E63207E57F7EAE899F6FAC7
          FDD139EAF3A357ABCEC8103D3264686589EB2B6AECCB8ADE7A3EE7FD665666C5
          00030CE430E0ACA8F79C1565D666CD00030C3CC740FCAEEED5D133EDF58FFBA3
          73D4E747AF569D91217A64C8D0CA12D757D4D89715BDF57CCEFBCDACCC8A0106
          18C861C07FC4FC478C0106186080817C068EE32877D6E8D9DDC950BF333A477D
          7E2FCB8C0CD1A39525EECFACD72C337B5F7B4596EB759FF3BD63CCC44C186080
          01061860800106186080817C06E27F16BD3A7A76BDFE717F748EFAFCE8D5AA33
          32448F0C195A59E2FA8A1AFBB2A2B79EF9DE636662260C30C0406E037F0AB2AC
          01647261770500000001000000006C61797436000000010A0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000006966616D550000000000000000363636FF020000
          0002000000020000000200000002000000020000000200000002000000020000
          00363636FF020000000200000002000000020000000200000002000000020000
          0002000000020000005844504902000000C000}
      end
      item
        ID = 'Slider.Textures.Thumb'
        ResourceClassName = 'TACLResourceTexture'
        Resource.Data = {
          41434C494D47333201000000050000006269747ACD000000030000000C000000
          34000000BD0000007801ED92C109032110453DEC256CD244087BF36A0F29C154
          6011A924CD9A79C31E87CD8CB09083031F119F28FFFF94526AAD758F04D5812D
          A51C0A46E00B1702FC3DC86F93B773D8FD1FF687FBBF24DE6B5E6420B38AD8F3
          A625CE60D2E795BB47B08C87851154FB16E0F5FF015EFD9CBC9D9FF87FB63F43
          7D7B3F1FDD23BAC678581841B56F015EFF1FE0D5CFC9DBF989FF67FB33D4B75A
          6BF788AE31B039E743C1087A9BBCEDD3BFFBE3ECC3957CF75964654FE696385B
          BE91C09373647261770500000001000000006C61797436000000010400000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000006966616D250000000000000000010000
          0001000000010000000100000001000000010000000100000001000000584450
          49020000006000}
      end
      item
        ID = 'Buttons.Textures.Button'
        ResourceClassName = 'TACLResourceTexture'
        Resource.Data = {
          41434C494D47333201000000050000006269747A760400000200000014000000
          3B010000660400007801ED9CCD4EDC40108411420881100201E21F169623E2FF
          E71E71C82BE409F69E6B9E242F3B51452AABD6B2B5E3AD262C4A1F5A3D98E9CF
          66A63D2DA72633994CCA24D8AEAFAF4BDBC6E371A15D5D5D15D8E5E565198D46
          7FEDE2E2A29C9F9F97B3B3B3727A7A5A4E4E4E9AE702EBEDEDCDB2E3E3E329DE
          EBEB6B71ECE8E8688AF7F2F2521C3B3C3C9CE23D3F3F17C70E0E0E1A1EC6FDE9
          E9C9B2FDFDFD29DEE3E363716C6F6F6F8AF7F0F0501CDBDDDD6D78C8ADFBFB7B
          CB767676A678777777C5B1EDEDED8687BCBFBDBDB56C6B6BABE1E11D72799B9B
          9BA1BC8D8D8D868777DB7DBEF5F5F5868775C2E5ADADAD353CAC392E6F7575B5
          E161FD72792B2B2B0D0F6BA1CB5B5E5E6E78580BB17E61CDC13A81771BEF23DE
          21E43D7215F9859CC03C62EC315EF81BF15C602D2D2D35BCC8FAF1FBC74D89B6
          9FDF4625C2F85C60B13DAF5786B6935737FF3A66DACEF1CBF1EBCA01CD116D77
          F5ADB9A60C6DD7C476F55186B6BBFAD65C5386B66B62BBFA2843DB5D7D6BAE29
          03ED08ABB9EFD03EBFBE8F4B5A8E41E640E640E640E6C067E7C0FBFB7B89B69B
          9B9B12617CAE081618C9F3E625C72FC76FC8BB98F9F27FE40BE739C20FFD9EAA
          E91FF12DD8FEBE74F5A336CFD18E10DBE639DA1162DB3C473B426C9BE7EA476D
          9EA31D21B6CD73B423C4B679AE7ED4E639DA1162DB3C570F489EA7BFFDEFE387
          BFDFB59A5A30B44FA41645567B2F037EE65E06F8AEFD0CD064FBF63444EC6760
          3DC33382E7D623C693E7D623C693E7D623C68317B19F81F58C3CB71E319E3CB7
          1E311EBC88FD0CAC67E4B9F588F1E045EC67603D032F623FC347F222F633E8F3
          45EC67505EC47E06E545EC67505EC47E06E50DDDCFF02FF7340CAD5F35FDDDBA
          ABF1B81F7EAEB96F6D9FE4D569F07DE399E397E3D7971B5DD7335F162F5F3027
          11D635DFCEB5CFD6AFF2FEA9A1660E640E640E640E20072234A8366388E639AB
          2FD8B3FA0CF97DF27C8D75C878CFEA9BF391F3312B47F4F7992F8B972F989328
          73BEADFA6223BE03C9C03DD0A6FEE37870C8A3FEE378E551FF71BCF2A8FF385E
          79D47F1CAF3CEA3F8E571EF51FC72B8FFA8FE39547FDC7F1CAE3BFE73B3E7931
          7B1A308ECE3C30F62BCD079E35C2FA6AC0BCD7A187461AFE9F6F94E1B9B0BE3B
          3588B13C9FC1A93F1AABE733383588B17A3E83538318ABE733383588B17A3E83
          538318ABE733383588B17A3E83538318ABE733383588B17A3E03D72FC7EBF90C
          0E87B17A3E03AF395ECF6770388CD5F31978CDF17A3E83C3612CCF67C0B71CAF
          399EE73344F1783E43D4DAACEF6F64FD98B78EF5C545D45C32FAEE31CF7530E7
          89EB8B49DEE269B47D7335CFF59CDF9CDF2179F355F205CF196543C6A7B66FEA
          88A923660E640E640E640E2C420E44E950E4A8F6E8B6C174191A9FBCC5D34275
          7EDC76CE6FCEEF901CCA7CF1F305631869B5DF51B5FDA2BE05F9FD4BFDC7F5CA
          531D68DE367918176A408E571E3520C72B8F1A90E395470DC8F1CAA306E478E5
          510372BCF2A801395E798EAEC0D8E4C5EC65C0FBCB31753CE703F5D0E130F6A3
          78E046596D4D18D2EF0F4E72D8C9647261770500000001000000006C61797436
          000000010F000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000006966616D7D0000
          0000000000000200000002000000020000000200000002000000020000000200
          0000020000000200000002000000020000000200000002000000020000000200
          0000020000000200000002000000020000000200000002000000020000000200
          0000020000000200000002000000020000000200000002000000020000005844
          5049020000006000}
      end
      item
        ID = 'TreeList.Colors.RowFocused'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF2D5A9A
      end
      item
        ID = 'TreeList.Colors.RowSelected'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF24497C
      end
      item
        ID = 'TreeList.Colors.RowSelectedInactive'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF172D4B
      end
      item
        ID = 'TreeList.Colors.SelectionRect'
        ResourceClassName = 'TACLResourceColor'
        Resource.Value = xFF24497C
      end>
    Left = 194
    Top = 326
  end
  object SVGIconImageList1: TSVGIconImageList
    Size = 24
    SVGIconItems = <
      item
        IconName = '3_2'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="36pt" height="36pt" viewBox="0 0 36 36">'#13#10' <' +
          'defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="black" fo' +
          'nt-family="Times New Roman" font-size="16" transform="scale(1 -1' +
          ')">'#13#10'  <g id="Spread" transform="translate(0 -36)">'#13#10'   <g id="P' +
          'age background" style="font-variant-ligatures:none">'#13#10'    <path ' +
          'd="M 0,35.999 L 0,0 L 35.999,0 L 35.999,35.999 L 0,35.999 Z" str' +
          'oke="none" stroke-width="0" marker-start="none" marker-end="none' +
          '" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   <g id="Mou' +
          'seOff" style="font-variant-ligatures:none">'#13#10'    <path d="M 30.7' +
          '08,6.705 L 5.293,6.705 C 2.956,6.705 1.059,8.601 1.059,10.938 L ' +
          '1.059,25.062 C 1.059,27.399 2.956,29.296 5.293,29.296 L 30.708,2' +
          '9.296 C 33.045,29.296 34.942,27.399 34.942,25.062 L 34.942,10.93' +
          '8 C 34.942,8.601 33.045,6.705 30.708,6.705 Z" fill-rule="evenodd' +
          '" stroke-linejoin="miter" stroke="#0a4a8e" fill="#1e90ff" stroke' +
          '-width="2.118" marker-start="none" marker-end="none" stroke-mite' +
          'rlimit="79.8403193612775"/>'#13#10'    <text xml:space="preserve" tran' +
          'sform="translate(5.585 11.645) scale(1 -1)" font-family="Arial" ' +
          'font-size="18" fill-rule="evenodd" stroke-linejoin="miter" strok' +
          'e="none" fill="#ffffff" stroke-width="1.413" stroke-miterlimit="' +
          '79.8403193612775"><tspan x="0" y="0">3:2</tspan></text>'#13#10'   </g>' +
          #13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '4_3'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="36pt" height="36pt" viewBox="0 0 36 36">'#13#10' <' +
          'defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="black" fo' +
          'nt-family="Times New Roman" font-size="16" transform="scale(1 -1' +
          ')">'#13#10'  <g id="Spread" transform="translate(0 -36)">'#13#10'   <g id="P' +
          'age background" style="font-variant-ligatures:none">'#13#10'    <path ' +
          'd="M 0,35.999 L 0,0 L 35.999,0 L 35.999,35.999 L 0,35.999 Z" str' +
          'oke="none" stroke-width="0" marker-start="none" marker-end="none' +
          '" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   <g id="Mou' +
          'seOff" style="font-variant-ligatures:none">'#13#10'    <path d="M 30.7' +
          '08,5.293 L 5.293,5.293 C 2.956,5.293 1.059,7.19 1.059,9.526 L 1.' +
          '059,26.474 C 1.059,28.811 2.956,30.708 5.293,30.708 L 30.708,30.' +
          '708 C 33.045,30.708 34.942,28.811 34.942,26.474 L 34.942,9.526 C' +
          ' 34.942,7.19 33.045,5.293 30.708,5.293 Z" fill-rule="evenodd" st' +
          'roke-linejoin="miter" stroke="#0a4a8e" fill="#1e90ff" stroke-wid' +
          'th="2.118" marker-start="none" marker-end="none" stroke-miterlim' +
          'it="79.8403193612775"/>'#13#10'    <text xml:space="preserve" transfor' +
          'm="translate(5.783 11.645) scale(1 -1)" font-family="Arial" font' +
          '-size="18" fill-rule="evenodd" stroke-linejoin="miter" stroke="n' +
          'one" fill="#ffffff" stroke-width="1.413" stroke-miterlimit="79.8' +
          '403193612775"><tspan x="0" y="0">4:3</tspan></text>'#13#10'   </g>'#13#10'  ' +
          '</g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '1_1'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 34.458,4.809 L 9.042,4.809 C 6.706,4.809 4.809,6.706 4.809' +
          ',9.043 L 4.809,34.458 C 4.809,36.795 6.706,38.692 9.042,38.692 L' +
          ' 34.458,38.692 C 36.795,38.692 38.692,36.795 38.692,34.458 L 38.' +
          '692,9.043 C 38.692,6.706 36.795,4.809 34.458,4.809 Z" stroke="#0' +
          'a4a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" s' +
          'troke-linejoin="miter" marker-start="none" marker-end="none" str' +
          'oke-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="preser' +
          've" transform="translate(9.911 15.281) scale(1 -1)" font-family=' +
          '"Arial" stroke="none" fill="#ffffff" stroke-width="1.413" fill-r' +
          'ule="evenodd" stroke-linejoin="miter" font-size="18" stroke-mite' +
          'rlimit="79.8403193612775"><tspan x="0" y="0">1:1</tspan></text>'#13 +
          #10'   </g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '16_9'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="36pt" height="36pt" viewBox="0 0 36 36">'#13#10' <' +
          'defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="black" fo' +
          'nt-family="Times New Roman" font-size="16" transform="scale(1 -1' +
          ')">'#13#10'  <g id="Spread" transform="translate(0 -36)">'#13#10'   <g id="P' +
          'age background" style="font-variant-ligatures:none">'#13#10'    <path ' +
          'd="M 0,35.999 L 0,0 L 35.999,0 L 35.999,35.999 L 0,35.999 Z" str' +
          'oke="none" stroke-width="0" marker-start="none" marker-end="none' +
          '" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   <g id="Mou' +
          'seOff" style="font-variant-ligatures:none">'#13#10'    <path d="M 30.7' +
          '08,9.529 L 5.293,9.529 C 2.956,9.529 1.059,11.426 1.059,13.763 L' +
          ' 1.059,22.236 C 1.059,24.573 2.956,26.47 5.293,26.47 L 30.708,26' +
          '.47 C 33.045,26.47 34.942,24.573 34.942,22.236 L 34.942,13.763 C' +
          ' 34.942,11.426 33.045,9.529 30.708,9.529 Z" fill-rule="evenodd" ' +
          'stroke-linejoin="miter" stroke="#0a4a8e" fill="#1e90ff" stroke-w' +
          'idth="2.118" marker-start="none" marker-end="none" stroke-miterl' +
          'imit="79.8403193612775"/>'#13#10'    <text xml:space="preserve" transf' +
          'orm="translate(2.916 12.701) scale(1 -1)" font-family="Arial" fo' +
          'nt-size="15" fill-rule="evenodd" stroke-linejoin="miter" stroke=' +
          '"none" fill="#ffffff" stroke-width="1.413" stroke-miterlimit="79' +
          '.8403193612775"><tspan x="0" y="0">16:9</tspan></text>'#13#10'   </g>'#13 +
          #10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '5_4'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 34.458,7.631 L 9.042,7.631 C 6.706,7.631 4.809,9.528 4.809' +
          ',11.865 L 4.809,31.636 C 4.809,33.973 6.706,35.87 9.042,35.87 L ' +
          '34.458,35.87 C 36.795,35.87 38.692,33.973 38.692,31.636 L 38.692' +
          ',11.865 C 38.692,9.528 36.795,7.631 34.458,7.631 Z" stroke="#0a4' +
          'a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" str' +
          'oke-linejoin="miter" marker-start="none" marker-end="none" strok' +
          'e-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="preserve' +
          '" transform="translate(9.3 15.418) scale(1 -1)" font-family="Ari' +
          'al" stroke="none" fill="#ffffff" stroke-width="1.413" fill-rule=' +
          '"evenodd" stroke-linejoin="miter" font-size="18" stroke-miterlim' +
          'it="79.8403193612775"><tspan x="0" y="0">5:4</tspan></text>'#13#10'   ' +
          '</g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '7_5'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="36pt" height="36pt" viewBox="0 0 36 36">'#13#10' <' +
          'defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="black" fo' +
          'nt-family="Times New Roman" font-size="16" transform="scale(1 -1' +
          ')">'#13#10'  <g id="Spread" transform="translate(0 -36)">'#13#10'   <g id="P' +
          'age background" style="font-variant-ligatures:none">'#13#10'    <path ' +
          'd="M 0,35.999 L 0,0 L 35.999,0 L 35.999,35.999 L 0,35.999 Z" str' +
          'oke="none" stroke-width="0" marker-start="none" marker-end="none' +
          '" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   <g id="Mou' +
          'seOff" style="font-variant-ligatures:none">'#13#10'    <path d="M 30.7' +
          '07,6 L 5.292,6 C 2.955,6 1.058,7.897 1.058,10.234 L 1.058,25.767' +
          ' C 1.058,28.103 2.955,30 5.292,30 L 30.707,30 C 33.044,30 34.941' +
          ',28.103 34.941,25.767 L 34.941,10.234 C 34.941,7.897 33.044,6 30' +
          '.707,6 Z" fill-rule="evenodd" stroke-linejoin="miter" stroke="#0' +
          'a4a8e" fill="#1e90ff" stroke-width="2.118" marker-start="none" m' +
          'arker-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'    <te' +
          'xt xml:space="preserve" transform="translate(5.422 11.751) scale' +
          '(1 -1)" font-family="Arial" font-size="18" fill-rule="evenodd" s' +
          'troke-linejoin="miter" stroke="none" fill="#ffffff" stroke-width' +
          '="1.413" stroke-miterlimit="79.8403193612775"><tspan x="0" y="0"' +
          '>7:5</tspan></text>'#13#10'   </g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '6_7'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 33.647,6.925 L 9.854,6.925 C 8.628,6.925 7.631,7.922 7.631' +
          ',9.148 L 7.631,34.353 C 7.631,35.579 8.628,36.576 9.854,36.576 L' +
          ' 33.647,36.576 C 34.873,36.576 35.87,35.579 35.87,34.353 L 35.87' +
          ',9.148 C 35.87,7.922 34.873,6.925 33.647,6.925 Z" stroke="#0a4a8' +
          'e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" strok' +
          'e-linejoin="miter" marker-start="none" marker-end="none" stroke-' +
          'miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="preserve" ' +
          'transform="translate(9.309 15.391) scale(1 -1)" font-family="Ari' +
          'al" stroke="none" fill="#ffffff" stroke-width="1.413" fill-rule=' +
          '"evenodd" stroke-linejoin="miter" font-size="18" stroke-miterlim' +
          'it="79.8403193612775"><tspan x="0" y="0">6:7</tspan></text>'#13#10'   ' +
          '</g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '4_5'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 32.599,5.513 L 10.901,5.513 C 9.488,5.513 8.338,6.662 8.33' +
          '8,8.076 L 8.338,35.425 C 8.338,36.838 9.488,37.988 10.901,37.988' +
          ' L 32.599,37.988 C 34.012,37.988 35.162,36.838 35.162,35.425 L 3' +
          '5.162,8.076 C 35.162,6.662 34.012,5.513 32.599,5.513 Z" stroke="' +
          '#0a4a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd"' +
          ' stroke-linejoin="miter" marker-start="none" marker-end="none" s' +
          'troke-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="pres' +
          'erve" transform="translate(11.529 16.473) scale(1 -1)" font-fami' +
          'ly="Arial" stroke="none" fill="#ffffff" stroke-width="1.413" fil' +
          'l-rule="evenodd" stroke-linejoin="miter" font-size="15" stroke-m' +
          'iterlimit="79.8403193612775"><tspan x="0" y="0">4:5</tspan></tex' +
          't>'#13#10'   </g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '3_4'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 9.042,9.043 L 9.042,34.458 C 9.042,36.795 10.939,38.692 13' +
          '.275,38.692 L 30.223,38.692 C 32.56,38.692 34.457,36.795 34.457,' +
          '34.458 L 34.457,9.043 C 34.457,6.706 32.56,4.809 30.223,4.809 L ' +
          '13.275,4.809 C 10.939,4.809 9.042,6.706 9.042,9.043 Z" stroke="#' +
          '0a4a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" ' +
          'stroke-linejoin="miter" marker-start="none" marker-end="none" st' +
          'roke-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="prese' +
          'rve" transform="translate(11.371 16.455) scale(1 -1)" font-famil' +
          'y="Arial" stroke="none" fill="#ffffff" stroke-width="1.413" fill' +
          '-rule="evenodd" stroke-linejoin="miter" font-size="15" stroke-mi' +
          'terlimit="79.8403193612775"><tspan x="0" y="0">3:4</tspan></text' +
          '>'#13#10'   </g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '9_16'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 13.279,9.043 L 13.279,34.458 C 13.279,36.795 15.176,38.692' +
          ' 17.513,38.692 L 25.986,38.692 C 28.323,38.692 30.22,36.795 30.2' +
          '2,34.458 L 30.22,9.043 C 30.22,6.706 28.323,4.809 25.986,4.809 L' +
          ' 17.513,4.809 C 15.176,4.809 13.279,6.706 13.279,9.043 Z" stroke' +
          '="#0a4a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="evenod' +
          'd" stroke-linejoin="miter" marker-start="none" marker-end="none"' +
          ' stroke-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space="pr' +
          'eserve" transform="translate(21.325 24.522) scale(1 -1)" font-fa' +
          'mily="Arial" font-size="13.5" stroke="none" fill="#ffffff" strok' +
          'e-width="1.413" fill-rule="evenodd" stroke-linejoin="miter" stro' +
          'ke-miterlimit="79.8403193612775"><tspan x="-3.754" y="0">9</tspa' +
          'n><tspan x="-7.508" y="15.081">16</tspan></text>'#13#10'   </g>'#13#10'  </g' +
          '>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '5_7'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 9.75,9.043 L 9.75,34.458 C 9.75,36.795 11.647,38.692 13.98' +
          '4,38.692 L 29.517,38.692 C 31.853,38.692 33.75,36.795 33.75,34.4' +
          '58 L 33.75,9.043 C 33.75,6.706 31.853,4.809 29.517,4.809 L 13.98' +
          '4,4.809 C 11.647,4.809 9.75,6.706 9.75,9.043 Z" stroke="#0a4a8e"' +
          ' fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" stroke-' +
          'linejoin="miter" marker-start="none" marker-end="none" stroke-mi' +
          'terlimit="79.8403193612775"/>'#13#10'    <text xml:space="preserve" tr' +
          'ansform="translate(11.354 16.543) scale(1 -1)" font-family="Aria' +
          'l" stroke="none" fill="#ffffff" stroke-width="1.413" fill-rule="' +
          'evenodd" stroke-linejoin="miter" font-size="15" stroke-miterlimi' +
          't="79.8403193612775"><tspan x="0" y="0">5:7</tspan></text>'#13#10'   <' +
          '/g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = '7_6'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 6.924,9.854 L 6.924,33.647 C 6.924,34.873 7.921,35.87 9.14' +
          '7,35.87 L 34.352,35.87 C 35.578,35.87 36.575,34.873 36.575,33.64' +
          '7 L 36.575,9.854 C 36.575,8.628 35.578,7.631 34.352,7.631 L 9.14' +
          '7,7.631 C 7.921,7.631 6.924,8.628 6.924,9.854 Z" stroke="#0a4a8e' +
          '" fill="#1e90ff" stroke-width="2.118" fill-rule="evenodd" stroke' +
          '-linejoin="miter" marker-start="none" marker-end="none" stroke-m' +
          'iterlimit="79.8403193612775"/>'#13#10'    <text xml:space="preserve" t' +
          'ransform="translate(9.225 15.391) scale(1 -1)" font-family="Aria' +
          'l" stroke="none" fill="#ffffff" stroke-width="1.413" fill-rule="' +
          'evenodd" stroke-linejoin="miter" font-size="18" stroke-miterlimi' +
          't="79.8403193612775"><tspan x="0" y="0">7:6</tspan></text>'#13#10'   <' +
          '/g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end
      item
        IconName = 'free'
        SVGText = 
          '<?xml version="1.0"?>'#10'<svg width="32" height="32" xmlns="http://' +
          'www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">'#10' <!' +
          '-- Free Dimensions (No Aspect Ratio) -->'#10#10' <g class="layer">'#10'  <' +
          'title>Layer 1</title>'#10'  <g id="svg_1" transform="translate(16, 1' +
          '6)">'#10'   <rect fill="none" height="24" id="svg_2" rx="3" ry="3" s' +
          'troke="#0A4A8E" stroke-dasharray="3 3" stroke-width="1.5" width=' +
          '"24" x="-12" y="-12"/>'#10'  </g>'#10' </g>'#10'</svg>'
      end
      item
        IconName = '2_3'
        SVGText = 
          '<?xml version="1.0" standalone="no"?>'#13#10'<!DOCTYPE svg PUBLIC "-//' +
          'W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/sv' +
          'g11.dtd">'#13#10'<!--Generator: Xara Designer (www.xara.com), SVG filt' +
          'er version: 6.3.0.9-->'#13#10'<svg stroke-width="0.501" stroke-linejoi' +
          'n="bevel" fill-rule="evenodd" xmlns:xlink="http://www.w3.org/199' +
          '9/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" overfl' +
          'ow="visible" width="43.5pt" height="43.5pt" viewBox="0 0 43.5 43' +
          '.5">'#13#10' <defs>'#13#10#9'</defs>'#13#10' <g id="Document" fill="none" stroke="b' +
          'lack" font-family="Times New Roman" font-size="16" transform="sc' +
          'ale(1 -1)">'#13#10'  <g id="Spread" transform="translate(0 -43.5)">'#13#10' ' +
          '  <g id="Page background" style="font-variant-ligatures:none">'#13#10 +
          '    <path d="M 0,43.499 L 0,0 L 43.499,0 L 43.499,43.499 L 0,43.' +
          '499 Z" stroke="none" stroke-width="0" marker-start="none" marker' +
          '-end="none" stroke-miterlimit="79.8403193612775"/>'#13#10'   </g>'#13#10'   ' +
          '<g id="MouseOff" style="font-variant-ligatures:none">'#13#10'    <path' +
          ' d="M 29.869,4.809 L 13.631,4.809 C 11.879,4.809 10.454,6.233 10' +
          '.454,7.986 L 10.454,35.515 C 10.454,37.267 11.879,38.692 13.631,' +
          '38.692 L 29.869,38.692 C 31.621,38.692 33.046,37.267 33.046,35.5' +
          '15 L 33.046,7.986 C 33.046,6.233 31.621,4.809 29.869,4.809 Z" st' +
          'roke="#0a4a8e" fill="#1e90ff" stroke-width="2.118" fill-rule="ev' +
          'enodd" stroke-linejoin="miter" marker-start="none" marker-end="n' +
          'one" stroke-miterlimit="79.8403193612775"/>'#13#10'    <text xml:space' +
          '="preserve" transform="translate(11.438 16.455) scale(1 -1)" fon' +
          't-family="Arial" stroke="none" fill="#ffffff" stroke-width="1.41' +
          '3" fill-rule="evenodd" stroke-linejoin="miter" font-size="15" st' +
          'roke-miterlimit="79.8403193612775"><tspan x="0" y="0">2:3</tspan' +
          '></text>'#13#10'   </g>'#13#10'  </g>'#13#10' </g>'#13#10'</svg>'#13#10
      end>
    Scaled = True
    Left = 194
    Top = 293
  end
end
