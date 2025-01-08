unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UWP.DarkMode, Vcl.WinXPanels,
  Vcl.ExtCtrls, Vcl.WinXCtrls, UWP.SideButton, GR32_Image,
  ACL.UI.Controls.BaseEditors,
  ACL.UI.Controls.Memo, Vcl.TitleBarCtrls, Vcl.StdCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, TFlatHintUnit, ACL.UI.Controls.TextEdit,
  ACL.UI.Controls.DropDown, ACL.UI.Controls.ComboBox, Vcl.Buttons, RzButton,
  DosCommand, ACL.UI.Controls.Labels, RzTabs, ACL.UI.Controls.Slider,
  ACL.UI.Controls.SpinEdit, ACL.UI.Controls.Scene2D,
  ACL.UI.Controls.ImageComboBox, ACL.UI.Controls.CheckComboBox,
  ACL.UI.Controls.SearchBox, ACL.UI.Controls.Category, ACL.UI.Controls.Buttons,
  ACL.UI.Insight, ACL.UI.Controls.GroupBox, ACL.UI.Controls.Docking, Vcl.Menus,
  Vcl.Mask, RzEdit, UWP.CollapsePanel, VirtualTrees.BaseAncestorVCL,
  VirtualTrees.BaseTree, VirtualTrees.AncestorVCL, VirtualTrees,
  VirtualExplorerTree, Vcl.FileCtrl, System.Generics.Collections, pngimage, jpeg,
  ACL.Classes, ACL.UI.Application, ACL.UI.Controls.MagnifierGlass,
  ACL.Classes.Collections, ACL.UI.Controls.BindingDiagram.SubClass,
  ACL.UI.Controls.BindingDiagram.Types, ACL.UI.Controls.CompoundControl,
  ACL.UI.Controls.BindingDiagram, SynEditHighlighter,
  SynHighlighterUNIXShellScript, SynEdit, ACL.UI.Controls.ProgressBox,
  MPCommonObjects, MPCommonUtilities, EasyListview, VirtualExplorerEasyListview,
  ACL.UI.Controls.FormattedLabel, ACL.UI.Controls.Panel,
  ACL.UI.Controls.Splitter, frameText2Img, UWP.Downloader,
  System.Net.HttpClient, System.Net.URLClient, System.JSON, RzPanel,
  System.Math, GR32_Layers, GR32, StableDiffusion, Threading,
  settings, System.Zip, System.IOUtils,
  ACL.UI.Controls.Base, rkSmartPath, ACL.UI.Controls.ActivityIndicator,
  System.Win.TaskbarCore, Vcl.Taskbar, System.Notification, Vcl.Themes,
  ACL.UI.Resources, TFlatButtonUnit, ACL.UI.Menus, Winapi.ShellAPI,
  ACL.UI.Controls.ScrollBox, Winapi.CommDlg, JvComponentBase, JvFormAutoSize,
  JvShellHook, JvSpellChecker, JvAppInst, JvSpellerForm, JvBaseDlg,
  JvJVCLAboutForm, JvComputerInfoEx, SVGIconImageListBase, SVGIconImageList,
  frameParams, System.SyncObjs, MPShellUtilities, VirtualShellNotifier,
  UWP.ShellMonitors, UWP.DosCommandEx, SynHighlighterSDPrompt, System.Actions, Vcl.ActnList,
  SynSpellCheck, sdDataModule, SynCompletionProposal, TFlatSplitterUnit, RzSplit,
  JvExExtCtrls, JvNetscapeSplitter, JvExtComponent, JvSplit;
{$DEFINE KernelNotifier}
type
  TStringList = class(System.Classes.TStringList)
  public
    function FindIndexByPartialText(const PartialText: string): Integer;
    function FindNameValueByPartialText(const PartialText: string): string;
  end;

type
  TStableDiffusionDist = class
  private
    FAssets: TStringList;
    FReleaseDate: TDateTime;
    FTagName: string;
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CheckRelease;
    property Assets: TStringList read FAssets write FAssets;
    property ReleaseData: TDateTime read FReleaseDate write FReleaseDate;
    property TagName: string read FTagName write FTagName;
    property Description: string read FDescription write FDescription;
  end;

type
  TFilePicturePair = record
    FileName: string;
    PreviewFileName: string;
  end;
  TSDModelList = class(TStringList)
  private
    FDirectoryPath: string;
    function GetFilePicturePairs(const DirectoryPath: string): TStringList;
  public
    constructor Create(const DirectoryPath: string);
    property DirectoryPath: string read FDirectoryPath;
    function FindPair(const FileName: string): TFilePicturePair;
  end;

type
  TLayer = class(TPositionedLayer)
  private
    FBitmap: TBitmap32;
  public
    constructor Create(ABitmap: TBitmap32); reintroduce;
    destructor Destroy; override;
    procedure Paint(Buffer: TBitmap32); override;
    property Bitmap: TBitmap32 read FBitmap;
  end;

