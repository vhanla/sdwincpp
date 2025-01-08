unit settings;

interface

uses
  System.Classes, System.SysUtils, Rest.Json, Generics.Collections;

const
  SETTINGSFILENAME = 'settings.json';

type
  TPaths = class
  private
    FSDModels: string;
    FSDLoras: string;
    FStableDiffusion: string;
    FBGRemover: string;
    FGFPGAN: string;
  public
    property SDModels: string read FSDModels write FSDModels;
    property SDLoras: string read FSDLoras write FSDLoras;
    property StableDiffusion: string read FStableDiffusion write FStableDiffusion;
    property BGRemover: string read FBGRemover write FBGRemover;
    property GFPGAN: string read FGFPGAN write FGFPGAN;
  end;

  TSetting = class(TObject)
  private
    FPaths: TPaths;
  public
    constructor Create;
    destructor Destroy; override;
    property Paths: TPaths read FPaths write FPaths;
  end;

  TSettings = class(TObject)
  public
    class function LoadSettings(FSettingsPath: string = ''): TSetting;
    class procedure SaveSettings(FSetting: TSetting; FSettingsPath: string = '');
  end;


implementation

{ TSettings }

constructor TSetting.Create;
begin
  inherited;
  FPaths := TPaths.Create;
end;

destructor TSetting.Destroy;
begin
  FPaths.Free;

  inherited;
end;

{ TSettings }

class function TSettings.LoadSettings(FSettingsPath: string): TSetting;
var
  LStrings: TStrings;
begin
  LStrings := TStringList.Create;
  try
    if FSettingsPath = '' then
      FSettingsPath := ExtractFilePath(ParamStr(0)) + SETTINGSFILENAME;

    if FileExists(FSettingsPath) then
    begin
      LStrings.LoadFromFile(FSettingsPath);
      Result := TJson.JsonToObject<TSetting>(LStrings.Text); // this does a .Create()
    end
    else
      Result := TSetting.Create;

  finally
    LStrings.Free;
  end;
end;

class procedure TSettings.SaveSettings(FSetting: TSetting;
  FSettingsPath: string);
var
  LStrings: TStrings;
  JSON: string;
begin
  if FSettingsPath = '' then
    FSettingsPath := ExtractFilePath(ParamStr(0)) + SETTINGSFILENAME;

  LStrings := TStringList.Create;
  try
    JSON := TJSON.ObjectToJsonString(FSetting);
    LStrings.Add(JSON);
    LStrings.SaveToFile(FSettingsPath);
  finally
    LStrings.Free;
  end;

end;

end.
