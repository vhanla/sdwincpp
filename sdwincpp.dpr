program sdwincpp;

uses
  Vcl.Forms,
  main in 'main.pas' {mainForm},
  Vcl.Themes,
  Vcl.Styles,
  VirtualThumbnails in 'VirtualThumbnails.pas',
  frameHFFlux in 'frameHFFlux.pas' {Frame1: TFrame},
  frameText2Img in 'frameText2Img.pas' {Frame2: TFrame},
  settings in 'settings.pas',
  functions in 'functions.pas',
  StableDiffusion in 'StableDiffusion.pas',
  imageHelper in 'imageHelper.pas',
  frameParams in 'frameParams.pas' {frameParameters: TFrame},
  Config.Base in 'Config.Base.pas',
  settings.sd in 'settings.sd.pas',
  SynHighlighterSDPrompt in 'SynHighlighterSDPrompt.pas',
  sdDataModule in 'sdDataModule.pas' {CommandsDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows11 Modern Dark');
  Application.CreateForm(TmainForm, mainForm);
  Application.CreateForm(TCommandsDataModule, CommandsDataModule);
  Application.Run;
end.