type
  TmainForm = class(TForm)
    SplitView1: TSplitView;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    crdFlux: TCard;
    ImgView321: TImgView32;
    TitleBarPanel1: TTitleBarPanel;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    FlatHint1: TFlatHint;
    cbSampleMethod: TACLComboBox;
    dcNvidiaStats: TDosCommand;
    lblSampleMethod: TACLLabel;
    lblSchedule: TACLLabel;
    cbSchedule: TACLComboBox;
    RzTabControl1: TRzTabControl;
    sldSteps: TACLSlider;
    aclsliderWidth: TACLSlider;
    aclsliderHeight: TACLSlider;
    aclCatImage: TACLCategory;
    imcbSDModels: TACLImageComboBox;
    ACLDockSite1: TACLDockSite;
    ACLDockPanel1: TACLDockPanel;
    CollapsePanel1: TCollapsePanel;
    icSDModels: TImageCollection;
    ilSDModels: TImageList;
    ACLApplicationController1: TACLApplicationController;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    dcStableDiffusion: TDosCommand;
    btnGenerate: TACLButton;
    xpListView: TVirtualMultiPathExplorerEasyListview;
    pnlPicInfo: TACLPanel;
    ACLFormattedLabel1: TACLFormattedLabel;
    pnlt2iInferer: TACLPanel;
    pnlt2iViewer: TACLPanel;
    pnlt2iExplorer: TACLPanel;
    Splitter1: TSplitter;
    crdSettings: TCard;
    ACLLabel3: TACLLabel;
    LabeledEdit1: TLabeledEdit;
    ACLGroupBox1: TACLGroupBox;
    ACLButton1: TACLButton;
    ACLRadioBox1: TACLRadioBox;
    ACLRadioBox2: TACLRadioBox;
    ACLRadioBox3: TACLRadioBox;
    ACLRadioBox4: TACLRadioBox;
    ACLRadioBox5: TACLRadioBox;
    ACLRadioBox6: TACLRadioBox;
    ACLRadioBox7: TACLRadioBox;
    UWPDownloader1: TUWPDownloader;
    Memo1: TMemo;
    RzStatusBar1: TRzStatusBar;
    pnlPrompt: TACLPanel;
    Splitter2: TSplitter;
    ACLButton3: TACLButton;
    FileOpenDialog1: TFileOpenDialog;
    LabeledEdit2: TLabeledEdit;
    ACLButton4: TACLButton;
    pnlParams: TACLPanel;
    ACLPanelContent: TACLPanel;
    splitImgExplorer: TACLSplitter;
    rkSmartPath1: TrkSmartPath;
    ACLActivityIndicator1: TACLActivityIndicator;
    Taskbar1: TTaskbar;
    NotificationCenter1: TNotificationCenter;
    PopupMenu1: TPopupMenu;
    Openindefaultviewer1: TMenuItem;
    Delete1: TMenuItem;
    SendtoRecycleBin1: TMenuItem;
    N1: TMenuItem;
    DeletePermanently1: TMenuItem;
    N2: TMenuItem;
    GFPGANit1: TMenuItem;
    DetectFace1: TMenuItem;
    FixFaceimg2img1: TMenuItem;
    ACLImageComboBox2: TACLImageComboBox;
    gbVAE: TACLGroupBox;
    ACLCheckBox1: TACLCheckBox;
    ACLCheckBox2: TACLCheckBox;
    sldCFG: TACLSlider;
    gbImageSize: TACLGroupBox;
    ACLSplitter3: TACLSplitter;
    cbClip: TACLImageComboBox;
    ACLResourceCollection1: TACLResourceCollection;
    gbTAESD: TACLGroupBox;
    ACLImageComboBox3: TACLImageComboBox;
    container: TPanel;
    tmrSplash: TTimer;
    activitySplash: TACLActivityIndicator;
    RzToolbarButton1: TRzToolbarButton;
    Card3: TCard;
    ACLComboBox4: TACLComboBox;
    GridPanel1: TGridPanel;
    ScrollBox1: TScrollBox;
    JvShellHook1: TJvShellHook;
    JvAppInstances1: TJvAppInstances;
    JvComputerInfoEx1: TJvComputerInfoEx;
    edSeed: TACLEdit;
    SVGIconImageList1: TSVGIconImageList;
    aclComboAspectRatio: TACLImageComboBox;
    txtOutput: TSynEdit;
    tmrOutput: TTimer;
    ACLSplitter4: TACLSplitter;
    ShellMonitorManager1: TShellMonitorManager;
    DirectoryMonitor1: TDirectoryMonitor;
    procSDServer: TDosCommandEx;
    sedPrompt: TSynEdit;
    sedNegPrompt: TSynEdit;
    pmnuEditor: TPopupMenu;
    pmnuSpelling: TMenuItem;
    pmnSeparator: TMenuItem;
    pmnDelete: TMenuItem;
    pmnAdd: TMenuItem;
    pmnIgnore: TMenuItem;
    pmnIgnoreOnce: TMenuItem;
    pmnSeparator2: TMenuItem;
    CheckFile1: TMenuItem;
    SpellClearErros11: TMenuItem;
    CheckSelection1: TMenuItem;
    CheckWord1: TMenuItem;
    N3: TMenuItem;
    ClearErrors1: TMenuItem;
    N4: TMenuItem;
    CheckAsYouType1: TMenuItem;
    N5: TMenuItem;
    lmiEditUndo: TMenuItem;
    MenuItem1: TMenuItem;
    lmiEditCut: TMenuItem;
    lmiEditCopy: TMenuItem;
    lmiEditPaste: TMenuItem;
    lmiEditDelete: TMenuItem;
    MenuItem2: TMenuItem;
    lmiEditSelectAll: TMenuItem;
    chkSDServer: TACLCheckBox;
    SynCompletionProposal1: TSynCompletionProposal;
    RzSplitter1: TRzSplitter;
    splitExplorer: TJvxSplitter;
    lblSeed: TACLLabel;
    lblClip: TACLLabel;
    lblModel: TACLLabel;
    lblCFG: TACLLabel;
    GridPanel2: TGridPanel;
    lblSteps: TACLLabel;
    gridImgSize: TGridPanel;
    ACLComboBox1: TACLComboBox;
    ACLLabel1: TACLLabel;
    procedure FormCreate(Sender: TObject);
    procedure dcNvidiaStatsTerminateProcess(ASender: TObject;
      var ACanTerminate: Boolean);
    procedure dcNvidiaStatsNewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure dcNvidiaStatsExecuteError(ASender: TObject; AE: Exception;
      var AHandled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure aclsliderHeightChange(Sender: TObject);
    procedure dcStableDiffusionTerminateProcess(ASender: TObject;
      var ACanTerminate: Boolean);
    procedure dcStableDiffusionExecuteError(ASender: TObject; AE: Exception;
      var AHandled: Boolean);
    procedure dcStableDiffusionNewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure btnGenerateClick(Sender: TObject);
    procedure dcStableDiffusionTerminated(Sender: TObject);
    procedure xpListViewItemClick(
      Sender: TCustomEasyListview; Item: TEasyItem; KeyStates: TCommonKeyStates;
      HitInfo: TEasyItemHitTestInfoSet);
    procedure RzTabControl1Change(Sender: TObject);
    procedure ACLButton1Click(Sender: TObject);
    procedure ImgView321MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure UWPDownloader1DblClick(Sender: TObject);
    procedure UWPDownloader1Click(Sender: TObject);
    procedure UWPDownloader1Downloaded(Sender: TObject; DownloadCode: Integer);
    procedure ACLButton3Click(Sender: TObject);
    procedure ACLButton4Click(Sender: TObject);
    procedure ACLImageComboBox1Buttons0Click(Sender: TObject);
    procedure aclsliderWidthChange(Sender: TObject);
    procedure tmrSplashTimer(Sender: TObject);
    procedure RzToolbarButton1Click(Sender: TObject);
    procedure ACLImageComboBox5Buttons0Click(Sender: TObject);
    procedure aclComboAspectRatioChange(Sender: TObject);
    procedure tmrOutputTimer(Sender: TObject);
    procedure sldStepsChange(Sender: TObject);
    procedure sldCFGChange(Sender: TObject);
    procedure xpListViewShellNotify(
      Sender: TCustomVirtualExplorerEasyListview;
      ShellEvent: TVirtualShellEvent);
    procedure DirectoryMonitor1Created(Sender: TObject);
    procedure DirectoryMonitor1Deleted(Sender: TObject);
    procedure xpListViewItemSelectionChanged(
      Sender: TCustomEasyListview; Item: TEasyItem);
    procedure ACLPopupMenu1Popup(Sender: TObject);
    procedure pmnuEditorPopup(Sender: TObject);
    procedure procSDServerExecuteError(ASender: TObject; AE: Exception;
      var AHandled: Boolean);
    procedure procSDServerTerminateProcess(ASender: TObject;
      var ACanTerminate: Boolean);
    procedure procSDServerTerminated(Sender: TObject);
    procedure procSDServerNewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure chkSDServerClick(Sender: TObject);
    procedure imcbSDModelsChange(Sender: TObject);
  private
    { Private declarations }
    FOutputBuffer: TStringList;
    FSyncLock: TCriticalSection;

    FTempFile: string;
    FDragging: Boolean;
    FLastX, FLastY: Integer;
    FZoomFactor: Single;
    FSDRelease: TStableDiffusionDist;
    FSDModelsPath: string;
    FPicturesPath: string;
    FOutputImagePath: string;
    GPUInfo: TStringList;
    realquit: Boolean;
    FSDModels: TSDModelList;
    //SDHighLighter: TSynStableDiffusionSyn;
    sdsynedit: TSynSDPromptSyn;
    FSDParams: TSDParams;
    FSetting: TSetting;
    FAspectRatioWidth, FAspectRatioHeight: Integer;
    procedure ListModels;
    procedure UpdatePictureList;
    function ExtractPNGTextChunk(const FileName: string): string;
    procedure WMHelp(var Message: TWMHelp); message WM_HELP;
  public
    { Public declarations }
    procedure UpdateZoom(Delta: Integer);
    procedure UpdatePan(DX, DY: Integer);

    procedure LoadSettings;
    procedure SaveSettings;
    procedure RegisterNotifier;

    procedure StartSDServer;
  end;

var
  mainForm: TmainForm;
  samplingMethod: array of string = ['euler','euler_a','heun','dpm2', 'dpm++2s_a', 'dpm++2m', 'dpm++2mv2', 'lcm'];
  modelMethod: array of string = ['txt2img', 'img2img', 'convert'];
  scheduleMethod: array of string = ['discrete', 'karras', 'ays'];
  rngMethod: array of string = ['std_default', 'cuda'];

implementation

uses
  CommCtrl, ShlObj, StrUtils, functions, DarkModeApi, DarkModeApi.Vcl, ACL.Utils.Common,
  SynEditMiscClasses, Winapi.ActiveX;

{$R *.dfm}

procedure TmainForm.ACLButton1Click(Sender: TObject);
begin
  FSDRelease.CheckRelease;

  if FSDRelease.Assets.Count > 0 then
  begin
    var Fecha := FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss am/pm', FSDRelease.FReleaseDate);
    Memo1.Lines.Add(Format('Released Data: %s', [Fecha]));
    for var I := 0 to FSDRelease.Assets.Count - 1 do
    begin
      Memo1.Lines.Add(FSDRelease.Assets.Names[I]);
    end;
  end;
end;

procedure TmainForm.btnGenerateClick(Sender: TObject);
var
  sdctx: PSdCtx;
  vaeDecodeOnlye: BOOL;
begin
//  vaeDecodeOnlye := True;
//  FSDParams.Create;
//  sdctx := NewSDCtx(@FSDParams.ModelPath,
//    @FSDParams.ClipLPath,
//    @FSDParams.T5xxlPath,
//    @FSDParams.DiffusionModelPath,
//    @FSDParams.VaePath,
//    @FSDParams.TaesdPath,
//    @FSDParams.ControlnetPath,
//    @FSDParams.LoraModelDir,
//    @FSDParams.EmbeddingsPath,
//    @FSDParams.StackedIdEmbeddingsPath,
//    vaeDecodeOnlye,
//    FSDParams.VaeTiling,
//    True,
//    FSDParams.NThreads,
//    FSDParams.WType,
//    FSDParams.RngType,
//    FSDParams.Schedule,
//    FSDParams.ClipOnCPU,
//    FSDParams.ControlNetCPU,
//    FSDParams.VaeOnCPU
//  );
//  if sdctx = nil then
//    raise Exception.Create('new_sd_ctx_t failed!');
//
//
//  Exit;
//improve the following stable diffusion prompt "a beautiful girl<lora:LCM_LoRA_Weights_SD15:1>" and return in json format
  FOutputImagePath := FPicturesPath + Format('image_%d.png', [GetTickCount]);
  if not dcStableDiffusion.IsRunning then
  begin
    dcStableDiffusion.InputToOutput := False;
//    DosCommand1.CurrentDir := '';
    dcStableDiffusion.CommandLine := AppPath + 'SD\sd.exe -m "' +
//    FSDModelsPath + ACLImageComboBox1.SelectedItem.Text + '" --cfg-scale 1 --steps 4 --sampling-method lcm --lora-model-dir "'
//    +'C:\Users\vhanl\projects\py\stable-diffusion-webui-forge\models\Lora'+
//    '" -H 512 -W 512 --seed -1 -b 1 -p "'+
//    SynEdit2.Text + '" --output "'+ExtractFilePath(ParamStr(0))+'output.png';
    FSDModelsPath + imcbSDModels.SelectedItem.Text + '"'+
    ' --cfg-scale ' + sldCFG.Position.ToString +
    ' --steps ' + sldSteps.Position.ToString +
    ' --sampling-method lcm --schedule karras --lora-model-dir "' +
    FSetting.Paths.SDLoras+
    '" -H '+aclsliderHeight.PositionAsInteger.ToString+' -W '+aclsliderWidth.PositionAsInteger.ToString+' --seed -1 -b 1'+
    ' --taesd "'+ExtractFilePath(ParamStr(0))+'diffusion_pytorch_model.safetensors'+'"'+
    ' -p "' + sedPrompt.Text + '"'+
    ' -n "' + sedNegPrompt.Text + '"'+
//    ' --difussion-fa'+
    ' --output "'+FOutputImagePath + ' -v';
    txtOutput.Lines.Clear;
    txtOutput.Lines.AddStrings(dcStableDiffusion.CommandLine);
    dcStableDiffusion.Execute;
//    ACLProgressBox1.Visible := True;
    btnGenerate.Enabled := False;
    btnGenerate.Caption := 'Please wait...';
    ACLActivityIndicator1.Active := True;
    ACLActivityIndicator1.Caption := 'Please wait...';
    Taskbar1.ProgressState := TTaskbarProgressState.Indeterminate;
  end;


end;

procedure TmainForm.chkSDServerClick(Sender: TObject);
begin
  StartSDServer;
end;

procedure TmainForm.ACLButton3Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    FSetting.Paths.SDModels := FileOpenDialog1.FileName;
    LabeledEdit1.Text := FSetting.Paths.SDModels;
    SaveSettings;
  end;
end;

procedure TmainForm.ACLButton4Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    FSetting.Paths.SDLoras := FileOpenDialog1.FileName;
    LabeledEdit2.Text := FSetting.Paths.SDLoras;
    SaveSettings;
  end;
end;

procedure TmainForm.ACLImageComboBox1Buttons0Click(Sender: TObject);
begin
  // refresh the list of models
  ListModels;
end;

procedure TmainForm.ACLImageComboBox5Buttons0Click(Sender: TObject);
var
  I: Integer;
begin
// switch vertical/horizontal aspect ratios
  var currenttag := ACLcomboAspectRatio.Items[ACLcomboAspectRatio.ItemIndex].Tag;
  if currenttag >= 0 then
  begin
    currenttag := currenttag xor 1;
    for I := 0 to ACLcomboAspectRatio.Items.Count - 1 do
    begin
      if ACLcomboAspectRatio.Items[I].Tag = currenttag then
      begin
        ACLcomboAspectRatio.ItemIndex := I;
        Break;
      end;
    end;
  end;
end;

procedure TmainForm.ACLPopupMenu1Popup(Sender: TObject);
var
  Error: ISpellingError;
  CorrectiveAction: CORRECTIVE_ACTION;
  Replacement: PChar;
  MenuItem: TMenuItem;
  Action: TSynSpellErrorReplace;
  Suggestions: IEnumString;
  Suggestion: PWideChar;
  Fetched: LongInt;
  Indicator: TSynIndicator;
  AWord: string;
  HaveError: Boolean;
begin
  // Remove replacement menu items and actions;
  repeat
    MenuItem := pmnuSpelling.Items[0];
    if MenuItem.Action is TSynSpellErrorReplace then
    begin
      pmnuSpelling.Remove(MenuItem);
      MenuItem.Action.Free;
      MenuItem.Free;
    end
    else
      Break;
  until (False);

  if not Assigned(CommandsDataModule.SynSpellCheck.SpellChecker()) then
  begin
    pmnuSpelling.Visible := False;
    Exit;
  end;

  if sedPrompt.Indicators.IndicatorAtPos(sedPrompt.CaretXY, Indicator) and
    (Indicator.Id = TSynSpellCheck.SpellErrorIndicatorId) then
     AWord := Copy(sedPrompt.Lines[sedPrompt.CaretY - 1], Indicator.CharStart,
       Indicator.CharEnd - Indicator.CharStart)
  else
    AWord := '';

  CommandsDataModule.SynSpellCheck.Editor := sedPrompt;
  Error := CommandsDataModule.SynSpellCheck.ErrorAtPos(sedPrompt.CaretXY);
  HaveError := Assigned(Error) and (AWord <> '');

  pmnSeparator.Visible := HaveError;
  pmnSeparator2.Visible := HaveError;
  pmnIgnore.Visible := HaveError;
  pmnAdd.Visible := HaveError;
  pmnIgnoreOnce.Visible := HaveError;
  pmnIgnore.Visible := HaveError;
  pmnDelete.Visible := HaveError;


  if HaveError then
  begin
    Error.Get_CorrectiveAction(CorrectiveAction);
    case CorrectiveAction of
      CORRECTIVE_ACTION_GET_SUGGESTIONS:
        begin
          CheckOSError(CommandsDataModule.SynSpellCheck.SpellChecker.Suggest(
            PChar(AWord), Suggestions));
          while Suggestions.Next(1, Suggestion, @Fetched) = S_OK do
          begin
            Action := TSynSpellErrorReplace.Create(Self);
            Action.Caption := Suggestion;
            MenuItem := TMenuItem.Create(Self);
            MenuItem.Action := Action;
            pmnuSpelling.Insert(pmnSeparator.MenuIndex, MenuItem);
            CoTaskMemFree(Suggestion);
          end;
        end;
      CORRECTIVE_ACTION_REPLACE:
        begin
          Error.Get_Replacement(Replacement);
          Action := TSynSpellErrorReplace.Create(Self);
          Action.Caption := Replacement;
          MenuItem := TMenuItem.Create(Self);
          MenuItem.Action := Action;
          pmnuSpelling.Insert(0, MenuItem);
        end;
    end;
  end;
end;

procedure TmainForm.aclComboAspectRatioChange(Sender: TObject);
var
  parts: TArray<string>;
begin
  var text := aclComboAspectRatio.Items[aclComboAspectRatio.ItemIndex].Text;
  if text.Contains('(') and text.Contains(')') then
  begin
    parts := text.split(['(',':',')']);    // returns in 1 and 2
    TryStrToInt(parts[1], FAspectRatioWidth);
    TryStrToInt(parts[2], FAspectRatioHeight);
    // update sliders max and min values for the aspect ratio
    if FAspectRatioWidth > FAspectRatioHeight then
    begin
      aclsliderWidth.OptionsValue.Max := 2048;
      aclsliderWidth.OptionsLabels.MaxValue := '2048';
      aclsliderHeight.OptionsValue.Max := Round(2048 * (FAspectRatioHeight / FAspectRatioWidth) / 8 ) * 8;
      aclsliderHeight.OptionsLabels.MaxValue := aclsliderHeight.OptionsValue.Max.ToString;
//      aclsliderWidth.OptionsValue.Min := Round(64 * (FAspectRatioHeight / FAspectRatioWidth) / 8 ) * 8;
//      aclsliderWidth.OptionsLabels.MinValue := aclsliderWidth.OptionsValue.Min.ToString;
    end
    else
    begin
      aclsliderHeight.OptionsValue.Max := 2048;
      aclsliderHeight.OptionsLabels.MaxValue := '2048';
      aclsliderWidth.OptionsValue.Max := Round(2048 * (FAspectRatioWidth / FAspectRatioHeight) / 64 ) * 64;
      aclsliderWidth.OptionsLabels.MaxValue := aclsliderWidth.OptionsValue.Max.ToString;
//      aclsliderHeight.OptionsValue.Min := Round(64 * (FAspectRatioWidth / FAspectRatioHeight) / 8 ) * 8;
//      aclsliderHeight.OptionsLabels.MinValue := aclsliderHeight.OptionsValue.Min.ToString;
    end;
  end
  else
  begin
    FAspectRatioWidth := 0;
    FAspectRatioHeight := 0;
    aclsliderHeight.OptionsValue.Max := 2048;
    aclsliderHeight.OptionsLabels.MaxValue := '2048';
    aclsliderHeight.OptionsValue.Max := 2048;
    aclsliderHeight.OptionsLabels.MaxValue := '2048';
  end;
end;

procedure TmainForm.aclsliderWidthChange(Sender: TObject);
var
  newHeight: Double;
  lwidth: Single;
begin
  lwidth := aclsliderWidth.Position;
  aclsliderWidth.OptionsLabels.CurrentValue := 'Width: ' + aclsliderWidth.Position.ToString;
  // sync with the height according to aspect ratio selected
  if (FAspectRatioWidth > 0) and (FAspectRatioHeight > 0) and (Sender = aclsliderWidth)  then
  begin
    newHeight := Round(lwidth * (FAspectRatioHeight / FAspectRatioWidth) /64) * 64;
    aclsliderHeight.Position := newHeight;
  end;
end;

procedure TmainForm.aclsliderHeightChange(Sender: TObject);
var
  newWidth: Double;
  lheight: Single;
begin
  lheight := aclsliderHeight.Position;
  aclsliderHeight.OptionsLabels.CurrentValue := 'Height: ' + aclsliderHeight.Position.ToString;
  // sync with the height according to aspect ratio selected
  if (FAspectRatioWidth > 0) and (FAspectRatioHeight > 0) and (Sender = aclsliderHeight) then
  begin
    newWidth := Round(lheight * (FAspectRatioWidth / FAspectRatioHeight) /64) * 64;
    aclsliderWidth.Position := newWidth;
  end;
end;

procedure TmainForm.dcNvidiaStatsExecuteError(ASender: TObject; AE: Exception;
  var AHandled: Boolean);
begin
  if AHandled then
    ShowMessage(AE.ToString);
end;

procedure TmainForm.dcNvidiaStatsNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  AOutputType := otEntireLine;

  GPUInfo.Clear;
  GPUInfo.Delimiter := ',';
  GPUInfo.StrictDelimiter := True;
  if ANewLine.Contains('NVIDIA') then
  begin
    //CSV format: name, memtotal, memused, memfree, gpu%, vram%
    GPUInfo.DelimitedText := ANewLine;
    if GPUInfo.Count = 7 then
    begin
      var MemTotal := StrToInt(GPUInfo[1]);
//      ProgressBar1.Max := MemTotal;
      var MemUsed := StrToInt(GPUInfo[2]);
//      ProgressBar1.Position := MemUsed;
      Caption := 'GPU: ' + GPUInfo[0] + ' - ' + GPUInfo[2] + '/' + GPUInfo[1] + ' ' + GPUInfo[6] + 'ºC            ';
//      GR32WGBar1.Yuzde := StrToInt(GPUInfo[4]);
//      GR32WGBar2.Yuzde := StrToInt(GPUInfo[5]);

    end;
  end;
end;

procedure TmainForm.dcNvidiaStatsTerminateProcess(ASender: TObject;
  var ACanTerminate: Boolean);
begin
  ACanTerminate := True;
end;

procedure TmainForm.dcStableDiffusionExecuteError(ASender: TObject;
  AE: Exception; var AHandled: Boolean);
begin
  if AHandled then
    ShowMessage(AE.ToString);
end;

procedure TmainForm.dcStableDiffusionNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);

