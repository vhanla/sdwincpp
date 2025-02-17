unit settings;

interface

uses
  System.Classes, System.SysUtils, Rest.Json, Rest.Json.Types, Generics.Collections;

const
  SETTINGSFILENAME = 'settings.json';

type
  TThemeStyle = (tsSystem, tsDark, tsLight);

  TSDExecutables = class
  private
    [JsonName('sdCliFullPath')]
    FSDCliFullPath: string;
    [JsonName('sdServerFullPath')]
    FSDServerFullPath: string;
  public
    property SDCLIFullPath: string read FSDCliFullPath write FSDCliFullPath;
    property SDServerFullPath: string read FSDServerFullPath write FSDServerFullPath;
  end;

  TRepos = class
  private
    [JsonName('name')]
    FName: string;
    [JsonName('github')]
    FGitHubRepo: string;
    [JsonName('version')]
    FVersion: string;
    [JsonName('sdAvx')]
    FSDAVX: TSDExecutables;
    [JsonName('sdAvx2')]
    FSDAVX2: TSDExecutables;
    [JsonName('sdAvx512')]
    FSDAVX512: TSDExecutables;
    [JsonName('sdCuda12')]
    FSDCUDA12: TSDExecutables;
    [JsonName('sdNoAvx')]
    FSDNOAVX: TSDExecutables;
    [JsonName('sdRocm')]
    FSDROCM: TSDExecutables;
    [JsonName('sdVulkan')]
    FSDVULKAN: TSDExecutables;
    [JsonName('hasServer')]
    FHasServer: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property GitHub: string read FGitHubRepo write FGitHubRepo;
    property Version: string read FVersion write FVersion;
    property SDAVX: TSDExecutables read FSDAVX write FSDAVX;
    property SDAVX2: TSDExecutables read FSDAVX2 write FSDAVX2;
    property SDAVX512: TSDExecutables read FSDAVX512 write FSDAVX512;
    property SDCUDA12: TSDExecutables read FSDCUDA12 write FSDCUDA12;
    property SDNOAVX: TSDExecutables read FSDNOAVX write FSDNOAVX;
    property SDROCM: TSDExecutables read FSDROCM write FSDROCM;
    property SDVULKAN: TSDExecutables read FSDVULKAN write FSDVULKAN;
    property HasServer: Boolean read FHasServer write FHasServer;
  end;

  TPaths = class
  private
    [JsonName('sdModels')]
    FSDModels: string;
    [JsonName('sdLoras')]
    FSDLoras: string;
    [JsonName('stableDiffusion')]
    FStableDiffusion: string;
    [JsonName('bgRemover')]
    FBGRemover: string;
    [JsonName('gfpgan')]
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
    [JsonName('theme')]
    FTheme: TThemeStyle;
    [JsonName('paths')]
    FPaths: TPaths;
    [JsonName('repos')]
    FRepos: TObjectList<TRepos>;
  public
    constructor Create;
    destructor Destroy; override;
    property Theme: TThemeStyle read FTheme write FTheme;
    property Paths: TPaths read FPaths write FPaths;
    property Repos: TObjectList<TRepos> read FRepos write FRepos;
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
  FRepos := TObjectList<TRepos>.Create(True); // Owns objects
end;

destructor TSetting.Destroy;
begin
  FRepos.Free;
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

{ TRepos }

constructor TRepos.Create;
begin
  FSDAVX := TSDExecutables.Create;
  FSDAVX2 := TSDExecutables.Create;
  FSDAVX512 := TSDExecutables.Create;
  FSDCUDA12 := TSDExecutables.Create;
  FSDNOAVX := TSDExecutables.Create;
  FSDROCM := TSDExecutables.Create;
  FSDVULKAN := TSDExecutables.Create;
end;

destructor TRepos.Destroy;
begin
  FSDVULKAN.Free;
  FSDROCM.Free;
  FSDNOAVX.Free;
  FSDCUDA12.Free;
  FSDAVX512.Free;
  FSDAVX2.Free;
  FSDAVX.Free;
  inherited;
end;

end.