function IsValidPathChar(Ch: Char): Boolean; inline;
begin
  Result := (Ch >= 'A') and (Ch <= 'Z') or
            (Ch >= 'a') and (Ch <= 'z') or
            (Ch >= '0') and (Ch <= '9') or
            (Ch = ':') or (Ch = '\') or (Ch = '.') or
            (Ch = '_') or (Ch = '-') or (Ch = ' ');
end;

function EncloseWindowsPaths(const Input: string; const QuoteChar: Char = '"'): string;
var
  i: Integer;
  Len: Integer;
  ResultStr: TStringBuilder;
  InQuote: Boolean;
  CurrentQuote: Char;
begin
  ResultStr := TStringBuilder.Create(Length(Input) * 2);
  try
    Len := Length(Input);
    i := 1;
    InQuote := False;
    CurrentQuote := #0;

    while i <= Len do
    begin
      // Handle quote characters
      if (Input[i] = '''') or (Input[i] = '"') then
      begin
        if not InQuote then
        begin
          InQuote := True;
          CurrentQuote := Input[i];
          // If we want to convert single quotes to double quotes
          if (QuoteChar = '"') and (Input[i] = '''') then
            ResultStr.Append(QuoteChar)
          else
            ResultStr.Append(Input[i]);
        end
        else if Input[i] = CurrentQuote then
        begin
          InQuote := False;
          // If we want to convert single quotes to double quotes
          if (QuoteChar = '"') and (Input[i] = '''') then
            ResultStr.Append(QuoteChar)
          else
            ResultStr.Append(Input[i]);
        end
        else
          ResultStr.Append(Input[i]);
      end
      // Check for unquoted drive letter pattern
      else if not InQuote and
              (i < Len - 1) and
              (Input[i] in ['A'..'Z', 'a'..'z']) and
              (Input[i + 1] = ':') and
              (Input[i + 2] = '\')
              then
      begin
        // Look ahead to find end of path
        var PathStart := i;
        i := i + 3;  // Skip drive letter and colon and backslash
        while (i <= Len) and IsValidPathChar(Input[i]) do
          Inc(i);

        if i - PathStart > 3 then
        begin
          ResultStr.Append(QuoteChar)
                  .Append(Input.Substring(PathStart, i - PathStart))
                  .Append(QuoteChar);
          Dec(i); // Adjust for the loop increment
        end
        else
          ResultStr.Append(Input.Substring(PathStart, i - PathStart));
      end
      else
      begin
        ResultStr.Append(Input[i]);
      end;

      Inc(i);
    end;

    Result := ResultStr.ToString;
  finally
    ResultStr.Free;
  end;
end;
begin
//  AOutputType := otEntireLine;
//
//  txtOutput.Lines.BeginUpdate;
//  try
//    txtOutput.Lines.Add(ANewLine);
//
//  finally
//    txtOutput.Lines.EndUpdate;
//  end;
//  txtOutput.GotoLineAndCenter(txtOutput.Lines.Count-1);
//
  FSyncLock.Enter;
  try
    FOutputBuffer.Add(ANewLine);
    if ANewLine.Contains('s/it') or ANewLine.Contains('it/s') then
    ACLActivityIndicator1.Caption := ANewLine;
  finally
    FSyncLock.Leave;
  end;
end;

procedure TmainForm.dcStableDiffusionTerminated(Sender: TObject);
var
  appNotification: TNotification;
begin
  if FileExists(FOutputImagePath) then
    ImgView321.Bitmap.LoadFromFile(FOutputImagePath);
  UpdatePictureList;
  btnGenerate.Enabled := True;
  btnGenerate.Caption := 'Generate';
  ACLActivityIndicator1.Active := False;
  ACLActivityIndicator1.Caption := 'Finished!';
  Taskbar1.ProgressState := TTaskbarProgressState.None;
  appNotification := NotificationCenter1.CreateNotification;
  try
    appNotification.Name := 'Stable Diffusion CPP';
    appNotification.Title := 'Finished Image Generation!';
    appNotification.AlertBody := 'Text 2 Image generation process finished!';
    NotificationCenter1.PresentNotification(appNotification);
  finally
    appNotification.Free;
  end;
end;

procedure TmainForm.dcStableDiffusionTerminateProcess(ASender: TObject;
  var ACanTerminate: Boolean);
begin
  ACanTerminate := True;

end;

procedure TmainForm.DirectoryMonitor1Created(Sender: TObject);
begin
  UpdatePictureList;
end;

procedure TmainForm.DirectoryMonitor1Deleted(Sender: TObject);
begin
//  UpdatePictureList;
  xpListView.RereadAndRefresh(True);
end;

function TmainForm.ExtractPNGTextChunk(const FileName: string): string;
const
  PNG_SIGNATURE: array[0..7] of Byte = (137, 80, 78, 71, 13, 10, 26, 10);
  CHUNK_TEXT: array[0..3] of AnsiChar = 'tEXt';
var
  FileStream: TFileStream;
  Signature: array[0..7] of Byte;
  ChunkLength: Cardinal;
  ChunkType: array[0..3] of AnsiChar;
  TextData: TBytes;
  I: Integer;
begin
  Result := '';
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    // Check PNG signature
    FileStream.ReadBuffer(Signature, SizeOf(Signature));
    if not CompareMem(@Signature, @PNG_SIGNATURE, SizeOf(PNG_SIGNATURE)) then
      Exit;

    while FileStream.Position < FileStream.Size do
    begin
      // Read chunk length
      FileStream.ReadBuffer(ChunkLength, SizeOf(ChunkLength));
      // Convert from big-endian to local byte order
      ChunkLength := (ChunkLength shr 24) or
                     ((ChunkLength shr 8) and $00FF00) or
                     ((ChunkLength shl 8) and $FF0000) or
                     (ChunkLength shl 24);

      // Read chunk type
      FileStream.ReadBuffer(ChunkType, SizeOf(ChunkType));

      if CompareMem(@ChunkType, @CHUNK_TEXT, SizeOf(CHUNK_TEXT)) then
      begin
        // Found tEXt chunk, read its content
        SetLength(TextData, ChunkLength);
        FileStream.ReadBuffer(TextData[0], ChunkLength);

        // Convert to string
        Result := '';
        for I := 0 to High(TextData) do
        begin
          if TextData[I] = 0 then // Null separator between keyword and text
            Result := Result + #13#10
          else
            Result := Result + AnsiChar(TextData[I]);
        end;
        Exit;
      end
      else
      begin
        // Skip to the next chunk
        FileStream.Seek(ChunkLength + 4, soFromCurrent); // +4 for CRC
      end;
    end;

  finally
    FileStream.Free;
  end;
end;

procedure TmainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Dlg: TForm;
  X, Y: Integer;
begin
  container.Visible := True;
  Dlg := CreateMessageDialog('You sure?', TMsgDlgType.mtConfirmation, mbYesNo);
  try
    if Assigned(Screen.ActiveForm) then
    begin
      X := Screen.ActiveForm.Left + (Screen.ActiveForm.Width - Dlg.Width) div 2;
      Y := Screen.ActiveForm.Top + (Screen.ActiveForm.Height - Dlg.Height) div 2;
      Dlg.Left := X;
      Dlg.Top := Y;
      if Dlg.ShowModal = mrYes then
        realquit := True;
    end;

  finally
    Dlg.Free;
  end;
  container.Visible := False;
//  if MessageDlg('You sure?', TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrYes then
//  if Dlg = mrYes then
//  begin
//    realquit := True;
////    Close;
//  end;

  if not realquit then
  begin
    CanClose := False;
  end;
  if dcNvidiaStats.IsRunning then
    dcNvidiaStats.Stop;
  if dcStableDiffusion.IsRunning then
    dcStableDiffusion.Stop;
  if procSDServer.IsRunning then
    procSDServer.Stop;
end;

procedure TmainForm.FormCreate(Sender: TObject);
begin
  container.Align := alClient;
  activitySplash.Active := True;
  CollapsePanel1.Collapsed := True;
  if SystemIsDarkMode then
  begin
    SetDarkMode(Handle, True);
    ACLApplicationController1.DarkMode := TACLBoolean(False);
  end
  else
    ACLApplicationController1.DarkMode := TACLBoolean(True);

  LoadSettings;
  sldSteps.Position := 4;
  sldCFG.Position := 1;

  realquit := False;
  GPUInfo := TStringList.Create;

  if not dcNvidiaStats.IsRunning then
  begin
    dcNvidiaStats.InputToOutput := False;
//    DosCommand1.CurrentDir := '';
    dcNvidiaStats.CommandLine := 'nvidia-smi.exe -lms 1000 --query-gpu=name,memory.total,memory.used,memory.free,utilization.gpu,utilization.memory,temperature.gpu --format=csv,noheader,nounits';
    dcNvidiaStats.Execute;
  end;
  FPicturesPath := ExtractFilePath(ParamStr(0)) + 'output';
  rkSmartPath1.Path := FPicturesPath;
  if not DirectoryExists(FPicturesPath) then
    CreateDir(FPicturesPath);
  FPicturesPath := IncludeTrailingPathDelimiter(FPicturesPath);
  FSDModelsPath := IncludeTrailingPathDelimiter(FSetting.Paths.SDModels);
  FSDModels := TSDModelList.Create(FSDModelsPath);
  ListModels;

//  ACLBindingDiagram1.Data.AddObject('Edit1');
//  ACLBindingDiagram1.Data.AddObject('Button1');
//  ACLBindingDiagram1.Data.AddLink('ACLGroupBox1', Button1);

  // Syntax Highlighter for Stable Diffusion prompts
//  SDHighLighter := TSynStableDiffusionSyn.Create(Self);
//  SynEdit2.Highlighter := SDHighLighter;
//  SynEdit3.Highlighter := SDHighLighter;

  sdsynedit := TSynSDPromptSyn.Create(Self);
  sedPrompt.Highlighter := sdsynedit;
  sedNegPrompt.Highlighter := sdsynedit;
  sedPrompt.WordWrap := True;

  sdsynedit.LoraAttri.Foreground := $8BE9FD; // Light blue
  sdsynedit.SymbolAttri.Foreground := clYellow;
  sdsynedit.TextAttri.Foreground := $F8F8F2; // Off-white for text content
  sdsynedit.EmphasisAttri.Foreground := clYellow;
  sdsynedit.UnderEmphasisAttri.Foreground := clGreen;
  sdsynedit.LevelAttri.Foreground := clGreen;
//  sdsynedit.SpaceAttri.Foreground := clNone;
  sdsynedit.CommentAttri.Foreground := clGray;
  sdsynedit.CommaAttri.Foreground := $423BFB; // Orange like
  sdsynedit.SentenceAttri.Background := $1c1c1c;
//  sdsynedit.NumberAttri.Foreground := clBlue;
//  sdsynedit.KeyAttri.Foreground := clPurple;
//  SDHighLighter.WordAttri.Foreground := clRed;
//  SDHighLighter.BracketAttri.Foreground := clRed;
//  SDHighLighter.WeightAttri.Foreground := clYellow;
//  SDHighLighter.LoraAttri.Foreground := clLime;
//  SDHighLighter.SpecialAttri.Foreground := clFuchsia;

  UpdatePictureList;

  FSDRelease := TStableDiffusionDist.Create;

  sedPrompt.Text := 'A beautiful model with red hair and blue eyes, wearing earrings, close-up of her face in a half-length portrait against a light background in the style of ultra-realistic photo with feather details and an orange color scheme depicted with high definition and natural lighting. The portrait shows complex detail and super detailed, fine, realistic skin texture, perfect teeth. <lora:LCM_LoRA_Weights_SD15:1>';
//  TextEditor1.Highlighter.LoadFromFile('StableDiffusion.json');
//  TextEditor1.Highlighter.Colors.LoadFromFile('Windows 11 Dark.json');
  sedNegPrompt.Text := 'photoshop, airbrush, disfigured, kitsch, oversaturated, low-res, Deformed, bad anatomy, disfigured, poorly drawn face, mutation, mutated, extra limb,poorly drawn hands, missing limb, floating limbs, disconnected limbs, malformed hands, long neck, long body, disgusting, poorly drawn, mutilated, mangled, conjoined twins, extra legs, extra arms, meme, deformed, elongated, strabismus, heterochromia, watermark, extra fingers, hand bags, handbag, handbags, mustache, beard';
  sedNegPrompt.WordWrap := True;
//  TextEditor2.Highlighter.LoadFromFile('StableDiffusion.json');
//  TextEditor2.Highlighter.Colors.LoadFromFile('Windows 11 Dark.json');
//  TextEditorSpellCheck1.Filename := ExtractFilePath(ParamStr(0)) + 'en-US\en_US';
//  txtOutput.Highlighter.LoadFromFile('StableDiffusionOut.json');
//  CustomTitleBar.SystemColors := True;
  FDragging := False;
  FZoomFactor := 1.0;
  ImgView321.Scale := 1.0;
  ImgView321.Cursor := crHandPoint;
  ImgView321.DoubleBuffered := True;

//  TTask.Run(
//    procedure
//    begin
//      TThread.Synchronize(nil,
//        procedure
//        begin
//          Memo1.Text := SDGetSystemInfo;
//        end
//      );
//    end
//  );

//  TStyleManager.Engine.RegisterStyleHook(TTextEditor, TScrollingStyleHook);
  TStyleManager.Engine.RegisterStyleHook(TACLFormattedLabel, TScrollingStyleHook);

  // Output processing
  FOutputBuffer := TStringList.Create;
  FSyncLock := TCriticalSection.Create;

  // Sizing window

  // Size of thumbnails
  xpListView.CellSizes.Thumbnail.Height := 256; //143 default
  xpListView.CellSizes.Thumbnail.Width := 225; //125 default

  // Registering for shell events
  DirectoryMonitor1.WatchPath := FPicturesPath;
  ShellMonitorManager1.Active := True;
end;

procedure TmainForm.FormDestroy(Sender: TObject);
begin
  FSyncLock.Free;
  FOutputBuffer.Free;

  FSDRelease.Free;

  sdsynedit.Free;
//  SDHighLighter.Free;
  FSDModels.Free;
  GPUInfo.Free;

  FSetting.Free;
end;

procedure TmainForm.imcbSDModelsChange(Sender: TObject);
begin
  if LowerCase(imcbSDModels.SelectedItem.Text).Contains('lcm') then
  begin
    sldCFG.OptionsValue.Max := 2;
    sldCFG.OptionsValue.Default := 1;
    sldCFG.OptionsLabels.MaxValue := '2.0';
    sldCFG.Position := 1;
    sldSteps.OptionsValue.Max := 6;
    sldSteps.OptionsLabels.MaxValue := '6.0';
    sldSteps.OptionsValue.Default := 4;
    sldSteps.Position := 4;
  end
  else
  begin
    sldCFG.OptionsValue.Max := 15;
    sldCFG.OptionsValue.Default := 7;
    sldCFG.OptionsLabels.MaxValue := '15.0';
    sldCFG.Position := 7;
    sldSteps.OptionsValue.Max := 150;
    sldSteps.OptionsLabels.MaxValue := '150.0';
    sldSteps.OptionsValue.Default := 20;
    sldSteps.Position := 20;
  end;
end;

procedure TmainForm.ImgView321MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  if Button = mbLeft then
  begin
    FDragging := True;
    FLastX := X;
    FLastY := Y;
    ImgView321.Cursor := crSizeAll;
  end;
end;

procedure TmainForm.ImgView321MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
  if FDragging then
  begin
    UpdatePan(X - FLastX, Y - FLastY);
    FLastX := X;
    FLastY := Y;
  end;
end;

procedure TmainForm.ImgView321MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  if Button = mbLeft then
  begin
    FDragging := False;
    ImgView321.Cursor := crHandPoint;
  end;
end;

procedure TmainForm.ImgView321MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if ssCtrl in Shift then
  begin
    UpdateZoom(WheelDelta);
    Handled := True;
  end;
end;

procedure TmainForm.ListModels;
const
  CUBO = 48;
var
  I: Integer;
  LImg: TPngImage;
  ScaleRatio: Double;
  NewWidth, NewHeight: Integer;
begin
  imcbSDModels.Items.BeginUpdate;
  ilSDModels.BeginUpdate;
  try
    imcbSDModels.Items.Clear;
    ilSDModels.Clear;
    ilSDModels.Masked := False;
    ilSDModels.ColorDepth := cd32Bit;
    var LIndex := 0;
    for I := 0 to FSDModels.Count - 1 do
    begin
      var lpng := FSDModels.ValueFromIndex[I];
      var bmp := TBitmap.Create;
      var NoPic := False;
      LImg := TPngImage.Create;
      try
        try
          var lpicpath := FSDModelsPath + lpng;
          if FileExists(lpicpath) then
          begin
            LImg.LoadFromFile(lpicpath);
            ScaleRatio := Min(CUBO/LImg.Width, CUBO/LImg.Height);
            NewWidth := Round(LImg.Width * ScaleRatio);
            NewHeight := Round(LImg.Height * ScaleRatio);
            LImg.AssignTo(bmp);
            // ====================================================
            // Important or else it gets alpha blended into the list! After Assign
            // AlphaFormat is afDefined which is OK if you want to draw 32 bit bmp
            // with alpha blending on a canvas but not OK if you put it into
            // ImageList -- it will be way too dark!
            // ====================================================
            bmp.AlphaFormat := afIgnored;
//            bmp.SetSize(LImg.Width, LImg.Height);
            bmp.SetSize(CUBO, CUBO);
            bmp.Canvas.StretchDraw(Rect((CUBO - NewWidth) div 2, (CUBO - NewHeight) div 2, (CUBO + NewWidth) div 2, (CUBO + NewHeight) div 2), LImg);
            Imagelist_Add(ilSDModels.Handle, bmp.Handle, 0);
          end
          else
            NoPic := True;
        except
          NoPic := True;
        end;

      finally
        bmp.Free;
        LImg.Free;
      end;
      if NoPic then
        imcbSDModels.Items.Add(FSDModels.Names[I], -1)
      else
      begin
        imcbSDModels.Items.Add(FSDModels.Names[I], LIndex);
        Inc(LIndex);
      end;

    end;
  finally
    imcbSDModels.Images := ilSDModels;
    ilSDModels.EndUpdate;
    if imcbSDModels.Items.Count > 0 then
      imcbSDModels.ItemIndex := 0;
    imcbSDModels.Items.EndUpdate;
  end;
end;

procedure TmainForm.LoadSettings;
begin
  if Assigned(FSetting) then
    FSetting.Free;
  FSetting := TSettings.LoadSettings();

  if not FileExists(AppPath+'settings.json') then
  begin
    FSetting.Paths.SDModels := AppPath + 'models\stable-diffusion';
    FSetting.Paths.SDLoras := AppPath + 'models\lora';
    FSetting.Paths.StableDiffusion := AppPath + 'SD';
    FSetting.Paths.BGRemover := AppPath + 'bgremover';
    SaveSettings;
  end
  else
  begin
    LabeledEdit1.Text := FSetting.Paths.SDModels;
    LabeledEdit2.Text := FSetting.Paths.SDLoras;
  end;
end;

procedure TmainForm.pmnuEditorPopup(Sender: TObject);
var
  Error: ISpellingError;
  CorrectiveAction: CORRECTIVE_ACTION;
  Replacement: PChar;
  MenuItem: TMenuItem;
  Action: TSynSpellErrorReplace;
  Suggestions: IEnumString;
  Suggestion: PWideChar;
  Fetched: LongInt;
  Indicator: TSynIndicator;
  AWord: string;
  HaveError: Boolean;
begin
  // Remove replacement menu items and actions;
  repeat
    MenuItem := pmnuSpelling.Items[0];
    if MenuItem.Action is TSynSpellErrorReplace then
    begin
      pmnuSpelling.Remove(MenuItem);
      MenuItem.Action.Free;
      MenuItem.Free;
    end
    else
      Break;
  until (False);

  if not Assigned(CommandsDataModule.SynSpellCheck.SpellChecker()) then
  begin
    pmnuSpelling.Visible := False;
    Exit;
  end;

  if sedPrompt.Indicators.IndicatorAtPos(sedPrompt.CaretXY, Indicator) and
    (Indicator.Id = TSynSpellCheck.SpellErrorIndicatorId) then
     AWord := Copy(sedPrompt.Lines[sedPrompt.CaretY - 1], Indicator.CharStart,
       Indicator.CharEnd - Indicator.CharStart)
  else
    AWord := '';

  CommandsDataModule.SynSpellCheck.Editor := sedPrompt;
  Error := CommandsDataModule.SynSpellCheck.ErrorAtPos(sedPrompt.CaretXY);
  HaveError := Assigned(Error) and (AWord <> '');

  pmnSeparator.Visible := HaveError;
  pmnSeparator2.Visible := HaveError;
  pmnIgnore.Visible := HaveError;
  pmnAdd.Visible := HaveError;
  pmnIgnoreOnce.Visible := HaveError;
  pmnIgnore.Visible := HaveError;
  pmnDelete.Visible := HaveError;


  if HaveError then
  begin
    Error.Get_CorrectiveAction(CorrectiveAction);
    case CorrectiveAction of
      CORRECTIVE_ACTION_GET_SUGGESTIONS:
        begin
          CheckOSError(CommandsDataModule.SynSpellCheck.SpellChecker.Suggest(
            PChar(AWord), Suggestions));
          while Suggestions.Next(1, Suggestion, @Fetched) = S_OK do
          begin
            Action := TSynSpellErrorReplace.Create(Self);
            Action.Caption := Suggestion;
            MenuItem := TMenuItem.Create(Self);
            MenuItem.Action := Action;
            pmnuSpelling.Insert(pmnSeparator.MenuIndex, MenuItem);
            CoTaskMemFree(Suggestion);
          end;
        end;
      CORRECTIVE_ACTION_REPLACE:
        begin
          Error.Get_Replacement(Replacement);
          Action := TSynSpellErrorReplace.Create(Self);
          Action.Caption := Replacement;
          MenuItem := TMenuItem.Create(Self);
          MenuItem.Action := Action;
          pmnuSpelling.Insert(0, MenuItem);
        end;
    end;
  end;
end;

procedure TmainForm.procSDServerExecuteError(ASender: TObject; AE: Exception;
  var AHandled: Boolean);
begin
  if AHandled then
    ShowMessage(AE.ToString);
end;

procedure TmainForm.procSDServerNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  FSyncLock.Enter;
  try
    FOutputBuffer.Add(ANewLine);
    if ANewLine.Contains('s/it') or ANewLine.Contains('it/s') then
    ACLActivityIndicator1.Caption := ANewLine;
  finally
    FSyncLock.Leave;
  end;
end;

procedure TmainForm.procSDServerTerminated(Sender: TObject);
var
  appNotification: TNotification;
begin
  chkSDServer.Checked := False;
end;

procedure TmainForm.procSDServerTerminateProcess(ASender: TObject;
  var ACanTerminate: Boolean);
begin
  ACanTerminate := True;
end;

procedure TmainForm.RegisterNotifier;
begin
  {$IFDEF KernelNotifier}
  ChangeNotifier.RegisterKernelChangeNotify(xpListView, AllKernelNotifiers);
  {$ENDIF KernelNotifier}
end;

procedure TmainForm.RzTabControl1Change(Sender: TObject);
begin
  CardPanel1.ActiveCardIndex := RzTabControl1.TabIndex;
end;

procedure TmainForm.RzToolbarButton1Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', 'https://github.com/vhanla/sdwincpp', nil, nil, SW_SHOWNORMAL);
end;

procedure TmainForm.SaveSettings;
begin
  if not Assigned(FSetting) then
    FSetting := TSettings.LoadSettings();
  TSettings.SaveSettings(FSetting);
end;

procedure TmainForm.sldCFGChange(Sender: TObject);
begin
  sldCFG.OptionsLabels.CurrentValue := 'CFG: ' + sldCFG.Position.ToString;
end;

procedure TmainForm.sldStepsChange(Sender: TObject);
begin
  sldSteps.OptionsLabels.CurrentValue := 'Sampling Steps: ' + sldSteps.Position.ToString;
end;

procedure TmainForm.StartSDServer;
var
  sdctx: PSdCtx;
  vaeDecodeOnlye: BOOL;
begin
  if not FileExists(AppPath + 'SD\sd-server.exe') then
  begin
    raise Exception.Create('sd-server.exe not found!');
  end;

  FOutputImagePath := FPicturesPath + Format('image_%d.png', [GetTickCount]);
  if not dcStableDiffusion.IsRunning then
  begin
    procSDServer.InputToOutput := False;
    procSDServer.CommandLine := AppPath + 'SD\sd-server.exe -m "' +
    FSDModelsPath + imcbSDModels.SelectedItem.Text + '"'+
    ' --cfg-scale ' + sldCFG.Position.ToString +
    ' --steps ' + sldSteps.Position.ToString +
    ' --sampling-method lcm --schedule karras --lora-model-dir "' +
    FSetting.Paths.SDLoras+
    '" -H '+aclsliderHeight.PositionAsInteger.ToString+' -W '+aclsliderWidth.PositionAsInteger.ToString+' --seed -1 -b 1'+
    ' --taesd "'+ExtractFilePath(ParamStr(0))+'diffusion_pytorch_model.safetensors'+'"'+
    ' -p "'+ sedPrompt.Text + '"'+
    ' -n "'+ sedNegPrompt.Text + '"'+
//    ' --difussion-fa'+
    ' --control-net-cpu'+
    ' --output "'+FOutputImagePath + ' -v';
    txtOutput.Lines.Clear;
    txtOutput.Lines.AddStrings(dcStableDiffusion.CommandLine);
    procSDServer.PIDStoragePath := AppPath;
    procSDServer.Execute;

    chkSDServer.Checked := True;
    ACLActivityIndicator1.Active := True;
    ACLActivityIndicator1.Caption := 'Please wait...';
//    Taskbar1.ProgressState := TTaskbarProgressState.Indeterminate;
  end;
end;

procedure TmainForm.tmrOutputTimer(Sender: TObject);
var
  tmpbuf: TStringList;
begin
  if not Assigned(txtOutput) then Exit;
  
  if FOutputBuffer.Count = 0 then
    Exit;

  tmpbuf := TStringList.Create;
  try
    FSyncLock.Enter;
    try
      tmpbuf.Assign(FOutputBuffer);
      FOutputBuffer.Clear;
    finally
      FSyncLock.Leave;
    end;

    txtOutput.Lines.BeginUpdate;
    try
      txtOutput.Lines.AddStrings(tmpbuf);
      txtOutput.GotoLineAndCenter(txtOutput.Lines.Count - 1);
      txtOutput.Refresh;
    finally
      txtOutput.Lines.EndUpdate;
    end;
  finally
    tmpbuf.Free;
  end;


end;

procedure TmainForm.tmrSplashTimer(Sender: TObject);
begin
  CustomTitleBar.Enabled := True;
  container.Visible := False;
  tmrSplash.Enabled := False;
  activitySplash.Active := False;
end;

procedure TmainForm.UpdatePan(DX, DY: Integer);
begin
  ImgView321.OffsetHorz := ImgView321.OffsetHorz + DX / FZoomFactor;
  ImgView321.OffsetVert := ImgView321.OffsetVert + DY / FZoomFactor;
  ImgView321.Invalidate;
end;

procedure TmainForm.UpdatePictureList;
var
//  pidList: TCommonPIDLList;
//  PIDL: PItemIDList;
  I: Integer;
  SearchRec: TSearchRec;
  SearchResult: Integer;
  FilePath: string;
  NS: TNamespace;
begin
  if not DirectoryExists(FPicturesPath) then
  Exit;

  xpListView.BeginUpdate;
  try
    xpListView.Clear;
    SearchResult := FindFirst(FPicturesPath + '*', faAnyFile, SearchRec);
    try
      while SearchResult = 0 do
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          FilePath := FPicturesPath + SearchRec.Name;
          //PIDL := PathToPIDL(FilePath);
          NS := TNamespace.CreateFromFileName(FilePath);
          if Assigned(NS) and (FilePath.EndsWith('.png') or FilePath.EndsWith('.jpg')) then
          begin
            NS.States := NS.States + [nsShellDetailsSupported];
            //VirtualMultiPathExplorerEasyListview1.AddCustomItem(nil, TNamespace.Create(PIDL, nil), True);
            xpListView.AddCustomItem(nil, NS, True);
          end;
        end;

        SearchResult := FindNext(SearchRec);
      end;

    finally
      FindClose(SearchRec);
    end;
  finally
    xpListView.EndUpdate;
  end;

  xpListView.Sort.SortAll();
end;

procedure TmainForm.UpdateZoom(Delta: Integer);
var
  OldZoom, NewZoom: Single;
  CenterX, CenterY: Single;
begin
  OldZoom := ImgView321.Scale;

  if Delta > 0 then
    NewZoom := OldZoom * 1.1
  else
    NewZoom := OldZoom / 1.1;

  NewZoom := Max(0.1, Min(10.0, NewZoom)); // Limit zoom range

  // Calculate the center of the visible area
  CenterX := ImgView321.OffsetHorz + (ImgView321.Width / 2) / OldZoom;
  CenterY := ImgView321.OffsetVert + (ImgView321.Height / 2) / OldZoom;

  ImgView321.Scale := NewZoom;

  // Adjust offset to keep the center point at the same position
  ImgView321.OffsetHorz := CenterX - (ImgView321.Width / 2) / NewZoom;
  ImgView321.OffsetVert := CenterY - (ImgView321.Height / 2) / NewZoom;

  ImgView321.Invalidate;
end;

procedure TmainForm.UWPDownloader1Click(Sender: TObject);
begin
  ForceDirectories(AppPath + 'downloads');
  var i := FSDRelease.Assets.FindIndexByPartialText('win-vulkan');
  if (i <> -1) then
  begin
    var cuda := FSDRelease.Assets.Names[i];
    var cudalink := FSDRelease.Assets.Values[cuda];
    UWPDownloader1.URL := cudalink;
    FTempFile :=  AppPath + 'downloads\' + cuda;
    UWPDownloader1.SavePath := FTempFile;

    if not FileExists(PChar(AppPath + 'downloads\' + cuda)) then
    begin
      UWPDownloader1.DoStartDownload;
    end
    else
    begin
      UWPDownloader1Downloaded(Sender, 200);
    end;
  end;
end;

procedure TmainForm.UWPDownloader1DblClick(Sender: TObject);
begin
//  FSDModels.

end;

procedure TmainForm.UWPDownloader1Downloaded(Sender: TObject;
  DownloadCode: Integer);
var
  ZipFile: TZipFile;
  ZipFileName: string;
//  ExtractedFiles: TStringDynArray;
  I: Integer;
  ExeFound: Boolean;
begin
  if DownloadCode = 200 then
  begin
    ExeFound := False;
    ZipFile := TZipFile.Create;
    try

      ZipFile.Open(FTempFile, zmRead);
      for I := 0 to ZipFile.FileCount - 1 do
      begin
        if SameText(ExtractFileName(ZipFile.FileNames[I]), 'sd.exe') then
        begin
          ExeFound := True;
          Break;
        end;
      end;

      if ExeFound then
      begin
        // Create a temporary extraction folder
        var TempExtractPath := TPath.Combine(TPath.GetTempPath, 'sd_' + FormatDateTime('yyyymmddhhnnss', Now));

        try
          ForceDirectories(TempExtractPath);

          ZipFile.ExtractAll(TempExtractPath);

          ForceDirectories(AppPath + 'SD');

          for var fn in TDirectory.GetFiles(TempExtractPath, '*', TSearchOption.soAllDirectories) do
          begin
            //var RelativePath := TPath
            if FileExists(AppPath + 'SD\' + TPath.GetFileName(fn)) then
              DeleteFile(AppPath + 'SD\' + TPath.GetFileName(fn));

            TFile.Move(fn, AppPath + 'SD\' + TPath.GetFileName(fn));
          end;

        finally

        end;

      end;
      ZipFile.Close;
    finally
      ZipFile.Free;
    end;
  end;
end;

procedure TmainForm.xpListViewItemClick(
  Sender: TCustomEasyListview; Item: TEasyItem; KeyStates: TCommonKeyStates;
  HitInfo: TEasyItemHitTestInfoSet);
begin
  try
    var fpath := xpListView.SelectedPath.ToLower;
    var fext := ExtractFileExt(fpath);
    if fext.Contains('.png') or fext.Contains('.jpg') or fext.Contains('gif') then
    begin
      ImgView321.Bitmap.LoadFromFile(fpath);
//      FSelectedFile := fPath;
//      pnlClipwatcher.Hide;
      if fext.Contains('.png') then
        ACLFormattedLabel1.Caption := ExtractPNGTextChunk(fpath);
      aclCatImage.Caption := Format('%s (%dx%d)', [ExtractFileName(fpath), ImgView321.Bitmap.Width, ImgView321.Bitmap.Height]);
    end;
  except
    ImgView321.Bitmap.Assign(nil);
  end;
end;

procedure TmainForm.xpListViewItemSelectionChanged(
  Sender: TCustomEasyListview; Item: TEasyItem);
begin
  try
    var fpath := xpListView.SelectedPath.ToLower;
    var fext := ExtractFileExt(fpath);
    if fext.Contains('.png') or fext.Contains('.jpg') or fext.Contains('gif') then
    begin
      ImgView321.Bitmap.LoadFromFile(fpath);
      if fext.Contains('.png') then
        ACLFormattedLabel1.Caption := ExtractPNGTextChunk(fpath);
      aclCatImage.Caption := Format('%s (%dx%d)', [ExtractFileName(fpath), ImgView321.Bitmap.Width, ImgView321.Bitmap.Height]);
    end;
  except
    ImgView321.Bitmap.Assign(nil);
  end;
end;

procedure TmainForm.xpListViewShellNotify(
  Sender: TCustomVirtualExplorerEasyListview; ShellEvent: TVirtualShellEvent);
begin
//  case ShellEvent.ShellNotifyEvent of
//    vsneDelete, vsneRenameItem:
//      VirtualMultiPathExplorerEasyListview1.RereadAndRefresh(False);
//  end;
end;

procedure TmainForm.WMHelp(var Message: TWMHelp);
begin
  Caption := 'Help!';
end;

{ TSDModelList }

constructor TSDModelList.Create(const DirectoryPath: string);
begin
  inherited Create;
  FDirectoryPath := DirectoryPath;
  AddStrings(GetFilePicturePairs(FDirectoryPath));
end;

function TSDModelList.FindPair(const FileName: string): TFilePicturePair;
var
  I: Integer;
  Pair: TFilePicturePair;
begin
  for I := 0 to Count - 1 do
  begin
    Pair.FileName := ExtractFilePath(Strings[I]) + ExtractFileName(Strings[I]);
    Pair.PreviewFileName := ExtractFilePath(Strings[I]) + ExtractFileName(Strings[I]);
    if SameText(Pair.FileName, FileName) then
    begin
      Pair.PreviewFileName := ExtractFilePath(Strings[I]) + ExtractFileExt(Strings[I]);
      Result := Pair;
      Exit;
    end;
  end;
  Result.FileName := '';
  Result.PreviewFileName := '';
end;

function TSDModelList.GetFilePicturePairs(
  const DirectoryPath: string): TStringList;
var
  SearchPath: string;
  Files: TSearchRec;
  FileName: string;
  PreviewFileName: string;
  PairList: TStringList;
begin
  PairList := TStringList.Create;
  try
    SearchPath := IncludeTrailingPathDelimiter(DirectoryPath) + '*.*';
    if FindFirst(SearchPath, faAnyFile, Files) = 0 then
    begin
      repeat
        var LFileExt := ExtractFileExt(Files.Name);
        if SameText(LFileExt, '.ckpt')
        or SameText(LFileExt, '.safetensors')
        or SameText(LFileExt, '.gguf')
        then
        begin
          FileName := Files.Name;
          PreviewFileName := ChangeFileExt(FileName, '.preview.png');
          if FileExists(IncludeTrailingPathDelimiter(DirectoryPath)+PreviewFileName) then
            PairList.AddPair(FileName,PreviewFileName)
          else
            PairList.AddPair(FileName,'');
        end;
      until FindNext(Files) <> 0;
    end;
    FindClose(Files);
  finally
    PairList.Sorted := True;
    Result := PairList;
  end;
end;

{ TStableDiffusionDist }

procedure TStableDiffusionDist.CheckRelease;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  JsonObj, AssetsObj: TJSONObject;
  JsonArray: TJSONArray;
  JsonValue: TJSONValue;
  I: Integer;
  Url, TagName, FileName: string;
  ResultList: TStringList;
begin
  ResultList := TStringList.Create;
  HttpClient := THTTPClient.Create;
  try
    Response := HttpClient.Get('https://api.github.com/repos/leejet/stable-diffusion.cpp/releases/latest');
    if Response.StatusCode = 200 then
    begin
      JsonObj := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONObject;
      try
        FTagName := JsonObj.GetValue('tag_name').Value;
        FDescription := JsonObj.GetValue('body').Value;
        var fecha := JsonObj.GetValue('published_at').Value;
        FReleaseDate := ISO8601ToDateTime(fecha);
        JsonArray := JsonObj.GetValue('assets') as TJSONArray;
        for I := 0 to JsonArray.Count - 1 do
        begin
          AssetsObj := JsonArray.Items[I] as TJSONObject;
          FileName := AssetsObj.GetValue('name').Value;
          Url := AssetsObj.GetValue('browser_download_url').Value;

          // Filter conditions
          ResultList.AddPair(FileName, Url);
        end;
      finally
        JsonObj.Free;
      end;
    end;

    if Assigned(FAssets) then
      FAssets.Free;
    FAssets := ResultList;
  finally
    HttpClient.Free;
//    ResultList.Free;
  end;
end;

constructor TStableDiffusionDist.Create;
begin
//  CheckRelease;
end;

destructor TStableDiffusionDist.Destroy;
begin
  if Assigned(FAssets) then
    FAssets.Free;
  inherited;
end;

{ TLayer }

constructor TLayer.Create(ABitmap: TBitmap32);
begin
  inherited Create(nil);

  FBitmap := TBitmap32.Create;
  FBitmap.SetSize(ABitmap.Width, ABitmap.Height);
  FBitmap.Clear(0);
end;

destructor TLayer.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TLayer.Paint(Buffer: TBitmap32);
begin
//  inherited;
  Buffer.Draw(0, 0, FBitmap);
end;

{ TStringListt }

function TStringList.FindIndexByPartialText(
  const PartialText: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Self.Count - 1 do
  begin
    if Pos(PartialText, Self.Names[I]) > 0 then
    begin
      Result := I;
      Exit;
    end;
  end;

end;

function TStringList.FindNameValueByPartialText(
  const PartialText: string): string;
var
  Index: Integer;
begin
  Index := FindIndexByPartialText(PartialText);

  if Index <> -1 then
    Result := Self.Strings[Index]
  else
    Result := '';
end;

end.
